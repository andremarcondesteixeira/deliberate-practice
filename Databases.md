# Database Systems Internals, Architecture & Performance Practice (100 Challenges)

## Phase 1: Database Storage Engines & On-Disk Layout

* **Card 1 (Page-Based Storage Architecture):** How do relational database storage engines organize data into fixed-size disk pages (e.g., 8KB in PostgreSQL, 16KB in InnoDB), and what is a slotted-page layout?
* **Card 2 (Row-Oriented vs Column-Oriented Storage):** Contrast row-oriented storage (optimized for OLTP point lookups) with column-oriented storage (optimized for OLAP aggregations and SIMD compression).
* **Card 3 (Log-Structured Merge-Trees - LSM):** Explain the architecture of LSM-tree engines (MemTable, WAL, SSTables) and how they optimize write throughput compared to B-Trees.
* **Card 4 (SSTable Compaction Strategies):** Contrast Size-Tiered Compaction (STCS) with Leveled Compaction (LCS) regarding write amplification, read latency, and disk space overhead.
* **Card 5 (Write-Ahead Logging - WAL):** What is the physiological role of the Write-Ahead Log (or Redo Log), and how does the ARIES recovery algorithm use WAL for atomicity and durability?
* **Card 6 (Buffer Pool Mechanics):** How does a database buffer pool manage page caching in RAM, and how do modified "dirty pages" get flushed to disk using checkpointing?
* **Card 7 (Buffer Pool Eviction Policies):** Contrast standard LRU page replacement with 2Q or LRU-K algorithms to prevent sequential scan pollution in the buffer pool.
* **Card 8 (Free Space Map & Visibility Map):** What roles do the Free Space Map (FSM) and Visibility Map (VM) play in PostgreSQL storage engines?
* **Card 9 (Freezing XIDs in PostgreSQL):** What is 32-bit transaction ID wraparound in PostgreSQL, and how does the autovacuum process freeze old XIDs to prevent data loss?
* **Card 10 (Direct I/O vs Page Cache):** Why do databases like MySQL InnoDB bypass the operating system page cache using `O_DIRECT`, while databases like RocksDB or Cassandra leverage OS page cache?

## Phase 2: Indexing Mechanics & Data Structures

* **Card 11 (B-Tree vs B+Tree Architecture):** Why do databases use B+Trees (data pointers only in leaf nodes) rather than standard B-Trees for disk-based indexing?
* **Card 12 (Clustered vs Secondary Indexes):** Contrast Clustered Indexes (where table rows are stored directly in leaf nodes) with Secondary Indexes (where leaf nodes store pointers or primary keys).
* **Card 13 (Covering Indexes & Index-Only Scans):** How does a Covering Index allow a database engine to execute an Index-Only Scan without hitting table heap pages?
* **Card 14 (GIN vs GiST Indexes):** In PostgreSQL, when should an architect choose a Generalized Inverted Index (GIN) over a Generalized Search Tree (GiST) for multi-value data types like JSONB or Full-Text Search?
* **Card 15 (BRIN Indexes):** How do Block Range Indexes (BRIN) provide ultra-lightweight indexing for giant, naturally ordered append-only tables?
* **Card 16 (LSM Bloom Filters):** How do in-memory Bloom filters optimize LSM-tree read paths by quickly checking whether a key definitely does not exist in an SSTable?
* **Card 17 (Hash Indexes Limitations):** Why are Hash Indexes rarely used in relational databases compared to B-Trees, despite providing $O(1)$ lookup time?
* **Card 18 (Composite Index Column Order):** How does the Leftmost Prefix Rule dictate query matching effectiveness on composite (multi-column) B-Tree indexes?
* **Card 19 (Partial & Expression Indexes):** How do Partial Indexes (with a `WHERE` clause) and Expression Indexes (indexing computed functions) optimize space and query performance?
* **Card 20 (Index Bloat & Fragmentation):** What causes index page splitting and leaf page bloat during random updates/deletions, and how do rebuilds (`REINDEX`, `OPTIMIZE TABLE`) fix it?

## Phase 3: Transactions, Concurrency Control & Isolation

