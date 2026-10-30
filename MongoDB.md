# MongoDB Architecture, Internals & Performance Practice (50 Challenges)

## Phase 1: Core Architecture, Document Model & WiredTiger Storage Engine

* **Card 1 (BSON Document Format):** How does BSON (Binary JSON) extend JSON with additional data types (like timestamps, binary data, and decimals) to optimize traversal and parsing speed?
* **Card 2 (WiredTiger Storage Engine Architecture):** What are the core architectural components of the WiredTiger storage engine (caches, table structures, memory-mapped files)?
* **Card 3 (WiredTiger Cache and Eviction):** How does the WiredTiger cache manage memory allocation, and how do cooperative eviction threads handle dirty page flushing?
* **Card 4 (Checkpoints and WAL Journaling):** Contrast WiredTiger check-pointing (writing dirty pages to data files every 60 seconds) with journal logging (WAL) for durability and crash recovery.
* **Card 5 (Storage Compression Algorithms):** How do Snappy, zlib, and zstd compression algorithms reduce disk storage footprints in WiredTiger collections and indexes?
* **Card 6 (MMAPv1 Historical Context):** Why was the legacy MMAPv1 storage engine deprecated and replaced by WiredTiger (addressing document-level locking vs collection-level locking)?
* **Card 7 (Oplog Structure and Capped Collections):** How does the Operations Log (`oplog.rs`) function as a capped collection to record all data modification operations for replication?
* **Card 8 (Database and Collection Metadata):** How does MongoDB manage internal catalog metadata and namespace files across database directories?
* **Card 9 (16MB BSON Document Limit):** Why does MongoDB enforce a strict 16MB limit on individual BSON document sizes, and when should you use GridFS instead?
* **Card 10 (Embedded Documents vs References):** What are the design trade-offs between embedding sub-documents (atomic writes, data duplication) versus referencing documents via ObjectIds (normalization)?

## Phase 2: Indexing Strategies & Query Optimization

* **Card 11 (Single Field and Compound Indexes):** How does MongoDB utilize B-Tree indexes for single-field and multi-field compound indexes?
* **Card 12 (Multikey Indexes on Arrays):** How do Multikey indexes automatically index array fields, and what restrictions apply when creating compound multikey indexes?
* **Card 13 (Text Indexes and Full-Text Search):** How do Text Indexes tokenize string fields for natural language searching, and what are the limitations of running multi-field text indexes?
* **Card 14 (Geospatial Indexes - 2dsphere):** How do `2dsphere` indexes encode spherical geometry data using GeoJSON objects for spatial queries (`$near`, `$geoWithin`)?
* **Card 15 (Wildcard Indexes):** When should you deploy Wildcard Indexes (`$**`) to index unpredictable or highly dynamic document schemas?
* **Card 16 (Partial and Sparse Indexes):** Contrast Partial Indexes (which index documents matching a specified filter expression) with Sparse Indexes (which index only documents containing the indexed field).
* **Card 17 (Covered Queries and Index-Only Scans):** How do Covered Queries execute entirely from index keys in RAM without fetching documents from disk heap storage?
* **Card 18 (Concurrent Index Builds):** How do modern background/concurrent index builds avoid locking entire collections during index creation?
* **Card 19 (Explain Plans and Query Profiling):** How do `explain("executionStats")` and winning execution plans reveal whether a query performed an IXSCAN or a COLLSCAN?
* **Card 20 (Index Bloat and Maintenance):** What causes index fragmentation and bloat over time, and how do `compact` or index rebuilds reclaim disk space?

## Phase 3: Replication, Replica Sets & High Availability

* **Card 21 (Replica Set Architecture):** What roles do Primary, Secondary, and Arbiter nodes play in a standard MongoDB Replica Set?
* **Card 22 (Raft-Inspired Election Process):** How do replica set elections use heartbeats, priority settings, and voting majorities to elect a new primary node?
* **Card 23 (Read Preferences):** Contrast read preferences (`primary`, `primaryPreferred`, `secondary`, `secondaryPreferred`, `nearest`) and their consistency implications.
* **Card 24 (Write Concerns):** How do write concerns (`w: 1`, `w: "majority"`, `j: true`) balance write latency against durability guarantees?
* **Card 25 (Read Concerns):** Compare read concerns (`local`, `available`, `majority`, `linearizable`, `snapshot`) regarding dirty reads, uncommitted data, and causal consistency.
* **Card 26 (Hidden and Delayed Members):** What operational use cases are served by Hidden replica set members (analytics) and Delayed members (disaster recovery buffer)?
* **Card 27 (Replication Lag Monitoring):** What factors cause replication lag on secondary nodes, and how do you monitor op-time differences?
* **Card 28 (Initial Sync Mechanics):** Walk through Initial Sync steps: cloning databases, copying indexes, and applying the oplog catcher phase.
* **Card 29 (Rollback Handling on Failover):** What happens to uncommitted writes on an old primary during a sudden failover when it rejoins as a secondary (rollback files)?
* **Card 30 (Election Storm Mitigation):** How do network partitions and unstable heartbeats trigger election storms, and how do `electionTimeoutMillis` settings stabilize clusters?

