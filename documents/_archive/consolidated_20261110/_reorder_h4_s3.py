import re
from pathlib import Path

path = Path(r"c:\Users\sanga\Desktop\Pranav Paper3_Final\documents\H4_papers_screened_final.md")
text = path.read_text(encoding="utf-8")

m = re.search(r"(### 3\.1 .+?)(\n## 4\. )", text, re.DOTALL)
if not m:
    raise SystemExit("Could not find §3 block")
body, suffix_start = m.group(1), m.group(2)

parts = re.split(r"\n---\n\n(?=### 3\.\d+)", body.strip())
sections = []
for part in parts:
    part = part.strip()
    if not part.startswith("###"):
        continue
    title_line = part.split("\n", 1)[0]
    sections.append((title_line, part))


def slug(title_line: str) -> str:
    t = title_line.lower()
    if "grapas" in t:
        return "grapas"
    if "pigliautile" in t:
        return "pigliautile"
    if "ibpc" in t:
        return "ibpc"
    if "chiucchi" in t:
        return "chiucchiu"
    if "cureau" in t and "2022" in t:
        return "cureau22"
    if "cureau" in t and ("2023" in t or "forum" in t):
        return "cureaufa"
    if "moshammer" in t:
        return "moshammer"
    if "rodrigues" in t:
        return "rodrigues"
    if "kraus" in t:
        return "kraus"
    if "korpilo" in t:
        return "korpilo"
    if "ueberham" in t:
        return "ueberham"
    if "jin" in t:
        return "jin"
    if "biel" in t:
        return "biel"
    if "song" in t:
        return "song"
    raise ValueError(f"Unknown section: {title_line}")


order = [
    "grapas",
    "pigliautile",
    "ibpc",
    "chiucchiu",
    "cureau22",
    "cureaufa",
    "moshammer",
    "rodrigues",
    "kraus",
    "korpilo",
    "ueberham",
    "jin",
    "biel",
    "song",
]

by_slug = {}
for title, content in sections:
    by_slug[slug(title)] = content

titles_new = {
    "grapas": "### 3.1 Grapas et al. 2026 — outdoor Brussels walks (multimodal SOR)",
    "pigliautile": "### 3.2 Pigliautile 2021 — indoor NEXT.ROOM / headphones",
    "ibpc": "### 3.3 IBPC 2018 — NEXT.ROOM thermal × soundscape (poster)",
    "chiucchiu": "### 3.4 Chiucchiù et al. 2026 — indoor NEXT.ROOM / headphones",
    "cureau22": "### 3.5 Cureau et al. 2022 — outdoor park walks",
    "cureaufa": "### 3.6 Cureau et al. 2023 — Forum Acusticum comfort walk (conference contribution)",
    "moshammer": "### 3.7 Moshammer 2019 — outdoor road/park walks",
    "rodrigues": "### 3.8 Rodrigues 2026 — outdoor walking",
    "kraus": "### 3.9 Kraus 2013 — mixed indoor/outdoor daily life",
    "korpilo": "### 3.10 Korpilo 2024 — outdoor visits to nearby forest/beach/park",
    "ueberham": "### 3.11 Ueberham et al. 2019 — outdoor cycling",
    "jin": "### 3.12 Jin, Jin & Kang 2020 — outdoor squares, respondents standing/sitting",
    "biel": "### 3.13 Biel et al. 2020 — mixed indoor/outdoor daily activity",
    "song": "### 3.14 Song et al. (2013, 2014) — outdoor park vs city walks",
}

