import os, re, sys
import fitz

folder = r"c:\Users\sanga\Desktop\Pranav Paper3_Final\Experiment papers\H4 highlighted sources"
out = r"c:\Users\sanga\Desktop\Pranav Paper3_Final\output\_h4_pdf_extract"
os.makedirs(out, exist_ok=True)

keys = re.compile(
    r"(hypothesis|we hypothes|aim of this|the objective|TSV|TCV|thermal comfort|thermal sensation|"
    r"LAeq|SPL|noise|interaction|ANOVA|Spearman|mixed.?linear|mixed.?model|"
    r"amplif|increas|work efficiency|productivity|restoration|occupancy|"
    r"UTCI|PET|two-way|factorial|main effect)",
    re.I,
)

files = sorted(os.listdir(folder))
for fn in files:
    if not fn.lower().endswith(".pdf"):
        continue
    path = os.path.join(folder, fn)
    doc = fitz.open(path)
    pages = []
    for i, page in enumerate(doc):
        t = page.get_text("text")
        pages.append(f"\n\n===== PAGE {i+1} =====\n{t}")
    doc.close()
    text = "".join(pages)
    raw_path = os.path.join(out, fn.replace(".pdf", ".txt"))
    with open(raw_path, "w", encoding="utf-8", errors="replace") as f:
        f.write(text)
    hits = []
    for m in keys.finditer(text):
        a = max(0, m.start() - 80)
        b = min(len(text), m.end() + 120)
        snippet = re.sub(r"\s+", " ", text[a:b]).strip()
        hits.append(snippet)
    # keep unique-ish first 80 hits
    seen = set()
    uniq = []
    for h in hits:
        k = h[:160]
        if k in seen:
            continue
        seen.add(k)
        uniq.append(h)
        if len(uniq) >= 60:
            break
    hit_path = os.path.join(out, fn.replace(".pdf", "_hits.txt"))
    with open(hit_path, "w", encoding="utf-8", errors="replace") as f:
        f.write(f"FILE: {fn}\nPAGES: {len(pages)}\nCHARS: {len(text)}\n\n")
        f.write("\n---\n".join(uniq))
    print(f"OK {fn} pages={len(pages)} chars={len(text)} hits={len(uniq)}")
