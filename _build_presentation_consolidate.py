# -*- coding: utf-8 -*-
"""Entrypoint: delegates to Brain/_build_presentation_consolidate.py (canonical paths)."""
from pathlib import Path
import runpy

runpy.run_path(
    str(Path(__file__).resolve().parent / "Brain" / "_build_presentation_consolidate.py"),
    run_name="__main__",
)
