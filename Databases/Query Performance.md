# Query Performance

## Optimizer & Plans

* **Cost-Based Optimizer:** How does a cost-based optimizer use statistics (histograms, most-common values, null fraction, n_distinct, correlation) to pick a plan? What happens when the statistics are stale?
* **EXPLAIN vs EXPLAIN ANALYZE:** What does `EXPLAIN` (estimated costs and rows) show, and what does `EXPLAIN ANALYZE` (actual time, rows, loops, buffers) add? What does a large gap between estimated and actual rows tell you?
* **Sequential Scan vs Index Scan:** Why does the optimizer deliberately choose a full sequential scan when a query returns a large fraction of rows? How do random vs sequential I/O costs factor in?
* **Index Scan vs Index-Only vs Bitmap Scan:** In PostgreSQL, explain the difference between an index scan, an index-only scan, and a bitmap heap scan. When does the planner prefer a bitmap scan?
* **Plan Caching & Parameter Sniffing:** How do prepared statements save parse and plan time? What is parameter sniffing, and why can a cached generic plan be terrible for skewed values (PostgreSQL custom vs generic plans, SQL Server sniffing)?

## Joins

* **Join Algorithms:** When does the planner choose a nested loop (small outer side, indexed inner side), a hash join, or a merge join (pre-sorted inputs)? What is an index nested loop join?
* **Hash Joins & Disk Spills:** Walk through the build and probe phases of a hash join. What happens when the hash table or a sort exceeds `work_mem`, and how do you spot temp-file spills?

## Writing Fast Queries

* **Sargable Predicates:** What makes a predicate sargable? Why do `WHERE YEAR(created_at) = 2026` and `WHERE varchar_col = 123` (implicit cast) prevent index use, and how do you rewrite them?
* **OR Conditions:** Why can `OR` across different columns stop the engine from using a single index, and how do index merges/bitmap ORs or a rewrite to `UNION ALL` help?
* **Avoiding `SELECT *`:** Why is `SELECT *` harmful in production code regarding network transfer, index-only scans, large/TOASTed columns, and schema evolution?
* **Partition Pruning:** How do declaratively partitioned tables let the planner skip partitions at plan time and at execution time? Which query shapes defeat pruning?
* **Finding Expensive Queries:** How do `pg_stat_statements` and slow query logs identify the queries with the highest total impact (calls × mean time), and why is that different from finding the single slowest query?

## Scenarios

* **Lab — The Slow `LIKE` Search:**
  * *Setup:* `WHERE username LIKE '%john%'` scans all 10 million rows and takes 5 seconds.
  * *Challenge:* Explain why a leading wildcard can't use a B-tree index, and compare trigram indexes (`pg_trgm`), full-text search, and a dedicated search engine.
* **Lab — The Unindexed Foreign Key:**
  * *Setup:* A report joining `orders` and `order_items` runs huge nested-loop scans, and deleting rows from `orders` blocks for seconds, because `order_items.order_id` has no index.
  * *Challenge:* Explain why databases index primary keys automatically but not foreign keys, how a missing FK index causes slow joins and slow, lock-holding parent deletes (each delete scans the child table), and verify the improvement with `EXPLAIN ANALYZE`.
