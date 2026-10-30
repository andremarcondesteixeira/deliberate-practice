# System Design

## Estimation

* **Latency Numbers:** Give the order of magnitude for an L1 cache hit, a main memory access, an SSD random read, a round trip inside a data center, a round trip between regions, and a disk seek. What do these numbers tell you about caching, chatty service calls, and cross-region designs?
* **Back-of-the-Envelope Capacity:** Turn "10 million daily active users, each doing 20 reads and 2 writes a day" into average and peak requests per second, storage growth per year, and bandwidth. Which assumptions (peak-to-average ratio, object size, replication factor) change the answer most?
* **Little's Law:** State Little's Law (L = λW). Use it to size a thread pool or connection pool for a given throughput and latency, and explain why a downstream slowdown multiplies the number of requests in flight.
* **Availability Math:** How much downtime per year and per month do 99.9%, 99.95%, and 99.99% allow? Why does a request that depends on five services at 99.9% each have lower availability, and how does redundancy change the math?
* **Cache Sizing & Hit Rate:** How do you estimate the hot working set from access patterns? If a cache's hit rate drops from 99% to 95%, by how much does load on the database grow, and why does that make cache hit rate a capacity metric?

## Method & Building Blocks

* **Structuring a Design:** Walk through a repeatable approach: clarify functional and non-functional requirements, estimate scale, define the API, sketch the data model, draw the high-level design, then go deep on bottlenecks and trade-offs. Why do requirements and numbers come before boxes and arrows?
* **Choosing a Datastore:** Given access patterns, consistency needs, and scale, how do you choose between a relational database, a document store, a wide-column store, a key-value store, a search engine, and object storage? Which questions decide it?
* **Sync vs Async Boundaries:** When should a queue or log sit between two components (spiky load, slow work, independent failure)? What do you pay for it (eventual consistency, duplicates, ordering, harder debugging), and how do you tell the client the work is accepted but not done?
* **Fan-out on Write vs Read:** Compare precomputing results when data is written (push) with assembling them when they are read (pull). How does the read/write ratio decide, and why do feed systems use a hybrid for accounts with millions of followers?

## Labs

* **Lab — URL Shortener:**
  * *Setup:* 100 million new short links a month, a 100:1 read-to-write ratio, links kept for 5 years, and redirects that must stay fast worldwide.
  * *Challenge:* Estimate QPS and storage. Choose how to generate short codes (a counter encoded in base62, a hash, or pre-allocated ID ranges) and handle collisions. Design storage and caching, choose between `301` and `302` redirects, and record click analytics without slowing redirects down.
* **Lab — Distributed Rate Limiter:**
  * *Setup:* An API gateway runs 50 instances. Each API key may make 1,000 requests per minute in total, across all instances.
  * *Challenge:* Design a shared limiter (for example, a token bucket in Redis updated atomically with a Lua script). Weigh accuracy against latency by mixing local and global counting, decide whether to fail open or closed when Redis is down, and decide what the response must tell the client (`429`, `Retry-After`, rate-limit headers).
* **Lab — Unique ID Generator:**
  * *Setup:* Several services need 64-bit IDs that are unique without coordination, roughly sortable by time, and fast enough to generate 10,000 per second per node.
  * *Challenge:* Design a Snowflake-style layout (timestamp, worker ID, sequence). Explain how to assign worker IDs safely, what happens when the clock moves backwards, and how this compares with database sequences, UUIDv4, and UUIDv7.
* **Lab — News Feed:**
  * *Setup:* 50 million daily users follow other users. A home feed shows recent posts from everyone a user follows. Most users have a few hundred followers, but a few have tens of millions.
  * *Challenge:* Choose fan-out on write, on read, or a hybrid, and justify it with numbers. Design feed storage and caching, pagination, and the path that handles celebrity accounts.
* **Lab — Notification Service:**
  * *Setup:* Other services send 10 million notifications a day (email, SMS, mobile push), with spikes of 50 times the normal rate during campaigns. External providers are slow and sometimes fail.
  * *Challenge:* Design intake, per-channel queues, retries with backoff, idempotency so users don't get duplicates, user preferences and quiet hours, provider failover, dead-letter handling, and delivery tracking.
* **Lab — Chat System:**
  * *Setup:* A chat product supports one-to-one and group conversations (up to 500 members), online presence, delivery and read receipts, and message history across devices.
  * *Challenge:* Design long-lived connections (WebSocket gateways and routing messages to the right gateway), message storage partitioned by conversation, ordering within a conversation, offline delivery, and presence updates that don't flood the system.
