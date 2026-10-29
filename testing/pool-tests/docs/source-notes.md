# Sources and Verification Boundaries

## Report Reference

G25, *Final Report: A Biomimetic Robotic Octopus Using Asymmetrically-Stiffening Propulsors*, Senior Projects Lab 441b, May 12, 2025, by Frank Zhang, Adrien Ramos and Kaleigh Ray. Source filename: `G25_Final_Report_441b.pdf`. Its SHA-256 is recorded in `source-inventory.json`. PDF page numbers below count from the cover page.

- PDF pp. 16-18, sections 3.1-3.2: test objectives, limited trial count, planned test matrix and procedure. The matrix describes intended work; only the reported completed cases are treated as results.
- PDF p. 19, section 3.3.2 and Figure 20: calibration, three physical marking locations, approximate 0.5 s marking interval and Excel analysis.
- PDF pp. 20-22, section 3.4.1 and Figures 21-23: recorded motion, fitted trends and extrapolated displacement associated with 3 m travel. The Figure 23 values are projections rather than a directly recovered continuous 3 m trajectory.
- PDF pp. 23-26, section 3.4.2 and Figures 24-26: fin-deactivation turning tests and reported 5.5 +/- 0.4 s result. That result is retained as reported, without assigning a confidence level to the +/- term.
- PDF pp. 27 and 29: limitations and proposed future active control loop.

## Original Files

Four original TRK files were recovered from the shared project folder `441b Files/PhysicsTracker/videos`. Their bytes were checked against the downloaded Drive ZIP. Git attributes disable line-ending conversion for these archived sources. Original XML labels, settings and marking coordinates remain unchanged.

`mass A/B/C` are saved PointMass track labels. The report describes nose-tip, top and bottom markers, but a separate per-file assignment of each saved label to each physical marker has not been verified from the missing videos. The field named `mass` in a Tracker PointMass object is not used here as the measured mass of the robot.

The motion-type interpretation was checked using only the geometry of saved image-coordinate markings. It is not a video-confirmed trial classification. No image-to-world trajectory conversion, refitting, turn-time extraction, revised uncertainty calculation or performance validation was performed.

The recovered projects reference four videos that were not included in that Drive folder. Their per-file settings also differ from the report's general camera description. Frame timing, orientation and calibration therefore need video verification before further quantitative analysis.

## Other Recovered Material

`GH017604.trk` contains no saved PointMass tracks. A separate `test1.trz` archive contains a video named `videos/GH017604.MOV` and a setup/calibration TRK, also without saved PointMass tracks. These remain local recovery references; they are not substituted for the four missing videos or counted as completed trajectory analyses.

IMU development files are outside this testing archive. The pool trajectory markings are video-based and are not IMU-derived positions.

## Outstanding Provenance

- Locate `GH017603.mov`, `IMG_1200.mov`, `IMG_1201.mov` and `IMG_1202.MOV`.
- Locate the original Excel workbook containing exported positions, fitted trends and turning analysis.
- Confirm the exact report-trial mapping, physical marker identities and analyzed portions of each video.

Until those links are established, the archive supports source inspection and documents the report's methods and results. It does not claim end-to-end reproduction of the reported metrics.
