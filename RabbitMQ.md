# RabbitMQ Architecture & Engineering Practice (50 Challenges)

## Phase 1: Core Concepts & AMQP 0-9-1 Protocol

* **Card 1 (AMQP Architecture Model):** Explain the core components of the AMQP 0-9-1 model: Publishers, Exchanges, Bindings, Queues, and Consumers.
* **Card 2 (Connection vs Channel):** Why does RabbitMQ multiplex multiple logical channels over a single TCP connection, and what are the thread-safety implications in client applications?
* **Card 3 (Virtual Hosts - vhosts):** How do virtual hosts provide logical isolation (separate namespaces for exchanges, queues, bindings, and security permissions) within a single RabbitMQ broker?
* **Card 4 (Publisher Confirms):** How do asynchronous Publisher Confirms guarantee reliable message delivery from publisher to broker, replacing legacy transactional channels?
* **Card 5 (Consumer Acknowledgements):** Contrast manual acknowledgements (`basic.ack`) with automatic acknowledgements (`no-ack`) regarding message reliability and loss prevention.
* **Card 6 (Prefetch Count / QoS):** Why is setting a prefetch count (QoS) critical for consumers to prevent memory exhaustion and ensure fair work distribution across multiple worker instances?
* **Card 7 (Negative Acknowledgements & Requeue):** What is the behavior of `basic.reject` and `basic.nack` when the `requeue` flag is set to `true` versus `false`?
* **Card 8 (AMQP Protocol Lifecycle):** Trace the handshake and channel establishment lifecycle when a client connects to a RabbitMQ node.

## Phase 2: Exchanges, Bindings & Routing

* **Card 9 (Direct Exchange Mechanics):** How does a Direct Exchange route messages to queues based on an exact match between the routing key and the binding key?
* **Card 10 (Fanout Exchange Mechanics):** Explain how a Fanout Exchange broadcasts incoming messages to all queues bound to it, ignoring routing keys entirely.
* **Card 11 (Topic Exchange Wildcards):** How do Topic Exchanges use wildcard characters (`*` for a single word, `#` for zero or more words) in routing keys and binding keys?
* **Card 12 (Headers Exchange Routing):** How does a Headers Exchange route messages based on header attribute key-value pairs rather than routing keys (using `x-match=all` or `x-match=any`)?
* **Card 13 (Binding Keys vs Routing Keys):** Differentiate between the routing key attached to a published message and the binding key used when binding a queue to an exchange.
* **Card 14 (Alternate Exchanges - AE):** How do Alternate Exchanges capture unroutable messages that fail to match any binding key on primary exchanges?
* **Card 15 (Consistent Hashing Exchange):** How does the Consistent Hashing Exchange plugin distribute messages evenly across multiple queues based on hashing routing keys?
* **Card 16 (Dead Letter Exchanges - DLX):** How do DLXs capture messages that are rejected, expired (TTL), or exceed queue length limits?
* **Card 17 (Custom Exchange Plugins):** When would an architecture require developing or installing custom exchange types beyond RabbitMQ's built-in set?
* **Card 18 (Dynamic Binding Management):** What are the performance and architectural trade-offs of dynamically creating and binding transient queues per client session?

## Phase 3: Queues, Message Lifecycle & Persistence

* **Card 19 (Durable vs Transient Queues):** Contrast durable queues (survive broker restarts) with transient/non-durable queues. What happens to messages inside transient queues during a crash?
* **Card 20 (Message Persistence Trade-offs):** What factors dictate whether a message is written to disk (persistence), and how does disk I/O impact broker throughput?
* **Card 21 (Lazy Queues Architecture):** How do Lazy Queues minimize RAM usage by immediately spilling messages to disk, and when should they be used?
* **Card 22 (Queue Length Limits & Overflow Behaviors):** How do `x-max-length` and `x-max-length-bytes` manage queue saturation using `drop-head` or `reject-publish` overflow actions?
* **Card 23 (Message TTL Mechanics):** Compare message-level TTL (set per message) with queue-level TTL (`x-message-ttl` set on the queue definition).
* **Card 24 (Single Active Consumer Pattern):** How does the Single Active Consumer feature guarantee that only one consumer processes messages from a queue while providing automatic failover to standby consumers?
* **Card 25 (Priority Queues Implementation):** How do priority queues (`x-max-priority`) handle message ordering, and what are the CPU overhead penalties on the broker?
* **Card 26 (Quorum Queues vs Classic Queues):** Why are Quorum Queues (backed by the Raft consensus algorithm) recommended over Classic Mirrored Queues for high availability?
* **Card 27 (Stream Queues Model):** How do RabbitMQ Stream Queues provide an append-only log storage model similar to Apache Kafka, supporting consumer offset tracking and replay?
* **Card 28 (Exclusive & Auto-Delete Queues):** What lifecycle constraints govern exclusive queues (bound to a single connection) and auto-delete queues (deleted when last consumer disconnects)?

## Phase 4: Clustering, High Availability & Federation

