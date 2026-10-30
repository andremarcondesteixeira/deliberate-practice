# Redis

## Data Structures

* **Strings & Bit Operations:** Why are Redis strings binary safe, what is their 512MB limit, and how do `SETBIT`, `BITCOUNT`, and `BITFIELD` let you keep bit-level counters directly in memory?
* **Compact Encodings:** How do hashes, lists, sets, and sorted sets switch from compact listpack/intset encodings to hashtables/skiplists as they grow? Which config thresholds control this, and why does it matter for memory?
* **Lists & Blocking Operations:** Contrast `LPUSH`/`RPOP` with blocking `BLPOP`/`BLMOVE` for building queues. How does `LMOVE` make a reliable queue?
* **Sets:** How do sets guarantee uniqueness, and what is the complexity of `SINTER`, `SUNION`, and `SDIFF` on large sets?
* **Sorted Sets:** Explain the hash table plus skip list behind sorted sets. Which use cases (leaderboards, rate limiters, delayed job queues) does that enable?
* **Bitmaps vs HyperLogLog:** Compare bitmaps (exact, memory proportional to the ID range) with HyperLogLog (~12KB, ~0.81% standard error) for counting unique users.
* **Geospatial Indexes:** How do `GEOADD`/`GEOSEARCH` encode coordinates as geohashes stored in a sorted set?
* **Streams:** How do Redis Streams provide an append-only log with consumer groups, IDs, acknowledgements, and the pending entries list? How do they compare with Kafka?
* **JSON & Search:** How do RedisJSON and the query engine (RediSearch) add document storage, secondary indexes, and full-text/vector search on top of the key-value core?

## Architecture & Memory

* **Single-Threaded Event Loop:** Why is Redis fast despite executing commands on one thread (in-memory data, `epoll`/`kqueue` multiplexing, no lock contention)? What do the I/O threads added in Redis 6 parallelize, and what don't they?
* **Eviction Policies:** Explain `noeviction`, `allkeys-lru`, `volatile-lru`, `allkeys-lfu`, `volatile-ttl`, and friends when `maxmemory` is reached. Why is Redis LRU approximate (sampling), and when does LFU beat LRU?
* **Expiration:** How does Redis combine lazy expiration on access with active sampling to purge expired keys? Why can memory stay high after many keys expire?
* **Lazy Freeing:** Why can `DEL` on a huge key block the server, and how do `UNLINK` and the `lazyfree-*` settings move freeing to a background thread?
* **Memory Fragmentation:** How does jemalloc fragmentation show up in `mem_fragmentation_ratio`, and how does active defragmentation help? What does a ratio below 1 mean?
* **Client Output Buffers & Pub/Sub:** How do slow clients and slow Pub/Sub subscribers grow output buffers without bound, and how do `client-output-buffer-limit` classes (normal, replica, pubsub) protect the server?
* **Pipelining:** How does pipelining cut round trips by sending many commands without waiting for replies? How is it different from `MULTI`/`EXEC`?
* **Transactions:** How do `MULTI`, `EXEC`, `DISCARD`, and optimistic `WATCH` work? Why is there no rollback when a command inside `EXEC` fails?
* **Lua Scripts & Functions:** Why do Lua scripts and Redis 7 Functions run atomically, and why is a long-running script dangerous? How do Functions improve on `EVAL`/`EVALSHA` (named libraries, persistence, replication)?
* **Client-Side Caching:** How does `CLIENT TRACKING` (default vs broadcasting mode) invalidate application-local caches when keys change?

## Persistence

* **RDB Snapshots & fork():** How does `BGSAVE` use `fork()` and copy-on-write to write a point-in-time snapshot? Why can the fork fail or the host start swapping with `vm.overcommit_memory=0` and a write-heavy workload?
* **AOF fsync Policies:** Contrast `appendfsync always`, `everysec`, and `no` regarding data loss and latency. How do you repair a truncated AOF (`redis-check-aof`)?
* **AOF Rewrite:** How does `BGREWRITEAOF` compact the log, and how are writes that arrive during the rewrite preserved (rewrite buffer, multi-part AOF in Redis 7)?
* **Hybrid Persistence:** How does an RDB preamble inside the AOF speed up restarts while keeping AOF durability?

## Replication & High Availability

* **PSYNC & the Replication Backlog:** Walk through full vs partial resynchronization with `PSYNC`. How does sizing `repl-backlog-size` avoid expensive full resyncs after short disconnects, and what does diskless replication change?
* **Stale Reads on Replicas:** What consistency risks come from reading replicas (asynchronous lag, acknowledged writes lost on failover)? What does `WAIT` give you, and what doesn't it?
* **Sentinel:** What do Sentinels do (monitoring, notification, failover, configuration provider)? How are a replica's `replica-priority` and replication offset used to pick the new master?
* **Sentinel Quorum & Split-Brain:** How do `down-after-milliseconds`, SDOWN vs ODOWN, and the quorum work? Why does failover need a majority of Sentinels, and how do `min-replicas-to-write` settings limit the writes an isolated old master can lose?

## Cluster

* **Hash Slots & Hash Tags:** How does Redis Cluster map keys to 16,384 slots with `CRC16(key) mod 16384`? How do hash tags (`{user123}.profile`) colocate keys for multi-key commands, and what hot-slot risk do they create?
* **MOVED vs ASK:** Contrast `MOVED` (slot ownership changed permanently) with `ASK` (slot mid-migration). How should a smart client handle each?
* **Cluster Bus & Failover:** How do nodes gossip over the cluster bus (port + 10000), mark nodes as failed, and elect a replica using config epochs? How do clients read from replicas with `READONLY`?

## Diagnostics & Scenarios

* **Slowlog & Latency Tools:** How do `SLOWLOG`, `LATENCY DOCTOR`, `LATENCY LATEST`, and `redis-cli --bigkeys`/`--memkeys` find blocking commands and big keys? Why is `MONITOR` dangerous in production?
* **Lab — Fork Latency Spike:**
  * *Setup:* A 25GB Redis instance stalls for 1.5 seconds and drops connections every time a background save starts.
  * *Challenge:* Explain how copying page tables during `fork()` blocks the event loop, why transparent huge pages make copy-on-write worse, and mitigate it (disable THP, smaller instances, persistence on replicas only).
* **Lab — OOM Write Lockout:**
  * *Setup:* A cache hits `maxmemory` with `noeviction`, and every write fails with `OOM command not allowed when used memory > 'maxmemory'`.
  * *Challenge:* Choose the right eviction policy for a cache vs a primary datastore, enforce TTLs, find what's consuming memory, and alert before the limit is reached.
