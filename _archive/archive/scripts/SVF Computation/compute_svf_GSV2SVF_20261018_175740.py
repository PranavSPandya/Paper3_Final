"""Five-image CamUp test of GSV2SVF SegNet weights, executed with PyTorch.

The paper classifies panoramas first. Direct fisheye input here is exploratory.
Legacy BN inference and pooling-index upsampling follow caffe-segnet source.
"""
from pathlib import Path
import ast
import math
import re
import sys
import types
import time
import hashlib
import numpy as np
import pandas as pd
import cv2
import torch
import torch.nn.functional as F
from google.protobuf import descriptor_pb2, descriptor_pool, message_factory

SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT = SCRIPT_DIR.parent.parent
MODEL = SCRIPT_DIR / "model" / "GSV2SVF"
SOURCE = PROJECT / "output/SVF Output/P4/P4_SVF_WalkU.csv"
OUTPUT = PROJECT / "output/SVF_GSV2SVF_test/P4/WalkU"
CLASS_NAMES = ("Sky", "Building", "Pole", "Road", "Pavement", "Tree",
               "Sign", "Fence", "Car", "Pedestrian", "Bicycle", "Unlabelled")


def load_weights(path):
    """Read original Caffe blobs using Google's protobuf library and Caffe field IDs."""
    schema = descriptor_pb2.FileDescriptorProto(name="segnet_weights.proto", package="segnet")
    definitions = {
        "Shape": [("dim", 1, 3, 3, None)],
        "Blob": [("num", 1, 5, 1, None), ("channels", 2, 5, 1, None),
                 ("height", 3, 5, 1, None), ("width", 4, 5, 1, None),
                 ("data", 5, 2, 3, None), ("shape", 7, 11, 1, ".segnet.Shape")],
        "Layer": [("name", 1, 9, 1, None), ("type", 2, 9, 1, None),
                  ("blobs", 7, 11, 3, ".segnet.Blob")],
        "Net": [("layer", 100, 11, 3, ".segnet.Layer")],
    }
    for name, fields in definitions.items():
        message = schema.message_type.add(name=name)
        for name, number, kind, label, target in fields:
            field = message.field.add(name=name, number=number, type=kind, label=label)
            if target:
                field.type_name = target
    pool = descriptor_pool.DescriptorPool()
    pool.Add(schema)
    net = message_factory.GetMessageClass(pool.FindMessageTypeByName("segnet.Net"))()
    net.ParseFromString(path.read_bytes())
    weights = {}
    for layer in net.layer:
        arrays = []
        for blob in layer.blobs:
            shape = list(blob.shape.dim) or [blob.num, blob.channels, blob.height, blob.width]
            array = np.asarray(blob.data, dtype=np.float32).reshape(shape)
            assert np.isfinite(array).all(), layer.name
            arrays.append(torch.from_numpy(array.copy()))
        if arrays:
            weights[layer.name] = arrays
    assert len(weights) == 51, f"Expected 26 convolutions + 25 BN layers; got {len(weights)}"
    return weights


def read_layers(path):
    text = path.read_text()
    layers = []
    for match in re.finditer(r"\blayer\s*\{", text):
        start, depth, end = match.end(), 1, match.end()
        while depth:
            depth += (text[end] == "{") - (text[end] == "}")
            end += 1
        block = text[start:end - 1]
        name = re.search(r'name:\s*"([^"]+)"', block).group(1)
        kind = re.search(r'type:\s*"([^"]+)"', block).group(1)
        assert kind in {"Convolution", "BN", "ReLU", "Pooling", "Upsample", "ArgMax"}, kind
        layers.append((name, kind, block))
    assert len(layers) == 87 and re.findall(r"input_dim:\s*(\d+)", text) == ["1", "3", "512", "1024"]
    return layers


def predict(image, layers, weights):
    # GSV2SVF SVFCore.classify uses raw OpenCV BGR, with no mean subtraction.
    resized = cv2.resize(image, (1024, 512))
    values = torch.from_numpy(resized.transpose(2, 0, 1).copy()).float().unsqueeze(0)
    pools = []
    used = set()
    with torch.inference_mode():
        for name, kind, block in layers:
            if kind == "Convolution":
                kernel, bias = weights[name]
                values = F.conv2d(values, kernel, bias.flatten(), padding=1)
                used.add(name)
            elif kind == "BN":
                assert "INFERENCE" in block and len(weights[name]) == 2
                scale, shift = weights[name]
                values = values * scale.reshape(1, -1, 1, 1) + shift.reshape(1, -1, 1, 1)
                used.add(name)
            elif kind == "ReLU":
                values.relu_()
            elif kind == "Pooling":
                assert "MAX" in block and re.search(r"kernel_size:\s*2", block)
                shape = values.shape
                values, indices = F.max_pool2d(values, 2, 2, return_indices=True)
                pools.append((indices, shape))
            elif kind == "Upsample":
                indices, shape = pools.pop()
                values = F.max_unpool2d(values, indices, 2, 2, output_size=shape)
            else:
                assert not pools and used == set(weights)
                assert values.shape == (1, 12, 512, 1024) and torch.isfinite(values).all()
                labels = values.argmax(1)[0].numpy().astype(np.uint8)
    return cv2.resize(labels, (image.shape[1], image.shape[0]), interpolation=cv2.INTER_NEAREST)