* **Card 21 (ACID Guarantees):** Deconstruct ACID semantics: Atomicity, Consistency, Isolation, and Durability within a single database system.
* **Card 22 (Concurrency Anomalies):** Define Dirty Reads, Non-Repeatable Reads, Phantom Reads, and Lost Updates in transaction processing.
* **Card 23 (Multi-Version Concurrency Control - MVCC):** How does MVCC allow "readers to never block writers, and writers to never block readers" by maintaining historical row tuples?
* **Card 24 (Read Committed vs Repeatable Read):** Contrast Read Committed (new snapshot per statement) with Repeatable Read (single snapshot per transaction) in MVCC implementations.
* **Card 25 (Write Skew Anomalies):** Explain Write Skew using a clinical duty shift or hotel reservation scenario, and why Repeatable Read isolation fails to prevent it.
* **Card 26 (Serializable Snapshot Isolation - SSI):** How does SSI achieve optimistic serializable isolation without heavy locking by tracking read-write dependency graphs (`siw` edges)?
* **Card 27 (Two-Phase Locking - 2PL):** Contrast 2PL (growing phase and shrinking phase) with Two-Phase Commit (2PC). How does 2PL prevent concurrent transaction conflicts?
* **Card 28 (Explicit Row Locking):** Differentiate between `SELECT ... FOR UPDATE` (exclusive lock) and `SELECT ... FOR SHARE` (shared lock) in relational transactions.
* **Card 29 (Deadlock Resolution Mechanics):** How do database lock managers detect circular waits in wait-for graphs and resolve deadlocks via transaction aborts?
* **Card 30 (PostgreSQL Vacuuming Mechanics):** Why does PostgreSQL require a VACUUM process to clean up dead tuples left behind by MVCC updates and deletes?

## Phase 4: Query Optimization, Execution & Joining

* **Card 31 (Cost-Based Optimizer - CBO):** How does a CBO use table statistics (data distribution histograms, null fractions, distinct values) to construct an execution plan?
* **Card 32 (Nested Loop Join):** When is a Nested Loop Join optimal (e.g., small outer table with indexed inner table), and what is an Index Nested Loop Join?
* **Card 33 (Hash Join Mechanics):** Walk through the Build Phase and Probe Phase of a Hash Join. What happens when the hash table exceeds available work memory (`work_mem`)?
* **Card 34 (Sort-Merge Join):** Under what conditions (e.g., pre-sorted index inputs or large datasets) does a database planner prefer a Sort-Merge Join over a Hash Join?
* **Card 35 (Sequential Scan vs Index Scan):** Why does a Cost-Based Optimizer deliberately choose a full table Sequential Scan over an Index Scan when retrieving a high percentage of table rows?
* **Card 36 (EXPLAIN ANALYZE Parsing):** What is the difference between `EXPLAIN` (planner estimated costs) and `EXPLAIN ANALYZE` (actual execution runtime metrics)?
* **Card 37 (Correlated Subqueries):** Why do correlated subqueries execute repeatedly per candidate row, and how do join transformations optimize them?
* **Card 38 (Prepared Statements & Plan Caching):** How do prepared statements optimize execution by skipping query parsing and planning steps on repeated invocations?
* **Card 39 (Vectorized Query Execution):** How do OLAP execution engines (like ClickHouse or DuckDB) process data in vectors (batches of tuples) using CPU SIMD registers?
* **Card 40 (JIT Compilation in Queries):** How does Just-In-Time (JIT) compilation (LLVM) accelerate complex expression evaluation in analytical database queries?

## Phase 5: Distributed Databases, Sharding & Consistency

