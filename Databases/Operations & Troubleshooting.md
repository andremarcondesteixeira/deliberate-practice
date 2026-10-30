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
