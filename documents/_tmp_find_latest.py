from pathlib import Path
cands = []
roots = [Path(r"D:\Pranav\Paper2_Revision"), Path(r"D:\Pranav\docker\Paper3_Final\documents")]
for root in roots:
    if not root.exists():
        continue
    for p in root.rglob("*"):
        if not p.is_file() or p.name.startswith("~$"):
            continue
        low = p.name.lower()
        if p.suffix.lower() in {".pdf", ".docx", ".md"} and any(s in low for s in ("highlight", "proof", "submitted paper", "paper_updated", "updated")):
            cands.append((p.stat().st_mtime, p.stat().st_size, str(p)))
cands.sort(reverse=True)
for m, s, p in cands[:40]:
    print(f"{s:10} {p}")