## Phase 4: Sharding, Horizontal Scaling & Distributed Clusters

* **Card 31 (Sharded Cluster Architecture):** Deconstruct a MongoDB sharded cluster into its three core logical components: Mongos Routers, Config Server Replica Set, and Shards.
* **Card 32 (Shard Key Selection Criteria):** What three fundamental properties (high cardinality, low frequency, even write distribution) define an optimal shard key?
* **Card 33 (Ranged Sharding vs Hashed Sharding):** Contrast Ranged Sharding (optimizing range queries, risking write hot-spots) with Hashed Sharding (ensuring even distribution, destroying range scan efficiency).
* **Card 34 (Chunk Migration and Balancing):** How does the balancer background process migrate data chunks between shards when chunk size thresholds (default 64MB) are exceeded?
* **Card 35 (Zone Sharding / Tag-Aware Sharding):** How does Zone Sharding route specific document ranges or tenants to dedicated geographical or hardware-tier shards?
* **Card 36 (Config Server Role):** Why must the Config Server Replica Set run with `w: "majority"` to maintain cluster metadata and chunk version maps?
* **Card 37 (Targeted Queries vs Scatter-Gather Queries):** Why are scatter-gather queries (hitting all shards because the shard key is missing from the query filter) a major performance anti-pattern?
* **Card 38 (Monotonic Shard Key Anti-Pattern):** Why does choosing an increasing shard key (like `ObjectId` timestamp prefix or auto-incrementing integers) bottleneck all writes onto a single target shard?
* **Card 39 (Compound Shard Keys and Refined Sharding):** How do compound shard keys (e.g., `{ tenantId: 1, userId: 1 }`) mitigate monotonicity and distribute writes across chunks?
* **Card 40 (Balancer Windows and Throttling):** Why do production environments restrict the balancer window to off-peak hours to prevent migration I/O spikes?

## Phase 5: Aggregation Framework, Transactions & Performance Troubleshooting

* **Card 41 (Aggregation Pipeline Architecture):** How does the aggregation pipeline process documents sequentially through stages (`$match`, `$group`, `$project`, `$sort`)?
* **Card 42 (Pipeline Optimization and Stage Reordering):** How does the query optimizer automatically reorder pipeline stages (e.g., pushing `$match` before `$sort`) to minimize memory usage?
* **Card 43 (Multi-Document ACID Transactions):** How do multi-document transactions work across replica sets, and what are their performance and latency trade-offs compared to single-document atomicity?
* **Card 44 (Transaction Lifetime Limits):** What is the purpose of `transactionLifetimeLimitSeconds` (default 60 seconds), and what happens when long-running transactions exceed it?
* **Card 45 (Change Streams Real-Time Integration):** How do Change Streams leverage the oplog to allow applications to listen to real-time data changes across collections or databases?
* **Card 46 (Security, RBAC and Encryption at Rest):** How do Role-Based Access Control (RBAC) and WiredTiger AES-256 encryption at rest secure enterprise MongoDB deployments?
* **Card 47 (Profiling Slow Queries):** How do you configure the database profiler (`db.setProfilingLevel(1, { slowms: 100 })`) and query the `system.profile` collection?
* **Card 48 (Lab Scenario A - The Unindexed Scatter-Gather Query):**
  * *The Setup:* A sharded cluster experiences 100% CPU utilization on all mongos routers. Queries filtering by email domain take 15 seconds to return.
  * *The Challenge:* Diagnose why omitting the shard key from queries forces a scatter-gather operation across all shards, and redesign the sharding strategy or indexing to target specific shards.
* **Card 49 (Lab Scenario B - The Monotonic Shard Key Bottleneck):**
  * *The Setup:* A high-throughput IoT ingestion pipeline shards collections using `_id` (`ObjectId`). Shard 3 processes 90% of all write operations while Shards 1 and 2 sit idle.
  * *The Challenge:* Explain why the time-based prefix of `ObjectId` causes write hot-spots, and refactor the sharding strategy using a hashed shard key or a compound prefix key.
* **Card 50 (Lab Scenario C - The Transaction Lock Timeout):**
  * *The Setup:* A multi-document transaction updating inventory counts aborts with `WriteConflict` errors and lock timeout exceptions during peak flash sale traffic.
  * *The Challenge:* Tune transaction execution times, reduce batch sizes within transactions, and resolve document-level contention to eliminate write conflicts.