study_area = {
    "grapas": "**Brussels, Belgium** (**Europe**) — **outdoor** urban walking routes (wearable multimodal campaign; day/night × safety strata in source).",
    "pigliautile": "**Perugia, Umbria, Italy** (**Europe**) — indoor **NEXT.ROOM** test chamber (UCLab / University of Perugia network).",
    "ibpc": "**Perugia, Umbria, Italy** (**Europe**) — indoor **NEXT.ROOM** (IBPC 2018 poster campaign; same facility lineage as §3.2).",
    "chiucchiu": "**Perugia, Umbria, Italy** (**Europe**) — indoor **NEXT.ROOM** chamber (controlled temperature + headphone soundscapes).",
    "cureau22": "**Perugia, Italy** (**Europe**) — **outdoor** field campaign between two **urban parks** (local-user comfort walks).",
    "cureaufa": "**Perugia, Italy** (**Europe**) — **outdoor** urban walk segments (Forum Acusticum / comfort-walk conference contribution).",
    "moshammer": "**Vienna, Austria** (**Europe**) — **outdoor** busy-road vs urban-park walking loops (1 h per setting).",
    "rodrigues": "**Lisbon, Portugal** (**Europe**) — **outdoor** everyday walking trips (app-logged urban context).",
    "kraus": "**Augsburg, Bavaria, Germany** (**Europe**) — **routine daytime** activities (collar dosimetry; indoor/outdoor mix).",
    "korpilo": "**Helsinki metropolitan area, Finland** (**Europe**) — **outdoor** visits to nearby urban **forest, beach, and park** stops.",
    "ueberham": "**Leipzig, Saxony, Germany** (**Europe**) — **outdoor** urban cycling routes.",
    "jin": "**Harbin, Heilongjiang, China** (**Asia**) — **outdoor urban squares** (cold continental climate; winter, transitional, and summer campaigns).",
    "biel": "**Toronto, Ontario, Canada** (**North America**) — **free-living** urban region (personal dosimetry; indoor/outdoor mix, May–August).",
    "song": "**Japan** (**Asia**) — **outdoor** urban **park vs city** walking routes (season-specific campaigns in the two papers).",
}


def fix_section(slug_key: str, content: str, new_header: str) -> str:
    lines = content.split("\n")
    lines[0] = new_header
    out = []
    for line in lines:
        if re.match(r"3\. \*\*Experiment location\.\*\*", line):
            out.append(f"3. **Study area.** {study_area[slug_key]}")
        else:
            out.append(line)
    body = "\n".join(out)
    body = re.sub(r"Pigliautile 2021, §3\.1", "Pigliautile 2021, §3.2", body)
    body = re.sub(r"same lineage as §3\.1", "same lineage as §3.2", body)
    body = re.sub(r"same facility lineage as §3\.1", "same facility lineage as §3.2", body)
    body = re.sub(r"campaign as §3\.1", "campaign as §3.2", body)
    body = re.sub(r"as §3\.1 \(C0/C1", "as §3.2 (C0/C1", body)
    body = re.sub(r"cells as §3\.1 item 6", "cells as §3.2 item 6", body)
    body = re.sub(r"strata as in §3\.1", "strata as in §3.2", body)
    body = re.sub(r"Same lattice as §3\.1:", "Same lattice as §3.2:", body)
    body = re.sub(r"same lineage as §3\.1\)", "same lineage as §3.2)", body)
    body = re.sub(r"journal version = §3\.4", "journal version = §3.5", body)
    body = re.sub(
        r"supplements the journal \*\*Fisher / multinomial\*\* suite \(§3\.4\)",
        "supplements the journal **Fisher / multinomial** suite (§3.5)",
        body,
    )
    body = re.sub(r"See §3\.4 —", "See §3.5 —", body)
    body = re.sub(r"use §3\.4 results", "use §3.5 results", body)
    body = re.sub(r"journal §3\.4 Fisher", "journal §3.5 Fisher", body)
    body = re.sub(r"Pigliautile §3\.1 keeps", "Pigliautile §3.2 keeps", body)
    return body


new_sections = []
for slug_key in order:
    if slug_key not in by_slug:
        raise SystemExit(f"Missing slug {slug_key}")
    new_sections.append(fix_section(slug_key, by_slug[slug_key], titles_new[slug_key]))

new_body = "\n\n---\n\n".join(new_sections) + "\n"
rest = text[m.end() - len(suffix_start) :]
pre = text[: m.start(1)]

table_old = """| § | Source (short) | Source design (timing) | Our outcome focus | Comfort votes in port? |
| ---: | --- | --- | --- | ---: |
| **3.1** | Pigliautile 2021 | Chamber; votes after each playback / temp step | Votes + warm−cool / traffic−nature analogues | Yes (1×/phase) |
| **3.2** | IBPC 2018 poster | Chamber NEXT.ROOM (poster) | Thermal × soundscape perception (descriptive) | Yes (chamber analogue) |
| **3.3** | Chiucchiù 2026 | Chamber; physiology + votes | Physiology warm−cool + vote Spearman | Yes |
| **3.4** | Cureau 2022 | ~55 min park walk; votes at end | Vote–vote associations by walk phase | Yes — **Methods anchor #5** |
| **3.5** | Cureau FA 2023 | Outdoor comfort walk (Perugia) | Cross-modal comfort; Fisher analogue | Yes (vote–vote) |
| **3.6** | Grapas 2026 | Brussels walks; wearable multimodal | SOR-style **Pearson** exposure→vote web | Votes + physio (supplementary catalogue) |
| **3.7** | Moshammer 2019 | 1 h outdoor road vs park | HRV + additive comfort on walks | Comfort + **physio** |
| **3.8** | Rodrigues 2026 | Trip-level walking panel | Noise / temp blocks | Comfort + **physio** |
| **3.9** | Kraus 2013 | 24–48 h personal noise | Piecewise dBA on HR/HRV | **Physio only** |
| **3.10** | Korpilo 2024 | Park/beach visits | EDA on soundscape index | **Physio only** |
| **3.11** | Ueberham 2019 | Cycling routes | Sound–thermal on cycling | Bike phases (Spearman) |"""