def load_geometry():
    """Reuse existing calibrated geometry without importing the TensorFlow model."""
    source = ast.parse((SCRIPT_DIR / "compute_svf_camup.py").read_text(encoding="utf-8-sig"))
    names = {"load_mse_core", "OpticalRectifier", "compute_svf"}
    selected = [node for node in source.body if isinstance(node, (ast.FunctionDef, ast.ClassDef))
                and node.name in names]
    namespace = dict(globals(), MSE_REFERENCE_RADIUS_PX=542.0)
    exec(compile(ast.Module(body=selected, type_ignores=[]), "camup_geometry", "exec"), namespace)
    namespace["ColleagueOpticalRectifier"], namespace["SkyViewFactorCalculator"] = namespace["load_mse_core"]()
    return namespace["OpticalRectifier"], namespace["compute_svf"]


def save_preview(path, image, labels, row):
    palette = cv2.imread(str(MODEL / "camvid11.png"))[0]
    overlay = cv2.addWeighted(image, 0.35, palette[labels], 0.65, 0)
    yy, xx = np.indices(labels.shape)
    overlay[(xx - 240) ** 2 + (yy - 240) ** 2 > 240 ** 2] = 0
    canvas = np.zeros((640, 960, 3), np.uint8)
    canvas[50:530, :480] = image
    canvas[50:530, 480:] = overlay
    cv2.putText(canvas, f"SegNet direct-fisheye test | {row['Filename']}", (8, 20), 0, .5, (255,255,255), 1)
    cv2.putText(canvas, f"SVF {row['SVF']:.3f} | TVF {row['TVF']:.3f} | BVF {row['BVF']:.3f}", (8, 43), 0, .5, (255,255,255), 1)
    for index, name in enumerate(CLASS_NAMES):
        x, y = (index % 4) * 240 + 8, 550 + (index // 4) * 30
        cv2.rectangle(canvas, (x,y-12), (x+14,y+2), tuple(map(int,palette[index])), -1)
        cv2.putText(canvas, f"{name} {row[name+'_%']:.1f}%", (x+20,y), 0, .4, (255,255,255), 1)
    assert cv2.imwrite(str(path), canvas)


def main():
    torch.set_num_threads(4)
    # Check the two legacy custom operations against explicit numerical examples.
    example = torch.tensor([[[[1., 4.], [3., 2.]]]])
    pooled, indices = F.max_pool2d(example, 2, return_indices=True)
    assert torch.equal(F.max_unpool2d(pooled, indices, 2), torch.tensor([[[[0.,4.],[0.,0.]]]]))
    assert torch.equal(example * 2 + 3, torch.tensor([[[[5.,11.],[9.,7.]]]]))
    before = hashlib.sha256(SOURCE.read_bytes()).hexdigest()
    records = pd.read_csv(SOURCE).sort_values("Filename").head(5)
    assert len(records) == 5 and records["PhaseID"].eq("WalkU").all()
    weights = load_weights(MODEL / "segnet_weights_driving_webdemo.caffemodel")
    layers = read_layers(MODEL / "segnet_model_driving_webdemo.prototxt")
    print(f"Loaded {len(weights)} weighted layers; CPU, 4 threads; FIVE images only", flush=True)
    Rectifier, factor = load_geometry()
    OUTPUT.mkdir(parents=True, exist_ok=True)
    results = []
    for number, (_, record) in enumerate(records.iterrows(), 1):
        started = time.monotonic()
        raw = cv2.imread(record.Image_Path)
        if raw is None:
            raise FileNotFoundError(record.Image_Path)
        height, width = raw.shape[:2]
        radius = int(record.Rectified_Lens_Radius_px)
        rectifier = Rectifier([float(x) for x in record.Calibration_Table.split(',')], width, height,
                             raw_radius=record.Raw_Lens_Radius_px, rectified_radius=radius,
                             calibration_ref_radius_px=record.Calibration_Ref_Radius_px)
        image, mask = rectifier.rectify_image(raw)
        x, y = width // 2, height // 2
        image = image[y-radius:y+radius, x-radius:x+radius]
        valid = mask[y-radius:y+radius, x-radius:x+radius] > 0
        labels = predict(image, layers, weights)
        row = {key:record[key] for key in ("ParticipantID", "PhaseID", "Filename", "Timestamp", "Image_Path")}
        row.update({name+'_%': float(np.mean(labels[valid] == i)*100) for i,name in enumerate(CLASS_NAMES)})
        assert abs(sum(row[name+'_%'] for name in CLASS_NAMES)-100) < 1e-8
        for name, index in (("SVF",0),("TVF",5),("BVF",1)):
            row[name] = factor(((labels == index) & valid).astype(np.uint8)*255,
                               int(record.SVF_Rings), (radius,radius), radius)
            row['Xception_'+name] = record[name]
        for name in ("Sky", "Tree", "Building"):
            row['Xception_'+name+'_%'] = record[name+'_%']
        stem = Path(record.Filename).stem
        row['Segmented_Image_Path'] = str(OUTPUT / (stem+'_segnet.jpg'))
        assert cv2.imwrite(str(OUTPUT / (stem+'_labels.png')),labels)
        save_preview(Path(row['Segmented_Image_Path']),image,labels,row)
        results.append(row)
        print(f"{number}/5 {record.Filename}: sky={row['Sky_%']:.2f}% tree={row['Tree_%']:.2f}% building={row['Building_%']:.2f}% | {time.monotonic()-started:.1f}s",flush=True)
    target = OUTPUT / "P4_WalkU_GSV2SVF_test.csv"
    pd.DataFrame(results).to_csv(target,index=False)
    assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == before
    print(f"PASS: 5 images, 12-class shares sum to 100%; source CSV unchanged.\n{target}",flush=True)


if __name__ == '__main__':
    main()
