# Decision Log: Page 3 — "When does adding stores actually pay off?"
*Date: 2026-07-09*

## Summary
Page 3 closes the deck's "scale right, not fast" spine by answering the handoff question from Page 2. After stress-testing, its claim was reframed from a **circular** version ("payoff per store tracks with unit strength" = AUV vs AUV) to an **empirical** one: *expansion and unit strength are independent, so scaling multiplies whatever unit you've already built.* The page is a single annotated quadrant scatter built **only from the US-50 dataset**, with three claim-quantifying KPI cards; all domain/Kamereo material (incl. Pizza 4P's) moves to the written analysis as **illustration, not evidence.**

## Design Tree (Final)
```
Page 3 — When does adding stores actually pay off?
├── Core claim — expansion ⊥ strength → scale multiplies the unit you already had (comparative, not causal)
├── Metric — AUV as payoff-per-store (rejects total-sales=size, %-growth=base)
├── Hero chart — quadrant scatter; X=units added '20→'21 (linear, honest label); Y=AUV; uniform dots; positional quadrant labels
├── Timing story — US-50 only on canvas; no external anecdote; reject fake life-cycle visual
├── Page composition — 3 claim-cards; question-title + so-what kicker; single annotated hero (Subway named in dilution corner)
├── Handoff from Page 2 — one foreshadowing sentence at Page 2's close
└── Kamereo so-what — written doc only; operator-not-logo bridge; Pizza 4P's illustrative
```

## Decisions

| # | Topic | Decision | Rationale | Depends On |
|---|-------|----------|-----------|------------|
| 1 | Core claim | "Expansion and unit strength are independent → scale multiplies the unit you already had." Stated comparatively ("tracks with"), never causally. | Original "payoff tracks strength" was circular: payoff-per-store ≈ AUV and unit-strength ≈ AUV, so it reduced to AUV vs AUV = Page 0 restated. Independence is an empirical finding one year of data genuinely supports. | — |
| 2 | Metric | AUV as payoff-per-store. Reject total system sales (size-gameable) and % unit growth (base-gameable). | AUV is the honest middle; it must be the *outcome* only, not also the independent variable. | #1 |
| 3 | Hero chart | Quadrant scatter: X = absolute units added 2020→2021 (linear, label owns the gaming); Y = AUV; uniform dots; bubble-size dropped; quadrant labels describe *position* not verdict. | Adds the expansion dimension pages 0–2 never showed. Linear (not log) so it doesn't imply "same column = same effort." Uniform dots kill re-imported bigness. | #1, #2 |
| 4 | Timing story | US-50 data only on the canvas. No second/"timing" visual. Pizza 4P's + Kamereo bridge move to the written doc. | A data-backed timing visual would manufacture a life-cycle axis the snapshot lacks — laundering a belief as measurement, worse than an honest anecdote. | #1 |
| 5 | Page composition | 3 KPI cards, each *is* the claim (independence number + two quadrant counts); reject any 4th/size/base/earlier-page card. Title = question *"When does adding stores actually pay off?"*; kicker = *"Growth doesn't create strength — it multiplies whatever you've already built."*; "Earn the Scale" = tab/section label. Single hero, annotated to name Subway in the dilution corner. | Copying pages 0–2's summary-KPI form onto a single-claim page produces filler that pulls from banned metrics. Cards must be counts/rank-mismatches the eye can't tally off the scatter. Titles are questions (house style + saved convention). | #3, #4 |
| 6 | Handoff from Page 2 | Add one foreshadowing sentence at Page 2's written close naming the open half. | Narrative continuity; Page 3 reads as the answer, not a fresh topic — without preempting its evidence. | #1 |
| 7 | Kamereo so-what | Written doc only. Bridge: bet on the operator who earns the scale, not the one who just adds stores. Pizza 4P's shown as **illustrative, not inferential**. | Keeps business implication + example separate from the dataset — analytical discipline while staying actionable. | #4 |

## Assumptions
*If any is false, decisions may need revisiting.*
- **The units-added vs AUV cloud is actually flat/independent.** Asserted by analogy to Page 2's store-count and franchise scatters — **not yet verified for units-added specifically.** If units-added correlates with AUV, decision #1 breaks.
- **Subway is in the weak-and-expanding (dilution) quadrant** — assumes Subway *added* units 2020→2021. If it net-closed stores, it's not in the expanding half and the annotation (#5) fails.
- **Median-split is the right quadrant boundary** (vs mean or a substantive threshold).

## Build Addendum — 2026-07-10
*Resolved during the PBIR build; supersedes the items below where noted.*
- **Card values verified from the CSV and locked:** R² = 5.5%, earned-scale = 14, dilution = 10; medians = +24 net units / $1,510.5K AUV. Quadrant occupancy is non-trivial (14 / 10 / 11 / 15 clockwise from top-right). The "unverified placeholders" risk is closed.
- **Subway assumption was false** — Subway net-closed 1,043 units (AUV $438K), so it sits in the retreating half, not the dilution quadrant. Decision #5 amended: the dilution-corner annotation names **Jersey Mike's** (+246 units, the dataset's fastest expander, below-median AUV $1,145K); Subway keeps a separate retreat annotation in the bottom-left.
- **Segment color (deferred risk): dropped** for cleanliness — uniform grey dots, gold reserved for the Jersey Mike's callout.
- **"Biggest expanders" card phrasing moot** — card 1 became the Independence (R²) number; the "6 of 10" placeholder was never used (actual would have been 3 of 10).

## Open Risks
- **Card values are unverified placeholders** — "6 of 10 biggest expanders below-median AUV" and the two quadrant counts (N, M) must be **computed from the final dataset + locked median definitions before publishing.** `execute_dax` was blocked by a driver bug this session, so these may need manual/visual computation.
- **"Biggest expanders" = absolute units-added is size-gameable** — the *count* on card 1 is honest, but the phrasing must not let a reader infer giants are "trying hardest."
- **Quadrant counts could be thin** — if only 1–2 chains occupy the dilution or earned-scale quadrant, cards 2–3 ("real, not theoretical") land weakly. Verify occupancy is non-trivial.
- **Segment color on the scatter** — keep for continuity with Page 2, or drop for cleanliness? Deferred to build.
