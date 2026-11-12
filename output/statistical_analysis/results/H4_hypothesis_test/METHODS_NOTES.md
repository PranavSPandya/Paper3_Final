# H4 confirmatory hypothesis tests
Run UTC: 2026-11-10 14:35:56 UTC
Input MD5: a3c4f9388b61def82e5b97b4232315be
Code MD5: H4_hypothesis_test.R e53f1489c59cd3ac0fce28bb8511621f
Code MD5: Paper3_common.R c5dfe4192833af6294e31d56d64bad90
Code MD5: H4_hypothesis_helpers.R 5d3e967e48d89aa613054484eb076e43

## Hypothesis
H4: Exposure to sound amplifies human discomfort under thermally uncomfortable outdoor conditions.
Confirmatory estimand: interaction between thermal discomfort (or UTCI) and measured dBA.

## Analyses
- Primary (perceived): phase-level REML LMM comfort ~ thermal_discomfort_z * dba_z + phase contrasts + (1|ParticipantID).
  Thermal discomfort = |thermal comfort vote − 3| on the 1–5 TCV scale (bout mean).
- Sensitivity (perceived): same structure with bout-mean UTCI instead of questionnaire discomfort.
- Secondary (physiology): 10 s and phase-mean LMMs Y ~ UTCI_z * dBA_z + Eq1 covariates; random intercepts and AR(1) within bout at 10 s.

## Not included
- Literature-method ports (Rodrigues, Grapas, Moshammer, etc.), YAMNet spectrum substitutes, and additive Eq1–7 grids.

## Multiple testing
Benjamini–Hochberg q-values are computed within analysis x grain x thermal_measure x fixed term across outcomes in that block.
