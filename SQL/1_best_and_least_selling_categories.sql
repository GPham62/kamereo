-- ============================================================================
-- Platform: DuckDB
-- Dataset: Channel-Category GMV Analysis
-- ============================================================================

-- ---- TABLE DEFINITION
CREATE TABLE channel_category_gmv (
    Channel   VARCHAR,
    Category  VARCHAR,
    GMV       DOUBLE
);

-- ---- DATA LOAD
INSERT INTO channel_category_gmv VALUES
    ('Horeca', 'Vegetable',  69.3),  ('Horeca', 'Fruit',      25.3),
    ('Horeca', 'Non-veggie', 73.0),  ('Horeca', 'Meat',       22.8),
    ('MT',     'Vegetable',  10.9),  ('MT',     'Fruit',       1.1),
    ('MT',     'Non-veggie',  0.9),  ('MT',     'Meat',        0.4),
    ('KA',     'Vegetable',  14.6),  ('KA',     'Fruit',       0.6),
    ('KA',     'Non-veggie',  8.0),  ('KA',     'Meat',        2.2),
    ('SME',    'Vegetable',   0.8),  ('SME',    'Fruit',       0.6),
    ('SME',    'Non-veggie',  1.2),  ('SME',    'Meat',        0.0);

-- ============================================================================
-- 1. Identify the best-selling and least-selling Categories for each Channel, excluding Categories with GMV < 1 and Non-Veggie > 70 .
-- ============================================================================

SELECT
    Channel,
    MAX(CASE WHEN rk_desc = 1 THEN Category END) AS Best_Category,
    MAX(CASE WHEN rk_desc = 1 THEN GMV END) AS Best_GMV,
    MAX(CASE WHEN rk_asc = 1 THEN Category END) AS Least_Category,
    MAX(CASE WHEN rk_asc = 1 THEN GMV END) AS Least_GMV
FROM (
    SELECT
        Channel,
        Category,
        GMV,
        ROW_NUMBER() OVER (PARTITION BY Channel ORDER BY GMV DESC) AS rk_desc,
        ROW_NUMBER() OVER (PARTITION BY Channel ORDER BY GMV ASC) AS rk_asc
    FROM channel_category_gmv
    WHERE GMV >= 1                                      -- filter #1: exclude small GMV
      AND NOT (Category = 'Non-veggie' AND GMV > 70)  -- filter #2: exclude outlier
) ranked
GROUP BY Channel
ORDER BY Channel;

-- RESULTS:
┌─────────┬───────────────┬──────────┬────────────────┬───────────┐
│ Channel │ Best_Category │ Best_GMV │ Least_Category │ Least_GMV │
│ varchar │    varchar    │  double  │    varchar     │  double   │
├─────────┼───────────────┼──────────┼────────────────┼───────────┤
│ Horeca  │ Vegetable     │     69.3 │ Meat           │      22.8 │
│ KA      │ Vegetable     │     14.6 │ Meat           │       2.2 │
│ MT      │ Vegetable     │     10.9 │ Fruit          │       1.1 │
│ SME     │ Non-veggie    │      1.2 │ Non-veggie     │       1.2 │
└─────────┴───────────────┴──────────┴────────────────┴───────────┘
-- ============================================================================
-- 2. Compare GMV by Category between the following Channel pairs: Horeca vs MT
-- ============================================================================

SELECT
    Category,
    MAX(CASE WHEN Channel = 'Horeca' THEN GMV END) AS Horeca_GMV,
    MAX(CASE WHEN Channel = 'MT' THEN GMV END) AS MT_GMV,
    ROUND(MAX(CASE WHEN Channel = 'Horeca' THEN GMV END) -
          MAX(CASE WHEN Channel = 'MT' THEN GMV END), 1) AS Gap,
    ROUND(MAX(CASE WHEN Channel = 'Horeca' THEN GMV END) /
          MAX(CASE WHEN Channel = 'MT' THEN GMV END), 1) AS Horeca_vs_MT_Multiple
FROM channel_category_gmv
WHERE Channel IN ('Horeca', 'MT')  -- filter early: skip other channels
GROUP BY Category
ORDER BY Gap DESC;

-- RESULTS:
┌────────────┬────────────┬────────┬────────┬───────────────────────┐
│  Category  │ Horeca_GMV │ MT_GMV │  Gap   │ Horeca_vs_MT_Multiple │
│  varchar   │   double   │ double │ double │        double         │
├────────────┼────────────┼────────┼────────┼───────────────────────┤
│ Non-veggie │       73.0 │    0.9 │   72.1 │                  81.1 │
│ Vegetable  │       69.3 │   10.9 │   58.4 │                   6.4 │
│ Fruit      │       25.3 │    1.1 │   24.2 │                  23.0 │
│ Meat       │       22.8 │    0.4 │   22.4 │                  57.0 │
└────────────┴────────────┴────────┴────────┴───────────────────────┘

-- ============================================================================
-- Compare GMV by Category between the following Channel pairs: KA vs SME
-- ============================================================================

SELECT
    Category,
    MAX(CASE WHEN Channel = 'KA' THEN GMV END) AS KA_GMV,
    MAX(CASE WHEN Channel = 'SME' THEN GMV END) AS SME_GMV,
    ROUND(MAX(CASE WHEN Channel = 'KA' THEN GMV END) -
    MAX(CASE WHEN Channel = 'SME' THEN GMV END), 1) AS Gap,
    ROUND(MAX(CASE WHEN Channel = 'KA' THEN GMV END) /
          NULLIF(MAX(CASE WHEN Channel = 'SME' THEN GMV END), 0), 1) AS KA_vs_SME_Multiple
FROM channel_category_gmv
WHERE Channel IN ('KA', 'SME')  -- filter early: skip other channels
GROUP BY Category
ORDER BY Gap DESC;

-- RESULTS:
┌────────────┬────────┬─────────┬────────┬────────────────────┐
│  Category  │ KA_GMV │ SME_GMV │  Gap   │ KA_vs_SME_Multiple │
│  varchar   │ double │ double  │ double │       double       │
├────────────┼────────┼─────────┼────────┼────────────────────┤
│ Vegetable  │   14.6 │     0.8 │   13.8 │               18.3 │
│ Non-veggie │    8.0 │     1.2 │    6.8 │                6.7 │
│ Meat       │    2.2 │     0.0 │    2.2 │               NULL │
│ Fruit      │    0.6 │     0.6 │    0.0 │                1.0 │
└────────────┴────────┴─────────┴────────┴────────────────────┘
