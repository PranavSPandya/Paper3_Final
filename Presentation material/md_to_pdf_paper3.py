"""Convert Paper3 markdown reports to compact PDF (pandoc → HTML → Edge headless).



Reads markdown from repo output paths (or explicit paths); writes PDFs only into

this folder (Presentation material) by default, named from each source stem

(e.g. Sound_screening_pca_vif.pdf, H4_Selection_Flow.pdf).

H4_Selection_Flow uses landscape Step 1 + Sound highlight; see md_to_pdf_h4_flow.py.

Regenerate all default PDFs (repo root):

  python "Presentation material/md_to_pdf_paper3.py"

H4 flow only:

  python "Presentation material/md_to_pdf_h4_flow.py"

"""

from __future__ import annotations



import argparse

import subprocess

import sys

import tempfile

from pathlib import Path



HERE = Path(__file__).resolve().parent

REPO = HERE.parent

DEFAULT_OUT_DIR = HERE

CSS = HERE / "_md_to_pdf_compact.css"



EDGE_CANDIDATES = [

    Path(r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"),

    Path(r"C:\Program Files\Microsoft\Edge\Application\msedge.exe"),

]



DEFAULT_MD_REL = [
    REPO / "Presentation material" / "Sound_screening_pca_vif.md",
    REPO / "Presentation material" / "H4_Selection_Flow.md",
    REPO / "Presentation material" / "H4_Selection_Flow_explained.md",
    REPO / "Presentation material" / "Reference Literature for all Paper3.md",
]

REFERENCE_LIT_FALLBACK = REPO / "Presentation material" / "Reference Literature for all Paper3.md"





def find_edge() -> Path:

    for p in EDGE_CANDIDATES:

        if p.is_file():

            return p

    raise FileNotFoundError(

        "Microsoft Edge not found (needed for headless --print-to-pdf). "

        f"Tried: {', '.join(str(p) for p in EDGE_CANDIDATES)}"

    )





def resolve_default_sources() -> list[Path]:

    sources: list[Path] = []

    for p in DEFAULT_MD_REL:

        if p.name == "Reference Literature for all Paper3.md" and not p.is_file():

            if REFERENCE_LIT_FALLBACK.is_file():

                p = REFERENCE_LIT_FALLBACK

        sources.append(p)

    return sources





def file_uri(path: Path) -> str:

    return path.resolve().as_uri()





def pdf_path_for(md: Path, out_dir: Path) -> Path:

    return out_dir / f"{md.stem}.pdf"





def build_pdf(
    edge: Path,
    md: Path,
    out_dir: Path,
    profile_root: Path,
    *,
    css_files: list[Path] | None = None,
    pandoc_from: str = "markdown",
    pdf_stem: str | None = None,
) -> Path:

    if not md.is_file():

        raise FileNotFoundError(md)

    styles = css_files or [CSS]

    for css in styles:

        if not css.is_file():

            raise FileNotFoundError(css)



    stem = pdf_stem or md.stem

    pdf_out = out_dir / f"{stem}.pdf"

    pdf_out.parent.mkdir(parents=True, exist_ok=True)



    with tempfile.TemporaryDirectory(prefix="md2pdf_", dir=HERE) as tmp:

        tmp_dir = Path(tmp)

        html = tmp_dir / f"{stem}.html"

        pandoc_cmd = [
            "pandoc",
            str(md),
            "-s",
            f"--from={pandoc_from}",
            "-o",
            str(html),
        ]

        for css in styles:
            pandoc_cmd.append(f"--css={css}")

        subprocess.run(

            pandoc_cmd,

            check=True,

            cwd=md.parent,

        )



        pdf_out.unlink(missing_ok=True)

        profile = profile_root / stem.replace(" ", "_")

        profile.mkdir(parents=True, exist_ok=True)

        cmd = [

            str(edge),

            "--headless=new",

            "--disable-gpu",

            "--no-first-run",

            "--no-default-browser-check",

            f"--user-data-dir={profile}",

            "--no-pdf-header-footer",

            "--virtual-time-budget=15000",

            f"--print-to-pdf={pdf_out.resolve()}",

            file_uri(html),

        ]

        subprocess.run(cmd, check=True, timeout=300)



    if not pdf_out.is_file() or pdf_out.stat().st_size == 0:

        raise RuntimeError(f"PDF not created or empty: {pdf_out}")

    return pdf_out





def parse_args(argv: list[str]) -> argparse.Namespace:

    parser = argparse.ArgumentParser(

        description=(

            "Convert Paper3 markdown reports to compact PDF. "

            "Default sources: three standard repo paths; default output: Presentation material."

        )

    )

    parser.add_argument(

        "markdown",

        nargs="*",

        help="Optional .md file(s). If omitted, converts the three default Paper3 reports.",

    )

    parser.add_argument(

        "--out-dir",

        type=Path,

        default=DEFAULT_OUT_DIR,

        help=f"Directory for PDF output (default: {DEFAULT_OUT_DIR}).",

    )

    return parser.parse_args(argv)





def main(argv: list[str] | None = None) -> int:

    args = parse_args(argv or sys.argv[1:])

    out_dir = args.out_dir.resolve()



    if args.markdown:

        sources = [Path(p).resolve() for p in args.markdown]

    else:

        sources = resolve_default_sources()



    try:

        edge = find_edge()

    except FileNotFoundError as exc:

        print(exc, file=sys.stderr)

        return 1



    profile_root = REPO / "temp" / "_tmp_edge_pdf_profile" / "Presentation material"

    profile_root.mkdir(exist_ok=True)



    failures: list[str] = []

    built: list[Path] = []



    for md in sources:

        if not md.is_file():

            failures.append(f"missing source: {md}")

            continue

        try:

            if md.stem in ("H4_Selection_Flow", "H4_Selection_Flow_explained"):
                from md_to_pdf_h4_flow import build_h4_flow_pdf

                pdf = build_h4_flow_pdf(md, out_dir, profile_root, edge)
            else:
                pdf = build_pdf(edge, md, out_dir, profile_root)

            built.append(pdf)

            print(f"OK\t{pdf}\t{pdf.stat().st_size} bytes")

        except subprocess.CalledProcessError as exc:

            failures.append(f"{md}: command failed ({exc})")

        except Exception as exc:

            failures.append(f"{md}: {exc}")



    if failures:

        for msg in failures:

            print(msg, file=sys.stderr)



    if not built:

        print(

            "No PDFs built. Requires: pandoc on PATH, Microsoft Edge, and valid markdown sources.",

            file=sys.stderr,

        )

        return 1 if failures else 2



    return 1 if failures else 0





if __name__ == "__main__":

    sys.exit(main())


