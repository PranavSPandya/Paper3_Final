"""Recompute §3 item-7 sample sizes from merged_all_11participants_8min.csv and patch the guide."""
from __future__ import annotations

import re
from pathlib import Path

import numpy as np
import pandas as pd

ROOT = Path(r"c:\Users\sanga\Desktop\Pranav Paper3_Final")
CSV = ROOT / "output/merged_all_11participants_8min.csv"
MD = ROOT / "documents/H4_papers_screened_final.md"
CORE = ["WalkG", "WalkU", "BikeG", "BikeU"]


def energy_dba(x: pd.Series) -> float:
    return float(np.sqrt(np.mean(np.square(x))))


def audit() -> dict[str, str]:
    df = pd.read_csv(CSV)
    df = df[df["PhaseID"].isin(CORE)].copy()

    pm = df.groupby(["ParticipantID", "PhaseID"], as_index=False).agg(
        dba=("ucm_SND_dBA", energy_dba),
        airt=("ucm_AIR_temp", "mean"),
        utci=("ucm_UTCI", "mean"),
        rh=("ucm_AIR_RH", "mean"),
        hr=("empatica_heart_rate", "mean"),
        sdnn=("empatica_hrv_td_sdnn", "mean"),
        rmssd=("empatica_hrv_td_rmssd", "mean"),
        eda=("empatica_eda_tonic", "mean"),
        tc=("questionnaire_thermal_comfort_1_5", "first"),
        ac=("questionnaire_acoustic_comfort_1_5", "first"),
        oc=("questionnaire_current_comfort_1_7", "first"),
        vis=("questionnaire_visual_comfort_1_5", "first"),
    )
    walk = pm[pm["PhaseID"].isin(["WalkG", "WalkU"])].copy()
    bike = pm[pm["PhaseID"].str.startswith("Bike")].copy()

    n_walk = len(walk)
    n_bike = len(bike)
    n_all = len(pm)
    n_wg = (pm.PhaseID == "WalkG").sum()
    n_wu = (pm.PhaseID == "WalkU").sum()
    n_bg = (pm.PhaseID == "BikeG").sum()
    n_bu = (pm.PhaseID == "BikeU").sum()

    med_air = walk["airt"].median()
    n_cool = int((walk["airt"] < med_air).sum())
    n_warm = int((walk["airt"] >= med_air).sum())

    def both_routes(phases: list[str]) -> int:
        ok = pm[pm["PhaseID"].isin(phases)].groupby("ParticipantID")["PhaseID"].apply(
            lambda s: set(phases).issubset(set(s))
        )
        return int(ok.sum())

    n_both_walk = both_routes(["WalkG", "WalkU"])
    n_both_bike = both_routes(["BikeG", "BikeU"])

    def person_both_thermal_halves(sub: pd.DataFrame) -> int:
        def halves(g: pd.DataFrame) -> pd.Series:
            med = g["airt"].median()
            return pd.Series(
                {
                    "cool": (g["airt"] < med).any(),
                    "warm": (g["airt"] >= med).any(),
                }
            )

        h = sub.groupby("ParticipantID").apply(halves, include_groups=False)
        return int((h["cool"] & h["warm"]).sum())

    n_pers_walk_thermal = person_both_thermal_halves(walk)

    dba60_walk = int((walk["dba"] >= 60).sum())
    dba60_walk_below = n_walk - dba60_walk
    dba65_walk = int((walk["dba"] >= 65).sum())
    dba65_walk_below = n_walk - dba65_walk

    dba65_all = int((pm["dba"] >= 65).sum())
    dba65_all_below = n_all - dba65_all

    ta32 = int((pm["airt"] > 32).sum())
    ta32_no = n_all - ta32
    both_td = int(((pm["airt"] > 32) & (pm["dba"] > 65)).sum())
    ta32_walk = int((walk["airt"] > 32).sum())

    low_tc = walk["tc"] <= 3
    low_ac = walk["ac"] <= 3
    n_ltc, n_lac = int(low_tc.sum()), int(low_ac.sum())
    n_both_low = int((low_tc & low_ac).sum())
    n_ltc_only = int((low_tc & ~low_ac).sum())
    n_lac_only = int((~low_tc & low_ac).sum())
    n_neither_low = int((~low_tc & ~low_ac).sum())

    wg = pm[pm.PhaseID == "WalkG"]
    wu = pm[pm.PhaseID == "WalkU"]
    bg = pm[pm.PhaseID == "BikeG"]
    bu = pm[pm.PhaseID == "BikeU"]

    walk_b = walk.copy()
    walk_b["band"] = pd.cut(
        walk_b["dba"],
        bins=[-np.inf, 60, 65, 70, 75, np.inf],
        labels=["<60", "60–65", "65–70", "70–75", ">75"],
    )
    walk_b["utci_q"] = pd.qcut(walk_b["utci"], 4, duplicates="drop")
    jin_cells = walk_b.groupby(["band", "utci_q"], observed=True).size()
    jin_min = int(jin_cells.min()) if len(jin_cells) else 0
    jin_max = int(jin_cells.max()) if len(jin_cells) else 0

    ut_med = walk["utci"].median()
    walk_t = walk.copy()
    walk_t["ut_half"] = np.where(walk_t["utci"] >= ut_med, "warm", "cool")
    walk_t["dq"] = pd.qcut(walk_t["dba"], 4, duplicates="drop")
    cool_half = walk_t[walk_t["ut_half"] == "cool"]
    warm_half = walk_t[walk_t["ut_half"] == "warm"]
    cool_q = [int(x) for x in cool_half.groupby("dq", observed=True).size().values]
    warm_q = [int(x) for x in warm_half.groupby("dq", observed=True).size().values]
    n_cool_ut = len(cool_half)
    n_warm_ut = len(warm_half)
    tang_min = min(cool_q + warm_q) if cool_q else 0

    vpm = df.groupby(["ParticipantID", "PhaseID"], as_index=False).agg(
        v=("vehicle_proportion", "mean"),
        r=("rural_natural_proportion", "mean"),
    )
    vpm = vpm[vpm["PhaseID"].isin(["WalkG", "WalkU"])]
    vpm["traffic_maj"] = vpm["v"] > vpm["r"]
    n_tr = int(vpm["traffic_maj"].sum())
    n_nat = int((~vpm["traffic_maj"]).sum())
    tr_wg = int(vpm[vpm.PhaseID == "WalkG"]["traffic_maj"].sum())
    tr_wu = int(vpm[vpm.PhaseID == "WalkU"]["traffic_maj"].sum())
    piv = vpm.pivot(index="ParticipantID", columns="PhaseID", values="traffic_maj")
    n_diff_label = int((piv["WalkG"] != piv["WalkU"]).sum()) if "WalkG" in piv.columns else 0

    phys = {
        k: int(walk[k].notna().sum())
        for k in ["hr", "sdnn", "rmssd", "eda"]
    }

    wind_ok = 0
    if "ucm_WIND_AWS" in df.columns:
        wsub = df[df.PhaseID.isin(["WalkG", "WalkU"])]
        wind_ok = int(
            wsub.groupby(["ParticipantID", "PhaseID"])["ucm_WIND_AWS"]
            .apply(lambda s: s.notna().any())
            .sum()
        )

    n_10s_walk = int(df[df.PhaseID.isin(["WalkG", "WalkU"])].groupby(["ParticipantID", "PhaseID"]).size().sum())

    return {
        "3.1": (
            f"**Audited** on core CSV ({n_all} phase cells). **WalkG {n_wg} + WalkU {n_wu} = {n_walk}** questionnaire cells. "
            f"**Paired WalkU−WalkG:** **{n_both_walk}/11** people. **Cooler vs warmer** (median phase `ucm_AIR_temp` on walk cells): "
            f"**{n_cool} cooler / {n_warm} warmer**. **Within-person both thermal halves (walk only):** **{n_pers_walk_thermal}/11**. "
            f"**10 s rows:** **{n_10s_walk}** on WalkG∪WalkU. **Flag:** Spearman within each thermal half ≈**11** cells; source **n=40** chamber."
        ),
        "3.2": (
            f"**WalkG {n_wg} + WalkU {n_wu} = {n_walk}** cells. Fisher tables **11** responses per walk phase. "
            f"**Flag:** **n=11** per table is small; source multi-walker parks not reproduced."
        ),
        "3.3": (
            f"**{n_walk}** walk cells; physiology finite walk: **hr {phys['hr']}/{n_walk}**, **sdnn {phys['sdnn']}/{n_walk}**, "
            f"**rmssd {phys['rmssd']}/{n_walk}**, **eda {phys['eda']}/{n_walk}**. **Paired warm−cool (walk):** **{n_pers_walk_thermal}/11** people. "
            f"**Flag:** no personality inventory; some tests use **22** pooled cells or ≈**11** per thermal half."
        ),
        "3.4": (
            f"**{n_walk}** walk bouts; **{n_10s_walk}** ten-second rows. **GLS/LMM rows:** **{n_walk}** (physiology above). "
            f"**Mean energy dBA:** WalkU **{wu.dba.mean():.1f}** ({n_wu} cells), WalkG **{wg.dba.mean():.1f}** ({n_wg}). "
            f"**Flag:** source **1 h×4** settings ≫ **8 min×2** routes."
        ),
        "3.5": (
            f"**{n_walk}** cells (WalkG+WalkU). **5 dB band × UTCI quartile:** **{len(jin_cells)}** non-empty cells, "
            f"**min {jin_min} / max {jin_max}** questionnaires per cell. **Flag:** min cell **{jin_min}** (<5); many empty crossed cells; source **N=1,495**."
        ),
        "3.6": (
            f"**All four phases {n_all}** cells (**11** each). **2-min windows:** up to **~3** per bout ⇒ **≤{n_all * 3}** correlated sub-rows (not independent). **Flag:** no full-day panel."
        ),
        "3.7": (
            f"**{n_walk}** walking trips (**WalkG {n_wg}**, **WalkU {n_wu}**); **{n_both_walk}/11** people with both. **LMM rows:** **{n_walk}**."
        ),
        "3.8": (
            f"**{n_all}** phase cells. **dBA ≥65 dB(A):** **{dba65_all} yes / {dba65_all_below} no**. "
            f"Walk **{len(walk)}** / Bike **{len(bike)}**. **5-min interval rows:** ≤**{n_all}** (often **0–1** per bout). **Flag:** no 15-min lags."
        ),
        "3.9": (
            f"**{n_walk}** walk cells. **WalkG** mean dBA **{wg.dba.mean():.1f}**; **WalkU** **{wu.dba.mean():.1f}**. **LMM:** **{n_walk}** rows."
        ),
        "3.10": (
            f"**{n_walk}** cells; **{n_both_walk}/11** repeated walk contexts. **10 s:** **{n_10s_walk}** rows. **Flag:** not **12 sites×30** respondents."
        ),
        "3.11": (
            f"**BikeG {n_bg} + BikeU {n_bu} = {n_bike}** cells; **{n_both_bike}/11** cyclists both routes. "
            f"Mean dBA **BikeU {bu.dba.mean():.1f}** vs **BikeG {bg.dba.mean():.1f}**. **Spearman per phase:** **n=11** each."
        ),
        "3.12": (
            f"**{n_walk}** walk cells. **dBA ≥60:** **{dba60_walk} yes / {dba60_walk_below} no**. **dBA ≥65:** **{dba65_walk} yes / {dba65_walk_below} no**."
        ),
        "3.13": (
            f"**{n_walk}** walk cells; RH and dBA defined on each. **LMM:** **{n_walk}** rows."
        ),
        "3.14": (
            f"**WalkG {n_wg} + WalkU {n_wu} = {n_walk}** cells for Pearson/LMM."
        ),
        "3.15": (
            f"**{n_walk}** walk cells. **Low thermal comfort (TC≤3):** **{n_ltc} yes / {n_walk - n_ltc} no**. "
            f"**Low acoustic (AC≤3):** **{n_lac} yes / {n_walk - n_lac} no**. **Both low:** **{n_both_low}**; **TC low only:** **{n_ltc_only}**; "
            f"**AC low only:** **{n_lac_only}**; **neither low:** **{n_neither_low}**. **Flag:** veto/cross-tab cells **<5**."
        ),
        "3.16": (
            f"**{n_walk}** walk cells. **dBA ≥60:** **{dba60_walk} yes / {dba60_walk_below} no**."
        ),
        "3.17": (
            f"By-phase Pearson: **WalkU n={n_wu}**, **WalkG n={n_wg}**. **All {n_all} core cells — `airt_c>32`:** **{ta32} yes / {ta32_no} no**; "
            f"**dBA>65:** **{dba65_all} yes / {dba65_all_below} no**; **both true:** **{both_td} yes / {n_all - both_td} no**. "
            f"**Walk only `airt_c>32`:** **{ta32_walk}/{n_walk}**. **Flag:** interaction **not estimable** (both true **{both_td}**)."
        ),
        "3.18": (
            f"**{n_walk}** cells. **YAMNet traffic-majority (phase mean v>r):** **{n_tr} true / {n_nat} false**; "
            f"**WalkG traffic-majority {tr_wg}/{n_wg}**, **WalkU {tr_wu}/{n_wu}**; **{n_diff_label}/11** people differ WalkG vs WalkU. "
            f"**Per-phase Spearman:** **n=11**."
        ),
        "3.19": (
            f"**{n_walk}** walk cells (WalkG+WalkU) for LMM / ordinal analogue."
        ),
        "3.20": (
            f"Spearman by route: **WalkU n={n_wu}**, **WalkG n={n_wg}** (not Bike*)."
        ),
        "3.21": (
            f"**Paired WalkU vs WalkG:** **{n_both_walk}/11** people, **{n_walk}** cells → **11** paired differences per outcome."
        ),
        "3.22": (
            f"**{n_walk}** walk cells; physiology **{phys['hr']}/{n_walk}** HR etc. **Median UTCI split:** **{n_cool_ut} cool / {n_warm_ut} warm** cells. "
            f"**Kruskal dBA quartiles within half — cool:** **{cool_q}**; **warm:** **{warm_q}** (min **{tang_min}**). **Flag:** min cell **{tang_min}**."
        ),
        "3.23": (
            f"**WalkG {n_wg} vs WalkU {n_wu}** for Kruskal (**11** each). Pooled comfort LMM **{n_walk}** rows."
        ),
        "3.24": (
            f"**Pearson within WalkG n={n_wg}, WalkU n={n_wu}**. **Wind `ucm_WIND_AWS` finite:** **{wind_ok}/{n_walk}** bout(s). "
            f"Pooled LMM **{n_walk}** cells."
        ),
    }


