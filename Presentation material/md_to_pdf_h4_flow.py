"""Build H4_Selection_Flow.pdf with presentation layout (pandoc → HTML → Edge).

Layout (vs generic compact PDF):
  - Spec + Steps 1–3: portrait (declared constructs first)
  - Appendix A inventory table: alone on a landscape page when present
  - Eq2 sound note: highlighted background when present

Run from repo root:

  python "Presentation material/md_to_pdf_h4_flow.py"

Optional output directory:

  python "Presentation material/md_to_pdf_h4_flow.py" --out-dir "Presentation material"

Extended narrative (centering, outcomes, FDR):

  python "Presentation material/md_to_pdf_h4_flow.py" \\
    "Presentation material/H4_Selection_Flow_explained.md"

PDF stem matches the source stem (`H4_Selection_Flow` or `H4_Selection_Flow_explained`).

Requires pandoc on PATH and Microsoft Edge (headless --print-to-pdf).
Source markdown (default):

  Presentation material/H4_Selection_Flow.md
"""

from __future__ import annotations

import argparse
import re
import sys
import tempfile
from pathlib import Path

# Shared Edge/pandoc pipeline from md_to_pdf_paper3.py
from md_to_pdf_paper3 import DEFAULT_OUT_DIR, build_pdf, find_edge

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
DEFAULT_MD = HERE / "H4_Selection_Flow.md"
COMPACT_CSS = HERE / "_md_to_pdf_compact.css"
H4_CSS = HERE / "_md_to_pdf_h4_flow.css"


def highlight_sound_block(text: str) -> str:
    """Highlight Eq2 sound note (new layout) or legacy **9. Sound** block."""
    eq2 = re.search(
        r"(\*\*Eq2 sound note:\*\*.*?)(?=\n\n---|\n\n## )",
        text,
        flags=re.S,
    )
    if eq2:
        block = eq2.group(1).strip()
        return (
            text[: eq2.start()]
            + "::: {.highlight-sound}\n"
            + block
            + "\n:::\n\n"
            + text[eq2.end() :]
        )

    pattern = r"(\*\*9\. Sound\*\*\n\n)(.+?)(\n- (?:<u>)?(?:\+\+)?SND dBA:)"
    match = re.search(pattern, text, flags=re.S)
    if not match:
        fallback = r"(\*\*9\. Sound\*\*.*?)(?=\n\*\*10\. Solar\*\*)"
        return re.sub(
            fallback,
            lambda m: "::: {.highlight-sound}\n" + m.group(1).strip() + "\n:::\n\n",
            text,
            count=1,
            flags=re.S,
        )
    header, body, snd_tail = match.group(1), match.group(2).strip(), match.group(3)
    replacement = (
        header
        + "::: {.highlight-sound}\n"
        + body
        + "\n:::\n"
        + snd_tail
    )
    return text[: match.start()] + replacement + text[match.end() :]


def fix_step3_interaction_asterisks(text: str) -> str:
    """Make interaction operators print as * in PDF without breaking MD table emphasis.

    Source docs may use \\*, &#42;, or bare * between terms; normalize for pandoc staging.
    """
    in_step3 = False
    out: list[str] = []
    for line in text.splitlines(keepends=True):
        if re.match(r"^## STEP 3\b", line):
            in_step3 = True
        elif in_step3 and re.match(r"^## STEP [45]\b", line):
            in_step3 = False
        if in_step3 and re.match(r"^\| Eq \d", line):
            line = line.replace("\\*", " * ").replace("&#42;", " * ")
        out.append(line)
    return "".join(out)


def _first_markdown_table_block(text: str) -> tuple[str, str] | None:
    """Return (table_block, after_table) for the first GitHub-style MD table, if any."""
    lines = text.splitlines(keepends=True)
    start = None
    for i, line in enumerate(lines):
        if line.lstrip().startswith("|"):
            start = i
            break
    if start is None:
        return None
    end = start + 1
    while end < len(lines) and lines[end].lstrip().startswith("|"):
        end += 1
    # Require a separator row so we do not grab a lone pipe line.
    block = "".join(lines[start:end])
    if not re.search(r"^\|[\s:\-|]+\|$", block, re.M):
        return None
    return block.strip(), "".join(lines[end:])