* **Card 41 (Database Sharding Patterns):** Contrast Hash-Based Sharding (even data distribution) with Range-Based Sharding (great for scans, vulnerable to write hot-spots).
* **Card 42 (Consistent Hashing Ring):** How does a Consistent Hashing ring with virtual nodes minimize data migration during database node additions or removals?
* **Card 43 (CAP Theorem in Datastores):** In the presence of a network partition (P), contrast CP stores (like HBase or CockroachDB) with AP stores (like Cassandra or DynamoDB).
* **Card 44 (Tunable Consistency in Dynamo-Style Stores):** Given $N$ replicas, explain how setting $R + W > N$ achieves strong quorum consistency in leaderless databases.
* **Card 45 (Read Repair vs Anti-Entropy):** How do leaderless databases use Read Repair during query execution and background Merkle Tree Anti-Entropy syncs to resolve data divergence?
* **Card 46 (Two-Phase Commit - 2PC Protocol):** Walk through the Prepare and Commit phases of 2PC across distributed database shards, and explain why a coordinator crash blocks the system.
* **Card 47 (Distributed Transactions - Spanner TrueTime):** How does Google Spanner use atomic clocks and GPS receivers (TrueTime API) to bound time uncertainty and guarantee strict serializability?
* **Card 48 (Distributed Consensus - Raft & Paxos):** How do modern distributed SQL databases (CockroachDB, YugabyteDB) use Raft or Paxos groups per shard to replicate state safely?
* **Card 49 (Global Secondary Indexes in Distributed DBs):** Why do global secondary indexes across sharded databases require asynchronous updates or distributed 2PC transactions?
* **Card 50 (Sloppy Quorums and Hinted Handoff):** How do sloppy quorums maintain write availability during node partitions at the expense of temporary read consistency?

## Phase 6: NoSQL, NewSQL & Specialized Datastores

* **Card 51 (Document Databases - MongoDB):** When is a document data model (JSON-like, schema-on-read, embedded arrays) superior to a normalized relational schema?
* **Card 52 (Wide-Column Stores - Cassandra):** How do wide-column stores model data around partition keys and clustering keys for fast multi-row range scans?
* **Card 53 (Key-Value Stores - Redis Architecture):** Why is Redis exceptionally fast as an in-memory data store, and how does it manage single-threaded event loop execution?
* **Card 54 (Redis Persistence Modes - RDB vs AOF):** Contrast Redis RDB point-in-time snapshotting with AOF (Append-Only File) logging regarding durability and recovery speed.
* **Card 55 (Graph Databases - Property Graphs):** How do graph databases (like Neo4j) achieve index-free adjacency to execute deep $N$-hop traversal queries in constant time?
* **Card 56 (Time-Series Databases - TSDB):** What architectural features (high-write ingestion, automatic retention downsampling, compression) characterize TSDBs like TimescaleDB or InfluxDB?
* **Card 57 (Vector Databases - ANN Search):** How do vector databases index high-dimensional embeddings using HNSW (Hierarchical Navigable Small World) graphs for Approximate Nearest Neighbor (ANN) search?
* **Card 58 (NewSQL Distributed Systems):** What defines NewSQL databases (combining NoSQL horizontal scale with full relational ACID compliance)?
* **Card 59 (Search Engines - Inverted Indexing):** How do inverted indexes in Elasticsearch/Lucene map tokenized terms to document posting lists for full-text retrieval?
* **Card 60 (HTAP Architecture):** How do Hybrid Transactional/Analytical Processing (HTAP) systems combine row-store engines with column-store replicas in a single database?

## Phase 7: Replication, High Availability & Disaster Recovery

* **Card 61 (Single-Leader Replication):** Walk through single-leader (active/passive) replication mechanics and contrast synchronous follower replication with asynchronous follower replication.
* **Card 62 (Physical vs Logical Replication):** Contrast Physical Streaming Replication (shipping raw WAL byte blocks) with Logical Replication (shipping row-level change events).
* **Card 63 (Multi-Leader Replication Hazards):** What architectural challenges (concurrent write conflicts, Last-Write-Wins data loss) plague multi-leader replication setups?
* **Card 64 (Change Data Capture - CDC):** How do CDC frameworks (like Debezium) stream database WAL mutations directly into event brokers (Kafka) without application-level double-writes?
* **Card 65 (Replication Lag Anomalies):** Explain Read-Your-Own-Writes consistency, Monotonic Reads, and Consistent Prefix Reads in eventually consistent replica topology.
* **Card 66 (Split-Brain in Automatic Failover):** How do high-availability orchestrators prevent split-brain scenarios where two database instances claim to be the active primary?
* **Card 67 (Connection Pooling - PgBouncer/ProxySQL):** Why are external connection poolers necessary for databases that allocate a dedicated OS process or thread per connection?
* **Card 68 (Point-In-Time Recovery - PITR):** How do base backups combined with archived continuous WAL logs enable Point-In-Time Recovery to a specific microsecond?
* **Card 69 (Read Replica Lag Mitigation):** How can applications route critical read queries to the primary database while sending non-critical queries to read replicas safely?
* **Card 70 (Cross-Region Replication Strategies):** What are the network latency trade-offs of deploying active-passive multi-region database architectures?

