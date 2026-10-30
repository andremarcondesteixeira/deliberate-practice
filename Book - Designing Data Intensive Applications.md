# Designing Data-Intensive Applications (DDIA) Practice (100 Challenges)

## Phase 1: Foundations of Data Systems & Maintainability

* **Card 1 (Reliability Definition):** How does Kleppmann define Reliability, and what is the crucial distinction between a *fault* and a *failure*?
* **Card 2 (Scalability & Load Parameters):** How do load parameters (e.g., requests/sec, read/write ratio, hit rate) define system scalability requirements?
* **Card 3 (Latency vs Response Time):** Differentiate between Response Time and Latency, and explain why high percentiles ($p95$, $p99$, $p999$) are critical for measuring user experience.
* **Card 4 (Head-of-Line Blocking in Tail Latency):** How does a single slow request in a server queue cause head-of-line blocking and inflate high-percentile response times ($p99$)?
* **Card 5 (Maintainability Pillars):** Explain the three core maintainability principles: Operability, Simplicity, and Evolvability.
* **Card 6 (Abstraction and Complexity):** How do good abstractions reduce cognitive load for developers while hiding accidental complexity?
* **Card 7 (Hardware vs Software Faults):** Contrast hardware faults (RAID failures, power outages) with systematic software bugs and human operational errors.
* **Card 8 (Measuring Throughput):** Define throughput in batch processing systems versus response time in interactive online services.

## Phase 2: Data Models & Query Languages

* **Card 9 (Relational vs Document Model):** Compare the relational model (tables, strict schemas, normalization) with the document model (JSON/XML trees, schema-on-read, locality).
* **Card 10 (Many-to-One and Many-to-Many Relationships):** Why does the relational model handle many-to-one and many-to-many relationships better than document databases?
* **Card 11 (Schema-on-Read vs Schema-on-Write):** Contrast dynamic typing (*schema-on-read*) in document databases with static enforcement (*schema-on-write*) in relational databases.
* **Card 12 (Graph Data Models):** Compare Property Graphs and Triple-Stores (RDF) regarding vertices, edges, and relationship traversal syntax.
* **Card 13 (Declarative vs Imperative Queries):** Why are declarative query languages (like SQL) superior for database query optimizers compared to imperative iteration code?
* **Card 14 (Network Model Historical Context):** How did CODASYL (the network model) handle relationships using explicit manual pointers, and why did relational modeling replace it?
* **Card 15 (Document Locality Trade-offs):** How does storage locality benefit reading an entire JSON document, and what is the write penalty when updating a small field inside a large document?
* **Card 16 (Datalog Query Language):** What is Datalog, and how does it express recursive queries across complex graph topologies?

## Phase 3: Storage Engines & Indexing

* **Card 17 (Log-Structured Storage Engine):** Walk through an append-only log storage engine. How does key-value compaction reclaim disk space?
* **Card 18 (Hash Indexes in Memory):** How does Bitcask store key-value data with an in-memory hash map index, and what are its memory limits?
* **Card 19 (SSTables and LSM-Trees):** Explain Sorted String Tables (SSTables) and how Log-Structured Merge-Trees (LSM-Trees) use memtables and disk compaction.
* **Card 20 (Compaction Strategies):** Contrast Size-Tiered compaction with Levelled compaction in LSM-Tree databases (like Cassandra or RocksDB).
* **Card 21 (B-Trees Architecture):** How do B-Trees partition disk pages into fixed-size blocks (typically 4KB) organized in a balanced tree structure?
* **Card 22 (LSM-Trees vs B-Trees Write Amplification):** Compare LSM-Trees (optimized for high write throughput) with B-Trees (optimized for fast point reads).
* **Card 23 (Write-Ahead Log - WAL):** Why must B-Tree engines maintain an append-only Write-Ahead Log (WAL) alongside disk page modifications?
* **Card 24 (Bloom Filters Optimization):** How do Bloom filters optimize LSM-Tree read operations for non-existent keys without hitting disk storage?
* **Card 25 (Clustered vs Secondary Indexes):** Contrast Clustered Indexes (storing row data directly in the index) with Secondary Indexes (storing pointers to heap files).
* **Card 26 (Covering Indexes):** What is a Covering Index, and how does storing payload columns directly in index leaf nodes avoid heap file lookups?
* **Card 27 (In-Memory Databases):** How do in-memory data stores (like Redis) achieve speed, and how do they handle durability (snapshots/AOF) differently than disk-first engines?
* **Card 28 (OLTP vs OLAP Storage Engines):** Contrast Online Transaction Processing (OLTP) query patterns with Online Analytical Processing (OLAP) star/snowflake schemas.
* **Card 29 (Column-Oriented Storage):** Why does storing each column contiguously on disk optimize OLAP aggregation queries over billions of rows?
* **Card 30 (Column Compression & Vectorized Execution):** How do bitmap encoding, run-length encoding, and SIMD CPU instructions accelerate column-oriented database reads?

