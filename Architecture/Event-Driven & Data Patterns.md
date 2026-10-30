# Event-Driven & Data Patterns

## Reliable Messaging

* **Dual Writes & the Outbox Pattern:** Why does writing to the database and then publishing an event risk inconsistency? How does the transactional outbox fix it, and how do polling publishers compare with CDC log tailing (Debezium)?
* **Idempotency Keys:** Why must API endpoints and message consumers be idempotent? Design idempotency with client-generated keys, a processed-message table, unique constraints, and version checks. What should a replay with a different payload return?
* **Lab — Ghost Orders:**
  * *Setup:* A client times out waiting for `POST /orders`, retries, and creates a duplicate order. Separately, an SQS worker occasionally processes the same message twice and bills a customer twice.
  * *Challenge:* Explain why at-least-once delivery and client retries make duplicates inevitable, then make order creation and billing idempotent end to end.
* **Kafka vs RabbitMQ:** Compare log-based brokers (Kafka) with queue-based brokers (RabbitMQ) regarding retention, replay, ordering, consumer model, routing flexibility, and throughput. When does each fit?
* **Lab — Poison Pill Loop:**
  * *Setup:* A malformed message crashes the consumer every time it's read. The broker redelivers it immediately, so the worker is stuck in a crash loop at 100% CPU and the queue stops moving.
  * *Challenge:* Isolate poison pills with bounded retries, delayed retry queues, and a dead-letter queue/exchange. Which alerts and tooling keep the DLQ from becoming a silent graveyard?
* **Lab — Consumer Lag During a Flash Sale:**
  * *Setup:* A traffic spike causes 30 minutes of consumer lag, delaying inventory updates and search read-model projections, so customers see items that are already sold out.
  * *Challenge:* Scale consumption (partitions vs consumers, batching, parallelism within a partition while keeping per-key order), prioritize critical events, and decide what the UI should do while the read model is behind.

## CQRS & Event Sourcing

* **CQRS:** How does CQRS let you optimize and scale write and read models independently, and how does it help with queries that span service boundaries? What complexity does it add?
* **Event Sourcing:** What are the benefits (audit trail, temporal queries, rebuildable projections) and costs (event schema evolution, eventual consistency, GDPR) of storing state as an immutable event sequence? How do snapshots speed up rebuilding aggregates with millions of events?
* **Eventual Consistency in the UI:** How do frontends handle read-model lag (optimistic updates, returning the new version and polling until the read model catches up, push notifications)?

## Caching & Multi-Tenancy

* **Caching Strategies:** Contrast cache-aside, read-through, write-through, and write-behind. What consistency risks does each carry, and why is "delete on write" usually safer than "update on write" with cache-aside?
* **Lab — Cache Stampede:**
  * *Setup:* A hot Redis key expires, and thousands of requests miss at once, all running an expensive query against the primary database and crashing it.
  * *Challenge:* Combine request coalescing (single-flight), a short distributed lock with stale-while-revalidate, probabilistic early expiration (XFetch), jittered TTLs, and background refresh.
* **Lab — Multi-Tenant Isolation:**
  * *Setup:* A B2B SaaS moving to a shared database must guarantee that no tenant can ever see another tenant's data, while a few large tenants cause noisy-neighbor problems.
  * *Challenge:* Compare database-per-tenant (silo), schema-per-tenant, and shared tables with row-level security (pool) regarding isolation, cost, migrations, and noisy neighbors. How do you enforce tenant scoping so a forgotten `WHERE tenant_id = ?` can't leak data?

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Stream Processing chapter (logs vs queues, change data capture, event sourcing) and the chapters on derived data and on encoding and evolution.
  * *Microservices Patterns* (Chris Richardson): the chapters on transactional messaging (outbox, polling publisher, transaction log tailing), event sourcing, and CQRS queries.
  * *Enterprise Integration Patterns* (Gregor Hohpe & Bobby Woolf): the patterns for Dead Letter Channel, Idempotent Receiver, Guaranteed Delivery, and Competing Consumers.
  * *Kafka: The Definitive Guide* (Gwen Shapira, Todd Palino et al.): the chapters on consumers (groups, partitions, rebalances), reliable data delivery, and exactly-once semantics.
* **Official docs:** the Debezium documentation ("Outbox Event Router"); the Apache Kafka documentation (consumer configuration, delivery semantics); the RabbitMQ documentation ("Dead Letter Exchanges", quorum queues, consumer acknowledgements); the Amazon SQS Developer Guide (visibility timeout, dead-letter queues, FIFO deduplication); Stripe's API reference on idempotent requests; the PostgreSQL manual's "Row Security Policies" section; AWS Prescriptive Guidance's cloud design patterns guide (event sourcing, transactional outbox, saga); AWS's *SaaS Tenant Isolation Strategies* whitepaper.
* **Papers:** "Kafka: a Distributed Messaging System for Log Processing" (Kreps, Narkhede & Rao, 2011); "Scaling Memcache at Facebook" (Nishtala et al., 2013), for leases against stampedes and stale sets; "Optimal Probabilistic Cache Stampede Prevention" (Vattani, Chierichetti & Lowenstein, 2015), the XFetch paper.
* **Related technologies:** compare Kafka, RabbitMQ, Amazon SQS/SNS, and Apache Pulsar (brokers), Debezium (CDC), EventStoreDB and Axon (event sourcing), Redis (caching and locks), and PostgreSQL row-level security (tenant isolation).
* **Search for:** `transactional outbox`, `dual write problem`, `idempotency key`, `poison pill message`, `consumer lag partitions`, `CQRS read model eventual consistency`, `event schema evolution`, `cache stampede XFetch`, `single-flight request coalescing`, `silo pool bridge tenancy`.
* **Hands-on:** run PostgreSQL, Debezium, and Kafka with Docker Compose, write orders plus outbox rows in one transaction, and confirm that a consumer that crashes mid-batch never double-processes an order.
