# sql-duolingo-retention-analysis
# * Project Goal: Analyzed memory decay and practice intervals in Duolingo language learners using Google BigQuery.

# * Key Finding : Recency is most the important aspect. All of the top 3 retentions 
# are <1 hour Lag_bin. while all of the 3 Highest Risk Windows are 3+ months lag_bin.
# So, the company should focus on notification alerts and flash card promotion
# to drive retention and customer success, over building lifetime repetition counts
# that will not be retained and cause customer frustration and attrition.

# * SQL Concepts Used: Aggregations (AVG, SUM), GROUP BY, multi-column ORDER BY, conditional WHERE filters, and string matching.
