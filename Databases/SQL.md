# SQL

## Queries & Filtering

* **Logical Clause Order:** What is the logical processing order of a query (`FROM`/`JOIN`, `WHERE`, `GROUP BY`, `HAVING`, window functions, `SELECT`, `DISTINCT`, `ORDER BY`, `LIMIT`)? Why can't `WHERE` reference a `SELECT` alias?
* **NULL & Three-Valued Logic:** Why does `WHERE col = NULL` return no rows? How do `IS NULL`, `IS DISTINCT FROM`, and three-valued logic (`TRUE`/`FALSE`/`UNKNOWN`) behave in `WHERE`, `CHECK`, and aggregates?
* **Empty Strings vs NULL:** How do databases treat `''` versus `NULL` in constraints, unique indexes, concatenation, and aggregates? What is Oracle's surprising behavior?
* **WHERE vs HAVING:** What is the difference between filtering rows with `WHERE` and filtering groups with `HAVING`? Why does moving a non-aggregate condition into `WHERE` speed up a query?
* **DISTINCT vs GROUP BY:** Contrast `SELECT DISTINCT` with `GROUP BY` for removing duplicates. What does PostgreSQL's `DISTINCT ON` do?
* **COALESCE & NULLIF:** How do `COALESCE` and `NULLIF` simplify data cleaning? Show how `NULLIF` prevents division-by-zero errors.
* **CASE & Conditional Aggregation:** How do `CASE WHEN` expressions transform values inline, and how do you pivot rows into columns with `SUM(CASE WHEN ... THEN 1 ELSE 0 END)` or `FILTER (WHERE ...)`?
* **Pattern Matching:** Contrast `LIKE`, `ILIKE`, and regular expression operators (`~`, `REGEXP`, `SIMILAR TO`) regarding behavior, collation, and index usage.
* **Date & Interval Arithmetic:** How do you add intervals, truncate timestamps (`date_trunc`), and compute differences in PostgreSQL, MySQL, and SQL Server? Why does `timestamp` vs `timestamptz` matter?
* **Keyset Pagination:** Why does `LIMIT ... OFFSET` get slower the deeper you page, and how does keyset (seek) pagination with `WHERE (created_at, id) < (?, ?)` fix it? What does it give up?

## Joins, Subqueries & Sets

* **Inner vs Outer Joins:** Contrast `INNER`, `LEFT`, `RIGHT`, and `FULL OUTER JOIN` regarding unmatched rows.
* **ON vs WHERE in Outer Joins:** Why does putting a right-table filter in `WHERE` instead of `ON` silently turn a `LEFT JOIN` into an inner join?
* **CROSS JOIN:** When is a Cartesian product intentional (generating combinations, calendars), and how does it happen by accident?
* **Self-Joins:** How do you use a self-join to compare rows in the same table, such as employees who earn more than their managers?
* **Correlated Subqueries:** Contrast uncorrelated subqueries (run once) with correlated subqueries (logically re-run per outer row). How do optimizers decorrelate them into joins, and when must you rewrite them yourself?
* **EXISTS, IN & Anti-Joins:** Why is `NOT IN` dangerous when the subquery can return `NULL`? Compare `NOT EXISTS`, `LEFT JOIN ... IS NULL`, and `NOT IN` for anti-joins.
* **ANY & ALL:** How do `= ANY(...)`, `> ALL(...)`, and `SOME` evaluate multi-row subqueries? What does `> ALL` return for an empty set?
* **Set Operations:** Contrast `UNION` (deduplicates) with `UNION ALL` (appends), and explain `INTERSECT` and `EXCEPT`/`MINUS`. Why should `UNION ALL` be your default?

## Window Functions & CTEs

* **Window Frames:** Explain `FUNCTION() OVER (PARTITION BY ... ORDER BY ... ROWS/RANGE BETWEEN ...)`. How do you compute running totals and moving averages, and why does `LAST_VALUE()` surprise people with the default frame?
* **ROW_NUMBER vs RANK vs DENSE_RANK:** How does each handle ties? Use one to write a "top 3 per group" query.
* **LAG & LEAD:** How do `LAG()` and `LEAD()` read previous and next rows without self-joins? Use them to compute day-over-day change.
* **CTEs:** What are the readability advantages of `WITH` queries? When does PostgreSQL inline a CTE versus materialize it, and how do `MATERIALIZED`/`NOT MATERIALIZED` change that?
* **Recursive CTEs:** How does a recursive CTE run its anchor and recursive members to traverse hierarchies (org charts, bills of materials)? How do you guard against cycles?
* **GROUPING SETS, ROLLUP & CUBE:** How do these produce multi-level subtotals in one query, and how does `GROUPING()` tell subtotal rows apart from real `NULL`s?

## Schema & Data Modification

* **Keys & Referential Actions:** How do primary and foreign keys enforce integrity? Contrast `ON DELETE CASCADE`, `RESTRICT`, `SET NULL`, and `SET DEFAULT`.
* **CHECK & UNIQUE Constraints:** How do `CHECK` constraints enforce domain rules, and how do `UNIQUE` constraints treat multiple `NULL`s (and PostgreSQL's `NULLS NOT DISTINCT`)?
* **Transaction Control:** How do `BEGIN`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT` work? What happens to a PostgreSQL transaction after a statement error without a savepoint?
* **UPSERT & MERGE:** Compare `INSERT ... ON CONFLICT DO UPDATE` (PostgreSQL), `ON DUPLICATE KEY UPDATE` (MySQL), and standard `MERGE`. Which are safe under concurrency without extra locking?
* **TRUNCATE vs DELETE:** Contrast `TRUNCATE` (DDL-like, deallocates storage, resets identity, minimal logging) with `DELETE` (row-by-row DML, fires triggers). Is `TRUNCATE` transactional in PostgreSQL? In MySQL?
* **Temporary & Unlogged Tables:** When should you use session-scoped temp tables, transaction-scoped temp tables, or unlogged tables for scratch data? What do you lose with unlogged tables after a crash?
