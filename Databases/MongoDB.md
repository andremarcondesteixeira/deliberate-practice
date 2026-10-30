# MongoDB

## Storage & Document Model

* **BSON:** How does BSON extend JSON with types such as `ObjectId`, `Date`, `Decimal128`, and binary data, and why is it faster to traverse than JSON text?
* **WiredTiger Architecture:** What are WiredTiger's core components (B-tree storage, document-level concurrency via MVCC, block compression with snappy/zstd)? Why did it replace MMAPv1's collection-level locking?
* **WiredTiger Cache & Eviction:** How does the WiredTiger cache use memory (by default 50% of (RAM − 1GB)), and what happens when eviction threads can't keep up and application threads are forced to help evict?
* **Checkpoints & Journal:** Contrast WiredTiger checkpoints (consistent snapshots written every 60 seconds) with the journal (write-ahead log). What can you lose on a crash with `j: false`?
* **Oplog:** How does the oplog (`local.oplog.rs`) record idempotent operations for replication, and how do you size its window?
* **16MB Document Limit:** Why does MongoDB cap documents at 16MB, and when should you use GridFS or a bucket/subset pattern instead?
* **Embedding vs Referencing:** What are the trade-offs of embedding sub-documents (single-document atomicity, locality, duplication, unbounded arrays) versus referencing by `_id` (normalization, `$lookup`)?

## Indexing & Queries

* **Compound Indexes & the ESR Rule:** How does the Equality-Sort-Range rule decide the field order of a compound index? When is a query fully covered, and why must the projection usually exclude `_id`?
* **Multikey Indexes:** How do multikey indexes index arrays, and why can't a compound index contain two array fields?
* **Text, Geospatial & Wildcard Indexes:** When do you use text indexes, `2dsphere` indexes with GeoJSON (`$near`, `$geoWithin`), and wildcard indexes (`$**`) for unpredictable schemas? What are their limitations?
* **Partial vs Sparse Indexes:** Contrast partial indexes (filter expression) with sparse indexes (only documents that have the field). Why are partial indexes preferred, and when won't the planner use them?
* **Index Builds:** How do modern index builds avoid blocking a collection for the whole build, and how are they coordinated across a replica set?
* **Explain Plans & Profiling:** How do `explain("executionStats")`, `totalKeysExamined`/`totalDocsExamined` vs `nReturned`, and the profiler (`system.profile`, `slowms`) reveal a `COLLSCAN` or an inefficient `IXSCAN`?

## Replica Sets

* **Replica Set Roles:** What roles do primary, secondary, and arbiter nodes play? Why are arbiters discouraged with `w: "majority"`?
* **Elections & Election Storms:** How do elections use heartbeats, priorities, terms, and majority votes? How can flaky networks cause repeated elections, and how does `electionTimeoutMillis` affect stability?
* **Read Preferences:** Contrast `primary`, `primaryPreferred`, `secondary`, `secondaryPreferred`, and `nearest`. What consistency do you lose reading from secondaries?
* **Write Concerns:** How do `w: 1`, `w: "majority"`, and `j: true` trade latency for durability? Which acknowledged writes can be rolled back?
* **Read Concerns & Causal Consistency:** Compare `local`, `available`, `majority`, `linearizable`, and `snapshot` read concerns. How do causally consistent sessions give read-your-own-writes on secondaries?
* **Hidden & Delayed Members:** What are hidden members (analytics, backups) and delayed members (a time buffer against bad deletes) for?
* **Replication Lag:** What makes secondaries lag (heavy writes, index builds, slow disks, large transactions), and how do you monitor it?
* **Initial Sync:** Walk through initial sync: cloning collections, building indexes, and applying oplog entries that arrived meanwhile. Why can a too-small oplog break it?
* **Rollbacks:** What happens to writes acknowledged only by an old primary when it rejoins as a secondary after failover? Where do the rolled-back documents go?

## Sharding

