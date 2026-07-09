# Decision Log: Top 50 US Fast-Food Chains — F&B Competitive Analysis (Power BI)
*Date: 2026-07-08*

## Summary
A Power BI descriptive analysis positioned as real on-the-job work for a startup F&B employer, decoding *why* the top US fast-food chains succeed and what our company should learn from it. The analysis rejects "store count" as a measure of greatness and instead builds a four-pillar case that **a single, highly productive unit — replicated with discipline — is what earns scale**. It culminates in a bookended vision: *"We don't pick a number of stores — we earn it."*

## Design Tree (Final)
```
DESIGN TREE — F&B Competitive Analysis

├── ✅ Audience & purpose — Junior-analyst deliverable for a startup F&B employer;
│      decode why US fast-food chains succeed as strategic input for "our company"
├── ✅ Framing — Treat as real on-the-job work, not an interview test artifact
├── ✅ Greatness lens — Reject raw store count AND total sales as the goal;
│      per-unit productivity + growth is the lens
├── ✅ Core thesis / vision — "Earn the scale": store count is a receipt, not a target
├── ✅ Four analytical pillars finalized:
│   ├── ✅ ① Segment economics — enriched category column; unit economics by segment
│   ├── ✅ ② Throughput vs Ubiquity — Units (log) × Sales/Unit scatter
│   ├── ✅ ③ Franchise Flywheel — Franchise% × Sales/Unit 2×2 (merged old ③+④)
│   └── ✅ ⑥ Lifecycle / Runway — Units × Growth% (merged old ⑤+⑥)
├── ✅ ⑧ Category-relative execution — folded INTO ① (evaluative, not a new pillar)
├── ✅ ⑦ Market concentration (Pareto) + ⑨ rank-shuffle slope — framing/story slides
├── ✅ Narrative arc — 11 slides, 3 acts, every chart carries insight + so-what
├── ✅ Vision line — blended & bookended (B opens, C motif, A+C closes)
├── ⬜ Data enrichment & measures (NEXT: Segment map · Franchise% · Growth% · cleanup)
├── ⬜ Power BI page layout & build
├── ⬜ Design theme
└── ⬜ Delivery format
```
*(⬜ nodes are deliberately deferred to the build phase — the strategy layer is fully resolved.)*

## Decisions

| # | Topic | Decision | Rationale | Depends On |
|---|-------|----------|-----------|------------|
| 1 | Audience & purpose | Junior-analyst strategic deliverable for a **startup F&B employer**; decode why US chains succeed | Data is a single 2021 snapshot with no customer/geo granularity → suits competitive-landscape framing, not ops dashboard | — |
| 2 | Framing | Treat as **real on-the-job work**, not an interview test artifact | Raises the bar; forces "so-what for us" on every slide | #1 |
| 3 | Greatness lens | **Reject** store count and total systemwide sales as the goal; optimize on **per-unit productivity + growth** | Subway is #1 by units yet worst per-unit and shrinking (−1,043); Chick-fil-A ~14× its per-unit at 1/8 the footprint | #1 |
| 4 | Core thesis / vision | **"Earn the scale"** — store count is a *receipt* of unit excellence, never a target | Unifies all four pillars; answers the opening question ("what's the right number of stores?") conclusively | #3 |
| 5 | Pillar ① Segments | Enrich data with a **Segment** column; compare unit economics by category | Chicken owns the top of the per-unit table (Chick-fil-A $6,100K, Raising Cane's $4,893K); category sets the ceiling | #3 |
| 6 | Pillar ② Engine | **Throughput vs Ubiquity** scatter — Units (log axis) × Sales/Unit, bubble = systemwide sales | Two distinct capital strategies (few rich stores vs many thin); a startup must pick one | #3 |
| 7 | Pillar ③ Flywheel | Merge old ③ (capital efficiency) + ④ (franchise ROI) into one **Franchise% × Sales/Unit 2×2** | They're two axes, not one insight; the 2×2 reveals Dream / Hoarders / Treadmill quadrants | #3 |
| 8 | Pillar ⑥ Lifecycle | Merge old ⑤ (momentum rank) + ⑥ (lifecycle) into **Units × Growth%** scatter | Same underlying variable (growth rate); the scatter is the richer form; sub-2,000-unit chains grow double-digits, giants plateau | #3 |
| 9 | ⑧ Category-relative | **Fold into ①** as an evaluative layer, not a separate pillar | 7× per-unit spread *within* chicken (CFA $6,100 vs Church's $870) → "category gets you in the room, execution wins" | #5 |
| 10 | ⑦ + ⑨ | Keep **Pareto concentration** and **rank-shuffle slope** as framing/story slides, not analytical pillars | Cheap to build, high narrative payoff; slope chart = "biggest ≠ best" hook; Pareto = "market is top-heavy" reality check | #4 |
| 11 | Narrative arc | **11 slides / 3 acts**: Landscape → What drives success → Timing & Playbook | Each act answers a different question (what's true → why → what we do); ~15 min at ~1.5 min/slide | #4–#10 |
| 12 | Vision line | **Blended & bookended**: open with B, repeat C as motif, close with A+C | All three candidate lines were strong; bookending advances rather than repeats the idea | #4, #11 |
| 13 | Platform & visuals | **Power BI**, native visuals only; log-scale scatters; **drop iso-revenue curves** | Core insights are native scatters/bars; curved reference lines aren't native and are optional garnish | #6, #11 |
| 14 | Data enrichment | Derive **Segment** (manual), **Franchise%**, **Unit Growth%**; clean comma-formatted text numbers | Raw CSV lacks all three; number columns are text (`"4,462"`) and won't aggregate until converted | #5–#8 |

## Assumptions
*If any of these are wrong, decisions may need revisiting.*

- The employer is a **startup F&B company** deciding its own category and growth model — this persona was assumed from the user's framing, not given by the data.
- **Sales per Unit is treated as a proxy for unit health**, but it is *revenue*, not profit — no margin data exists in the dataset.
- The **Segment classification** (chicken / burger / pizza / coffee-snack / sub / mexican) is the analyst's judgment call, not a source-provided field.
- Systemwide-sales concentration figures (top 10 ≈ two-thirds) are **approximate** — computed by estimate, to be confirmed against a precise sum during build.

## Open Risks
*Explicitly deferred, uncertain, or flagged during the interview.*

- **No true time series.** "Growth" is only the 2020→2021 *net* unit change; the Lifecycle pillar *infers* maturity from size + one year of movement, not a trend line. Must be disclosed on-slide.
- **No profit/margin data.** Productivity conclusions rest on revenue-per-unit only.
- **Segment mapping subjectivity** — some chains are borderline (e.g., Panda Express = Asian vs mexican-bucket; Culver's = burger vs custard). Needs human eyeball before build.
- **Iso-revenue curves dropped** — the "equal total sales" visual relies on bubble size + annotation instead of true `y = k/x` reference lines (not native to Power BI).
- **Data hygiene** — comma-formatted numbers stored as text, plus curly apostrophes in chain names (`Arby's`, `Church's`) may cause matching/join issues during enrichment.

---

*Strategy layer signed off. Remaining nodes (data enrichment, layout, theme, delivery) move to the build phase.*
