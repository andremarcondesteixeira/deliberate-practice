# SQL Engineering & Query Practice (50 Challenges)

## Phase 1: Basic Queries, Filtering & Aggregation

* **Card 1 (SELECT Execution Order):** What is the logical processing order of clauses in a SQL query (e.g., FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY)?
* **Card 2 (Handling NULLs in Comparisons):** Why does `WHERE column = NULL` fail to return rows, and how do `IS NULL` and `IS NOT NULL` correctly handle missing data?
* **Card 3 (DISTINCT vs GROUP BY):** Contrast `SELECT DISTINCT` with `GROUP BY` regarding performance, duplicate elimination, and aggregation capabilities.
* **Card 4 (WHERE vs HAVING):** What is the fundamental difference between filtering rows with `WHERE` versus filtering grouped aggregate results with `HAVING`?
* **Card 5 (COALESCE and NULLIF Functions):** How do `COALESCE` (returning the first non-null value) and `NULLIF` (returning null if two expressions are equal) simplify conditional data cleaning?
* **Card 6 (String Pattern Matching):** Contrast the performance and behavior of SQL `LIKE`, `ILIKE` (case-insensitive), and regular expression operators (`REGEXP` / `SIMILAR TO`).
* **Card 7 (Date and Interval Arithmetic):** How do databases handle date addition, subtraction, and interval truncations across different SQL dialects (PostgreSQL, MySQL, SQL Server)?
* **Card 8 (CASE WHEN Expressions):** How do conditional expressions (`CASE WHEN ... THEN ... ELSE ... END`) enable inline value transformation and pivoting logic?
* **Card 9 (LIMIT and OFFSET Pagination):** Why does deep pagination using large `OFFSET` values degrade query performance, and what are alternative keyset pagination strategies?
* **Card 10 (Handling Empty Strings vs NULLs):** How do databases treat empty strings (`''`) versus `NULL` values in constraints, unique indexes, and aggregate functions?

## Phase 2: Joins, Subqueries & Set Operations

* **Card 11 (INNER JOIN vs OUTER JOIN):** Contrast INNER JOIN with LEFT, RIGHT, and FULL OUTER JOIN regarding how unmatched table rows are handled.
* **Card 12 (ON vs WHERE in OUTER JOINs):** What is the crucial difference between placing a filter condition in the `ON` clause versus the `WHERE` clause during a `LEFT JOIN`?
* **Card 13 (CROSS JOIN Mechanics):** When does a `CROSS JOIN` occur intentionally or accidentally, and how does it generate Cartesian products?
* **Card 14 (Self-Join Applications):** How do you use a Self-Join to query hierarchical data or compare rows within the same table (e.g., finding employees who earn more than their managers)?
* **Card 15 (Correlated vs Uncorrelated Subqueries):** Contrast uncorrelated subqueries (executed once independently) with correlated subqueries (re-executed for every row processed by the outer query).
* **Card 16 (EXISTS vs IN Operators):** Why is `EXISTS` often more performant than `IN` or `NOT IN` when checking for existence against large subqueries containing `NULL` values?
* **Card 17 (ANY, ALL, and SOME Operators):** How do comparison operators modified by `ANY` or `ALL` evaluate multi-row subquery results?
* **Card 18 (UNION vs UNION ALL):** Contrast `UNION` (which eliminates duplicates via sorting) with `UNION ALL` (which appends result sets without sorting overhead).
* **Card 19 (INTERSECT and EXCEPT Set Operations):** How do `INTERSECT` (common rows) and `EXCEPT` / `MINUS` (difference of rows) execute set operations?
* **Card 20 (Anti-Join Pattern):** How do you construct an efficient Anti-Join (finding rows in Table A that have no matching rows in Table B) using `LEFT JOIN` with `IS NULL` or `NOT EXISTS`?

## Phase 3: Advanced Grouping, Window Functions & CTEs

* **Card 21 (Window Functions Anatomy):** Explain the structure of a window function (`FUNCTION() OVER (PARTITION BY ... ORDER BY ... ROWS/RANGE ...)`).
* **Card 22 (ROW_NUMBER vs RANK vs DENSE_RANK):** Contrast `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()` when handling duplicate values in ordered partitions.
* **Card 23 (Aggregate Window Functions):** How do running totals and moving averages work when using aggregate functions with an `OVER` clause and framing constraints (`ROWS BETWEEN`)?
* **Card 24 (LAG and LEAD Functions):** How do `LAG()` and `LEAD()` functions allow access to data from previous or subsequent rows without performing self-joins?
* **Card 25 (FIRST_VALUE and LAST_VALUE):** How do `FIRST_VALUE()` and `LAST_VALUE()` extract boundary values within a defined window frame?
* **Card 26 (Common Table Expressions - CTEs):** What are the readability and architectural advantages of using Common Table Expressions (`WITH` queries) over nested subqueries?
* **Card 27 (Recursive CTEs):** How do Recursive CTEs execute iterative queries to traverse hierarchical graph structures, organizational charts, or bill-of-materials data?
* **Card 28 (Materialized CTEs vs Inlined CTEs):** In modern SQL engines (like PostgreSQL), when does the optimizer materialize a CTE into a temporary table versus inlining it into the main query?
* **Card 29 (GROUPING SETS, CUBE, and ROLLUP):** How do advanced grouping extensions (`ROLLUP`, `CUBE`, `GROUPING SETS`) generate multi-level subtotal aggregations in a single query?
* **Card 30 (Conditional Aggregation / Pivot):** How do you pivot row-level data into columns using conditional aggregation (`SUM(CASE WHEN ... THEN 1 ELSE 0 END)`)?

