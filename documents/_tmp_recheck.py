import zipfile
import xml.etree.ElementTree as ET
import pymupdf
from pathlib import Path

def docx_paras(path):
    W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
    with zipfile.ZipFile(path) as z:
        root = ET.fromstring(z.read("word/document.xml"))
    paras = []
    for para in root.iter(W + "p"):
        bits = []
        for t in para.iter(W + "t"):
            if t.text:
                bits.append(t.text)
            if t.tail:
                bits.append(t.tail)
        line = "".join(bits).strip()
        if line:
            paras.append(line)
    return paras

needles = [
    "rain suppress", "rain suppresses", "rain conditions suppress",
    "80.96bikes", "80.96 bikes", "55.08bikes", "55.08 bikes",
    "53.52bikes", "53.52 bikes", "1.99bikes", "1.99 bikes",
    "Windi", "Shade sustains", "shading along",
    "UTCI > 32", "UTCI ≥", "Day of Year", "Cold, Shade",
    "91.57", "2.99", "0.65, Cluster", "-3.97", "−3.97",
]
pdfs = [
    Path(r"D:\Pranav\Paper2_Revision\Submitted Paper.pdf"),
    Path(r"D:\Pranav\Paper2_Revision\Submitted Paper_updated.pdf"),
]
for p in pdfs:
    doc = pymupdf.open(p)
    text = "\n".join(page.get_text() for page in doc)
    print("PDF", p.name, "pages", doc.page_count, "bytes", p.stat().st_size)
    for s in needles:
        c = text.count(s)
        if c:
            print(f"  {c:3} {s}")
    print()

hl = Path(r"D:\Pranav\Paper2_Revision\Resubmission package_12Sep_withoutshade_fixed\other attachments\Highlights_mllm.docx")
print("HIGHLIGHTS", hl.stat().st_size)
for line in docx_paras(hl):
    print(" ", line)
