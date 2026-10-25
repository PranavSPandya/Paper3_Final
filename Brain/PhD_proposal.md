# PhD Research Proposal & Authoritative Targets (Single Source of Truth)

> **File Purpose:** Synthesis of the three core PhD proposal and confirmation documents. This file serves as the permanent, authoritative benchmark for all target deliverables, research hypotheses, work packages, and paper roadmaps across the PhD.
>
> **Synthesized Sources:**
> 1. `./source_documents/Pranav Uclouvain asp_partie_scientifique_EN_17-02-2022_final.pdf` *(Original FNRS ASP Scientific Proposal, Feb 2022)*
> 2. `./source_documents/Progress report for confirmation.docx` *(Mid-Term Confirmation Progress Report, Feb 2024)*
> 3. `./source_documents/ASP Renewal Grant FNRS version 8.docx` *(FNRS ASP Renewal Grant Application, 2024)*

---

## 1. Project Identification & Overview

- **PhD Candidate:** Pranav Shailesh Pandya
- **Host Institution:** UCLouvain (Université catholique de Louvain), LAB (Louvain research institute for Landscape, Architecture, Built environment)
- **Funding Body:** F.R.S.-FNRS (Aspirant / Research Fellow, Ref e-space: 40011852)
- **Admission Date:** 01/10/2022
- **PhD Topic:** Urban Green Infrastructure for Stress Reduction and Thermal Comfort (GIST)
- **Primary Case Study Region:** Brussels Capital Region (BCR), Belgium

---

## 2. Research Core Hypotheses & Objectives

### Working Hypothesis 1 (Environmental & Urban Morphology)
Urban fabric characteristics and small-to-medium scale Urban Green Infrastructure (UGI) integrated within the urban fabric modulate environmental conditions and psychophysiological Outdoor Thermal Comfort (OTC). The research aims to identify the specific role that urban fabric design and UGI characteristics (tree canopy ratio, geometry, species diversity, green patches, view factors) play in enhancing OTC and reducing physiological stress, specifically for soft mobility users with a focus on bicycle riders and pedestrians.

### Working Hypothesis 2 (Multi-Domain User-Centered Methodology)
Outdoor thermal comfort and stress evaluation cannot be assessed by physical micrometeorology alone; it requires a multi-domain (thermal, visual, acoustic, and air quality) and user-centered research methodology combining:
1. High-resolution in-situ microclimate sensing,
2. Detailed spatial and visual UGI documentation (e.g. Green View Index - GVI),
3. Continuous physiological / biometric monitoring (HRV, EDA/Skin Conductance, Skin Temperature),
4. Subjective psychometric assessments (validated questionnaires for perceived restorativeness, state anxiety, and thermal sensation).

---

## 3. Work Packages (WP1 to WP5) & Deliverables

