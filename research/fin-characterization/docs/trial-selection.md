# Trial Selection Provenance

Updated 2026-10-29 after clarification from Frank Zhang and inspection of all recovered MATLAB scripts.

## Experimental background recalled by the author

Third trials were generally acquired when one of the first two trials appeared problematic. The specific problems are no longer recalled. When a replacement trial was used, the author's practice was to explicitly hardcode the replacement in the corresponding analysis. This background does not identify every recording as valid or invalid and does not override the recovered code.

## Behavior confirmed in the code

| Series / condition | Actual file references | Interpretation limited to code evidence |
| --- | --- | --- |
| `DAR_1120/DAR_100mm` | `DAR1120.m` reads `test1.csv` and `test3.csv` | Explicit replacement: `test2.csv` is skipped in this historical analysis. The exact fault that motivated it is not recorded here. |
| `DAR_1120/DAR_80mm` | `DAR1120.m` reads `test2.csv` and passes `test1.csv` to a special-processing function | A heading says "80mm, test 3", but the executable path reads `test1.csv`. This comment does not establish that `test3.csv` was analyzed. The caller mentions a 40 s cutoff, while the special function actually uses nominal rows from 8 to 30 s. |
| Final ABS, PP, Nylon and Delrin scripts | `ABS1127.m`, `PP1122.m`, `N1122.m`, `DAR_1204.m` read `test1.csv` and `test2.csv` | Their `if i == 99` special branches are empty and unreachable for these series (maximum loop length 36). No third-trial replacement is enabled. |

The final four scripts subsequently select the lower-`d_ratio` result from those two input trials at each length. The saved MAT ratios and error bars match that behavior in independent numerical checks and direct MATLAB execution. The existence of another recording is not grounds to change these inputs retrospectively.

## Other third-trial files present

The following third trials are present but not read by the final four-material scripts:

- `ABS_1127/ABS_100mm/test3.csv`
- `ABS_1127/ABS_105mm/test3.csv`
- `DAR_1204/DAR_150mm/test3.csv`
- `N_1122/N_140mm/test3.csv`
- `N_1122/N_145mm/test3.csv`
- `N_1122/N_150mm/test3.csv`
- `PP_1122/PP_150mm/test3.csv`

All recordings remain indexed and preserved in the data package. No file has been deleted or relabeled invalid. Historical omissions and replacements are documented separately from hypothetical future reanalysis.
