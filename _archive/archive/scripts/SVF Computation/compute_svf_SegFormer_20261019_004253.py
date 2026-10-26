"""Run SegFormer-B5 on key-windowed P4 CamUp images for WalkU and BikeU.

Cityscapes pretrained weights are a candidate, not a camera-validated model.
All 19 classes are saved; previews group Building + Wall as Built-up.
"""
import argparse
from pathlib import Path
import importlib.util
import os
os.environ['USE_TF'] = '0'
os.environ['USE_FLAX'] = '0'
import hashlib
import time
import cv2
import numpy as np
import pandas as pd
import torch
from transformers import SegformerImageProcessor, SegformerForSemanticSegmentation

PROJECT = Path(__file__).resolve().parents[2]
SCRIPT_DIR = Path(__file__).resolve().parent
MODEL = Path(__file__).resolve().parent / 'model/SegFormer_B5'
SOURCE = PROJECT / 'output/SVF Output_TVF_BVF/P4/P4_SVF_WalkU_BikeU.csv'
OUTPUT_ROOT = PROJECT / 'output/SVF SegFormer_B5'
GROUPS = {'Sky': [10], 'Vegetation': [8], 'Built-up': [2, 3]}
# BGR: sky blue, dark green, orange and grey.
COLORS = [(233,180,86), (0,100,0), (0,94,213), (128,128,128)]

geometry_spec = importlib.util.spec_from_file_location(
    'camup_geometry', SCRIPT_DIR / 'compute_svf_camup - Copy.py')
if geometry_spec is None or geometry_spec.loader is None:
    raise ImportError('Could not load geometry from compute_svf_camup - Copy.py')
geometry = importlib.util.module_from_spec(geometry_spec)
geometry_spec.loader.exec_module(geometry)
Rectifier, factor = geometry.OpticalRectifier, geometry.compute_svf


def save_preview(path, image, labels, valid, result):
    groups = np.full(labels.shape, 3, dtype=np.uint8)
    for index, ids in enumerate(GROUPS.values()):
        groups[np.isin(labels, ids)] = index
    colors = np.asarray(COLORS, dtype=np.uint8)[groups]
    overlay = cv2.addWeighted(image, .35, colors, .65, 0)
    overlay[~valid] = 0
    canvas = np.zeros((620,960,3),dtype=np.uint8)
    canvas[55:535,:480] = image
    canvas[55:535,480:] = overlay
    cv2.putText(canvas,f"P4 / {result['PhaseID']} / {result['Filename']}",(8,20),0,.55,(255,255,255),1)
    cv2.putText(canvas,f"SegFormer-B5 | SVF {result['SVF']:.3f} | TVF {result['TVF']:.3f} | BVF {result['BVF']:.3f}",(8,43),0,.5,(255,255,255),1)
    for index,name in enumerate([*GROUPS,'Other']):
        x = index*240+8
        share = float(np.mean(groups[valid]==index)*100)
        cv2.rectangle(canvas,(x,553),(x+16,569),COLORS[index],-1)
        cv2.putText(canvas,f'{name} {share:.2f}%',(x+22,567),0,.44,(255,255,255),1)
    cv2.putText(canvas,'Left: rectified input | Right: predicted groups | All 19 labels retained in PNG/CSV',(8,600),0,.47,(255,255,255),1)
    if not cv2.imwrite(str(path),canvas):
        raise IOError(path)


