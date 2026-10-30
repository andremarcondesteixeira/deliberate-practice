# Storage Engines & Indexing

## Log-Structured Engines

* **Append-Only Logs & Hash Indexes:** Walk through an append-only log engine with an in-memory hash index (Bitcask). How does compaction reclaim space, and why must all keys fit in memory?
* **SSTables & LSM-Trees:** How do LSM-trees combine a WAL, an in-memory memtable, and immutable sorted SSTables? Trace a write and a read.
* **Compaction Strategies:** Contrast size-tiered and leveled compaction regarding write amplification, read latency, and temporary disk space.
* **Bloom Filters:** How do Bloom filters let an LSM read skip SSTables that definitely don't contain a key? Which false-positive trade-off do you tune with bits per key?

## Page-Oriented Engines

* **Pages & Slotted Layout:** How do relational engines organize data into fixed-size pages (8KB in PostgreSQL, 16KB in InnoDB), and how does a slotted-page layout handle variable-length rows?
* **B+Trees:** Why do databases use B+trees (data only in the leaves, linked leaf pages) rather than plain B-trees? What is a page split, and why does branching factor matter so much for tree depth?
* **Write-Ahead Logging & Recovery:** Why must page modifications reach the WAL before dirty pages reach disk? Outline how ARIES uses analysis, redo, and undo to recover after a crash.
* **Buffer Pool:** How does the buffer pool cache pages and flush dirty pages through checkpoints? Why do engines use LRU-K, 2Q, or midpoint-insertion LRU instead of plain LRU (sequential scan pollution)?
* **Direct I/O vs Page Cache:** Why does InnoDB typically use `O_DIRECT` to bypass the OS page cache, while PostgreSQL and RocksDB lean on it? What is double buffering?

## Comparing Engines

* **LSM vs B-Tree Amplification:** Compare write, read, and space amplification for LSM-trees and B-trees. Which suits write-heavy workloads, which suits read-heavy point lookups, and how does write amplification affect SSD lifespan?
* **Row vs Column Storage:** Contrast row-oriented storage for OLTP point lookups with column-oriented storage for OLAP scans. Why do analytical schemas use star/snowflake shapes?
* **Column Compression & Vectorized Execution:** How do bitmap encoding, run-length encoding, and vectorized (SIMD) execution let engines like ClickHouse or DuckDB scan billions of rows quickly?
* **In-Memory Databases:** Why are in-memory stores fast? (Hint: mostly by avoiding encoding overhead, not by avoiding disk reads.) How do they still achieve durability with snapshots, append-only logs, or replication?

## Indexes

* **Clustered vs Secondary Indexes:** Contrast clustered indexes (rows stored in the index leaves, as in InnoDB) with heap tables plus secondary indexes (as in PostgreSQL). Why do InnoDB secondary indexes store the primary key, and what does a wide primary key cost?
* **Covering Indexes & Index-Only Scans:** How does a covering index (e.g., `INCLUDE` columns) let the engine answer a query without touching the table? Why does PostgreSQL also need the visibility map for an index-only scan?
* **Composite Index Column Order:** How does the leftmost-prefix rule decide whether a multi-column B-tree index can serve a filter or sort? Why should equality columns come before range columns?
* **Hash Indexes:** Why are hash indexes rare in relational databases despite $O(1)$ lookups (no range scans, no ordering, historical crash-safety issues)?
* **Partial & Expression Indexes:** How do partial indexes (`WHERE` clause) and expression indexes (`lower(email)`) save space and make otherwise unindexable predicates fast?
* **Index Bloat & Write Cost:** What causes index bloat and fragmentation under random updates and deletes, and how do `REINDEX CONCURRENTLY` or `OPTIMIZE TABLE` fix it? Why is every unused secondary index a tax on write throughput?