## Phase 4: Encoding & Data Evolution

* **Card 31 (Formats and Backward/Forward Compatibility):** Define Backward Compatibility (newer code reading older data) and Forward Compatibility (older code reading newer data).
* **Card 32 (Binary Encoding Formats):** Compare Protocol Buffers (Protobuf), Thrift, and Avro regarding field tags, schema definitions, and schema evolution rules.
* **Card 33 (Avro Schema Resolution):** How does Apache Avro match the writer's schema with the reader's schema dynamically using schema resolution rules?
* **Card 34 (JSON and XML Limitations):** What are the performance and parsing drawbacks of text-based formats (JSON, XML, CSV) regarding numbers, binary strings, and schema enforcement?
* **Card 35 (Data Flow via Databases):** Why must databases account for "data outliving code" when writing records under changing application schemas?
* **Card 36 (Data Flow via Service Calls (REST/gRPC)):** How do API contracts in REST and gRPC handle client and server version evolution independently?
* **Card 37 (Data Flow via Asynchronous Messaging):** How do message brokers decouple producers and consumers during asynchronous schema upgrades?

## Phase 5: Replication

* **Card 38 (Leader-Based Replication):** How does single-leader (active/passive) replication flow updates from the leader to followers via a replication log?
* **Card 39 (Synchronous vs Asynchronous Replication):** Contrast the durability guarantees and latency trade-offs of synchronous versus asynchronous follower replication.
* **Card 40 (Semi-Synchronous Replication):** Why do production systems configure one follower as synchronous and the rest as asynchronous (semi-synchronous)?
* **Card 41 (Failover Mechanics):** Walk through automatic leader failover: split-brain risk, fencing tokens, and node timeout detection.
* **Card 42 (Replication Log Implementations):** Compare statement-based replication, write-ahead log (WAL) shipping, and logical (row-based) log replication (`binlog`).
* **Card 43 (Replication Lag Anomalies):** Define Read-Your-Own-Writes consistency, Monotonic Reads, and Consistent Prefix Reads in eventually consistent replicas.
* **Card 44 (Multi-Leader Replication):** In what architectural scenarios (multi-datacenter, offline clients) is multi-leader replication used, and how are write conflicts handled?
* **Card 45 (Conflict Resolution Strategies):** Contrast Last-Write-Wins (LWW) conflict resolution with Conflict-Free Replicated Data Types (CRDTs) and operational transformation.
* **Card 46 (Leaderless Replication - Dynamo Style):** Explain leaderless replication (Riak, Cassandra) using read repairs and anti-entropy background processes.
* **Card 47 (Quorum Writes and Reads):** Given $N$ replicas, define the quorum condition $W + R > N$ for guaranteeing overlapping read and write node sets.
* **Card 48 (Sloppy Quorums and Hinted Handoff):** How do sloppy quorums and hinted handoff maintain write availability during network partitions at the cost of strict quorum consistency?
* **Card 49 (Concurrent Write Detection):** How do version vectors and vector clocks determine whether two operations are causally dependent or strictly concurrent?

## Phase 6: Partitioning (Sharding)

