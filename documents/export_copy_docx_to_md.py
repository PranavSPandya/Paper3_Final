"""Export Paper3_outline2 - Copy.docx → markdown.

Main file is Word Final (accepted) text: insertions kept, deletions dropped.
No HTML, no strikethrough redline. Track changes stay in the .docx.
"""
from __future__ import annotations

import re
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path

DOCX = Path(r"D:\Pranav\docker\Paper3_Final\documents\Paper3_outline2 - Copy.docx")
OUT = Path(r"D:\Pranav\docker\Paper3_Final\documents\Paper3_outline_ml.md")
OUT_BEFORE = Path(r"D:\Pranav\docker\Paper3_Final\documents\Paper3_outline_ml_before.md")
OUT_AFTER = Path(r"D:\Pranav\docker\Paper3_Final\documents\Paper3_outline_ml_after.md")

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"

HEADER = ""


def wrap_track(kind: str, text: str) -> str:
    if kind == "ins":
        lead = len(text) - len(text.lstrip())
        trail = len(text) - len(text.rstrip())
        core = text.strip()
        if not core:
            return text
        return text[:lead] + f"**{core}**" + (text[-trail:] if trail else "")
    if kind == "del":
        lead = len(text) - len(text.lstrip())
        trail = len(text) - len(text.rstrip())
        core = text.strip()
        if not core:
            return text
        return text[:lead] + f"~~{core}~~" + (text[-trail:] if trail else "")
    return text


def segments_tracked(segments: list[tuple[str, str]]) -> str:
    merged: list[tuple[str, str]] = []
    for kind, text in segments:
        if not text:
            continue
        if merged and merged[-1][0] == kind:
            merged[-1] = (kind, merged[-1][1] + text)
        else:
            merged.append((kind, text))
    return "".join(wrap_track(kind, text) for kind, text in merged).strip()


def render_tracked(p: ET.Element) -> str:
    return segments_tracked(walk_rich(p))


def local_name(tag: str) -> str:
    return tag.split("}")[-1]


def text_from_run(run: ET.Element) -> str:
    parts: list[str] = []
    for node in run:
        name = local_name(node.tag)
        if name == "t" and node.text:
            parts.append(node.text)
        elif name == "tab":
            parts.append("\t")
        elif name in ("br", "cr"):
            parts.append(" ")
        elif name == "delText" and node.text:
            parts.append(node.text)
    return "".join(parts)


def walk_rich(elem: ET.Element, mode: str = "normal") -> list[tuple[str, str]]:
    segments: list[tuple[str, str]] = []
    for child in elem:
        name = local_name(child.tag)
        if name == "r":
            segments.append((mode, text_from_run(child)))
        elif name == "ins":
            segments.extend(walk_rich(child, "ins"))
        elif name == "del":
            segments.extend(walk_rich(child, "del"))
        elif name in ("hyperlink", "sdt", "smartTag"):
            segments.extend(walk_rich(child, mode))
    return segments


def segments_plain(segments: list[tuple[str, str]], *, keep: str) -> str:
    """keep: 'revised' (normal+ins) or 'original' (normal+del)."""
    out: list[str] = []
    for kind, text in segments:
        if not text:
            continue
        if keep == "revised" and kind in ("normal", "ins"):
            out.append(text)
        elif keep == "original" and kind in ("normal", "del"):
            out.append(text)
    return re.sub(r"  +", " ", "".join(out)).strip()


def paragraph_has_track(p: ET.Element) -> bool:
    for node in p.iter():
        n = local_name(node.tag)
        if n in ("ins", "del"):
            return True
    return False


def render_revised(p: ET.Element) -> str:
    return segments_plain(walk_rich(p), keep="revised")


def render_original(p: ET.Element) -> str:
    return segments_plain(walk_rich(p), keep="original")


def load_comments(z: zipfile.ZipFile) -> dict[str, dict]:
    if "word/comments.xml" not in z.namelist():
        return {}
    root = ET.fromstring(z.read("word/comments.xml"))
    out: dict[str, dict] = {}
    for node in root.findall(f"{W}comment"):
        cid = node.get(f"{W}id")
        if cid is None:
            continue
        text = render_revised(node)
        out[cid] = {
            "id": cid,
            "author": node.get(f"{W}author") or "",
            "date": (node.get(f"{W}date") or "")[:10],
            "text": text,
        }
    return out


def paragraph_style(p: ET.Element) -> str:
    p_pr = p.find(f"{W}pPr")
    if p_pr is None:
        return ""
    ps = p_pr.find(f"{W}pStyle")
    if ps is None:
        return ""
    return ps.get(f"{W}val") or ""


