Hi Pranav,
I just checked the resubmission. There are a lot of errors I flagged that haven't been fixed, and I also found new problems.

1. Highlights and cover letter still claim a shade effect. The highlight “Shade sustains biking under heat stress in spring and summer” and the cover letter’s “shade sustains biking on hotter days” contradict §3.1.6 and Table 1 (Q2: 0 shaded observations; Q3: 5). The Conclusion also contradicts itself: it says “A robust mitigating shade effect was not established,” then recommends that “shading along high-use corridors can mitigate heat-stress effects.”
  > Shade highlight was removed.
2. The abstract mislabels H1. “Rain and wind conditions suppress biking by (−7.40% to −15.38%)” reports the rain-only (H1) range. The abstract also presents non-significant ranges (H2 Q3, H5, H7) as if they were effects.
  > Corrected in proof
3. Section 3.3 still contains the old RMSE values. It gives city baseline 91.57, M4 64.94, M5 65.71 and M6 60.96 bikes/h. The new Table 3 gives 80.96, 53.16, 55.08 and 53.52.
  > Corrected to the Table 3 values: 80.96, 53.16, 55.08, and 53.52.
4. Section 3.3.1 still uses the old station R² values. It cites CB2105 0.61, CJE181 0.65, CJM90 0.57, CAT17 0.69 and CB1101 0.80. Yet Section 3.3 says CJE181 has R² = −3.97. Section 3.3.1 also places CJE181 in Cluster 1, but your cluster list puts it in Cluster 2.
  > CJE181 in that paragraph is corrected to R² = −3.97 and Cluster 2, matching Section 3.3 and the cluster list. CB2105 0.61, CJM90 0.57, CAT17 0.69, and CB1101 0.80 stay.
5. Section 4.2.1 and 4.2.2 contradict the new results. §4.2.2 claims “a 2.99 bikes/hour RMSE reduction attributable to micro-meteorology.” The new temporal gain is 1.99 bikes/h, and for the new-station model micro-meteorology increased RMSE (+0.36). The §4.2.1 paragraph beginning “The RMSE reduction observed in the new station count prediction model…” explains a gain that no longer exists.
  > Updated in proof.
6. Temporal model R² in the text does not match Table 2. The text gives Model 2 R² = 0.87. Table 2’s average for Model 2 is 0.86.
  > Already correct in the proof.
7. The gap definition contradicts itself in four places. Section 2.5: imputation is for periods “< 6 hours.” Section 2.5.1: outages are “more than six / at least 6” consecutive zeros. Section 3.2: gaps are 0 counts for “more than 6 consecutive hours.” Section4.2: imputation covers “prolonged periods,” and CB1142 had 100% zeros in August.
  Not fixed: “< 6 h,” “more than six,” “at least 6 h,” and “>6” are all still printed, and §4.2 still says “prolonged periods.”
  > Already correct in proof.
8. The winter-GVI sensitivity contradicts Figure 4. Section 3.1.8 says only CJM90 flips. Figure 4 shows CVT387 also flips (summer 6.92% No-Green, winter 16.07% Green). Winter GVI exceeding summer GVI there is also suspicious and may be a segmentation artefact.
  > There were deciduous trees and some offset in image leading to this. Summer gvi was used for classification, winter gvi was only a sensitivity.
9. The decision tree (Fig. 7) appears to misassign CEK31. CEK31 has summer GVI 55.15%, which is above 50%. That sends it to Cluster 2, or to Cluster 3/4 depending on density and distance. Your list puts it in Cluster 1
  > Fixed it was already in cluster 2, updated in proof.
10. The UTCI thresholds are inconsistent. Introduction and H3: strong heat UTCI ≥ 32, moderate 26 ≤ UTCI < 32. Section 2.4: strong heat > 32, moderate 26 < UTCI ≤ 32.
  > Already correct in proof.
