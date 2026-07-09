# PRD: Top 50 US Fast-Food Chains — Competitive Analysis Presentation (Power BI)
*Date: 2026-07-08 · Owner: Junior Data Analyst · Status: Ready to build*

> Generated from conversation context using the `to-prd` method (Problem → Solution → User Stories → Implementation → Out of Scope → Notes), adapted for an analytics/BI deliverable rather than a code feature. **Testing is intentionally out of scope for this project** — this PRD is a living record of implementation only.

---

## Problem Statement

A startup F&B company wants to understand **why the top US fast-food chains are so successful** and what that implies for its own strategy. The naive instinct — the question the business actually walks in with — is *"is more better? How many stores do we need to be great?"* That framing is wrong and, if left unchallenged, leads to a capital-destroying land-grab (the "open stores fast" trap that is visibly killing Subway).

There is a public dataset of the top 50 chains (2021 snapshot) but, as delivered, it is a flat table of raw counts and dollar figures with no narrative, no derived economics, and no strategic point of view. On its own it answers nothing.

## Solution

A **~15-minute, 11-slide Power BI presentation** in a 3-act narrative that dismantles the "more stores = greatness" myth and replaces it with an evidence-backed vision: **build one exceptional, replicable unit and let its economics earn the scale.**

The deck is organized so every single chart carries one insight and one "so-what for us" — no filler visuals. It bookends itself with a vision line: opens by mirroring the audience's naive question, drums a 4-word motif through each act, and closes on the resolved answer.

**Vision (north star):**
> *"We don't pick a number of stores — we earn it: build one restaurant worth copying, and let its excellence decide how far it travels."*

## User Stories

1. As the **F&B executive audience**, I want the deck to open by voicing my own assumption ("how many stores do we need?"), so that I feel understood before my thinking is challenged.
2. As the **executive**, I want to see that the biggest chains are often the *least* productive, so that I stop equating store count with success.
3. As the **executive**, I want a reality check on how concentrated the market is, so that I understand we cannot win by being a smaller version of a giant.
4. As a **strategy owner**, I want to know which food category has the best unit economics, so that I can pre-load our odds by choosing the right category.
5. As a **strategy owner**, I want to see how much performance varies *within* a category, so that I understand execution — not just category choice — determines the outcome.
6. As a **strategy owner**, I want to understand the two ways chains scale (throughput vs ubiquity), so that I can deliberately commit our limited capital to one engine.
7. As a **capital-constrained founder**, I want to see the relationship between franchising and unit profitability, so that I know *when* to franchise (only after the unit is proven).
8. As a **strategy owner**, I want to see where growth is still available by chain size, so that I target the mid-market runway instead of fighting saturated giants.
9. As the **executive**, I want a single synthesized "winner's recipe," so that I have a concrete profile to emulate.
10. As the **decision-maker**, I want a closing recommendation and vision, so that I know what we do Monday.
11. As the **analyst presenting**, I want honest data-limitation caveats stated up front, so that the analysis reads as credible and professional rather than naive.
12. As a **future franchisee-facing team**, I want per-unit sales framed as a franchisee-ROI proxy, so that we understand what makes our franchise self-recruiting.

## Implementation Decisions

**Data model — single flat fact table, 3 derived columns (no separate dim table):**
- **Segment** (categorical): Burger / Chicken / Pizza / Sandwich / Coffee & Snacks / Mexican / Asian — a **`SWITCH` calculated column** keyed on `[Fast-Food Chains]` (chosen over a separate mapping table: 50 static rows, no reuse → a dimension table is over-engineering). Falls back to `"Uncategorized"` to surface any apostrophe mismatch. Drives pillars ① and ⑧. Borderline rulings recorded below.
- **Franchise %** = `DIVIDE([Franchised Stores], [2021 Total Units])` — calculated column. Drives the Flywheel 2×2.
- **Unit Growth %** = `DIVIDE([Change in Units], [2021 Total Units] - [Change in Units])` — calculated column. Drives the Lifecycle scatter.
- **Numeric cleanup — DONE at import**: Power Query already loaded all figures as `Int64`; no comma-stripping needed. Watch curly apostrophes in chain names for the Segment join.