def comment_ids_in_paragraph(p: ET.Element) -> list[str]:
    ids: list[str] = []
    for node in p.iter():
        if local_name(node.tag) == "commentRangeEnd":
            cid = node.get(f"{W}id")
            if cid:
                ids.append(cid)
    return ids


def md_heading(level: int, text: str) -> str:
    return f"{'#' * level} {text}\n\n"


def escape_cell(s: str) -> str:
    return s.replace("|", "\\|").replace("\n", " ")


def table_rows_plain(tbl: ET.Element, *, keep: str) -> list[list[str]]:
    rows: list[list[str]] = []
    for tr in tbl.findall(f"{W}tr"):
        row: list[str] = []
        for tc in tr.findall(f"{W}tc"):
            cell_parts: list[str] = []
            for p in tc.findall(f"{W}p"):
                t = (
                    render_revised(p)
                    if keep == "revised"
                    else render_original(p)
                )
                if t:
                    cell_parts.append(t)
            row.append(" ".join(cell_parts))
        if any(c.strip() for c in row):
            rows.append(row)
    return rows


def table_to_md(rows: list[list[str]]) -> str:
    if not rows:
        return ""
    width = max(len(r) for r in rows)
    for r in rows:
        while len(r) < width:
            r.append("")
    lines = [
        "| " + " | ".join(escape_cell(c) for c in rows[0]) + " |",
        "| " + " | ".join("---" for _ in rows[0]) + " |",
    ]
    for r in rows[1:]:
        lines.append("| " + " | ".join(escape_cell(c) for c in r) + " |")
    return "\n".join(lines) + "\n\n"


def note_block(comment: dict) -> str:
    author = comment.get("author") or "Reviewer"
    cid = comment.get("id", "")
    date = comment.get("date", "")
    body = comment.get("text", "")
    meta = f"Comment [{cid}] {author}"
    if date:
        meta += f" ({date})"
    return f"> [!NOTE]\n> **{meta}:** {body}\n\n"


def style_to_md_prefix(style: str) -> tuple[int | None, bool]:
    if style == "Heading1":
        return 2, True
    if style == "Heading2":
        return 3, True
    if style == "Title":
        return 2, True
    return None, False


def emit_paragraph(
    p: ET.Element,
    style: str,
    parts: list[str],
    before: list[str],
    after: list[str],
) -> None:
    revised = render_revised(p)
    original = render_original(p)
    if not revised and not original and not comment_ids_in_paragraph(p):
        return

    level, is_heading = style_to_md_prefix(style)
    lvl = level or 2
    # Main md = Word Final (accepted) text only. No strikethrough / bold redline.
    clean = revised or original

    if is_heading and clean:
        before.append(md_heading(lvl, original or revised))
        after.append(md_heading(lvl, revised or original))
        parts.append(md_heading(lvl, clean))
        return

    before.append((original or "") + "\n\n")
    after.append((revised or "") + "\n\n")
    if clean:
        parts.append(clean + "\n\n")


def main() -> None:
    parts: list[str] = [HEADER]
    before_parts: list[str] = [
        "# Paper3 outline — **before** track changes (Copy.docx deletions kept)\n\n"
    ]
    after_parts: list[str] = [
        "# Paper3 outline — **after** track changes (Copy.docx insertions kept)\n\n"
    ]

    with zipfile.ZipFile(DOCX) as z:
        comments = load_comments(z)
        root = ET.fromstring(z.read("word/document.xml"))
        body = root.find(f"{W}body")
        if body is None:
            raise SystemExit("No document body")

        for child in body:
            name = local_name(child.tag)
            if name == "p":
                style = paragraph_style(child)
                emit_paragraph(child, style, parts, before_parts, after_parts)
                for cid in comment_ids_in_paragraph(child):
                    if cid in comments:
                        nb = note_block(comments[cid])
                        parts.append(nb)
                        before_parts.append(nb)
                        after_parts.append(nb)
            elif name == "tbl":
                rows_b = table_rows_plain(child, keep="original")
                rows_a = table_rows_plain(child, keep="revised")
                parts.append(table_to_md(rows_a))
                before_parts.append(table_to_md(rows_b))
                after_parts.append(table_to_md(rows_a))
            elif name == "sectPr":
                continue

    for path, chunks in (
        (OUT, parts),
        (OUT_BEFORE, before_parts),
        (OUT_AFTER, after_parts),
    ):
        text = re.sub(r"\n{3,}", "\n\n", "".join(chunks))
        path.write_text(text, encoding="utf-8")
        print(f"Wrote {path} ({len(text)} chars)")

    main_text = "".join(parts)
    print(f"HTML tags: {main_text.count('<ins ') + main_text.count('<del ')}")
    print(f"Diff fences: {main_text.count('```diff')}")


if __name__ == "__main__":
    main()
