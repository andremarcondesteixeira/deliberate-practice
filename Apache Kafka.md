# Apache Kafka Architecture & Event Streaming Practice (50 Challenges)

## Phase 1: Core Architecture, Brokers & KRaft Consensus

* **Card 1 (Kafka Broker Role):** What are the primary operational responsibilities of an Apache Kafka broker in a distributed cluster?
* **Card 2 (KRaft Consensus Protocol):** How does KRaft (Kafka Raft Metadata Mode) replace Apache ZooKeeper for managing cluster metadata and controller elections?
* **Card 3 (Topic & Partition Anatomy):** Explain the structural relationship between a logical Kafka topic and its physical, append-only log partitions.
* **Card 4 (Partition Offset Semantics):** What is a partition offset, and why are monotonically increasing integer offsets immutable even after log compaction or deletion?
* **Card 5 (Log Segment Architecture):** How does Kafka organize partition data on disk into active and closed log segments paired with `.log`, `.index`, and `.timeindex` files?
* **Card 6 (Zero-Copy Data Transfer):** How does Kafka leverage Linux `sendfile` system calls and OS page cache optimization to achieve high-performance network data transfers?
* **Card 7 (Controller Quorum & Combined Mode):** What is the difference between running KRaft controller nodes in isolated mode versus combined mode in production environments?
* **Card 8 (Broker States and Fencing):** How do brokers register with the active controller, and what triggers a broker fence or state transition during startup or network isolation?

## Phase 2: Producers, Partitioning & Write Mechanics

* **Card 9 (Producer Architecture & Record Accumulator):** How does the Kafka producer use an in-memory RecordAccumulator buffer to batch records before network transmission?
* **Card 10 (Partitioning Key Hash Mechanics):** How does a producer determine the target partition using a partitioning key, and what happens when the key is `null`?
* **Card 11 (Sticky Partitioner Strategy):** How does the sticky partitioner improve batching efficiency compared to classic round-robin partitioning when records have null keys?
* **Card 12 (Producer Acks Configuration):** Contrast producer `acks` levels (`acks=0`, `acks=1`, and `acks=all`) regarding data durability guarantees and latency trade-offs.
* **Card 13 (Idempotent Producer):** How does the idempotent producer (`enable.idempotence=true`) prevent duplicate message production using sequence numbers and producer IDs?
* **Card 14 (Producer Batching Tuning Controls):** How do `linger.ms` and `batch.size` parameters balance throughput optimization against end-to-end message latency?
* **Card 15 (Max Request Size Limits):** What configuration limits govern maximum producer payload sizes (`max.request.size`) and broker ingestion limits (`message.max.bytes`), and what are the performance impacts of large messages?
* **Card 16 (Custom Partitioners):** When would an architecture require implementing a custom partitioner plugin instead of relying on default hash-based partitioning?

## Phase 3: Replication, Fault Tolerance & Durability

* **Card 17 (Replication Factor and High Availability):** What does a replication factor of 3 guarantee for cluster durability when a single broker fails?
* **Card 18 (In-Sync Replicas - ISR):** Define the In-Sync Replica (ISR) set. What happens when a follower replica lags behind the leader?
* **Card 19 (Minimum In-Sync Replicas):** How does `min.insync.replicas` protect against data loss when combined with `acks=all` if the ISR shrinks below the required threshold?
* **Card 20 (Unclean Leader Election):** What is Unclean Leader Election (`unclean.leader.election.enable`), and why is enabling it a dangerous trade-off for data consistency?
* **Card 21 (High Watermark and Log End Offset):** Differentiate between a partition's Log End Offset (LEO) and its High Watermark (HW) offset.
* **Card 22 (Leader Epochs for Truncation Safety):** How do Leader Epoch files prevent data divergence and stale log truncation during unclean failovers?
* **Card 23 (Tiered Storage Architecture):** How does Tiered Storage decouple short-term local disk retention from long-term object storage (S3/GCS)?
* **Card 24 (Disk Space Management and Retention Policies):** Contrast time-based retention (`retention.ms`) with size-based retention (`retention.bytes`) and log compaction policies.

## Phase 4: Consumers, Consumer Groups & Offsets

* **Card 25 (Consumer Group Coordination Protocol):** Explain how a consumer group divides partition workloads across multiple consumer instances. What is the fundamental assignment rule per partition?
* **Card 26 (Group Coordinator & Rebalance Process):** What is the role of the Group Coordinator broker, and what triggers a consumer group rebalance cycle?
* **Card 27 (Cooperative Sticky Assignor):** How does the Cooperative Sticky Assignment strategy minimize partition movement and avoid "stop-the-world" consumer group pauses during rebalances?
* **Card 28 (Pull-Based Consumer Model):** Why did Kafka choose a pull-based consumer model rather than a push-based model for data consumption?
* **Card 29 (Consumer Offset Management):** Where are consumer offsets stored internally (`__consumer_offsets` topic), and how do manual vs. auto-commit strategies impact delivery semantics?
* **Card 30 (Consumer Lag Monitoring):** What is consumer lag, and why is monitoring partition-level lag critical for production health and SLA compliance?
* **Card 31 (Consumer Poll Loop & Heartbeats):** How do `max.poll.interval.ms` and `heartbeat.interval.ms` configurations prevent zombie consumers from stalling partition consumption?
* **Card 32 (Offset Reset Strategies):** When a new consumer group starts with no committed offsets, how do `auto.offset.reset` policies (`earliest` vs. `latest`) dictate behavior?

