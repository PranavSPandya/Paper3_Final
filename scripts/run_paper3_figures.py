"""Run Paper3_Figures.ipynb for phaseavg and timeseries output folders."""
from __future__ import annotations

import json
import os
from pathlib import Path

os.environ.setdefault("MPLBACKEND", "Agg")

import matplotlib.pyplot as plt

plt.show = lambda *args, **kwargs: None  # noqa: ARG005 — headless run

NOTEBOOK = Path(__file__).resolve().parent / "Paper3_Figures.ipynb"
PROJECT_ROOT = NOTEBOOK.resolve().parent.parent
os.chdir(PROJECT_ROOT)

# Config + helpers once; reload/plot/save per analysis mode.
SETUP_CELLS = (1, 2, 3)
PLOT_CELLS = (5, 7, 9, 11, 13, 14, 16, 18)
ANALYSIS_MODES = ("phaseavg", "timeseries")


def _code_cells(nb: dict) -> list[tuple[int, str]]:
    out: list[tuple[int, str]] = []
    for index, cell in enumerate(nb.get("cells", [])):
        if cell.get("cell_type") != "code":
            continue
        source = "".join(cell.get("source", []))
        if source.strip():
            out.append((index, source))
    return out


def main() -> None:
    with NOTEBOOK.open(encoding="utf-8") as handle:
        nb = json.load(handle)

    indexed = {idx: src for idx, src in _code_cells(nb)}
    namespace: dict = {
        "__name__": "__main__",
        "__file__": str(NOTEBOOK),
    }

    for idx in SETUP_CELLS:
        exec(compile(indexed[idx], f"{NOTEBOOK.name}:cell_{idx + 1}", "exec"), namespace)

    figures_root = namespace["FIGURES_ROOT"]
    for mode in ANALYSIS_MODES:
        print(f"\n=== Figure bundle: {mode} -> {figures_root / mode} ===")
        namespace["reload_figure_data"](mode)
        for idx in PLOT_CELLS:
            exec(compile(indexed[idx], f"{NOTEBOOK.name}:cell_{idx + 1}", "exec"), namespace)

    print("\nDone. Figure folders:")
    for mode in ANALYSIS_MODES:
        folder = figures_root / mode
        if folder.is_dir():
            for png in sorted(folder.glob("*.png")):
                print(f"  [{mode}] {png.name}")


if __name__ == "__main__":
    main()
