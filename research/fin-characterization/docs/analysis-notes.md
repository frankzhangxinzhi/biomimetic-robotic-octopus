# Original Processing and Reproduction Notes

Audit date: 2026-10-29. Source recordings and MATLAB files were read without modification. Independent calculations used Python/NumPy and MAT-file inspection. The initial numerical cross-check was followed by direct execution of the original `getProcessedData.m` in MATLAB R2024a Update 6 for all 98 referenced trials. Selected ratios and `d_ratio` values matched the saved results within 1e-10. The original `OverallPlots.m` also executed successfully and generated all three figures. No source files or saved MAT snapshots were overwritten. See `matlab-verification.json` for the direct MATLAB checks.

## Verified data coverage

The final four material scripts reference 98 nonempty CSV files across 49 material-length conditions. Every referenced file contains 135,013 rows and five finite numeric columns, with exported time ranging from 0 to 44.999 s. Additional CSV files exist, including earlier ABS/DAR tests and third trials omitted from the final four scripts. All recovered CSV files are indexed in `data/source_manifest.json`.

Exported timestamps are nondecreasing but contain repeated values. The displayed numeric precision is consistent with limited-precision CSV export; the precise export/acquisition cause has not been established. Repeated exported timestamps are not by themselves evidence of duplicate samples. Preserve the original row order. The scripts use a nominal 3000 Hz sampling rate; the observed row count is slightly above 135,000, so exact hardware sampling-rate coercion remains unverified.

## Algorithm actually present in getProcessedData.m

1. Use the mean of force rows 3000:12000 (MATLAB indexing, nominally about 1-4 s) as the baseline.
2. Subtract that baseline from force column 4.
3. Use rows 24000:end for FFT dominant-frequency detection and period integration, excluding DC from the peak search.
4. Sum positive and negative force separately within each complete inferred period. Normalize using nominal frequency 1.9 Hz, density 1000 kg/m^3, chord 0.035 m and `A = L`.
5. Calculate a thrust-to-drag ratio for each period, then take the mean of those ratios. This is not generally identical to the ratio of the mean thrust and mean drag coefficients, although the plot axis uses a ratio-of-means notation.
6. Calculate each `d_*` value as `1.990 * std(per_period_values)`, using sample standard deviation. The code does not divide by sqrt(n). Treat these as the original cycle-variability error bars, not a verified confidence interval for the mean.
7. Select the lower-`d_ratio` trial at each length. A tie selects trial 2. The single-material plots still show both trials. The MAT snapshots and combined plots use the selected trial only.

The audit found 70 complete periods per referenced trial under the present algorithm. The report's 75-cycle statement and the code comment referring to 80 samples do not describe this current calculation exactly. The statistical multiplier is fixed rather than recalculated from the actual period count.

## Saved result comparison

All 49 selected `ratio` and `d_ratio` values reproduce with maximum absolute differences below 1e-10. The four saved length arrays also match the scripts.

For ABS, Polyester and Nylon, the saved `cT`, `cD`, `ctotal` and their corresponding `d_*` fields are approximately 1.621138938 times values recomputed with the current `A = L` normalization. The factor is numerically 16/pi^2. This is consistent with a different common normalization in the earlier analysis, but the historical reason is not established. Delrin's saved coefficient fields match the current function. The shared coefficient scale cancels in thrust-to-drag ratios.

Preserve these snapshots. Do not silently overwrite their coefficient fields or claim full coefficient reproduction. No statistical reinterpretation or trial averaging has been substituted into the archived work.

## Historical code differences

- `N1122.m` and `PP1122.m` retain ABS titles/comments from a copied script.
- The four individual scripts use a shared 77.5-102.5 mm shaded range. `OverallPlots.m` uses material-specific ranges attributed in its comments to video footage: ABS 97.5-122.5, Polyester 142.5-152.5, Nylon 122.5-142.5 and Delrin 127.5-152.5 mm. The videos themselves were not recovered here.
- `dataAcquisition.m` currently specifies 10 s and a 30 Hz cutoff. `dataAcquisition-FrankLaptop.m` specifies 45 s and 20 Hz. Both specify 3000 Hz and a sixth-order Butterworth filter followed by `filtfilt`. Their historical calibration slope is 3.3e-6 V/g. The report's rounded calibration value differs. Neither acquisition file alone proves the exact configuration used for every recording.
- `plotData.m` uses a different baseline window than `getProcessedData.m`.
- `ABS1120.m` and `DAR1120.m` call an older function interface without `Lfin`; they are incompatible with the current `getProcessedData.m` as written. Earlier DAR processing contains explicit adjustments for load-cell anomalies. These older scripts do not establish why later `test3.csv` files were omitted.
- The buckling-prediction script uses `Rc = 0.017` m, while the report's tabulated assumptions state 0.020 m. The combined plot hardcodes theoretical values rather than reading the prediction script's output. The script also uses a search/tolerance approach, so the presence of this file is not proof that it generated the reported table.
- The combined overlay legend includes a predicted-buckling-line entry, but the overlay section does not draw the material-specific prediction lines. The subplots do draw those lines.

## Trial provenance and future analysis

The author clarified that third trials generally followed a concern about an earlier trial, and that replacements were explicitly hardcoded when used. The exact faults are no longer recalled. See [trial-selection.md](trial-selection.md) for the confirmed replacement at DAR 100 mm on 11/20, the conflicting DAR 80 mm comment, and the absence of third-trial replacements in the final four scripts. If a revised statistical treatment or coefficient normalization is wanted later, preserve it separately from the archived results, document the changes and compare both outputs. Path-only portability edits can then be made on a separate working copy. None have been applied to the originals here.