def main():
    parser = argparse.ArgumentParser(description='P4 WalkU/BikeU SegFormer-B5 comparison')
    parser.add_argument('--source', type=Path, default=SOURCE)
    parser.add_argument('--output-root', type=Path, default=OUTPUT_ROOT)
    parser.add_argument('--phase', choices=['both', 'WalkU', 'BikeU'], default='both')
    parser.add_argument('--limit', type=int, default=None, help='Optional per-phase preview limit')
    args = parser.parse_args()
    if args.limit is not None and args.limit < 1:
        raise ValueError('--limit must be positive')
    torch.set_num_threads(4)
    if not args.source.is_file():
        raise FileNotFoundError(args.source)
    before = hashlib.sha256(args.source.read_bytes()).hexdigest()
    data = pd.read_csv(args.source)
    required = {'ParticipantID', 'PhaseID', 'Filename', 'Timestamp', 'Image_Path',
                'Calibration_Table', 'Raw_Lens_Radius_px', 'Rectified_Lens_Radius_px',
                'Calibration_Ref_Radius_px', 'SVF_Rings', 'SVF', 'TVF', 'BVF'}
    missing = required - set(data.columns)
    if missing:
        raise ValueError(f'Source is missing required fields: {sorted(missing)}')
    if not data.ParticipantID.astype(str).eq('P4').all():
        raise ValueError('Source must contain only P4')
    phases = ['WalkU', 'BikeU'] if args.phase == 'both' else [args.phase]
    data = data[data.PhaseID.isin(phases)].copy()
    if data.empty or data.duplicated(['PhaseID', 'Filename']).any():
        raise ValueError('Source has no requested phase rows or contains duplicate image keys')
    if args.limit:
        data = data.sort_values(['PhaseID', 'Timestamp', 'Filename']).groupby('PhaseID', sort=False).head(args.limit)
    processor = SegformerImageProcessor.from_pretrained(MODEL,local_files_only=True)
    model = SegformerForSemanticSegmentation.from_pretrained(MODEL,local_files_only=True).eval()
    names = {int(key):value for key,value in model.config.id2label.items()}
    assert len(names)==19 and [names[i] for i in [2,3,8,10]]==['building','wall','vegetation','sky'],names
    print(f'Model loaded: official Transformers, 19 classes, CPU 4 threads, phases={phases}',flush=True)
    rectifier = None
    for phase in phases:
        rows = data[data.PhaseID.eq(phase)].sort_values(['Timestamp', 'Filename'])
        if rows.empty:
            raise ValueError(f'No P4 {phase} rows in {args.source}')
        output = args.output_root/'P4'/phase
        output.mkdir(parents=True,exist_ok=True)
        target = output/f'P4_{phase}_SegFormer_B5.csv'
        partial = output/f'P4_{phase}_SegFormer_B5_PARTIAL.csv'
        resume = partial if partial.is_file() else target
        saved = pd.read_csv(resume) if resume.is_file() else pd.DataFrame()
        if not saved.empty and ('Source_SHA256' not in saved or not saved.Source_SHA256.eq(before).all()):
            raise ValueError(f'Refusing to resume {resume}; source CSV changed')
        results = saved.to_dict('records')
        by_filename = {str(row['Filename']): row for row in results}
        print(f'{phase}: {len(rows)} selected images; {len(results)} checkpoint rows found',flush=True)
        for number,(_,record) in enumerate(rows.iterrows(),1):
            stem = Path(record.Filename).stem
            path = output/(stem+'_segformer.jpg')
            mask_path = output/(stem+'_labels.png')
            if stem in by_filename and path.is_file() and mask_path.is_file():
                continue
            started = time.monotonic()
            raw = cv2.imread(record.Image_Path)
            if raw is None:
                raise FileNotFoundError(record.Image_Path)
            height,width = raw.shape[:2]
            radius = int(record.Rectified_Lens_Radius_px)
            if (height,width,radius)!=(480,640,240):
                raise ValueError(f'Unexpected CamUp geometry for {record.Filename}: {width}x{height}, radius {radius}')
            if rectifier is None:
                calibration = record.Calibration_Table
                rectifier = Rectifier([float(x) for x in calibration.split(',')],width,height,
                    raw_radius=record.Raw_Lens_Radius_px,rectified_radius=radius,
                    calibration_ref_radius_px=record.Calibration_Ref_Radius_px)
            if record.Calibration_Table != calibration:
                raise ValueError(f'Calibration changed within source rows at {record.Filename}')
            image,mask = rectifier.rectify_image(raw)
            image,valid = image[:,80:560],mask[:,80:560]>0
            inputs = processor(images=cv2.cvtColor(image,cv2.COLOR_BGR2RGB),return_tensors='pt')
            with torch.inference_mode():
                prediction = model(**inputs)
                labels = processor.post_process_semantic_segmentation(prediction,target_sizes=[(480,480)])[0].numpy().astype('uint8')
            if labels.shape!=(480,480) or labels.max()>=19 or not valid.any():
                raise ValueError(f'Invalid SegFormer output or fisheye mask for {record.Filename}')
            result = {key:record[key] for key in ['ParticipantID','PhaseID','Filename','Timestamp','Image_Path']}
            result.update({names[index]+'_%':float(np.mean(labels[valid]==index)*100) for index in range(19)})
            if abs(sum(result[names[index]+'_%'] for index in range(19))-100)>=1e-8:
                raise ValueError(f'Class shares do not sum to 100% for {record.Filename}')
            for name,ids in [('SVF',[10]),('TVF',[8]),('BVF',[2,3])]:
                binary = (np.isin(labels,ids)&valid).astype('uint8')*255
                result[name] = factor(binary,int(record.SVF_Rings),(radius,radius),radius)
                result['Xception_'+name] = record[name]
            result['Segmented_Image_Path'] = str(path)
            result['Model'] = 'SegFormer_B5_Cityscapes'
            result['Source_SHA256'] = before
            save_preview(path,image,labels,valid,result)
            labels[~valid]=255
            if not cv2.imwrite(str(mask_path),labels):
                raise IOError(f'Failed saving labels: {mask_path}')
            by_filename[stem] = result
            if number % 10 == 0 or number == len(rows):
                results = sorted(by_filename.values(),key=lambda row:(row['Timestamp'],row['Filename']))
                temp = partial.with_suffix('.tmp.csv')
                pd.DataFrame(results).to_csv(temp,index=False)
                os.replace(temp,partial)
            print(f'{phase} {number}/{len(rows)} {record.Filename}: Sky {result["sky_%"]:.2f}%, Vegetation {result["vegetation_%"]:.2f}%, Building {result["building_%"]:.2f}% | {time.monotonic()-started:.1f}s',flush=True)
        if partial.is_file():
            os.replace(partial,target)
        print(f'{phase} complete: {len(by_filename)} rows -> {target}',flush=True)
    if hashlib.sha256(args.source.read_bytes()).hexdigest()!=before:
        raise RuntimeError('Source SVF CSV changed during SegFormer processing')
    print('PASS: all requested phase rows processed; source CSV unchanged.',flush=True)


if __name__=='__main__':
    main()