### WP1: Systematic Review & Methodological Framework (Completed)
- **Target:** Identify state-of-the-art experimental practices for human-centered OTC field studies, map research gaps, and establish standardized guidelines for multi-sensor wearable data collection in outdoor urban spaces.
- **Key Deliverable (Paper #1):**
  - Systematic review journal paper titled: *"Environmental and psychophysiological data collection for urban outdoor thermal comfort assessment"*.
  - Protocol definition for ethics approval and field campaign design.
- **Target Venue:** *Building and Environment* / high-impact urban climate journal.

### WP2: Geospatial Documentation & Macro/Micro UGI Analysis (Completed / Informs WP3)
- **Target:** Compile and cross-examine multi-source geospatial datasets across the Brussels Capital Region (BCR) to characterize urban morphology, vegetative cover, and microclimate distributions.
- **Datasets Compiled:**
  - Remote Sensing: NASA Landsat (30 m) and MODIS (250 m) for Land Surface Temperature (LST) and Normalized Difference Vegetation Index (NDVI).
  - High-Resolution Aerial Data: UrBIS LiDAR point cloud and geospatial databases for building heights, street geometry, and vegetation canopies.
  - Climate Reanalysis: Copernicus Climate Change Service (C3S / VITO) data at 100 m resolution (air temperature, relative humidity, wind speed, solar radiation).
  - Thermal Indices: Computation of Universal Thermal Climate Index (UTCI), Physiological Equivalent Temperature (PET), and Predicted Mean Vote (PMV) across Brussels cycling routes.

### WP3: Experimental Campaign — Bicycling Count, Speed & Microclimate/GVI (Paper #2)
- **Target:** Investigate the behavior of urban cyclists seeking thermally and environmentally comfortable cycling routes/times across the BCR, evaluating how weather extremes, seasonal changes, and street-level greenery influence bicycle flow.
- **Data & Methods:**
  - Hourly and 15-minute automated bicycle counter data from Brussels Mobility (18 stations across BCR, 2019–2023 / 2024).
  - Google Street View (GSV) 360° panoramic imagery collected at counter locations in both summer and winter.
  - Semantic segmentation using deep convolutional models (Xception / DeepLabv3+ with PixelLib) to calculate seasonal Green View Index (GVI: trees, grass, low plants).
  - Statistical and machine learning modeling: Negative Binomial Regression (NB2) for hypothesis testing (H1–H7: rain, wind, heat, cold, GVI, shade interactions) and Leave-One-Station-Out (LOSO) cross-validation with Random Forest for predictive generalization.
- **Key Deliverable (Paper #2):**
  - Full journal manuscript on the impact of microclimate, weather extremes, and seasonal street greenery on cycling mobility.
  - Revisions, sensitivity analyses, and response to reviewers.

### WP4: Human-Centered Multi-Sensor Field Campaign (Paper #3)
- **Target:** Conduct an on-site, human-subject experimental field campaign in Brussels measuring real-time physiological stress, subjective psychological perceptions, eye tracking, and personal environmental exposure across contrasting urban and green mobility environments.
- **Experimental Design & Routes:**
  - 17–18 adult participants (P2 to P18; P1 test pilot).
  - 5 core experimental phases comparing modes and environments:
    1. `BikeU` (Cycling in Urban setting: Usquare / Etterbeek toward Montgomery)
    2. `WalkU` (Walking in Urban setting)
    3. `BikeG` (Cycling in Green setting: Bois de la Cambre park)
    4. `WalkG` (Walking in Green setting)
    5. `Tram` (Public Transit: Boondael Gare to Etterbeek Gare)
    - Additional baseline/transition phases: `Indoor` (quiet baseline), `Reststop` (transitions between routes).
- **Multi-Sensor Suite:**
  - **Empatica Embrace Plus:** Continuous physiological monitoring (Blood Volume Pulse / BVP, Heart Rate Variability / HRV, Electrodermal Activity / EDA / Skin Conductance, Skin Temperature / ST, Accelerometer).
  - **Pupil Labs Neon Eye Tracker:** Gaze tracking, pupil dilation, fixation counts, scene camera capture.
  - **LYS Button (1 & 2):** Ambient light spectrum, intensity, and circadian lux (LYS 1 on participant, LYS 2 on researcher).
  - **Atmotube Pro (Left & Right):** Mobile air quality sensing (VOCs, PM1, PM2.5, PM10) positioned on researcher to capture directional pollution.
  - **ucm Hepia Backpack (Cityfeel):** Mobile microclimatic station measuring air temperature, relative humidity, black globe temperature (mean radiant temperature / MRT proxy), atmospheric pressure, noise, and GPS coordinates.
  - **Psychometric Questionnaires:** State-Trait Anxiety Inventory (STAI), Perceived Restorativeness Scale (PRS), Thermal Sensation Vote (TSV), acoustic and overall comfort scales.
- **Key Deliverable (Paper #3):**
  - Full journal paper comparing physiological stress vs. psychological comfort responses across urban vs. green transit modes.
  - Potential second specialized paper/conference contribution on multi-sensor exposure fusion.

### WP5: Thesis Synthesis, Packaging & Defense
- **Target:** Doctoral dissertation preparation synthesizing findings from WP1 through WP4 into a coherent multi-domain urban comfort framework for urban planners, landscape architects, and municipal transport authorities.
- **Structure:**
  - Chapter 1: Introduction, Problem Statement, Objectives & Hypotheses
  - Chapter 2: Literature Review & Methodological Framework (Paper #1)
  - Chapter 3: Macro/Mesoscale Urban Morphology & Bicycle Mobility under Climate Stress (Paper #2)
  - Chapter 4: Microscale Human-Centered Experimental Campaign: Physiological vs Psychological Comfort (Paper #3)
  - Chapter 5: Integrated Urban Planning & Design Guidelines for Resilient Soft Mobility
  - Chapter 6: Conclusion, Limitations & Future Research Horizons
- **Final Steps:** Manuscript review with supervisory panel, doctoral confirmation, private defense, public defense.

---

## 4. Key Milestone Status Matrix (Reference Benchmark)

| Work Package | Deliverable | Original Target Window | Current Status Benchmark |
|---|---|---|---|
| **WP1** | Paper #1 (Systematic Review & Framework) | Year 1 (2022–2023) | **Completed / Published** |
| **WP1** | Ethics Agreement for Human Experimentation | Year 1–2 (2023) | **Completed / Approved** |
| **WP2** | Macro Geospatial Analysis & Climate Reanalysis | Year 1–2 (2023–2024) | **Completed** |
| **WP3** | Paper #2 (Bike Count, GVI & Microclimate Modeling) | Year 2–3 (2024–2025) | **Submitted / Revisions Addressed** |
| **WP4** | Field Campaign Execution (Sensors & Surveys) | Summer 2024–Fall 2024 | **Completed** (Data collected for P2–P18) |
| **WP4** | Multi-Sensor Data Processing Pipeline | Fall 2024–2025 | **Active / In Progress** |
| **WP4** | Sensor Cross-Validation & Statistical Merging | 2025–2026 | **Pending** |
| **WP4** | Paper #3 Manuscript Preparation | 2025–2026 | **Pending** |
| **WP5** | Doctoral Thesis Writing & Defense | Final 6 Months | **Pending** |