def transform_h4_flow_markdown(text: str) -> str:
    """Landscape-wrap STEP 1 inventory table (MD or HTML); leave constructs/spec portrait."""
    text = highlight_sound_block(text)

    step1 = re.search(r"^## STEP 1[^\n]*\n", text, re.M)
    if step1:
        prefix = text[: step1.start()].rstrip()
        from_step1 = text[step1.start() :]
        intro_end = from_step1.find("\n|")
        html_end = from_step1.find("</table>")

        if intro_end != -1:
            heading_intro = from_step1[:intro_end].strip()
            table_and_rest = from_step1[intro_end:]
            parsed = _first_markdown_table_block(table_and_rest)
            if parsed is not None:
                table_block, after = parsed
                inventory = (heading_intro + "\n\n" + table_block).strip()
                # Portrait block until STEP 2 (spec + declared constructs + rules).
                step2 = re.search(r"\n---\n\n## STEP 2|\n## STEP 2", after)
                if step2:
                    description = after[: step2.start()].strip()
                    remainder = after[step2.start() :].lstrip("\n")
                else:
                    description = after.strip()
                    remainder = ""
                parts = [
                    prefix,
                    "",
                    "::: {.landscape .step1-inventory}",
                    inventory,
                    ":::",
                    "",
                    "::: {.portrait-start .step1-description}",
                    description,
                    ":::",
                    "",
                    remainder,
                ]
                return "\n".join(p for p in parts if p is not None).strip() + "\n"

        if html_end != -1:
            table_end = html_end + len("</table>")
            inventory = from_step1[:table_end].strip()
            after_table = from_step1[table_end:]
            step2 = re.search(r"\n---\n\n## STEP 2", after_table)
            if not step2:
                step2 = re.search(r"\n## STEP 2", after_table)
            if step2:
                description = after_table[: step2.start()].strip()
                remainder = after_table[step2.start() :].lstrip("\n")
            else:
                description = after_table.strip()
                remainder = ""
            parts = [
                prefix,
                "",
                "::: {.landscape .step1-inventory}",
                inventory,
                ":::",
                "",
                "::: {.portrait-start .step1-description}",
                description,
                ":::",
                "",
                remainder,
            ]
            return "\n".join(p for p in parts if p is not None).strip() + "\n"

    return text


def build_h4_flow_pdf(
    md: Path,
    out_dir: Path,
    profile_root: Path,
    edge: Path,
) -> Path:
    if not COMPACT_CSS.is_file() or not H4_CSS.is_file():
        raise FileNotFoundError("Missing H4 or compact CSS next to this script")

    raw = md.read_text(encoding="utf-8")
    transformed = fix_step3_interaction_asterisks(transform_h4_flow_markdown(raw))

    with tempfile.NamedTemporaryFile(
        mode="w",
        suffix=".md",
        prefix="H4_Selection_Flow_",
        dir=HERE,
        delete=False,
        encoding="utf-8",
    ) as tmp:
        tmp.write(transformed)
        staging = Path(tmp.name)

    try:
        return build_pdf(
            edge,
            staging,
            out_dir,
            profile_root,
            css_files=[COMPACT_CSS, H4_CSS],
            pandoc_from="markdown+fenced_divs",
            pdf_stem=md.stem,
        )
    finally:
        staging.unlink(missing_ok=True)


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="H4 Selection Flow PDF with landscape Step 1.")
    parser.add_argument(
        "markdown",
        nargs="?",
        type=Path,
        default=DEFAULT_MD,
        help=f"Source .md (default: {DEFAULT_MD.relative_to(REPO)})",
    )
    parser.add_argument(
        "--out-dir",
        type=Path,
        default=DEFAULT_OUT_DIR,
        help=f"PDF output folder (default: {DEFAULT_OUT_DIR})",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv or sys.argv[1:])
    md = args.markdown.resolve()
    out_dir = args.out_dir.resolve()

    if not md.is_file():
        print(f"missing source: {md}", file=sys.stderr)
        return 1

    try:
        edge = find_edge()
    except FileNotFoundError as exc:
        print(exc, file=sys.stderr)
        return 1

    profile_root = HERE.parent / "temp" / "_tmp_edge_pdf_profile" / "Presentation material"
    profile_root.mkdir(exist_ok=True)

    try:
        pdf = build_h4_flow_pdf(md, out_dir, profile_root, edge)
        print(f"OK\t{pdf}\t{pdf.stat().st_size} bytes")
        return 0
    except Exception as exc:
        print(f"{md}: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
