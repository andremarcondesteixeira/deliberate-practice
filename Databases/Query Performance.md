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

## Study Guide

* **Books:**
  * *SQL Performance Explained* (Markus Winand, also free online as *Use The Index, Luke*): the chapters on the WHERE clause, joins and partial results cover sargable predicates, bind parameters and plan caching, join algorithms and `OR`/`LIKE` pitfalls across databases.
  * *PostgreSQL Query Optimization* (Henrietta Dombrovskaya, Boris Novikov & Anna Bailliekova): reading execution plans, the cost model, join algorithms and rewriting slow queries in PostgreSQL.
  * *PostgreSQL 14 Internals* (Egor Rogov, free from Postgres Professional): the part on query execution, for planner statistics, the cost of each scan type, bitmap scans, and nested loop, hash and merge joins.
  * *High Performance MySQL* (Silvia Botros & Jeremy Tinley): the chapters on indexing for high performance and query performance optimization, for the MySQL side.
* **Official docs:** the PostgreSQL manual's "Performance Tips" chapter ("Using EXPLAIN", "Statistics Used by the Planner"), the planner cost constants and `plan_cache_mode` under "Query Planning" in the server configuration chapter, the `pg_stat_statements` and `pg_trgm` module pages, and "Partition Pruning" under "Table Partitioning"; the MySQL Reference Manual's "Optimization" chapter (execution plans, index merge); and the SQL Server docs on parameter sniffing and Query Store.
* **Papers:** "Access Path Selection in a Relational Database Management System" (Selinger et al., 1979), the origin of cost-based optimization; "How Good Are Query Optimizers, Really?" (Leis et al., 2015), on why cardinality estimates go wrong and how much that costs.
* **Related technologies:** compare plans in PostgreSQL (`EXPLAIN ANALYZE`, `auto_explain`), MySQL 8 (`EXPLAIN ANALYZE`, `EXPLAIN FORMAT=TREE`), SQL Server (actual execution plans, Query Store) and Oracle (`DBMS_XPLAN`); use a plan visualizer such as depesz's explain tool or PEV2; and for the `LIKE` lab compare `pg_trgm`, PostgreSQL full-text search and Elasticsearch.
* **Search for:** `sargable predicate`, `estimated vs actual rows`, `CREATE STATISTICS extended statistics`, `custom vs generic plan`, `parameter sniffing`, `bitmap heap scan lossy`, `hash join batches work_mem`, `log_temp_files`, `index foreign key columns`, `pg_trgm gin_trgm_ops`.
* **Hands-on:** load a few million rows with `generate_series`, then run each card's query shape under `EXPLAIN (ANALYZE, BUFFERS)` before and after adding the right index, and watch the plan change.
