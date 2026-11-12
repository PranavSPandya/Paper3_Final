# H4 family-table spectrum duplicate
Run UTC: 2026-11-12 08:48:14 UTC
Input MD5: a3c4f9388b61def82e5b97b4232315be
- Family equations that use sound are repeated for dBA, octave SHARE, band LEVEL, L90-excess, and YAMNet/spectrum columns.
- dBA_energy_mean = 10 log10 mean of 10^(dBA/10). SHARE encodings = arithmetic bout mean of octave/freq proportions.
- Band LEVEL L_low/L_f20/L_63 = 10 log10 mean(share * 10^(dBA/10)). L_excess subtracts bout L90 in linear units first.
- Y ~ dBA_z + UTCI_z is not run (not a source thermal-vote formula; not the H4 close).
- H4 increase close = Peng thermal ~ sound_z, p<0.05.