## Phase 5: Ecosystem Components (Kafka Connect, Streams & Schema Registry)

* **Card 33 (Kafka Connect Architecture):** How do source and sink connectors in Kafka Connect run as distributed workers to integrate external data stores without custom code?
* **Card 34 (Kafka Streams State Management):** How does the Kafka Streams library manage local state stores using RocksDB and changelog topics for fault-tolerant stream processing?
* **Card 35 (Schema Registry and Evolution):** Why is an external Schema Registry (using Avro, Protobuf, or JSON Schema) crucial for enforcing backward and forward compatibility rules across microservices?
* **Card 36 (Kafka MirrorMaker 2.0):** How does MirrorMaker 2.0 replicate topics, consumer offsets, and configurations between distinct Kafka clusters for disaster recovery?
* **Card 37 (ksqlDB Stream-Table Duality):** How does ksqlDB enable streaming SQL queries by leveraging the fundamental duality between streams and tables?
* **Card 38 (Exactly-Once Semantics - EOS):** How do Kafka Transactions coordinate producers, consumer offset commits, and read-committed isolation levels to achieve end-to-end Exactly-Once Processing (EOS)?

## Phase 6: Security, Operations & Troubleshooting Scenarios

* **Card 39 (Encryption and Authentication):** How do TLS (encryption in transit) and SASL (SCRAM, OAuth, Kerberos authentication) secure a production Kafka cluster?
* **Card 40 (Authorization via ACLs):** How do Access Control Lists (ACLs) restrict client read and write permissions at the topic and consumer group level?
* **Card 41 (JMX Metrics & Monitoring):** What are the key JMX metrics (e.g., UnderReplicatedPartitions, OfflinePartitionsCount, RequestQueueTimeMs) required to monitor Kafka broker health?
* **Card 42 (Topic Partition Expansion Impact):** Why is increasing partition counts on an existing topic dangerous if producers rely on specific key-hashing routing rules?

## Phase 7: Advanced Architectural Scenarios

* **Card 43 (Lab Scenario A - The Unclean Failover Data Loss):**
  * *The Setup:* Following a multi-broker outage, a topic with `replication.factor=3` and `min.insync.replicas=1` recovers, but recent writes are missing from consumers.
  * *The Challenge:* Diagnose how an out-of-sync replica was elected leader due to misconfigured unclean leader election, and explain how proper ISR baselines prevent it.

* **Card 44 (Lab Scenario B - Consumer Group Rebalance Storm):**
  * *The Setup:* A large consumer group processing high-throughput events enters an endless loop of rebalances every time a consumer processes a large batch of messages.
  * *The Challenge:* Tune `max.poll.interval.ms` and `max.poll.records` to prevent processing timeouts from triggering false consumer dropouts.

* **Card 45 (Lab Scenario C - Producer OutOfMemory / Buffer Exhaustion):**
  * *The Setup:* A producer application throws `BufferExhaustedException` because the local memory buffer filled up faster than records could be sent to the broker.
  * *The Challenge:* Configure `max.block.ms` and scale producer thread pooling or network bandwidth to handle upstream traffic spikes.

* **Card 46 (Lab Scenario D - Hot Partitions Caused by Null Keys):**
  * *The Setup:* A Kafka topic with 10 partitions has its CPU utilization concentrated entirely on Broker 1, while Brokers 2 and 3 sit idle.
  * *The Challenge:* Diagnose why null-key message distribution caused uneven partition assignment, and implement a deterministic partitioning key strategy.

* **Card 47 (Lab Scenario E - ZooKeeper to KRaft Migration Failure):**
  * *The Setup:* An engineering team upgrading a legacy Kafka 3.x cluster encounters metadata divergence errors during the KRaft dual-write migration phase.
  * *The Challenge:* Detail the multi-phase KIP-866 live migration procedure (metadata copy, dual-write hybrid runtime, rolling reconfiguration) required to transition safely without downtime.

* **Card 48 (Lab Scenario F - Log Compaction Infinite Growth):**
  * *The Setup:* A compacted topic used for state storage grows indefinitely on disk, consuming all available broker storage capacity despite having old keys.
  * *The Challenge:* Configure clean-up policies (`segment.ms`, `min.cleanable.dirty.ratio`) to force log cleaner threads to reclaim space from stale keyed messages.

* **Card 49 (Lab Scenario G - Broker Network Thread Saturation):**
  * *The Setup:* Kafka broker logs report severe request queue delays, and producer latency spikes from 5ms to over 2 seconds under peak load.
  * *The Challenge:* Tune `num.network.threads` and `num.io.threads` relative to available CPU cores to eliminate network thread pool bottlenecks.

* **Card 50 (Lab Scenario H - Cross-DC Replication Bandwidth Saturation):**
  * *The Setup:* MirrorMaker 2 replication between two datacenters saturates the inter-DC WAN link, impacting production user traffic.
  * *The Challenge:* Implement compression (`compression.type=zstd`), batch size adjustments, and dedicated network rate-limiting pipes to optimize cross-cluster replication traffic.