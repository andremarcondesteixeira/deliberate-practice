# Apache Kafka

## Architecture & Storage

* **Topics, Partitions & Offsets:** Explain how a topic maps to append-only partition logs. Why are offsets per partition, monotonically increasing, and never reused, even after deletion or compaction? What ordering guarantee does Kafka give, and at what scope?
* **KRaft:** How does KRaft replace ZooKeeper with a Raft-based metadata quorum and an event-sourced metadata log? Contrast dedicated controllers with combined mode, and explain how brokers register, heartbeat, and get fenced.
* **Log Segments:** How does a partition break into segments with `.log`, `.index`, and `.timeindex` files? Why does retention delete whole segments, and why is only the active segment written to?
* **Zero-Copy & Page Cache:** How does Kafka use the OS page cache and `sendfile` to serve consumers without copying data through user space? Why does TLS disable zero-copy?
* **Tiered Storage:** How does tiered storage move closed segments to object storage (S3/GCS) while keeping recent data on local disks? What does that change for retention, rebalancing, and recovery time?
* **Retention & Compaction:** Contrast `retention.ms`/`retention.bytes` deletion with `cleanup.policy=compact`. What does compaction guarantee, and what are tombstones?

## Producers

* **Batching & the Record Accumulator:** How does the producer batch records per partition in the accumulator, and how do `linger.ms`, `batch.size`, and compression trade latency for throughput?
* **Partitioning:** How does the default partitioner pick a partition for a keyed record (murmur2 hash) and for a null key (sticky partitioning)? When do you need a custom partitioner?
* **acks & min.insync.replicas:** Contrast `acks=0`, `acks=1`, and `acks=all`. Why is `acks=all` only durable together with `min.insync.replicas=2` on a replication factor of 3, and what does the producer see when the ISR shrinks below it?
* **Idempotent Producer:** How do producer IDs and per-partition sequence numbers let `enable.idempotence=true` eliminate duplicates from retries? How does it keep ordering with up to 5 in-flight requests per connection?
* **Message Size Limits:** Which settings cap message size (`max.request.size`, `message.max.bytes`, `max.message.bytes`, `fetch.max.bytes`), and why are large messages bad for Kafka? What is the claim-check alternative?

## Replication

* **Replication & ISR:** What does a replication factor of 3 guarantee? Define the in-sync replica set, and explain what removes a follower from it (`replica.lag.time.max.ms`).
* **High Watermark vs Log End Offset:** Differentiate a partition's log end offset (LEO) from its high watermark (HW). Why can consumers only read up to the HW?
* **Leader Epochs:** How do leader epochs prevent log divergence and incorrect truncation after leader changes, compared with the older high-watermark-based truncation?
* **Lab — Unclean Failover Data Loss:**
  * *Setup:* After a multi-broker outage, a topic with `replication.factor=3`, `min.insync.replicas=1`, and `unclean.leader.election.enable=true` comes back, but recent writes are missing.
  * *Challenge:* Explain how an out-of-sync replica became leader, why the missing records can never be recovered, and which settings (`min.insync.replicas=2`, `acks=all`, unclean election off) trade availability for durability.

## Consumers

* **Consumer Groups:** How does a consumer group split partitions across members, and why can each partition be consumed by at most one member of a group? What does that imply for scaling past the partition count?
* **Rebalance Protocols:** What triggers a rebalance, and what does the group coordinator do? Compare eager rebalancing, the cooperative sticky assignor, static membership (`group.instance.id`), and the KIP-848 consumer protocol (broker-side assignment, GA in Kafka 4.0).
* **Pull vs Push:** Why did Kafka choose a pull-based consumer model? How does long polling avoid busy waiting?
* **Offset Commits & Delivery Semantics:** Where are committed offsets stored (`__consumer_offsets`)? Show how committing before vs after processing gives at-most-once vs at-least-once, and why auto-commit can produce either.
* **auto.offset.reset:** What do `earliest`, `latest`, and `none` do when a group has no committed offset or its offset has expired?
* **Consumer Lag:** What is consumer lag, how is it measured per partition, and why is lag in time often more useful than lag in messages?
* **Lab — Rebalance Storm:**
  * *Setup:* A consumer group processing large batches rebalances endlessly; each rebalance kicks out the consumer that was mid-processing.
  * *Challenge:* Explain the difference between `session.timeout.ms`/heartbeats and `max.poll.interval.ms`, then fix it by tuning `max.poll.records` and `max.poll.interval.ms`, or by moving slow work off the poll thread.

## Exactly-Once & Ecosystem

* **Exactly-Once Semantics:** How do transactions (transactional IDs, producer epochs, the transaction coordinator), atomic offset commits (`sendOffsetsToTransaction`), and `isolation.level=read_committed` give exactly-once read-process-write? Where does the guarantee stop?
* **Kafka Connect:** How do source and sink connectors run as distributed workers, and how do single message transforms, converters, and dead-letter topics fit in?
* **Kafka Streams State:** How does Kafka Streams keep local RocksDB state stores fault tolerant with changelog topics, and what are standby replicas for?
* **Stream-Table Duality:** Explain the stream-table duality behind KTables and ksqlDB. How does a compacted topic represent a table?
* **MirrorMaker 2:** How does MirrorMaker 2 replicate topics, configs, and consumer offsets (offset translation via checkpoints) between clusters? What changes in topic naming?