* **Card 29 (EBS/BEAM Distributed Nodes):** How does RabbitMQ leverage the Erlang runtime (BEAM) and distributed node communication to form clusters?
* **Card 30 (Classic Queue Mirrored Queues vs Quorum Queues):** Explain why classic mirrored queues were deprecated in favor of Quorum Queues for safety and split-brain resilience.
* **Card 31 (Network Partition Handling Strategies):** Compare RabbitMQ's three partition handling modes (`ignore`, `pause_minority`, `autoheal`). Which mode is safest for Quorum Queues?
* **Card 32 (Federation Plugin WAN Replication):** How does the RabbitMQ Federation plugin link exchanges or queues across different datacenters or WAN boundaries asynchronously?
* **Card 33 (Shovel Plugin Message Mover):** How does the Shovel plugin reliably pull messages from a source queue and push them to a destination broker or exchange?
* **Card 34 (Load Balancing RabbitMQ Clusters):** Why do external load balancers (like HAProxy or AWS NLB) require careful configuration (TCP health checks, round-robin) when sitting in front of RabbitMQ?
* **Card 35 (Raft Consensus in Quorum Queues):** How do Quorum Queues use Raft logs to replicate state across cluster nodes and elect leaders automatically?
* **Card 36 (Node Disk vs RAM Nodes):** What is the difference between RAM nodes and Disk nodes in a RabbitMQ cluster regarding metadata storage and startup recovery?
* **Card 37 (Cluster Scaling Limitations):** Why does scaling a RabbitMQ cluster beyond 5–7 nodes for queues encounter diminishing returns due to internal metadata replication overhead?
* **Card 38 (Multi-Region Active-Active Challenges):** What distributed systems challenges arise when attempting active-active bi-directional replication of queues across distant geographical regions?

## Phase 5: Security, Monitoring & Operational Management

* **Card 39 (AMQPS Encryption in Transit):** How do you configure TLS/SSL certificates for secure client-to-broker and inter-node cluster communication?
* **Card 40 (Authentication and Authorization Backends):** Contrast internal database authentication with external backends like LDAP or OAuth2 token validation.
* **Card 41 (Management Plugin and HTTP API):** What operational insights do the RabbitMQ Management Web UI and HTTP REST API provide for cluster monitoring?
* **Card 42 (Prometheus & Grafana Integration):** How do you scrape native Prometheus metrics from RabbitMQ to build comprehensive operational dashboards?
* **Card 43 (Memory Alarms & Flow Control):** How do high-watermark memory alarms trigger connection blocking (`blocked` connection state) to protect the broker from OOM crashes?
* **Card 44 (Disk Space Alarms):** How do free disk space alarms protect the broker from halting when disk persistence storage drops below configured thresholds?

## Phase 6: Advanced Troubleshooting & Real-World Scenarios

* **Card 45 (Lab Scenario A - The Publisher Blocked State):**
  * *The Setup:* A high-throughput publisher application hangs indefinitely and stops sending messages. `rabbitmqctl list_connections` shows the connection state as `blocked`.
  * *The Challenge:* Diagnose how memory high-watermark alarms triggered publisher flow control because consumers weren't acknowledging messages fast enough.

* **Card 46 (Lab Scenario B - Memory Alarm Triggered by Consumer Backpressure):**
  * *The Setup:* A RabbitMQ node experiences sudden memory exhaustion and crashes, even though disk space is plentiful.
  * *The Challenge:* Explain how unacked messages accumulating in memory buffers violate the memory watermark, and how switching to Lazy Queues or tuning prefetch counts resolves it.

* **Card 47 (Lab Scenario C - Network Partition Split-Brain Recovery):**
  * *The Setup:* Following a temporary cloud network glitch, two nodes in a cluster form isolated split-brain islands, leading to conflicting queue states upon reconnection.
  * *The Challenge:* Detail how Quorum Queues using Raft consensus handle partition healing automatically compared to legacy classic queues requiring manual intervention.

* **Card 48 (Lab Scenario D - Poison Pill Messages & Infinite Loops):**
  * *The Setup:* A malformed message causes a consumer service to throw an unhandled exception. The worker nacks and requeues the message, creating an infinite processing loop that consumes 100% CPU.
  * *The Challenge:* Architect a robust Dead Letter Exchange (DLX) pipeline with retry counts and max-delivery limits to isolate poison pill messages.

* **Card 49 (Lab Scenario E - Slow Consumer Disk Spilling Bottleneck):**
  * *The Setup:* A queue processing millions of messages experiences severe latency spikes when consumers slow down, causing disk I/O to spike to 100%.
  * *The Challenge:* Diagnose how operating system page cache eviction and disk write amplification impact classic queues versus stream queues under heavy backpressure.

* **Card 50 (Lab Scenario F - File Descriptor Exhaustion):**
  * *The Setup:* RabbitMQ logs throw `EMFILE: Too many open files` errors, and new client applications are abruptly refused new connections.
  * *The Challenge:* Trace how unclosed consumer channels, unpooled publisher connections, or excessive socket counts exhaust OS file descriptor limits (`ulimit -n`), and configure system limits.