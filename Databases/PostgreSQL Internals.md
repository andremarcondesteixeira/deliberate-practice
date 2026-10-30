# PostgreSQL Internals

## MVCC & Vacuum

* **Dead Tuples & VACUUM:** Why do PostgreSQL updates and deletes leave dead tuples, and what do `VACUUM`, `VACUUM FULL`, and autovacuum each do? What are HOT updates, and how does `fillfactor` help them?
* **Free Space Map & Visibility Map:** What roles do the FSM and the visibility map play, and how does the visibility map enable index-only scans and faster vacuums?
* **Autovacuum Starvation:** What happens when autovacuum can't keep up, keeps getting cancelled, or is held back by a long-running transaction or an abandoned replication slot pinning the xmin horizon? How do you diagnose it?
* **Lab — Transaction ID Wraparound:**
  * *Setup:* Production stops accepting writes with `database is not accepting commands to avoid wraparound data loss in database "production"`.
  * *Challenge:* Explain 32-bit XID wraparound and freezing, why the database shuts itself down, the emergency recovery steps (find what holds back the horizon, `VACUUM (FREEZE)` the oldest tables, single-user mode only as a last resort), and the monitoring and autovacuum settings that prevent a repeat.

## Indexing

* **GIN vs GiST:** When should you choose a GIN index over GiST for JSONB, arrays, full-text search, or geometric data? Compare build time, update cost, and lookup speed.
* **BRIN Indexes:** How do block range indexes give tiny indexes for huge, naturally ordered append-only tables (time series), and what happens to them when physical order is random?

## Memory & Connections

* **Memory Configuration:** How should host RAM be split between `shared_buffers`, the OS page cache, and per-operation `work_mem`/`maintenance_work_mem`? Why is ~25% for `shared_buffers` a common starting point, and why can a high `work_mem` cause OOMs?
* **Process-per-Connection & Pooling:** Why does PostgreSQL's process-per-connection model make thousands of connections expensive compared with MySQL's thread-per-connection model? How do PgBouncer's session and transaction pooling modes help, and which features break in transaction mode?

## Operations

* **Lock Contention Diagnosis:** How do you use `pg_locks`, `pg_stat_activity`, and `pg_blocking_pids()` to find who is blocking whom? How do `lock_timeout` and `idle_in_transaction_session_timeout` limit the damage?
* **Point-In-Time Recovery:** How do a base backup plus continuously archived WAL let you restore to an exact timestamp or LSN? How do you prove that backups actually restore?

## Study Guide

* **Books:**
  * *PostgreSQL 14 Internals* (Egor Rogov, free from Postgres Professional): the parts on MVCC and vacuum (including freezing), the buffer cache and WAL, locks, and index types (GiST, GIN, BRIN) cover nearly every card here.
  * *The Internals of PostgreSQL* (Hironobu Suzuki, free online): the chapters on concurrency control, VACUUM processing, HOT and index-only scans, the buffer manager, and base backup and point-in-time recovery, with clear diagrams.
* **Official docs:** the PostgreSQL manual's "Routine Database Maintenance Tasks" chapter (routine vacuuming, preventing transaction ID wraparound failures, the autovacuum daemon); "Database Physical Storage" (free space map, visibility map, page layout); the GiST, GIN and BRIN index chapters in the Internals part; "Resource Consumption" under "Server Configuration"; "Continuous Archiving and Point-in-Time Recovery (PITR)" under "Backup and Restore"; and the `pg_locks` and `pg_stat_activity` views. The PgBouncer docs list which features break in transaction pooling mode.
* **Papers:** "The Design of the POSTGRES Storage System" (Michael Stonebraker, 1987), the no-overwrite storage design that dead tuples and vacuum come from.
* **Related technologies:** compare MySQL/InnoDB (undo logs instead of dead tuples, thread-per-connection) and Oracle (undo segments); pgBackRest, Barman and WAL-G for PITR; PgBouncer and RDS Proxy for pooling; and the `pgstattuple`, `pg_visibility`, `pageinspect` and `pg_repack` extensions for inspecting and fixing bloat.
* **Search for:** `transaction ID wraparound`, `autovacuum_freeze_max_age`, `xmin horizon`, `HOT updates fillfactor`, `GIN fastupdate pending list`, `BRIN pages_per_range correlation`, `PgBouncer transaction pooling prepared statements`, `pg_blocking_pids`, `recovery_target_time`.
* **Hands-on:** create a table, update every row a few times and watch `n_dead_tup` in `pg_stat_user_tables` and the tuple headers with `pageinspect`; then hold a transaction open in another session and confirm `VACUUM VERBOSE` can't remove the dead tuples.