## Phase 8: Benchmarking, Maintenance & Troubleshooting Scenarios

* **Card 71 (Database Connection Exhaustion):** What causes `too many connections` errors, and how does thread stack overhead degrade database CPU performance under unpooled connection spikes?
* **Card 72 (Autovacuum Starvation):** What happens when PostgreSQL autovacuum cannot acquire table locks or is cancelled by long-running analytical queries?
* **Card 73 (Hot Partition / Celebrity Key Problem):** How do you diagnose and resolve write throttling caused by a single heavily accessed partition key in sharded datastores?
* **Card 74 (High Write Amplification):** What causes write amplification in LSM-tree or B-tree storage engines, and how does it degrade underlying SSD lifespan?
* **Card 75 (Slow Query Log & PG_Stat_Statements):** How do database administrators use `pg_stat_statements` or slow query logs to identify high-impact query bottlenecks?
* **Card 76 (N+1 Query Problem):** How does the ORM N+1 query pattern overwhelm database connection pools, and how do eager fetching or join fetches resolve it?
* **Card 77 (Temp File Disk Spills):** Why do complex queries write temporary files to disk, and how does increasing `work_mem` or sort buffers prevent disk I/O bottlenecks?
* **Card 78 (Lock Contention Diagnosis):** How do lock dependency trees (`pg_locks`, `sys.innodb_lock_waits`) help locate transactions holding locks on critical tables?
* **Card 79 (Unused Index Overhead):** Why are unused secondary indexes dangerous for high-throughput write workloads?
* **Card 80 (Database Schema Migration Deadlocks):** How do DDL operations (`ALTER TABLE`) acquire exclusive table lock access (`ACCESS EXCLUSIVE`), and how do you execute zero-downtime schema migrations?

## Phase 9: Advanced Architectural Scenarios & Case Studies

* **Card 81 (Lab Scenario A - The Autovacuum Wraparound Emergency):**
  * *The Setup:* A PostgreSQL production database shuts down abruptly and enters read-only mode. Server logs report `database is not accepting commands to avoid wraparound data loss in database "production"`.
  * *The Challenge:* Detail the emergency recovery steps required to run single-user mode `VACUUM FREEZE` and adjust autovacuum settings to prevent future wraparound outages.

* **Card 82 (Lab Scenario B - The Cascading Connection Pool Collapse):**
  * *The Setup:* A sudden spike in client traffic causes database connection pool starvation. Application worker threads hang waiting for database connections, causing a cascade of HTTP 504 timeouts.
  * *The Challenge:* Implement bounded thread pools, fast-fail queue limits, and PgBouncer transaction-level pooling to survive traffic surges.

* **Card 83 (Lab Scenario C - The LSM Compaction Disk I/O Spike):**
  * *The Setup:* An LSM-based store (Cassandra/RocksDB) experiences sudden, severe query latency spikes every afternoon. Disk metrics show 100% disk utilization due to concurrent major compactions.
  * *The Challenge:* Configure compaction throughput throttling, switch to leveled compaction, or schedule background maintenance windows to smooth disk I/O load.

* **Card 84 (Lab Scenario D - The Unindexed Foreign Key Lock Escalation):**
  * *The Setup:* Deleting a record in a parent table in PostgreSQL causes massive lock contention and application timeouts on unrelated foreign key operations in child tables.
  * *The Challenge:* Diagnose why unindexed foreign key columns require exclusive share locks on child tables, and implement mandatory foreign key secondary indexing.