## Operations

* **Security:** How do TLS, SASL mechanisms (SCRAM, OAUTHBEARER, GSSAPI/Kerberos), and ACLs on topics and consumer groups secure a cluster?
* **Key Broker Metrics:** Which metrics signal trouble: `UnderReplicatedPartitions`, `UnderMinIsrPartitionCount`, `OfflinePartitionsCount`, `ActiveControllerCount`, request queue time, and network/request handler idle ratios?
* **Adding Partitions:** Why does increasing a topic's partition count break per-key ordering and key-based routing, and why can't you decrease it?
* **Lab — Producer Buffer Exhaustion:**
  * *Setup:* A producer throws `BufferExhaustedException`/`TimeoutException` because records arrive faster than they can be sent.
  * *Challenge:* Explain how `buffer.memory` and `max.block.ms` interact, and fix it with batching/compression, more partitions or brokers, or backpressure on the upstream source.
* **Lab — Unbalanced Broker Load:**
  * *Setup:* A 10-partition topic's traffic lands almost entirely on Broker 1 while Brokers 2 and 3 idle.
  * *Challenge:* Tell apart the possible causes: a skewed partition key, partition leadership imbalance (preferred leader election), or bad replica placement. Fix each.
* **Lab — ZooKeeper to KRaft Migration:**
  * *Setup:* A team upgrading a ZooKeeper-based Kafka 3.x cluster hits metadata errors during migration. Kafka 4.0 no longer supports ZooKeeper.
  * *Challenge:* Describe the KIP-866 migration phases (deploy controllers, metadata copy, dual-write mode, rolling broker restarts, finalize), the point of no return, and how to roll back before it.
* **Lab — Compacted Topic Keeps Growing:**
  * *Setup:* A compacted state topic keeps growing until brokers run out of disk.
  * *Challenge:* Explain why the active segment is never compacted and how `segment.ms`, `min.cleanable.dirty.ratio`, `delete.retention.ms`, and log cleaner health affect space reclamation.
* **Lab — Request Queue Saturation:**
  * *Setup:* Broker request queue time climbs, and producer latency jumps from 5ms to 2s at peak.
  * *Challenge:* Use the network and request handler idle ratios to find the bottleneck, then tune `num.network.threads` and `num.io.threads` or add brokers.
* **Lab — Cross-DC Replication Saturating the WAN:**
  * *Setup:* MirrorMaker 2 replication saturates the inter-datacenter link and slows user traffic.
  * *Challenge:* Reduce bandwidth with compression (`zstd`), larger batches, replicating only the topics you need, and quotas/rate limits.

## Study Guide

* **Books:**
  * *Kafka: The Definitive Guide* (Gwen Shapira, Todd Palino, Rajini Sivaram & Krit Petty): the chapters on producers, consumers, Kafka internals, reliable data delivery, exactly-once semantics, cross-cluster mirroring, security, administration and monitoring cover nearly every card. Use the second edition; KRaft, tiered storage and KIP-848 matured after it, so read the official docs for those.
  * *Designing Event-Driven Systems* (Ben Stopford, free from Confluent): the chapters on the log, stream-table duality, exactly-once and event-driven service design.
  * *Kafka Streams in Action* (William P. Bejeck Jr.): state stores, changelog topics, standby replicas and KTables.
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Stream Processing chapter's section on log-based message brokers, for why Kafka is built the way it is.
* **Official docs:** the Apache Kafka documentation's "Design" section (persistence, efficiency, message delivery semantics, replication, log compaction), its "Operations" section (KRaft, ZooKeeper migration, tiered storage, monitoring, geo-replication), the "Security" section, the configuration reference for brokers, topics, producers and consumers, and the Kafka Streams developer guide. The Kafka Improvement Proposals (KIPs) on the Apache wiki explain the design behind each feature.
* **Papers:** "Kafka: a Distributed Messaging System for Log Processing" (Kreps, Narkhede & Rao, 2011).
* **Related technologies:** compare Redpanda (Kafka API, one Raft group per partition), Apache Pulsar (brokers separated from BookKeeper storage), RabbitMQ streams, Amazon Kinesis, and managed Kafka (Amazon MSK, Confluent Cloud).
* **Search for:** `Kafka ISR high watermark`, `leader epoch truncation`, `idempotent producer sequence numbers`, `transactional.id zombie fencing`, `cooperative sticky assignor`, `max.poll.interval.ms`, `log cleaner dirty ratio`, the KIPs behind the deck (KIP-98 exactly-once, KIP-101 leader epochs, KIP-405 tiered storage, KIP-500 and KIP-866 for KRaft, KIP-848), and Jay Kreps's essay "The Log" (expanded into the short book *I Heart Logs*).
* **Hands-on:** run a 3-broker KRaft cluster in Docker, produce with `acks=all` while you stop brokers one by one, and watch the ISR with `kafka-topics.sh --describe` and consumer lag with `kafka-consumer-groups.sh --describe`.
