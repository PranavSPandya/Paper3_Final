# Paper 3 — QGIS Package: Study Area & Active Transit Corridors

This directory contains the production-grade, self-contained **QGIS Project Package** and **Print Layouts** for **Paper 3 (Active Transit in Green vs. Urban Corridors, Brussels-Capital Region)**.

---

## 1. Quick Start Guide

1. **Open the Project**:
   * Double-click **`Paper3_Study_Area.qgz`** (or open **`Paper3_Study_Area.qgs`**) in QGIS (version 3.16+ / 3.22 / 3.28 / 3.34+ / 3.44 LTR).
   * All layers use **relative paths** (`./data/...`), so this folder can be moved or shared anywhere without path errors.
   * **Project CRS**: Canonical **`EPSG:31370` (BD72 / Belgian Lambert 72)** with full WKT2 definitions.
2. **Access the Dual Print Layouts**:
   In QGIS, go to top menu **`Project` → `Layouts`**:
   * **`styled_map`**: Wide publication format (350 × 145 mm, aspect ratio 2.41:1), directly matching the 3-panel figure with side-by-side maps, titles above each panel, tags `(a)`, `(b)`, `(c)`, connector lines from Brussels to Panel (b), and integrated route legend.
   * **`Paper3_Study_Area_Map`**: Standard A4 Landscape (297 × 210 mm) with top header banner, scale bars, north arrows, callout annotations, and full bottom metadata block.
3. **Use the Standalone Layout Templates**:
   * **`styled_map.qpt`**: Importable template for the styled 3-panel layout.
   * **`Study_Area_Layout_Template.qpt`**: Importable template for the A4 landscape layout.
   * In any QGIS project: **`Project` → `Layout Manager` → `New from Template`**.

---

## 2. Directory Contents

| File / Folder | Format | Description |
| :--- | :--- | :--- |
| **`Paper3_Study_Area.qgz`** | QGIS Project Archive | Main compressed project file containing styled layers and both print layouts. |
| **`Paper3_Study_Area.qgs`** | QGIS XML Project | Uncompressed human-readable project file with canonical EPSG:31370 CRS definitions. |
| **`styled_map.qpt`** | QGIS Layout Template | Standalone template for the styled 3-panel horizontal map. |
| **`styled_map_export.png`** | Raster Image (300 DPI) | High-resolution render matching the 3-panel publication layout (4133 × 1712 px). |
| **`styled_map_export.pdf`** | Vector Document | Scalable publication-grade vector PDF of `styled_map`. |
| **`Study_Area_Layout_Template.qpt`** | QGIS Layout Template | Standalone template for the A4 landscape layout. |
| **`Study_Area_Layout_Export.png`** | Raster Image (300 DPI) | High-resolution render of the A4 layout (3507 × 2480 px). |
| **`Study_Area_Layout_Export.pdf`** | Vector Document | Scalable vector PDF of the A4 layout. |
| **`data/`** | OGC GeoPackage (`.gpkg`) | Standardized geospatial data layers in both `EPSG:31370` and `EPSG:4326`. |
| **`shapefiles/`** | ESRI Shapefiles (`.shp`) | Official shapefiles with canonical `.prj` headers for universal GIS compatibility. |
| **`Path buffer/`** | GeoPackage (`.gpkg`) | Individual 50m flat-cap buffer files for each transit phase (`BikeG`, `BikeU`, `Tram`, `WalkG`, `WalkU`). |
| **`path_withstop/`** | CSV & PNG | Processed participant GPS logs and speed threshold reference figures. |

---

## 3. Visual Styling & Transparency Specifications

1. **50% Transparency on Administrative Polygons**:
   * **Belgium National Boundary:** Layer opacity set to **50%** (`opacity=0.50`) and fill color set to `#f8fafc` at 50% alpha (`QColor(248, 250, 252, 128)`). This allows OpenStreetMap topography, cities, and road networks to show through cleanly while maintaining a crisp border stroke (`#1e293b`).
   * **Brussels-Capital Region:** Layer opacity set to **50%** (`opacity=0.50`) and fill color set to `#f97316` at 50% alpha (`QColor(249, 115, 22, 128)`).
2. **Routes & Active Transit Envelopes (100% Crisp & Opaque)**:
   * **`WalkG`**: Forest Green (`#2ca25f`), solid 0.95 mm line + 50 m buffer envelope (`#14532d`).
   * **`BikeG`**: Emerald Green (`#006d2c`), solid 0.95 mm line + 50 m buffer envelope (`#052e16`).
   * **`WalkU`**: Crimson Red (`#ef4444`), solid 0.95 mm line + 50 m buffer envelope (`#7f1d1d`).
   * **`BikeU`**: Amber Orange (`#f97316`), solid 0.95 mm line + 50 m buffer envelope (`#7c2d12`).
   * **`Tram`**: Purple (`#8b5cf6`), solid 0.95 mm line + 50 m buffer envelope (`#4c1d95`).
   * **`Matched 8-min Windows`**: High-contrast dashed line overlays (1.15 mm width).
3. **Study Area Bound Rectangle in Panel (b)**:
   * Panel (b) Brussels includes an overview bounding rectangle (`#dc2626` crisp red stroke, 0.7 mm width) dynamically linked to Panel (c), clearly indicating the location of the experimental corridor within the capital.
   * The meteorological station star icon has been removed from Panel (b) to focus solely on the regional context and study area location.
4. **OSM Basemap Boundary Clipping in `styled_map` Layout**:
   * **Panel (a) Belgium**: OSM tiles are strictly clipped inside the Belgium national boundary using an exterior mask (`#ffffff` fill, no border). Outside territory and sea water artifacts are cleanly eliminated.
   * **Panel (b) Brussels-Capital Region**: OSM tiles are strictly clipped to the BCR administrative shapefile boundary (`#ffffff` exterior mask).
   * **Panel (c) Corridor**: Kept with full street network and environmental context.

---

## 4. Official Boundary Data Sources

1. **National Boundary (Belgium)**:
   * **Source**: **European Commission / Eurostat GISCO** (Geographic Information System of the Commission), NUTS 2021 database (`NUTS_RG_01M_2021_4326_LEVL_0.geojson`, code `BE`).
   * **North-West Boundary**: Verified as the **North Sea** coastline (67 km from De Panne to Knokke-Heist). Explicitly labeled `NORTH SEA (Water)` in blue.
2. **Regional Boundary (Brussels-Capital Region)**:
   * **Source**: **Eurostat GISCO NUTS 2021** (`LEVL_1.geojson`, code `BE1`) and **Statbel / IGN-NGI Open Data**.
3. **Reference Meteorological Station**:
   * **Source**: **Royal Meteorological Institute of Belgium (RMI / KMI-IRM)** — Uccle Automatic Weather Station (AWS, 104 m a.s.l.).
4. **Base Cartography**:
   * **Source**: **OpenStreetMap contributors** (ODbL). Standard XYZ raster tiles set at 60% opacity.
5. **Study Corridor Terminology**:
   * Strictly uses **"Etterbeek Corridor"** (Boulevard Général Jacques / Avenue de la Couronne) for the urban transects and **"Bois de la Cambre"** for the green transects (*strictly no mention of Ixelles*).