def _section_start(sec3: str, key: str) -> int:
    for prefix in (f"### {key} —", f"### {key} "):
        i = sec3.find(prefix)
        if i >= 0:
            return i
    raise SystemExit(f"section heading {key} not found")


def patch_md(samples: dict[str, str]) -> None:
    text = MD.read_text(encoding="utf-8")
    i3 = text.find("## 3. Paper by paper")
    i4 = text.find("## 4. Cross-paper limitations")
    if i3 < 0 or i4 < 0:
        raise SystemExit("§3 bounds not found")
    head, sec3, tail = text[:i3], text[i3:i4], text[i4:]

    for key in sorted(samples.keys(), key=lambda k: (float(k.split(".")[1]), k)):
        body = samples[key]
        start = _section_start(sec3, key)
        line_start = sec3.find("7. **Sample size (for test).**", start)
        if line_start < 0:
            raise SystemExit(f"sample item missing in {key}")
        line_end = sec3.find("\n", line_start)
        new_line = f"7. **Sample size (for test).** {body}"
        sec3 = sec3[:line_start] + new_line + sec3[line_end:]

    note = (
        "*(Item 7 counts audited from `output/merged_all_11participants_8min.csv` "
        "core phases WalkG, WalkU, BikeG, BikeU — run `python scripts/h4_sample_size_audit.py` to refresh.)*\n\n"
    )
    if "Item 7 counts audited" not in sec3:
        sec3 = sec3.replace(
            "Default file: `output/merged_all_11participants_8min.csv`;",
            note + "Default file: `output/merged_all_11participants_8min.csv`;",
            1,
        )

    MD.write_text(head + sec3 + tail, encoding="utf-8")


if __name__ == "__main__":
    s = audit()
    patch_md(s)
    print("patched", len(s), "sections")
