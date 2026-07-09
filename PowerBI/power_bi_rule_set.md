# Power BI Rule Set — Fast-Food Chains Analysis
*Living conventions for this project. Read before building any visual or writing any DAX.*
*Last updated: 2026-07-08*

---

## 1. Chart titles are QUESTIONS, never conclusions ⭐ (the cardinal rule)

Every visual title must be an **open-ended question**, a **"X vs Y"** framing, or an **"X over time"** framing — **never a stated finding**.

- ✅ `"Which type of food sells the most per store?"`
- ✅ `"Store count vs sales per store — which engine?"`
- ✅ `"Do bigger chains still have room to grow?"`
- ❌ `"Chicken & Burgers Lead Unit Economics"` (conclusion — forbidden)
- ❌ `"Average of Sales per Unit by Segment"` (describes axes, not engaging)

**The three-layer title system:**
| Layer | Job | Example |
|---|---|---|
| **Title** | Ask the question | *"Which type of food sells the most per store?"* |
| **Subtitle** | Describe what's plotted (neutral, no verdict) | *"Average sales per unit, by segment (2021)"* |
| **Narration / callout** | Deliver the answer (spoken or a small annotation) | *"Chicken and burgers lead"* |

The deck **bookends** on this: cover asks *"How many stores does it take to become great?"*, final slide repeats and resolves it with the vision line.

---

## 2. DAX & data-model conventions

- **Apostrophes are curly (`’`, U+2019) in this dataset.** DAX string literals must match exactly — a straight `'` will silently fail to match and fall through. Always type curly apostrophes when referencing chain names (Arby's, Domino's, Dunkin', Wendy's, McDonald's, etc.).
- **Always end a `SWITCH` mapping with a catch-all** (e.g. `"Uncategorized"`) so mismatches are visible, not silent.
- **Prefer a calculated column over a separate dimension table** for small, static, single-use mappings (our 50-row Segment map). A dim table + relationship is over-engineering here.
- **All measures live in a dedicated `_Measures` table** (calculator-icon table, underscore prefix sorts it to top). Set every new measure's Home table to `_Measures`.

---

## 3. Visual-build checklist

- **Check the aggregation.** When a numeric column goes on an axis, Power BI defaults to **Sum**. Per-unit / per-store / rate metrics almost always need **Average** (or a weighted measure) — Sum silently rewards big segments. Verify every time.
- **Sort by value, descending** for ranked bars so the insight rises to the top.
- **Turn on data labels** for exact values.
- **Steer the eye** — highlight the 1–2 bars/points that matter, grey the rest.

---

## 4. Report structure & naming

- **Pages use a `N · Name` numeric prefix** to lock presentation order:
  `0 · Cover` · `1 · The Landscape` · `2 · What Drives Success` · `3 · Timing & Playbook`
- One page per **act**, laid out as a mini-dashboard of that act's visuals.

---

## 5. Analytical honesty (state these caveats up front)

- **No profit data** — `Sales per Unit` is *revenue*, a productivity proxy, not margin.
- **No true time series** — "growth" is only the 2020→2021 *net* unit change; lifecycle is *inferred*, not trended.
- **Segment is analyst-enriched**, not source-provided — a judgment call worth disclosing.
- **Segment-of-one caution** — a single-member category (e.g. Panda Express = "Asian") distorts per-segment averages. Keep it *and annotate*, or filter it — never let it silently skew a chart.

---

## 6. Tooling notes

- The Power BI MCP `execute_dax` endpoint errors on this build ("data source must be specified"). **Metadata tools work** (`get_table_schema`, `list_tables`) — use those to verify columns/measures. Validate values by **hand math**, not live queries.
- After adding columns/measures, **reconnect** (`connect_powerbi`) before reading schema — the connection caches stale state.

---

*When a new convention or mistake-to-avoid emerges, add it here.*