* **Card 85 (Lab Scenario E - The Stale Read Replica Anomaly):**
  * *The Setup:* A user updates their user profile, clicks save, and refreshes the page, but the old profile data renders because the web app directed the read query to an asynchronously lagging read replica.
  * *The Challenge:* Design a "Read-Your-Own-Writes" routing architecture using transaction LSN (Log Sequence Number) tracking or sticky session routing.

* **Card 86 (Lab Scenario F - The Phantom Rows Write Skew Outage):**
  * *The Setup:* A doctor-on-call scheduling system uses `Repeatable Read` isolation. Two doctors attempt to take leave simultaneously, and both transactions succeed, leaving zero doctors on call.
  * *The Challenge:* Diagnose why `Repeatable Read` missed the phantom write condition, and refactor the transaction using `Serializable` isolation or explicit `SELECT FOR UPDATE` locking.

* **Card 87 (Lab Scenario G - The Cache Stampede on Database Invalidation):**
  * *The Setup:* When a critical Redis cache key expires, thousands of concurrent user requests miss the cache simultaneously and execute a complex SQL query against the primary database, crashing it.
  * *The Challenge:* Implement single-flight request coalescing, probabilistic early expiration (XFetch algorithm), or background cache pre-warming.

* **Card 88 (Lab Scenario H - The DynamoDB Hot Partition Throttling):**
  * *The Setup:* A DynamoDB table configured with high overall provisioned write capacity experiences frequent `ProvisionedThroughputExceededException` errors during peak hours.
  * *The Challenge:* Diagnose hot partition key skew (e.g., partition keying by date or country), and implement partition key salting or write-sharding techniques.

* **Card 89 (Lab Scenario I - The Inverted Index Bloat Death Spiral):**
  * *The Setup:* An Elasticsearch search cluster experiences high JVM garbage collection pauses and out-of-memory crashes due to heap exhaustion during heavy document indexing.
  * *The Challenge:* Tune bulk indexing sizes, refresh intervals, index mapping types, and segment merging limits to reduce heap pressure.

* **Card 90 (Lab Scenario J - The Zero-Downtime Column Renaming Trap):**
  * *The Setup:* An engineering team renames a database column (`ALTER TABLE users RENAME COLUMN email TO user_email;`). The deployment causes widespread runtime exceptions across running app instances.
  * *The Challenge:* Outline the multi-phase expand-and-contract migration pattern (add new column, dual-write via app or triggers, backfill historical data, switch reads, remove old column).

## Phase 10: Performance Tuning & Hardware Interactions

* **Card 91 (SSD Flash Memory & TRIM):** How do SSD Flash Translation Layers (FTL), block erasure constraints, and TRIM commands impact random database write workloads?
* **Card 92 (NUMA Architecture Tuning):** What is Non-Uniform Memory Access (NUMA), and why can NUMA memory imbalance cause erratic database performance and sudden swap usage?
* **Card 93 (Dirty Page Flushes & File System Syncs):** How do `fsync` call frequencies and kernel dirty page parameters (`vm.dirty_background_ratio`, `vm.dirty_ratio`) influence database write spikes?
* **Card 94 (RAM Allocation Ratios):** How should a database administrator divide physical host RAM between the database engine buffer pool, OS page cache, and working memory per query?
* **Card 95 (CPU Core Scaling Limitations):** What internal database lock bottlenecks (e.g., buffer pool latch contention) limit linear scaling across systems with 64+ CPU cores?
* **Card 96 (WAL Partitioning and Striping):** Why is placing Write-Ahead Logs on physically separate storage media or high-throughput NVMe drives a standard performance optimization?
* **Card 97 (Shared Memory Allocation in Postgres):** How does PostgreSQL allocate shared memory segments (`shared_buffers`) across server processes, and what are the system `shmmax` kernel boundaries?
* **Card 98 (Connection Overhead Metrics):** What are the memory allocation differences between process-per-connection models (PostgreSQL) and thread-per-connection models (MySQL/SQL Server)?
* **Card 99 (Partition Pruning Performance):** How does dynamic partition pruning in declarative partitioned tables allow database query planners to eliminate unneeded disk page scans?
* **Card 100 (Database Benchmarking Practices):** Why are synthetic benchmarks (like `pgbench` or `sysbench`) often misleading compared to realistic production workload replay testing?