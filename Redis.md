# Redis Architecture, Internals & Performance Practice (50 Challenges)

## Phase 1: Core Data Structures & Commands

* **Card 1 (Strings & Binary Safety):** Explain why Redis strings are binary safe, and how max-size limits (up to 512MB) and bit-level manipulations (`SETBIT`, `BITCOUNT`) work.
* **Card 2 (Hashes & Memory Encoding):** How do Redis hashes optimize memory utilization using ziplists (or listpacks in newer versions) versus hashtable encodings?
* **Card 3 (Lists & Blocking Operations):** Contrast regular list operations (`LPUSH`, `RPOP`) with blocking variants (`BLPOP`, `BRPOP`) for implementing message queues.
* **Card 4 (Sets & Set Algebra):** How do Redis sets ensure uniqueness, and how do set intersection (`SINTER`), union (`SUNION`), and difference (`SDIFF`) execute efficiently?
* **Card 5 (Sorted Sets - ZSETs):** Explain the dual-data-structure architecture of Sorted Sets combining hash tables with skip lists (and ziplists/listpacks for small sets).
* **Card 6 (Bitmaps and HyperLogLogs):** Compare Bitmaps (exact bit counters) with HyperLogLog structures (probabilistic cardinality estimation with ~0.81% standard error).
* **Card 7 (Geospatial Indexes):** How do Redis GEO commands encode geographical coordinates into geohashes backed by sorted sets?
* **Card 8 (Streams Architecture):** How do Redis Streams provide append-only log data structures with consumer groups, message IDs, and acknowledgements akin to Kafka?
* **Card 9 (JSON Module & Search):** How do Redis JSON and RediSearch modules extend core key-value capabilities to support document storage and full-text search?
* **Card 10 (Bitmap Bitfields):** How does the `BITFIELD` command execute arbitrary bit-level integer arithmetic directly inside Redis memory?

## Phase 2: Architecture, Single-Threaded Event Loop & Memory

* **Card 11 (Single-Threaded Event Loop):** Explain how Redis achieves high throughput using a single-threaded event loop driven by multiplexing APIs (`epoll`, `kqueue`).
* **Card 12 (IO Thread Pools in Redis 6+):** What architectural role do multi-threaded I/O worker threads play in Redis 6 and later for network read/write operations?
* **Card 13 (Memory Max and Eviction Policies):** Detail the behavior of Redis eviction policies (`noeviction`, `allkeys-lru`, `volatile-lru`, `allkeys-lfu`, `volatile-ttl`) when `maxmemory` is reached.
* **Card 14 (LRU vs LFU Algorithmic Trade-offs):** Why is Least Frequently Used (LFU) often superior to Least Recently Used (LRU) for caching hot keys in Redis?
* **Card 15 (Memory Fragmentation and jemalloc):** How does the jemalloc memory allocator manage memory fragmentation, and how do you monitor fragmentation ratio (`mem_fragmentation_ratio`)?
* **Card 16 (Lazy Freeing Mechanics):** Contrast blocking deletion (`DEL`) with asynchronous background thread deletion (`UNLINK`) using lazy freeing.
* **Card 17 (Expiration Algorithms):** How does Redis combine lazy expiration (on key access) with active probabilistic sampling (every 100ms) to purge expired keys?
* **Card 18 (Client Output Buffer Limits):** What are client output buffer limits, and how do they prevent rogue slow clients from exhausting server memory?
* **Card 19 (Pipeline Performance Optimization):** How do Redis pipelines reduce network round-trip time (RTT) overhead by batching multiple commands into a single TCP write?
* **Card 20 (Transactions with MULTI/EXEC):** How do `MULTI`, `EXEC`, `DISCARD`, and optimistic locking via `WATCH` handle transaction semantics without traditional isolation rollback?

## Phase 3: Persistence Mechanics (RDB & AOF)

* **Card 21 (RDB Snapshots & Copy-on-Write):** How does `BGSAVE` create point-in-time RDB snapshots using the operating system's Copy-on-Write (CoW) fork mechanism?
* **Card 22 (Append-Only File fsync Policies):** Contrast AOF `fsync` policies (`always`, `everysec`, `no`) regarding durability guarantees and disk I/O performance.
* **Card 23 (AOF Rewrite BGREWRITEAOF):** How does `BGREWRITEAOF` shrink bloated AOF log files by generating a minimal set of commands representing current dataset state?
* **Card 24 (Hybrid Persistence Mode):** How does Redis combine RDB preambles with AOF logs in modern versions to accelerate server restart times?
* **Card 25 (Diskless Replication):** How does diskless replication avoid disk I/O bottlenecks by streaming RDB files directly over sockets to replicas?
* **Card 26 (Fork Memory Overcommitment Risk):** Why can CoW fork operations fail with `Out Of Memory` if the Linux kernel has `vm.overcommit_memory=0` and memory usage is high?
* **Card 27 (Persistence Corruption Recovery):** How do tools like `redis-check-aof` repair corrupted Append-Only Files after sudden power failures?
* **Card 28 (AOF Rewrite Child Process Limits):** What happens to incoming writes during an active AOF rewrite, and how does the AOF rewrite buffer prevent data loss?