**Segment rulings (borderline calls, default):** Dairy Queen → Coffee & Snacks; Culver's & Freddy's → Burger; Panera → Sandwich; Panda Express → Asian (segment of one — exclude from or annotate on per-segment average charts). Subject to final analyst review.

**Known tooling note:** the Power BI MCP `execute_dax` endpoint errors ("data source must be specified") on this build — metadata tools work, but live DAX spot-checks are unavailable; validation done by hand math instead.

**Four analytical pillars (each a distinct chart type, shared Y-axis of Sales/Unit where possible for visual cohesion):**
- **① Segment economics** — bar of avg Sales/Unit by Segment. Insight: category sets the ceiling.
- **⑧ Category-relative execution** (folded into ①) — dumbbell/dot plot of per-unit min↔max within each segment. Insight: 7× spread inside chicken → execution decides.
- **② Throughput vs Ubiquity** — scatter, **Units on a logarithmic X-axis** × Sales/Unit Y, bubble = systemwide sales, color = Segment. Iso-revenue curves intentionally omitted; bubble size + annotation carries "same total, opposite engine."
- **③ Franchise Flywheel** — 2×2 scatter, Franchise% X × Sales/Unit Y. Quadrants: Dream / Hoarders / Treadmill.
- **⑥ Lifecycle / Runway** — scatter, Units (log) X × Unit Growth% Y. Insight: sub-2,000-unit chains grow double-digit; giants plateau.

**Framing/story slides (narrative, not new analysis):**
- **⑨ Rank-shuffle slope chart** — rank by Units → rank by Sales/Unit. The "biggest ≠ best" opening hook.
- **⑦ Market concentration Pareto** — cumulative systemwide sales; top 10 ≈ two-thirds. The reality-check.

**Narrative architecture — 11 slides / 3 acts:**
- Act 1 *Landscape* (S1–4): framing question, KPI cards, slope chart, Pareto.
- Act 2 *What drives success* (S5–8): segment bar, within-category spread, throughput/ubiquity, flywheel.
- Act 3 *Timing & Playbook* (S9–11): lifecycle scatter, winner's-recipe scorecard, recommendation + vision.

**Vision deployment (bookend):** Title = *"The right number of stores isn't a number you pick — it's a number you earn."* · Recurring motif = *"Perfect the unit. Earn the scale."* · Close = *"Build one restaurant worth copying — and let its excellence earn the scale."*

**Platform:** Power BI Desktop, native visuals only (no custom-visual dependencies); log-scale scatters; consistent Sales/Unit Y-axis across pillars for a "one system" feel.

## Out of Scope

- **Profitability / margin analysis** — dataset has revenue-per-unit only, no cost data.
- **True time-series / trend lines** — only a 2020→2021 net-unit delta exists; lifecycle is *inferred*, not trended.
- **Geographic / regional breakdowns, menu, pricing, or customer-level data** — none present.
- **Iso-revenue reference curves** — not native to Power BI; deliberately replaced by bubble size.
- **Predictive modeling / forecasting** — this is a descriptive analysis, not predictive.
- **Row-level ETL pipeline / refresh automation** — single static CSV; no scheduled refresh needed.

## Further Notes

- **Honesty caveats are a feature, not a footnote** — stating the no-profit / no-time-series / subjective-segment limitations up front is what makes this read like a real analyst deliverable.
- **First build artifact** is the human-reviewed Segment mapping table for all 50 chains — the one enrichment requiring judgment; the other three fields are one-line DAX.
- **Companion artifact**: `DECISION_LOG.md` (same folder) records every strategic choice and its rationale.
- Source data: `Top 50 Fast-Food Chains In USA.csv` (2021 snapshot, 50 rows, 7 columns).