* **Card 50 (Partitioning Goals):** Why is data partitioned (sharded) across multiple nodes, and how does partitioning combine with replication?
* **Card 51 (Partitioning by Key Range):** How does partitioning data by contiguous key ranges enable efficient range queries, and how does it cause hot-spots?
* **Card 52 (Partitioning by Hash of Key):** How does hashing partition keys distribute traffic evenly across shards, and why does it break range query performance?
* **Card 53 (Compound Keys in Partitioning):** How do compound primary keys (e.g., `(user_id, timestamp)`) enable hash partitioning on the first column and range sorting on the second?
* **Card 54 (Skew and Hotspots Mitigation):** How can applications mitigate extreme partition skew (e.g., celebrity keys receiving millions of concurrent writes)?
* **Card 55 (Document-Based Secondary Indexes):** Explain local secondary indexes (scatter-gather reads across all partitions) in sharded databases.
* **Card 56 (Term-Based Secondary Indexes):** Explain global secondary indexes (partitioned by index term) and why updating them requires asynchronous execution.
* **Card 57 (Rebalancing Strategies - Fixed Partitions):** How does pre-creating a fixed number of partitions (e.g., 256) simplify cluster rebalancing when adding new nodes?
* **Card 58 (Dynamic Partitioning):** How do databases like HBase dynamically split and merge partitions based on threshold data volume limits?
* **Card 59 (Hash Modulo N Pitfall):** Why is naive `hash(key) mod N` partitioning dangerous during node additions or removals?
* **Card 60 (Request Routing and Service Discovery):** How do routing tiers, ZooKeeper, or gossip protocols direct client requests to the correct partition node?

## Phase 7: Transactions & Isolation Levels

* **Card 61 (ACID Principles):** Deconstruct ACID semantics: Atomicity, Consistency, Isolation, and Durability in transaction processing.
* **Card 62 (BASE Philosophy):** Contrast ACID guarantees with BASE (Basically Available, Soft state, Eventual consistency) distributed systems tradeoffs.
* **Card 63 (Single-Object vs Multi-Object Transactions):** Why are multi-object transactions difficult in distributed datastores, and how do single-object atomic writes compare?
* **Card 64 (Dirty Reads & Read Committed):** Define Dirty Reads and explain how Read Committed isolation prevents reading uncommitted concurrent writes.
* **Card 65 (Dirty Writes & Row Locking):** Define Dirty Writes and explain how row-level locks prevent transactions from overwriting uncommitted concurrent updates.
* **Card 66 (Non-Repeatable Reads & Read Skew):** What is Read Skew (Non-Repeatable Read), and why is it problematic for long-running backup or analytics queries?
* **Card 67 (Snapshot Isolation & MVCC):** How does Multi-Version Concurrency Control (MVCC) enforce Snapshot Isolation so that "readers never block writers, and writers never block readers"?
* **Card 68 (Lost Updates & Atomic Writes):** What causes the Lost Update problem during concurrent read-modify-write cycles, and how do explicit `SELECT FOR UPDATE` locks mitigate it?
* **Card 69 (Write Skew and Phantoms):** Explain Write Skew using a medical call-duty or booking scenario. How do phantom reads cause write skew?
* **Card 70 (Materializing Phantoms):** How does materializing phantoms convert a phantom condition into physical database rows to enable row locking?
* **Card 71 (Serializability):** Define Serializability as the strongest transaction isolation level, guaranteeing equivalent sequential execution outcomes.
* **Card 72 (Actual Serial Execution):** How do single-threaded in-memory databases (like Redis or VoltDB) achieve true serial execution without lock overhead?
* **Card 73 (Two-Phase Locking - 2PL):** Walk through 2PL using shared (read) locks and exclusive (write) locks. How does 2PL differ from Two-Phase Commit (2PC)?
* **Card 74 (Serializable Snapshot Isolation - SSI):** How does SSI achieve optimistic serializability without blocking locks by tracking causal dependencies and aborting conflicting transactions?

## Phase 8: The Trouble with Distributed Systems