* **Lab — Checkout Without Double Charges:**
  * *Setup:* An order service calls an external payment provider. Clients retry on timeouts, the provider sometimes times out after charging, and orders must never be charged twice or lost.
  * *Challenge:* Combine idempotency keys, an order state machine, the transactional outbox, provider webhooks, and a daily reconciliation job. Explain what happens in each failure case: client retry, crash after charging, and a lost webhook.
* **Lab — Real-Time Leaderboard:**
  * *Setup:* A game with 10 million players needs a global top 100, each player's exact rank, and the players just above and below them, updated within a second of each score change.
  * *Challenge:* Design it around Redis sorted sets. Estimate memory, decide how to shard when one set is too big or too hot, handle ties, and show how to rebuild the leaderboard from durable storage after data loss.
* **Lab — Distributed Job Scheduler:**
  * *Setup:* Users schedule millions of one-off and recurring jobs. Each job must run close to its scheduled time, at least once, and never on two workers at the same time.
  * *Challenge:* Design job storage partitioned by time bucket, how workers claim due jobs (leases, `SELECT ... FOR UPDATE SKIP LOCKED`, or partition ownership), recovery when a worker dies mid-job, and why jobs must be idempotent anyway.
* **Lab — File Upload Service:**
  * *Setup:* Users upload files of up to 5 GB that must be virus-scanned, have thumbnails or previews generated, and become downloadable only after they pass the scan.
  * *Challenge:* Design direct-to-S3 uploads with presigned URLs and multipart upload, a metadata database with a per-file state machine, event-driven processing (S3 events to a queue to workers), access control on downloads, and cleanup of abandoned uploads.
* **Lab — Event Ingestion Pipeline:**
  * *Setup:* Clients send 1 million small events per second. Product teams need per-minute dashboards within a few seconds, and analysts need the raw events queryable for a year.
  * *Challenge:* Design the ingestion edge, Kafka topics and partition keys, stream aggregation for the dashboards, and cheap long-term storage (columnar files on S3). Handle late and duplicate events, and plan for traffic spikes and backfills.
* **Lab — Search Autocomplete:**
  * *Setup:* A search box must suggest the top 10 completions within 50 ms as the user types, ranked by popularity, across 100 million distinct queries, with trends reflected within an hour.
  * *Challenge:* Compare a trie with precomputed top-k per prefix against a search engine with edge n-grams. Design how popularity counts are collected and rebuilt, the caching layers (including the client), and how to filter offensive suggestions.

## Study Guide

* **Books:**
  * *System Design Interview – An Insider's Guide* (Alex Xu; Volume 2 with Sahn Lam): worked designs for most of the labs here (URL shortener, rate limiter, unique IDs, news feed, notifications, chat, autocomplete, leaderboard, payments), each with estimation and trade-offs. Use it to check your answer after attempting a lab, not before.
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the foundation behind every choice in these designs; reread the chapters on replication, partitioning, transactions, and stream processing when a lab exposes a gap.
  * *Understanding Distributed Systems* (Roberto Vitillo): short, practical chapters on communication, coordination, scalability (partitioning, caching, CDNs), and resiliency, for turning building blocks into a design.
* **Official docs:** the AWS Well-Architected Framework's Reliability and Performance Efficiency pillars; the Amazon Builders' Library (search for "shuffle sharding", "Timeouts, retries, and backoff with jitter", and "Using load shedding to avoid overload"); the Amazon S3 User Guide on presigned URLs and multipart upload; and the Redis documentation on sorted sets and on using Lua scripts.
* **Papers:** "The Tail at Scale" (Jeffrey Dean & Luiz André Barroso, 2013); "Scaling Memcache at Facebook" (Nishtala et al., 2013); "TAO: Facebook's Distributed Data Store for the Social Graph" (Bronson et al., 2013), for caching and fan-out at very large scale.
* **Related technologies:** Redis (rate limits, leaderboards, counters, presence), Kafka (ingestion and fan-out), S3 (uploads and cheap storage), DynamoDB and Cassandra (large key-value workloads), Elasticsearch or OpenSearch (search and autocomplete), and Snowflake-style IDs or UUIDv7 (RFC 9562).
* **Search for:** `latency numbers every programmer should know` (Jeff Dean's list), `back of the envelope estimation`, `Little's law thread pool sizing`, `availability nines table`, `fan-out on write vs fan-out on read`, `Twitter Snowflake ID`, `token bucket Redis Lua`, `shuffle sharding`, `presigned URL multipart upload`, `transactional outbox payment idempotency`.
* **Hands-on:** do one lab a week with a 45-minute timer. Write down the requirements, numbers, API, data model, a diagram, and three trade-offs before reading anything, then compare with the matching chapter in Xu or DDIA and note what you missed.