* **Sharded Cluster Architecture:** Deconstruct a sharded cluster into `mongos` routers, the config server replica set, and shards. Why must config servers use majority reads and writes?
* **Shard Key Selection:** What makes a good shard key (high cardinality, low frequency, non-monotonic writes, support for targeted queries)? How do compound shard keys and `refineCollectionShardKey` help?
* **Chunks & the Balancer:** How does the balancer migrate chunks/ranges between shards, and why restrict it to a balancing window in production?
* **Zone Sharding:** How do zones pin ranges of data (tenants, regions) to specific shards for data residency or hardware tiers?
* **Lab — Scatter-Gather Queries:**
  * *Setup:* Every `mongos` sits at 100% CPU, and queries filtering by email domain take 15 seconds.
  * *Challenge:* Explain why queries without the shard key are broadcast to all shards, and fix it by redesigning the shard key, adding a lookup collection, or changing the query pattern.
* **Lab — Monotonic Shard Key Hot Spot:**
  * *Setup:* An IoT pipeline shards on `_id` (`ObjectId`). Shard 3 handles 90% of writes while Shards 1 and 2 idle.
  * *Challenge:* Explain why `ObjectId`'s timestamp prefix sends all inserts to the last chunk, and compare a hashed shard key with a compound key such as `{ deviceId: 1, ts: 1 }`.

## Aggregation & Transactions

* **Aggregation Pipeline:** How does the pipeline stream documents through stages like `$match`, `$group`, `$project`, `$sort`, and `$lookup`? What is the 100MB per-stage memory limit, and how does spilling to disk work (`allowDiskUse`)?
* **Pipeline Optimization:** Which reorderings does the optimizer apply automatically (moving `$match` earlier, coalescing `$sort` + `$limit`), and why should a `$match` on indexed fields come first?
* **Multi-Document Transactions:** How do multi-document transactions work on replica sets and sharded clusters, what do they cost compared with single-document atomicity, and what happens after the default 60-second `transactionLifetimeLimitSeconds`?
* **Change Streams:** How do change streams use the oplog to deliver real-time changes, and how do resume tokens let consumers continue after a crash?
* **Security:** How do RBAC, SCRAM/x.509 authentication, TLS, encryption at rest, and Queryable Encryption secure a deployment?
* **Lab — Transaction Write Conflicts:**
  * *Setup:* During a flash sale, multi-document transactions updating inventory abort with `WriteConflict` errors and time out.
  * *Challenge:* Reduce contention by shrinking transactions, avoiding hot documents (bucketed counters), retrying `TransientTransactionError` correctly, and questioning whether a transaction is needed at all.

## Study Guide

* **Books:**
  * *MongoDB: The Definitive Guide* (Shannon Bradshaw, Eoin Brazil & Kristina Chodorow): the parts on indexing, aggregation, transactions, schema design, replication and sharding map almost one-to-one onto this deck's sections.
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Replication chapter (failover, replication lag, read-your-writes) and the Partitioning chapter (called Sharding in the second edition; key-range vs hash partitioning, hot spots, rebalancing), for the general theory behind replica sets and shard keys.
  * *Practical MongoDB Aggregations* (Paul Done, free online edition from the author): pipeline design, performance tips and worked examples for the aggregation section.
* **Official docs:** the MongoDB Manual's "Data Modeling", "Indexes", "Replication", "Sharding", "Aggregation", "Transactions" and "Change Streams" sections; the WiredTiger and journaling pages in the Storage section; the "Explain Results" and "Database Profiler" pages; the Production Notes; and the Security section. MongoDB University's free courses cover the same ground with labs.
* **Papers:** "Tunable Consistency in MongoDB" (William Schultz, Tess Avitabile & Alyson Cabral, 2019), on write concerns, read concerns and rollback; "In Search of an Understandable Consensus Algorithm" (Diego Ongaro & John Ousterhout, 2014), the Raft paper that MongoDB's election protocol builds on.
* **Related technologies:** compare WiredTiger with InnoDB (both B-tree engines with MVCC), replica sets with PostgreSQL streaming replication, MongoDB sharding with Citus or Vitess, change streams with Debezium-based CDC, and Amazon DocumentDB or Cosmos DB, which implement the MongoDB API but not its engine.
* **Search for:** `MongoDB ESR rule`, `WiredTiger cache eviction application threads`, `write concern majority rollback`, `causally consistent sessions`, `shard key cardinality frequency monotonicity`, `jumbo chunks`, `TransientTransactionError retry`, and MongoDB's "Building with Patterns" series for the bucket, subset and outlier schema patterns.
* **Hands-on:** start a three-member replica set locally (Docker or `mlaunch`), kill the primary during a stream of `w: 1` writes and find the rolled-back documents; then shard a collection on `_id` and watch every insert land on one shard.