* **Card 75 (Unreliable Networks & Packets):** Why must distributed systems assume asynchronous network channels where packets can be delayed, duplicated, or dropped indefinitely?
* **Card 76 (Unreliable Clocks & Time):** Differentiate between Time-of-Day clocks (NTP synchronized) and Monotonic clocks (`clock_gettime(CLOCK_MONOTONIC)`).
* **Card 77 (Clock Drift and Last-Write-Wins Risks):** How does NTP clock drift cause data loss or silent overwrites in Last-Write-Wins (LWW) multi-leader databases?
* **Card 78 (Process Pauses & GC Invalidation):** How do garbage collection pauses, VM STW events, or page faults cause nodes to lose lease ownership without knowing it?
* **Card 79 (Fencing Tokens):** How do incrementing fencing tokens protect shared resources from stale requests sent by paused or deadlocked former leaders?
* **Card 80 (Byzantine Faults vs Crash-Stop):** Contrast Crash-Stop/Crash-Recovery fault models with Byzantine faults (untrusted nodes, malicious messaging).
* **Card 81 (Safety and Liveness Guarantees):** Define Safety properties ("nothing bad happens") and Liveness properties ("something good eventually happens") in distributed algorithms.

## Phase 9: Consistency & Consensus

* **Card 82 (Linearizability Definition):** Define Linearizability (strong consistency) as making a system appear as if there is only a single copy of data updated atomically.
* **Card 83 (Linearizability vs Serializability):** Contrast Linearizability (a freshness guarantee on single objects) with Serializability (a multi-object transaction isolation property).
* **Card 84 (Cost of Linearizability):** According to the CAP theorem, why does maintaining linearizability during network partitions sacrifice system availability?
* **Card 85 (Causal Consistency & Total Order):** Why is Causal Consistency the strongest consistency model that does not sacrifice availability under network partitions?
* **Card 86 (Sequence Number Generators):** How do logical clocks (Lamport Timestamps) generate globally ordered sequence numbers without physical clock synchronization?
* **Card 87 (Total Order Broadcast):** Define Total Order Broadcast (reliable, ordered delivery to all nodes) and explain why it is equivalent to consensus.
* **Card 88 (Two-Phase Commit - 2PC Protocol):** Walk through the 2PC protocol across a Coordinator and Participants: Prepare Phase, Commit Phase, and Coordinator crash risks.
* **Card 89 (Distributed Consensus Algorithms):** How do consensus algorithms (Raft, Paxos, Zab) elect leaders and replicate state machines safely across epoch terms?
* **Card 90 (XA Transactions Standard):** What is the XA standard for heterogeneous 2PC distributed transactions, and why does it suffer from operational complexity?

## Phase 10: Batch & Stream Processing

* **Card 91 (Batch Processing & MapReduce):** Explain the Map, Shuffle, and Reduce execution stages in MapReduce or Hadoop architectures.
* **Card 92 (Unix Philosophy in Data Systems):** How does the Unix design philosophy (small tools, `stdin`/`stdout`, uniform pipe interfaces) translate to distributed batch processing?
* **Card 93 (Data Join Strategies in Batch Jobs):** Compare Sort-Merge Joins, Broadcast Hash Joins, and Partitioned-Hash Joins in distributed data pipelines.
* **Card 94 (Batch Job Fault Tolerance):** How do frameworks like MapReduce or Spark recover from mid-job worker failures without re-executing the entire pipeline?
* **Card 95 (Stream Processing vs Batch Processing):** Contrast bounded, batch processing over historical data with unbounded, real-time event stream processing.
* **Card 96 (Stream Join Types):** Compare Stream-Stream joins (windowed joins), Stream-Table joins (enrichment), and Table-Table joins (materialized views).
* **Card 97 (Windowing Strategies in Streaming):** Differentiate between Tumbling Windows (fixed non-overlapping), Hopping Windows (overlapping), and Session Windows (activity-based).
* **Card 98 (Event Time vs Processing Time):** Why is ordering events by Event Time (when it occurred) critical for stream processing accuracy compared to Processing Time (when received)?
* **Card 99 (Watermarks in Event Streaming):** What is a Watermark in stream engines (like Flink or Beam), and how does it handle out-of-order or late-arriving events?
* **Card 100 (Exactly-Once Stream Delivery):** How do idempotent writes, transactional commits, and Chandy-Lamport state snapshotting achieve end-to-end exactly-once stream processing?