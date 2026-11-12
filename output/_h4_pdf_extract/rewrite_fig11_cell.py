from pathlib import Path
import json

p = Path(r"c:\Users\sanga\Desktop\Pranav Paper3_Final\scripts\Paper3_Figures.ipynb")
nb = json.loads(p.read_text(encoding="utf-8"))
src = r'''# Figure 11: two maps, same layout, different grain. Circles = saved BH q < 0.05 only.
# Phase-average: H1_H3_Contrasts + H2_Concordance + H5_combined_phaseavg.
# 10 s: H1_H3_Planned_Contrasts_10s (phase_level) + H5_combined_timeseries. H2 has no 10 s table.
from pathlib import Path
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
from matplotlib.colors import TwoSlopeNorm, LinearSegmentedColormap
from matplotlib.cm import ScalarMappable


def fig11_evidence_map(grain='phaseavg'):
    assert grain in ('phaseavg', 'timeseries')
    root = Path(globals().get('ROOT', r'C:\Users\sanga\Desktop\Pranav Paper3_Final'))
    output = Path(globals().get('OUT', root / 'Figures'))
    res = root / 'output' / 'statistical_analysis' / 'results'
    outcomes = list(globals().get('OUTCOMES'))
    comparisons = ['BikeG - BikeU', 'WalkG - WalkU', 'WalkU - BikeU', 'WalkG - BikeG']
    contrast_cols = ['H1 cycling\ngreen minus urban', 'H1 walking\ngreen minus urban',
                     'H3 urban\nwalk minus cycle', 'H3 green\nwalk minus cycle']
    labels = globals().get('LAB', {})
    survey_labels = globals().get('SURVEY_LAB', {})
    label_overrides = {'eyetracker_gaze_velocity': 'Gaze velocity',
                       'eyetracker_saccade_peak_velocity': 'Saccade peak velocity'}

    def measure_label(name):
        return label_overrides.get(name, labels.get(name, name.replace('empatica_', '').replace('eyetracker_', '').replace('_', ' ')))

    def survey_label(name):
        if name in survey_labels:
            return survey_labels[name]
        text = name.removeprefix('questionnaire_')
        for suffix in ['_mean_1_5', '_1_5', '_1_7']:
            text = text.removesuffix(suffix)
        return text.replace('stai_', 'STAI: ').replace('prs11_', 'PRS: ').replace('_rev', ' (reversed)').replace('_', ' ').capitalize()

    def matrix(table, row, column, value, index, columns):
        return table.pivot(index=row, columns=column, values=value).reindex(index=index, columns=columns).to_numpy(float)

    if grain == 'phaseavg':
        contrasts_all = pd.read_csv(res / 'H1_H3_phaseavg' / 'H1_H3_Contrasts.csv')
        correlations = pd.read_csv(res / 'H1_H3_phaseavg' / 'H2_Concordance.csv')
        h5 = pd.read_csv(res / 'H5_combined_phaseavg' / 'H5_combined_phaseavg_Heat_Noise_Exposures.csv')
        hyp = contrasts_all['context'].str.extract(r'hypothesis=([^;]+)', expand=False).isin(['H1', 'H3'])
        primary = contrasts_all['scale'].str.startswith('normalization=Primary', na=False)
        contrasts = contrasts_all[hyp & primary & contrasts_all['context'].str.contains('outcome_type=Physiological', na=False)].copy()
        correlations = correlations[
            correlations['statistic_test'].eq('t-test (within-participant correlation)')
            & correlations['outcome'].str.startswith('questionnaire_', na=False)
        ].copy()
        questionnaires = correlations['outcome'].drop_duplicates().tolist()
        env_predictors = ['ucm_UTCI', 'ucm_AIR_T_mid', 'ucm_MRT', 'ucm_SND_dBA', 'SVF',
                          'atmo_pm2.5_avg', 'lys_lux_avg', 'lys_kelvin_avg']
        env_labels = ['UTCI', 'Air temp', 'MRT', 'Sound dBA', 'Sky view', 'PM2.5', 'Illuminance', 'Colour temp']
        assert len(contrasts) == 104 and len(correlations) == 468
        effects = matrix(contrasts, 'outcome', 'comparison', 'smd', outcomes, comparisons)
        contrast_q = matrix(contrasts, 'outcome', 'comparison', 'q_value', outcomes, comparisons)
        associations = matrix(correlations, 'predictor', 'outcome', 'correlation', outcomes, questionnaires)
        association_q = matrix(correlations, 'predictor', 'outcome', 'q_value', outcomes, questionnaires)
        show_b = True
        effect_norm = TwoSlopeNorm(vmin=-max(1., float(np.nanmax(np.abs(effects)))), vcenter=0,
                                   vmax=max(1., float(np.nanmax(np.abs(effects)))))
        env_clip = 1.0
        grain_title = 'Phase-average'
        a_bar = 'A: paired SMD  (red = negative, green = positive)'
        c_bar = 'C: coefficient per SD of env (clipped at ±1)'
        note = ('A: H1_H3_Contrasts.csv. B: H2_Concordance.csv (no 10 s table). '
                'C: H5_combined_phaseavg Heat_Noise_Exposures.csv, Eq1–7 unique hits.')
        b_kind = 'h2'
        b_title = 'B · Physiology with questionnaire'
        b_bar = 'B: correlation r  (red = negative, green = positive)'
        b_rotate = 65
        domains = [('ENVIRONMENT', 'C columns: measured env terms', '#e8f2ed'),
                   ('PHYSIOLOGY', 'Rows: 26 autonomic and ocular outcomes', '#eaf0f7'),
                   ('PSYCHOLOGY', 'B: 18 votes (phase-average only)', '#f4edf6')]
    else:
        raw = pd.read_csv(res / 'H1_H3_timeseries' / 'H1_H3_Planned_Contrasts_10s.csv')
        raw['hypothesis'] = raw['context'].str.extract(r'hypothesis=([^;]+)', expand=False)
        contrasts = raw[(raw['effect_type'] == 'phase_level') & raw['hypothesis'].isin(['H1', 'H3'])].copy()
        slopes = raw[(raw['effect_type'] == 'phase_slope') & raw['hypothesis'].isin(['H1', 'H3'])].copy()
        h5 = pd.read_csv(res / 'H5_combined_timeseries' / 'H5_combined_timeseries_hypothesis.csv')
        questionnaires = []
        env_predictors = ['ucm_UTCI', 'ucm_AIR_T_mid', 'ucm_MRT', 'ucm_HUMIDEX', 'ucm_SUN_Gh', 'SVF',
                          'gvi_50m', 'ucm_SND_dBA', 'atmo_pm2.5_avg', 'lys_lux_avg', 'lys_kelvin_avg']
        env_labels = ['UTCI', 'Air temp', 'MRT', 'HUMIDEX', 'Solar', 'Sky view', 'GVI',
                      'Sound dBA', 'PM2.5', 'Illuminance', 'Colour temp']
        assert len(contrasts) == 104 and len(slopes) == 104
        effects = matrix(contrasts, 'outcome', 'comparison', 'estimate', outcomes, comparisons)
        contrast_q = matrix(contrasts, 'outcome', 'comparison', 'q_value', outcomes, comparisons)
        associations = matrix(slopes, 'outcome', 'comparison', 'estimate', outcomes, comparisons)
        association_q = matrix(slopes, 'outcome', 'comparison', 'q_value', outcomes, comparisons)
        show_b = True
        finite = np.abs(effects[np.isfinite(effects)])
        effect_limit = max(1., float(np.nanmax(finite)) if finite.size else 1.)
        effect_norm = TwoSlopeNorm(vmin=-effect_limit, vcenter=0, vmax=effect_limit)
        slope_finite = np.abs(associations[np.isfinite(associations) & np.isfinite(association_q) & (association_q < .05)])
        slope_limit = float(np.nanmax(slope_finite)) if slope_finite.size else 1.
        correlation_norm = TwoSlopeNorm(vmin=-slope_limit, vcenter=0, vmax=slope_limit)
        env_clip = None
        grain_title = '10 s timeseries'
        a_bar = 'A: 10 s phase-level estimate (within-person z)'
        c_bar = 'C: t-statistic (estimate / SE); Y not standardized'
        b_bar = 'B: 10 s slope estimate (per minute, within-person z)'
        b_kind = 'slope'
        b_title = 'B · Phase slopes'
        b_rotate = 90
        note = ('A+B: H1_H3_Planned_Contrasts_10s.csv (level and slope). '
                'C: H5_combined_timeseries_hypothesis.csv, one circle per outcome × env (Eq1–7 unique; 26 BH rows collapse to 11).')
        domains = [('ENVIRONMENT', 'C columns: measured env terms', '#e8f2ed'),
                   ('PHYSIOLOGY LEVEL', 'A: 10 s phase-level contrasts', '#eaf0f7'),
                   ('PHYSIOLOGY SLOPE', 'B: 10 s per-minute slopes', '#f4edf6')]

    env_all = h5[~h5['predictor'].astype(str).str.startswith('Phase')].copy()
    env_hits = env_all[env_all['q_value'] < .05].sort_values('model_id').drop_duplicates(['outcome', 'predictor'])
    env = env_hits[env_hits['predictor'].isin(env_predictors)].copy()
    env['t_stat'] = pd.to_numeric(env['estimate'], errors='coerce') / pd.to_numeric(env['std_error'], errors='coerce')
    env_color_col = 't_stat' if grain == 'timeseries' else 'estimate'
    env_effects = matrix(env, 'outcome', 'predictor', env_color_col, outcomes, env_predictors)
    env_q = matrix(env, 'outcome', 'predictor', 'q_value', outcomes, env_predictors)
    if env_clip is None:
        hit = np.abs(env_effects[np.isfinite(env_q) & (env_q < .05)])
        vmax = float(np.nanmax(hit)) if hit.size else 1.
        vmax = vmax if np.isfinite(vmax) and vmax > 0 else 1.
        env_norm = TwoSlopeNorm(vmin=-vmax, vcenter=0, vmax=vmax)
    else:
        env_norm = TwoSlopeNorm(vmin=-env_clip, vcenter=0, vmax=env_clip)
    if grain == 'phaseavg':
        correlation_norm = TwoSlopeNorm(vmin=-1, vcenter=0, vmax=1)
    palette = LinearSegmentedColormap.from_list('neg_pos', ['#b91c1c', '#f8fafc', '#15803d'])

    figure = plt.figure(figsize=(18, 11.4), facecolor='white')
    if grain == 'phaseavg':
        phase_axis = figure.add_axes([.19, .28, .16, .50])
        env_axis = figure.add_axes([.36, .28, .20, .50], sharey=phase_axis)
        concordance_axis = figure.add_axes([.58, .28, .39, .50], sharey=phase_axis)
    else:
        phase_axis = figure.add_axes([.19, .28, .16, .50])
        concordance_axis = figure.add_axes([.36, .28, .16, .50], sharey=phase_axis)
        env_axis = figure.add_axes([.54, .28, .43, .50], sharey=phase_axis)

    def draw_hits(axis, values, adjusted_p, norm, column_labels, title, split=None):
        n_row = values.shape[0]
        for row in range(n_row):
            if row % 2 == 0:
                axis.axhspan(row - .5, row + .5, color='#f4f6f8', zorder=0)
            for column in range(values.shape[1]):
                value, q = values[row, column], adjusted_p[row, column]
                if np.isfinite(value) and np.isfinite(q) and q < .05:
                    mapped = value
                    if norm.vmin is not None and norm.vmax is not None:
                        mapped = np.clip(mapped, norm.vmin, norm.vmax)
                    axis.scatter(column, row, s=110 if values.shape[1] <= 8 else 88,
                                 color=palette(norm(mapped)), edgecolor='#20252b', linewidth=.85, zorder=3)
        axis.set(xlim=(-.5, values.shape[1] - .5), ylim=(n_row - .5, -.5))
        axis.set_xticks(range(len(column_labels)), column_labels)
        axis.tick_params(axis='x', length=0, labelsize=8, pad=6)
        axis.tick_params(axis='y', length=0, labelsize=8)
        axis.set_yticks(range(n_row))
        if split is not None:
            axis.axhline(split, color='#718096', linewidth=.8)
        axis.set_title(title, loc='left', fontsize=11, fontweight='bold', pad=12)
        for spine in axis.spines.values():
            spine.set_visible(False)

    draw_hits(phase_axis, effects, contrast_q, effect_norm, contrast_cols,
              'A · Phase contrasts', split=12.5)
    phase_axis.set_yticklabels([measure_label(name) for name in outcomes])
    phase_axis.axvline(1.5, color='#718096', linewidth=.8)
    plt.setp(phase_axis.get_xticklabels(), rotation=90, ha='right', va='center', rotation_mode='anchor')
    draw_hits(env_axis, env_effects, env_q, env_norm, env_labels,
              'C · Environment parameters', split=12.5)
    env_axis.tick_params(axis='y', labelleft=False)
    plt.setp(env_axis.get_xticklabels(), rotation=90, ha='right', va='center', rotation_mode='anchor')
    bars = [(phase_axis, effect_norm, a_bar), (env_axis, env_norm, c_bar)]
    if show_b:
        b_labels = contrast_cols if b_kind == 'slope' else [survey_label(name) for name in questionnaires]
        draw_hits(concordance_axis, associations, association_q, correlation_norm, b_labels, b_title, split=12.5)
        concordance_axis.tick_params(axis='y', labelleft=False)
        plt.setp(concordance_axis.get_xticklabels(), rotation=b_rotate, ha='right', va='center', rotation_mode='anchor')
        if b_kind == 'slope':
            concordance_axis.axvline(1.5, color='#718096', linewidth=.8)
        bars.append((concordance_axis, correlation_norm, b_bar))
    for axis, norm, label in bars:
        box = axis.get_position()
        color_axis = figure.add_axes([box.x0, .14, box.width, .01])
        colorbar = figure.colorbar(ScalarMappable(norm=norm, cmap=palette), cax=color_axis, orientation='horizontal')
        colorbar.set_label(label, fontsize=7)
        colorbar.ax.tick_params(labelsize=6.5)

    figure.suptitle(f'Multimodal Evidence Map · {grain_title}', y=.985, fontsize=19, fontweight='bold', color='#18334d')
    figure.text(.5, .955, 'Only BH q < 0.05 from the saved result tables is drawn. Blank cells were tested and were not significant.',
                ha='center', fontsize=11, color='#475569')
    for index, (heading, detail, color) in enumerate(domains):
        center = .20 + index * .30
        figure.text(center, .912, heading, ha='center', fontsize=11, fontweight='bold',
                    bbox=dict(boxstyle='round,pad=.6', facecolor=color, edgecolor='none'))
        figure.text(center, .872, detail, ha='center', va='center', fontsize=9, color='#475569')
    handles = [Line2D([], [], marker='o', linestyle='', markerfacecolor='#15803d', markeredgecolor='#20252b', label='q < .05, positive'),
               Line2D([], [], marker='o', linestyle='', markerfacecolor='#b91c1c', markeredgecolor='#20252b', label='q < .05, negative')]
    figure.legend(handles=handles, loc='lower center', bbox_to_anchor=(.57, .07), ncol=2, frameon=False, fontsize=8)
    figure.text(.19, .045, note, fontsize=8, color='#475569')
    figure.text(.19, .025, 'Do not mix grains. Green = positive. Red = negative.', fontsize=8, color='#475569')
    output.mkdir(parents=True, exist_ok=True)
    stem = f'Figure11_multimodal_evidence_map_{grain}'
    figure.savefig(output / f'{stem}.svg', bbox_inches='tight', facecolor='white')
    figure.savefig(output / f'{stem}.png', dpi=300, bbox_inches='tight', facecolor='white')
    if grain == 'phaseavg':
        figure.savefig(output / 'Figure11_multimodal_evidence_map.svg', bbox_inches='tight', facecolor='white')
        figure.savefig(output / 'Figure11_multimodal_evidence_map.png', dpi=300, bbox_inches='tight', facecolor='white')
    counts = {'A': int((np.isfinite(contrast_q) & (contrast_q < .05)).sum()),
              'C': int((np.isfinite(env_q) & (env_q < .05)).sum())}
    if show_b:
        counts['B'] = int((association_q < .05).sum())
    print(f'{grain} BH q < 0.05 drawn: {counts}')
    try:
        from IPython.display import display
        display(figure)
    finally:
        plt.close(figure)
    return counts

fig11_evidence_map('phaseavg')
fig11_evidence_map('timeseries')
'''
nb["cells"][10]["source"] = [line + "\n" for line in src.split("\n")]
if nb["cells"][10]["source"][-1] == "\n":
    nb["cells"][10]["source"].pop()
p.write_text(json.dumps(nb, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
print("rewrote cell 10")