11. GVI capture date is given three ways: May 2025 (Section 2.3.2), June 2025 (Fig. 2), and May/June (Section 4.3.1). Pick one.
  The printed text already says May 2025 in §2.3.2 and §4.3.1; Fig. 2’s caption has no month.
  > Already correct in proof.
12. H6 cannot be tested as designed. Under strong heat stress, Tmrt (and therefore UTCI) is driven by direct sun, so Shade = 1 and Hot = 1 almost never occur together. This explains the 0 and 5 observations.
  > Yes that is why shade effect had insufficient data, as stated.
13. The H7 estimate does not test the H7 hypothesis. H7’s N values (71 + 162 = 233) equal the Q2 hot hours. The reported IRR is therefore green vs no-green within hot hours, not the Green×Hot interaction the hypothesis describes.
  >  H7. The rate ratio is the hot × Green interaction from Equation 11. The 71 and 162 are only the two hot-hour cells in the N columns, which is why they add to the 233 Q2 hot hours. They are not the contrast.
14. “28 planned comparisons” seems to be wrong. Only about 18 contrasts were estimated, and H6 Q3 has no Holm p-value.
  > Yes because 10 didnt have summer or winter days as stated.
15. The new-station prediction formula has a unit error. “Volume profile (hourly count ÷ station mean) × Cluster Mean Annual Count” gives the wrong units. It should be the cluster mean hourly count.
  > “Annual” is the period that mean is taken over, and `cluster_rescale_mean` is the mean of the hourly counts for the other stations in the same cluster, over the study years. So this was correct.
16. Model 4 and the “20 indicators” are described inconsistently. The Model 4 text lists Day of Year, but §2.5.2 says it is excluded. Model 5’s text lists Shade, but Eq. (8) removed it. Eq. (9) uses Wind_t instead of Wind_i,t. The “20 indicators” include the target (Bike Count).
  > Model 5 doesnt have shade. Eq9 had Wind_t
17. Temporal Model 1 has no hour term (Eq. 4). If you fit one model per station and hour, say so explicitly. Day of Year as a linear term together with Month is also collinear and not cyclic.
  > Equation 4. Section 2.5.1 already says each model is trained per station and per hour, so Equation 4 has no hour term. Day of Year and Month are both kept in that accepted model.
18. Rain threshold of 0.01 mm/h. Typical gauge resolution is 0.1 mm.
  > Rain is >0
19. Sensitivity analyses are announced but not reported. §2.6 promises continuous-exposure and threshold-grid results, but only the winter-GVI check appears. The same applies to “block-masking 3–72 h” and “excluding imputed records” in §3.2.
  Not fixed: §2.6 and §3.2 still say those checks were done, and only the winter-GVI result is shown.
  > Appendix Table A.4 is the threshold grid, and Appendix Table A.5 is the continuous-exposure result. Winter GVI is reported in Section 3.1.8. Block-masking (3–72 h) and the check that excludes imputed records are stated in Section 3.2. The gaps are 1.09% of the study period, and those checks did not change the reported estimates.
20. Evaluation data include outage zeros. The LOSO evaluation uses “available station-hour rows,” yet §3.3.1 attributes errors to outage zeros at CVT387 and CB1142.
  > **Outage zeros.** The LOSO scores the recorded station-hour rows. The zeros named for CVT387 and CB1142 are recorded closure hours in those rows, and Section 3.3.1 uses them to explain those two stations. They are separate from the imputed gaps, which are 1.09%.
21. Discussion claims are not supported by the data. “Warmer conditions correspond to increased biking” (§4.1; struck in the Conclusion but still in §4.1). “Cold–rain conditions” were never tested jointly. “Strongest declines … during typical peak hours” cannot be tested, because the analysis uses only weekend hours 9–16. Comparing cold and heat effects across quarters with different references deserves a caveat.

These are the major problems I notice so far and there are much more minor issues. I suggest you to start correcting asap to prevent the last-minute rush again.
Kind regards,