table_new = """| § | Source (short) | Source design (timing) | Our outcome focus | Comfort votes in port? |
| ---: | --- | --- | --- | ---: |
| **3.1** | Grapas 2026 (Christos) | Brussels walks; wearable multimodal | SOR-style **Pearson** exposure→vote web | Votes + physio (supplementary catalogue) |
| **3.2** | Pigliautile 2021 | Chamber; votes after each playback / temp step | Votes + warm−cool / traffic−nature analogues | Yes (1×/phase) |
| **3.3** | IBPC 2018 poster | Chamber NEXT.ROOM (poster) | Thermal × soundscape perception (descriptive) | Yes (chamber analogue) |
| **3.4** | Chiucchiù 2026 | Chamber; physiology + votes | Physiology warm−cool + vote Spearman | Yes |
| **3.5** | Cureau 2022 | ~55 min park walk; votes at end | Vote–vote associations by walk phase | Yes — **Methods anchor #5** |
| **3.6** | Cureau FA 2023 | Outdoor comfort walk (Perugia) | Cross-modal comfort; Fisher analogue | Yes (vote–vote) |
| **3.7** | Moshammer 2019 | 1 h outdoor road vs park | HRV + additive comfort on walks | Comfort + **physio** |
| **3.8** | Rodrigues 2026 | Trip-level walking panel | Noise / temp blocks | Comfort + **physio** |
| **3.9** | Kraus 2013 | 24–48 h personal noise | Piecewise dBA on HR/HRV | **Physio only** |
| **3.10** | Korpilo 2024 | Park/beach visits | EDA on soundscape index | **Physio only** |
| **3.11** | Ueberham 2019 | Cycling routes | Sound–thermal on cycling | Bike phases (Spearman) |
| **3.12** | Jin 2020 | Harbin urban squares; stand/sit | LAeq band × UTCI ANOVA (comfort) | Yes (legacy pipeline) |
| **3.13** | Biel 2020 | Toronto free-living panel | Noise + Ta LMM on HRV | **Physio only** (legacy) |
| **3.14** | Song 2013/2014 | Japan park vs city walks | HR/HRV route contrast only | **No** (not fitted) |"""

if table_old not in pre:
    raise SystemExit("Table block not found")
pre = pre.replace(table_old, table_new)

intro_old = "Each subsection: **1** citation → **11** what cannot be matched (item **3** = experiment location). **Pisello AL** appears in bold in **§3.1–§3.6** (Anna Laura / UCLab block listed **first**). `---` separates papers. **Setting:** **indoor chamber:** §3.1–§3.3; **outdoor field or mixed mobility:** §3.4–§3.11. Our measured data are **outdoor walk/cycle bouts**; chamber playbacks are not reproduced."
intro_new = "Each subsection: **1** citation → **11** what cannot be matched (item **3** = **Study area:** city/region, country, continent). **Order:** **§3.1** Christos **Grapas** (Brussels); **§3.2–§3.6** Anna Laura / Pisello network (NEXT.ROOM + Perugia walks); **§3.7–§3.11** other **European** field ports; **§3.12–§3.14** **outside Europe** (Jin, Biel, Song). `---` separates papers. **Setting:** **indoor chamber:** §3.2–§3.4; **outdoor field or mixed mobility:** §3.1, §3.5–§3.14. Our measured data are **outdoor walk/cycle bouts**; chamber playbacks are not reproduced."
if intro_old not in pre:
    raise SystemExit("Intro block not found")
pre = pre.replace(intro_old, intro_new)

path.write_text(pre + new_body + rest, encoding="utf-8")
print("OK", len(order), "sections")