## Phase 4: Replication, High Availability & Sentinel

* **Card 29 (Master-Replica PSYNC Protocol):** Walk through the PSYNC handshake, partial resynchronization backlog buffer, and full synchronization phases.
* **Card 30 (Redis Sentinel Architecture):** What are the operational responsibilities of Redis Sentinel nodes in monitoring, notification, and automated failover?
* **Card 31 (Sentinel Quorum and Failure Detection):** How do `down-after-milliseconds` and quorum thresholds determine when a master is objectively down (ODOWN)?
* **Card 32 (Replica Read-Only & Drift Pitfalls):** What are the data consistency risks of reading stale or unexpired keys from read-only replicas during network splits?
* **Card 33 (Replication Backlog Sizing):** How does tuning `repl-backlog-size` prevent costly full resynchronizations during temporary network glitches?
* **Card 34 (Client-Side Caching & Tracking):** How does Redis client-side caching (Tracking mode) invalidate application local caches when keys change?
* **Card 35 (Pub/Sub Memory Pressures):** Why can slow Pub/Sub subscribers cause unbounded memory growth in Redis server output buffers?
* **Card 36 (Sentinel Split-Brain Prevention):** How do majority voting quorums in Sentinel prevent split-brain failover races?
* **Card 37 (Replica Priority Configuration):** How does `replica-priority` influence which replica is selected during an automated failover promotion?

## Phase 5: Clustering, Sharding & Scalability

* **Card 38 (Redis Cluster Architecture & Hash Slots):** Explain how Redis Cluster distributes data across 16,384 hash slots using CRC16 checksum modulo 16384.
* **Card 39 (Hash Tags for Multi-Key Operations):** How do Hash Tags (`{user123}.profile` and `{user123}.settings`) force specific keys into the same hash slot for multi-key transactions?
* **Card 40 (Cluster Slot Migration MOVED vs ASK):** Contrast `MOVED` redirection (permanent slot ownership change) with `ASK` redirection (temporary migration state).
* **Card 41 (Cluster Gossip Protocol):** How do cluster nodes exchange heartbeat and cluster state metadata via the internal gossip protocol on port + 10,000?
* **Card 42 (Read from Replicas in Cluster Mode):** How do clients issue the `READONLY` command to query replica nodes directly in cluster topologies?
* **Card 43 (Cluster Failover Voting Timeout):** How do replica election timeouts and epoch increments govern leader election during master node failures?
* **Card 44 (Redis Enterprise Active-Active CRDTs):** How do conflict-free replicated data types enable multi-master geo-distributed active-active replication without locking?

## Phase 6: Advanced Scenarios, Lua Scripting & Troubleshooting

* **Card 45 (Lua Scripting Atomicity):** Why are Lua scripts guaranteed to execute atomically in Redis, and what are the latency dangers of running long scripts?
* **Card 46 (Redis Functions vs Lua Scripts):** Contrast Redis Functions (introduced in Redis 7) with legacy Lua scripts regarding library management and persistence.
* **Card 47 (Slowlog Configuration & Analysis):** How do `slowlog-log-slower-than` and `slowlog-max-len` assist in profiling blocking commands?
* **Card 48 (Latency Doctor and Monitor):** How do `LATENCY DOCTOR`, `LATENCY LATEST`, and `MONITOR` diagnose production performance degradation?
* **Card 49 (Lab Scenario A - The Fork Latency Spike):**
  * *The Setup:* A Redis instance with 25GB of RAM experiences a sudden 1.5-second latency spike and drops connection packets every time a background backup triggers.
  * *The Challenge:* Diagnose how Linux page table duplication during `fork()` causes single-threaded event loop blocking, and mitigate it using transparent huge pages (THP) disablement or swap adjustments.
* **Card 50 (Lab Scenario B - The OOM Eviction Storm):**
  * *The Setup:* A Redis cache hits its `maxmemory` limit with `noeviction` enabled, causing all subsequent write commands to fail with `OOM command not allowed when used memory > 'maxmemory'`.
  * *The Challenge:* Implement proper eviction policies, proactive TTL expiration strategies, and memory monitoring alerts to prevent write lockouts.