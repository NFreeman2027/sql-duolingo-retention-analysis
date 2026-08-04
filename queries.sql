# SQL analysis of 13M Duolingo Sessions from Kaggle.com - https://www.kaggle.com/datasets/kylefengkfeng209/how-fast-do-you-forget-13m-duolingo-sessions?select=forgetting_curve.csv
# 3 Queries to examine the retention of people trying to learn Spanish with Duolingo Lessons
# ------------------------------------------------------------------------------  
# * Retention over time -
SELECT 
    lag_bin,
    ROUND(AVG(pct_perfect_sessions), 2) AS avg_pct_perfect
FROM 
    `sql-portfolio-project-504414.duolingo_data.forgettin_curve`
WHERE 
    language_name = 'Spanish'
GROUP BY 
    lag_bin, lag_bin_order
ORDER BY 
    lag_bin_order ASC;
# -----------------------------------------------------------------------------
# Key Finding: A SQL analysis of Spanish language practice intervals reveals that session accuracy remains relatively steady (~83%–86%) across the 
# first month of inactivity, but suffers a sharp drop-off to 78.91% when practice lags by 3 months or longer.
# -----------------------------------------------------------------------------
# * Practice vs. Retention - 
SELECT 
    practice_bin,
    practice_bin_order,
    SUM(n_traces) AS total_observations,
    ROUND(AVG(pct_perfect_sessions), 2) AS avg_pct_perfect_sessions
FROM 
    `sql-portfolio-project-504414.duolingo_data.forgettin_curve`
WHERE 
    language_name = 'Spanish'
GROUP BY 
    practice_bin,
    practice_bin_order
ORDER BY 
    practice_bin_order ASC;
# -----------------------------------------------------------------------------
# Key Finding : Analysis revealed an initial slight dip in perfection rate during early practice stages (3-4 exposures at 82.83%),
# followed by steady recovery and plateauing near 84% accuracy once an item reaches 10+ exposures  
# -----------------------------------------------------------------------------
# * Top 3 Best Retention vs. Highest Forgetting - 
-- Top 3 Best Performing Windows
SELECT 
    'Best Retention' AS category,
    lag_bin,
    practice_bin,
    pct_perfect_sessions
FROM 
    `sql-portfolio-project-504414.duolingo_data.forgettin_curve`
WHERE 
    language_name = 'Spanish'
ORDER BY 
    pct_perfect_sessions DESC
LIMIT 3;

-- Bottom 3 Risk Windows
SELECT 
    'Highest Forgetting Risk' AS category,
    lag_bin,
    practice_bin,
    pct_perfect_sessions
FROM 
    `sql-portfolio-project-504414.duolingo_data.forgettin_curve`
WHERE 
    language_name = 'Spanish'
ORDER BY 
    pct_perfect_sessions ASC
LIMIT 3;
# -----------------------------------------------------------------------------
# Key Finding : Recency is most important. All top 3 are <1 hour Lag_bin
# All 3 Highest Risk Windows are 3+ months lag_bin
# So, product should focus on notification alerts and flash card promotion
# over building lifetime repetition counts to drive retention and success

