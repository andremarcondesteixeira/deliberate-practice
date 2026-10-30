# RabbitMQ

## AMQP Model

* **AMQP 0-9-1 Model:** Explain how publishers, exchanges, bindings, queues, and consumers fit together. Why do publishers never send directly to a queue?
* **Connections vs Channels:** Why does RabbitMQ multiplex channels over one TCP connection? What are the thread-safety rules for channels, and why is opening a connection per message an anti-pattern?
* **Virtual Hosts:** How do vhosts isolate exchanges, queues, bindings, and permissions inside one broker?
* **Publisher Confirms:** How do asynchronous publisher confirms make publishing reliable, and why did they replace AMQP transactions? What is the `mandatory` flag for?
* **Consumer Acknowledgements:** Contrast manual acks with automatic acks. What do `basic.nack` and `basic.reject` do with `requeue=true` vs `requeue=false`?
* **Prefetch (QoS):** Why does an unbounded prefetch exhaust consumer memory and starve other consumers? How do you choose a prefetch count?

## Exchanges & Routing

* **Direct, Fanout & Topic Exchanges:** How does each type route messages? Explain routing keys vs binding keys and the topic wildcards `*` (exactly one word) and `#` (zero or more words).
* **Headers & Plugin Exchanges:** How does a headers exchange route on header values with `x-match=all`/`any`? When do you reach for the consistent-hash exchange or a custom exchange plugin?
* **Alternate Exchanges:** How does an alternate exchange capture messages that match no binding, and how does that differ from the `mandatory` flag?
* **Dead Letter Exchanges:** Which events dead-letter a message (rejection without requeue, TTL expiry, queue length overflow, quorum queue `delivery-limit`)? What does the `x-death` header record?

## Queues

* **Durability & Persistence:** Contrast durable and transient queues, and persistent and transient messages. Which combination survives a broker restart, and how does persistence affect throughput?
* **Classic Queue Storage:** Why did lazy queues stop being necessary once classic queues v2 (RabbitMQ 3.12+) started moving messages to disk aggressively? How does RAM usage behave with long queues?
* **Length Limits & Overflow:** How do `x-max-length` and `x-max-length-bytes` behave with `drop-head`, `reject-publish`, and `reject-publish-dlx`?
* **Message TTL:** Compare per-message TTL with per-queue `x-message-ttl`. Why are expired per-message-TTL messages only removed when they reach the head of a classic queue?
* **Single Active Consumer:** How does single active consumer keep strict ordering with automatic failover to standby consumers?
* **Priority Queues:** How do priority queues (`x-max-priority`) work, and what memory and CPU cost do they add? Why keep the number of priorities small?
* **Exclusive, Auto-Delete & Temporary Queues:** What lifecycle rules govern exclusive queues, auto-delete queues, and server-named queues? What does creating a queue per client session cost?
* **Quorum Queues:** How do quorum queues use Raft to replicate messages and elect leaders? Why did they replace classic mirrored queues (removed in RabbitMQ 4.0), and which features don't they support?
* **Streams:** How do RabbitMQ streams provide an append-only, replayable log with offset tracking, and when would you choose them over quorum queues or Kafka?

## Clustering & Distribution

* **Erlang Clustering:** How do RabbitMQ nodes form a cluster using Erlang distribution and the Erlang cookie? What is shared across the cluster (metadata) and what isn't (queue contents, unless replicated)?
* **Network Partition Handling:** Compare `ignore`, `pause_minority`, and `autoheal`. Which is safest, and how do quorum queues behave during a partition?
* **Federation vs Shovel:** How does federation link exchanges or queues across WAN boundaries, and how does Shovel move messages from a source to a destination? When do you choose each?
* **Load Balancers in Front of RabbitMQ:** What should you watch out for when placing HAProxy or an NLB in front of a cluster (TCP health checks, long-lived connections, idle timeouts, queue leader locality)?
* **Cluster Size:** Why do RabbitMQ clusters rarely exceed 3–7 nodes, and why are odd numbers recommended?

## Operations

* **Security:** How do you configure TLS for client and inter-node traffic, and how do the internal auth backend, LDAP, and OAuth 2.0 compare?
* **Monitoring:** What do the management UI/HTTP API and the Prometheus plugin expose, and which metrics matter most (queue depth, unacked messages, publish/deliver rates, memory, file descriptors)?
* **Memory & Disk Alarms:** How do the memory high watermark and the free disk limit trigger flow control and block publishing connections? Why do consumers keep working while publishers are blocked?
* **Lab — Blocked Publishers:**
  * *Setup:* A high-throughput publisher hangs. `rabbitmqctl list_connections` shows its connections as `blocked`, and memory keeps rising because consumers hold huge numbers of unacked messages.
  * *Challenge:* Explain how the memory alarm triggered publisher flow control, and fix it with prefetch limits, faster consumers, queue length limits, and separate publisher and consumer connections.
* **Lab — Slow Consumers & Disk I/O:**
  * *Setup:* When consumers slow down, a queue holding millions of messages drives disk I/O to 100%, and latency spikes.
  * *Challenge:* Explain how messages are paged to disk under backpressure, and compare classic queues, quorum queues, and streams for this workload.
* **Lab — Split-Brain Recovery:**
  * *Setup:* After a cloud network glitch, two halves of a cluster diverge, and queue state conflicts when they reconnect.
  * *Challenge:* Explain how `pause_minority` and quorum queues avoid divergence, compared with legacy mirrored queues that needed manual intervention.
