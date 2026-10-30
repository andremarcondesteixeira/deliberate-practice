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

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Storage and Retrieval chapter for LSM storage, column storage and full-text indexes, and the chapters on transactions and consensus for what NewSQL systems promise and what it costs them.
  * *Cassandra: The Definitive Guide* (Jeff Carpenter & Eben Hewitt): the data modeling chapter (query-first design, partition and clustering keys) and the chapters on reading, writing and compaction, including tombstones.
  * *Elasticsearch: The Definitive Guide* (Clinton Gormley & Zachary Tong, free online from Elastic): the "Inside a Shard" chapter explains segments, refresh, flush and merging. It targets old versions, so check settings against the current reference.
  * *Introduction to Information Retrieval* (Christopher D. Manning, Prabhakar Raghavan & Hinrich Schütze, free online edition): the chapters on building and compressing inverted indexes, for the theory under Lucene.
* **Official docs:** the Apache Cassandra documentation's data modeling section; the Prometheus documentation's Storage page; the TimescaleDB docs on hypertables and compression; the Elasticsearch Reference's guides on tuning for indexing speed and sizing shards, plus its mapping limit and circuit breaker settings; the pgvector README on HNSW options; and the architecture overviews of CockroachDB and TiDB.
* **Papers:** "Bigtable: A Distributed Storage System for Structured Data" (Chang et al., 2006); "Gorilla: A Fast, Scalable, In-Memory Time Series Database" (Pelkonen et al., 2015); "Efficient and Robust Approximate Nearest Neighbor Search Using Hierarchical Navigable Small World Graphs" (Malkov & Yashunin); "Spanner: Google's Globally-Distributed Database" (Corbett et al., 2012); "TiDB: A Raft-based HTAP Database" (Huang et al., 2020).
* **Related technologies:** ScyllaDB and HBase (wide-column); Prometheus, VictoriaMetrics, InfluxDB and TimescaleDB (time series); OpenSearch and Solr (also built on Lucene); pgvector, Milvus, Qdrant and FAISS (vectors); Spanner, CockroachDB, YugabyteDB and TiDB (NewSQL); and ClickHouse or DuckDB as pure OLAP engines to contrast with HTAP.
* **Search for:** `Cassandra query-first data modeling`, `Cassandra tombstones`, `Gorilla delta-of-delta XOR compression`, `Lucene segment merging`, `Elasticsearch refresh_interval bulk indexing`, `mapping explosion`, `HNSW ef_construction M recall`, `Spanner TrueTime commit wait`, `HTAP columnar replica`.
* **Hands-on:** index a large dataset into a local Elasticsearch with default settings, then again with `refresh_interval: -1`, larger bulk batches and zero replicas, and compare throughput and heap usage in the node stats API.
