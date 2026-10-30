# Specialized Datastores

* **Wide-Column Stores:** How do wide-column stores like Cassandra model data around partition keys and clustering keys? Why do you design one table per query, and why are tombstones a performance hazard?
* **Time-Series Databases:** What characterizes TSDBs (Prometheus, InfluxDB, TimescaleDB): append-heavy ingestion, chunked storage with delta-of-delta/XOR (Gorilla) compression, inverted label indexes, and retention with downsampling?
* **Search Engines & Inverted Indexes:** How does Lucene/Elasticsearch map analyzed terms to posting lists? What are segments, refresh vs flush, and segment merging?
* **Vector Databases:** How do vector databases index embeddings with HNSW graphs for approximate nearest-neighbor search? What do the `M` and `ef` parameters trade off?
* **NewSQL:** What defines NewSQL databases (Spanner, CockroachDB, YugabyteDB, TiDB) that combine horizontal scaling with relational ACID transactions? What do they cost in latency?
* **HTAP:** How do hybrid transactional/analytical systems combine a row store with columnar replicas in one database (TiFlash, SingleStore, AlloyDB's columnar engine)?
* **Lab — Elasticsearch Heap Death Spiral:**
  * *Setup:* During heavy indexing, an Elasticsearch cluster suffers long GC pauses and out-of-memory crashes.
  * *Challenge:* Tune bulk request sizes, refresh intervals, mappings (avoid mapping explosions, disable unneeded fields), shard counts, and merge settings to cut heap pressure.
