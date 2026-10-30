# Database Operations & Troubleshooting

## Schema Changes

* **DDL Locks & Lock Queues:** Why do many `ALTER TABLE` operations need an `ACCESS EXCLUSIVE` lock, and why can even a fast DDL statement freeze all traffic while it waits behind a long query? How do `lock_timeout` with retries and online schema change tools (`pg_repack`, `gh-ost`, `pt-online-schema-change`) avoid that?
* **Migration Tooling:** How do Flyway and Liquibase version and apply migrations, and why must every migration stay compatible with the previous app version during rolling deploys?
* **Lab — The Column Rename Trap:**
  * *Setup:* A deploy runs `ALTER TABLE users RENAME COLUMN email TO user_email;` and every running app instance starts throwing exceptions.
  * *Challenge:* Walk through expand-and-contract: add the new column, dual-write, backfill in batches, switch reads, stop writing the old column, drop it. Which steps need separate deployments?

## Change Data Capture

* **Change Data Capture:** How do CDC tools like Debezium read the WAL/binlog and stream row changes to Kafka without application dual-writes? What are initial snapshots, replication slots, and the risk of a slot nobody consumes?

## Connections

* **Connection Exhaustion:** What causes `too many connections` errors, and why does adding connections often reduce throughput? How do you size a pool (a small multiple of cores, not request concurrency)?
* **Lab — Connection Pool Collapse:**
  * *Setup:* A traffic spike saturates the database connection pool. App threads hang waiting for connections, upstream requests time out with 504s, and retries make it worse.
  * *Challenge:* Trace how slow queries hold connections and back up request queues. Fix it with bounded pools, short acquisition timeouts (fail fast), bounded request queues, and a transaction-mode pooler or RDS Proxy.

## Hardware & OS Tuning

* **SSDs & Flash Translation Layers:** How do SSD erase blocks, the FTL, internal garbage collection, and TRIM affect random-write database workloads and latency spikes?
* **fsync & Dirty Page Flushing:** How do `fsync` frequency and kernel settings (`vm.dirty_background_ratio`, `vm.dirty_ratio`) cause periodic write stalls? Why put the WAL on separate, low-latency storage?
* **NUMA:** What is NUMA, and how can memory imbalance across nodes cause erratic database latency or swapping despite free RAM?
* **CPU Scaling Limits:** Which internal contention points (buffer pool latches, lock manager, WAL insertion) stop databases from scaling linearly on 64+ core machines?
* **Benchmarking Pitfalls:** Why are synthetic benchmarks such as `pgbench` or `sysbench` often misleading, and what makes a benchmark realistic (production query mix, data distribution, warm caches, replay)?

## Scenarios

* **Lab — LSM Compaction I/O Spike:**
  * *Setup:* A Cassandra/RocksDB cluster shows severe latency spikes every afternoon, with disks at 100% during large compactions.
  * *Challenge:* Throttle compaction throughput, revisit the compaction strategy (size-tiered vs leveled), and spread or schedule maintenance to smooth I/O.

## Study Guide

* **Books:**
  * *Database Reliability Engineering* (Laine Campbell & Charity Majors): the chapters on release management (schema migrations), infrastructure engineering and operational visibility, for the operational mindset behind this deck.
  * *Refactoring Databases* (Scott W. Ambler & Pramod J. Sadalage): the transition-period approach behind expand-and-contract, with a catalog of safe structural changes such as renaming a column.
  * *Systems Performance* (Brendan Gregg): the Memory, File Systems and Disks chapters for dirty-page flushing, `fsync`, NUMA and SSD behavior, and the Benchmarking chapter for why benchmarks mislead.
  * *Release It!* (Michael T. Nygard): the stability patterns and antipatterns (timeouts, bulkheads, fail fast, blocked threads), which explain connection pool collapse and retry storms.
* **Official docs:** the PostgreSQL manual's "Explicit Locking" section (table-level lock modes and which commands take them) and the lock notes on the `ALTER TABLE` reference page; the MySQL Reference Manual's "InnoDB and Online DDL" section; the Debezium documentation for the PostgreSQL and MySQL connectors (snapshots, replication slots, WAL retention); the Flyway and Liquibase docs; the HikariCP wiki page "About Pool Sizing"; and the Linux kernel documentation for the `/proc/sys/vm` settings.
* **Papers:** "Online, Asynchronous Schema Change in F1" (Ian Rae et al., 2013); "The Unwritten Contract of Solid State Drives" (Jun He et al., 2017).
* **Related technologies:** `pg_repack`, `gh-ost` and `pt-online-schema-change` for online DDL; Flyway, Liquibase and Sqitch for migrations; PgBouncer and RDS Proxy for pooling; Debezium on Kafka Connect for CDC; `pgbench`, `sysbench` and HammerDB for benchmarks and `fio` for raw disk tests; Cassandra's `nodetool setcompactionthroughput` and RocksDB's rate limiter for compaction throttling.
* **Search for:** `ALTER TABLE lock queue lock_timeout`, `expand and contract migration`, `parallel change pattern`, `Debezium replication slot WAL growth`, `connection pool sizing cores`, `Little's law connection pool`, `SSD garbage collection latency`, `vm.dirty_ratio write stalls`, `numactl interleave database`, `compaction throttling`, and Jeremy Cole's write-up on "MySQL swap insanity" and NUMA.
* **Hands-on:** in one `psql` session hold a `SELECT` open inside a transaction, run `ALTER TABLE ... ADD COLUMN` in a second, then try a plain `SELECT` in a third and watch the queue in `pg_stat_activity`; repeat with `SET lock_timeout = '2s'`.