## Phase 4: Data Definition, Modification & Constraints

* **Card 31 (DDL vs DML vs DCL):** Categorize SQL statements into Data Definition Language (DDL), Data Manipulation Language (DML), and Data Control Language (DCL).
* **Card 32 (Primary and Foreign Key Constraints):** How do Primary Keys (uniqueness and non-nullability) and Foreign Keys enforce relational integrity across tables?
* **Card 33 (ON DELETE CASCADE vs RESTRICT):** Contrast referential action clauses (`CASCADE`, `RESTRICT`, `SET NULL`, `SET DEFAULT`) when parent records are deleted.
* **Card 34 (CHECK and UNIQUE Constraints):** How do `CHECK` constraints validate domain rules, and how do `UNIQUE` constraints handle `NULL` values across multiple rows?
* **Card 35 (Transactions and ACID Commands):** How do `BEGIN TRANSACTION` (or `START TRANSACTION`), `COMMIT`, `ROLLBACK`, and `SAVEPOINT` control atomic execution blocks?
* **Card 36 (UPSERT / ON CONFLICT Clauses):** How do `INSERT ... ON CONFLICT DO UPDATE` (PostgreSQL) or `INSERT ... ON DUPLICATE KEY UPDATE` (MySQL) handle unique constraint collisions?
* **Card 37 (MERGE Statement / Upsert):** How does the SQL standard `MERGE` statement coordinate conditional `INSERT`, `UPDATE`, and `DELETE` operations in a single pass?
* **Card 38 (TRUNCATE vs DELETE):** Contrast `TRUNCATE TABLE` (fast DDL operation resetting table storage) with `DELETE` (slow DML operation logging row deletions).
* **Card 39 (ALTER TABLE DDL Locks):** Why do certain `ALTER TABLE` operations acquire exclusive table locks, and how do modern databases execute zero-downtime migrations?
* **Card 40 (Temporary and Unlogged Tables):** When should you use Session-Temporary tables, Transaction-Temporary tables, or Unlogged tables for scratchpad data processing?

## Phase 5: Performance Tuning, Indexing & Troubleshooting

* **Card 41 (Sargable Predicates):** What makes a predicate "sargable" (Search Argument Able), and why do functions wrapped around columns (`WHERE YEAR(date) = 2026`) prevent index usage?
* **Card 42 (Implicit Type Casting Hazards):** Why does comparing a varchar column to an integer literal (`WHERE varchar_col = 123`) cause index scans to fail due to implicit type casting?
* **Card 43 (Composite Index Column Order):** How does the Leftmost Prefix Rule dictate whether a multi-column B-Tree index is utilized by a query filter?
* **Card 44 (EXPLAIN Plan Analysis):** How do database query planners use `EXPLAIN` to report estimated costs, scan types (Seq Scan vs Index Scan), and join algorithms?
* **Card 45 (Index Scans vs Bitmap Index Scans):** Explain the difference between an Index Scan, an Index-Only Scan, and a Bitmap Index Scan in PostgreSQL query execution.
* **Card 46 (Query Plan Caching and Parameter Sniffing):** What is parameter sniffing, and how can cached execution plans perform poorly when query parameters have skewed data distributions?
* **Card 47 (Avoiding SELECT * Anti-Pattern):** Why is querying `SELECT *` discouraged in production applications regarding network bandwidth, index coverage, and schema evolution?
* **Card 48 (OR Conditions and Index Merging):** Why can `OR` conditions across different columns disable single-index scans, and how does rewriting them as `UNION` queries improve performance?
* **Card 49 (Lab Scenario A - The Slow LIKE Query):**
  * *The Setup:* A search query `WHERE username LIKE '%john%'` performs a full table scan and takes 5 seconds on a table with 10 million rows.
  * *The Challenge:* Explain why leading wildcard patterns invalidate B-Tree indexes, and outline alternative solutions using Trigram indexes or Full-Text Search.
* **Card 50 (Lab Scenario B - The Missing Index Join Bottleneck):**
  * *The Setup:* A report joining `Orders` and `OrderItems` causes massive Nested Loop scans with high disk I/O because a foreign key column lacked an index.
  * *The Challenge:* Identify how missing foreign key indexes trigger table scans on inner join loops, and trace the performance recovery after adding the index.