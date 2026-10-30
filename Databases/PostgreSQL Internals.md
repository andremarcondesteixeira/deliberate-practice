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
