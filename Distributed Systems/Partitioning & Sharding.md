# Partitioning & Sharding

## Partitioning Strategies

* **Why Partition:** Why is data partitioned (sharded), and how does partitioning combine with replication on the same nodes?
* **Key-Range vs Hash Partitioning:** Contrast range partitioning (efficient range scans, hot spots on sequential keys) with hash partitioning (even spread, no range queries). Which do MongoDB, Cassandra, and DynamoDB use by default?
* **Compound Keys:** How does a compound key such as `(user_id, timestamp)` hash on the first column and sort on the second (Cassandra partition + clustering keys, DynamoDB partition + sort keys)? Why does that force query-first data modeling?
* **Hot Keys & Skew:** How do you mitigate extreme skew, such as a celebrity key receiving millions of writes? Compare key salting/write sharding, splitting the hot key, and caching, and explain the read-side cost of salting.

## Secondary Indexes

* **Local (Document-Partitioned) Indexes:** Explain local secondary indexes and why queries on them become scatter-gather across every partition. Why does tail latency get worse as you add partitions?
* **Global (Term-Partitioned) Indexes:** Explain global secondary indexes partitioned by the indexed term. Why are they usually updated asynchronously, and what consistency lag does that create?

## Rebalancing & Routing

* **Hash Mod N & Consistent Hashing:** Why is `hash(key) mod N` disastrous when N changes? How does consistent hashing on a ring minimize key movement, and why do implementations use many virtual nodes per server?
* **Fixed vs Dynamic Partitioning:** Compare pre-creating a fixed number of partitions (Elasticsearch shards, Riak) with dynamic splitting/merging by size (HBase regions, MongoDB chunks) and partitions proportional to nodes.
* **Request Routing:** How do clients find the node that owns a key: a routing tier, partition-aware clients, or any-node forwarding? What role do ZooKeeper/etcd or gossip play in tracking ownership?
* **Resharding Without Downtime:** Which mechanisms (dual writes, backfill, change-log catch-up, cut-over) let you split or move shards with zero downtime?
* **Colocation & Entity Groups:** How do entity groups, interleaved tables, or colocated tables keep related rows on the same shard so joins and transactions stay local?
* **Distributed Hash Tables:** How do peer-to-peer DHTs such as Chord or Kademlia route lookups in $O(\log N)$ hops without a central directory?

## Storage at Scale

* **Erasure Coding vs Replication:** How does Reed-Solomon erasure coding cut storage overhead compared with 3x replication while keeping durability, and what does it cost on reads and repairs?
* **Metadata Server Bottlenecks:** How do distributed file systems like GFS/HDFS keep a single metadata server from becoming the bottleneck (large blocks, client caching, federation)?
* **Lab — Rebalancing Storm:**
  * *Setup:* Adding one node to a search/database cluster triggers massive shard movement that saturates inter-node bandwidth and pushes query latency to 10 seconds.
  * *Challenge:* Throttle migration bandwidth, limit concurrent moves, restrict the balancer to an off-peak window, and explain why many small partitions rebalance more smoothly than a few big ones.
