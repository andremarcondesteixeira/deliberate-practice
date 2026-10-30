# Replication & Consistency Models

## Leader-Based Replication

* **Single-Leader Replication:** Walk through how writes flow from the leader to followers through a replication log. How is a new follower bootstrapped without downtime (snapshot plus log position)?
* **Sync, Async & Semi-Sync Replication:** Contrast the durability and latency trade-offs of synchronous and asynchronous followers. Why do production systems often make exactly one follower synchronous (semi-synchronous)?
* **Replication Log Formats:** Compare statement-based replication, physical WAL shipping, and logical (row-based) replication. Which one allows replicating across major versions or into other systems (CDC)?
* **Failover & Split-Brain:** Walk through automatic leader failover: detecting failure, choosing a new leader, reconfiguring clients. How can it lose committed writes or create two primaries, and how do HA orchestrators (Patroni, Orchestrator) use quorums and fencing to prevent it?

## Replication Lag

* **Replication Lag Anomalies:** Define read-your-own-writes, monotonic reads, and consistent prefix reads. Give a concrete user-visible bug that each one prevents.
* **Session Guarantees:** What do monotonic writes and writes-follow-reads guarantee, and how do client sessions (MongoDB causal sessions, LSN tokens) bundle all four session guarantees?
* **Lab — The Stale Read Replica:**
  * *Setup:* A user updates their profile, the page reloads, and the old data renders because the read went to an asynchronously lagging replica.
  * *Challenge:* Design read-your-own-writes routing using (a) primary reads for a window after a write, (b) tracking the commit LSN/version token on the client and waiting for a replica to catch up, and (c) sticky sessions. What are the trade-offs of each?

## Multi-Leader & Leaderless Replication

* **Multi-Leader Replication:** In which scenarios (multiple datacenters, offline clients, collaborative editing) is multi-leader replication used, and why are write conflicts unavoidable?
* **Conflict Resolution:** Contrast last-write-wins, application-level merges (siblings), CRDTs, and operational transformation. Which ones silently lose data?
* **CRDTs:** How do state-based (CvRDT) and operation-based (CmRDT) CRDTs reach strong eventual consistency without coordination? Walk through how a PN-Counter and an OR-Set (versus an LWW-Element-Set) resolve concurrent updates.
* **Leaderless Replication:** How do Dynamo-style stores (Cassandra, Riak) keep replicas convergent using read repair and Merkle-tree anti-entropy? Which keys does read repair alone never fix?
* **Quorums ($W + R > N$):** Why do overlapping read and write quorums return the latest value, and how do clients tune $N$, $W$, $R$ per operation? Name the edge cases where quorum reads still return stale data (sloppy quorums, concurrent writes, partially failed writes, LWW clock skew).
* **Sloppy Quorums & Hinted Handoff:** How do sloppy quorums and hinted handoff keep writes available during partitions, and why does that break the $W + R > N$ guarantee?
* **Lab — Partition Read-Amplification Storm:**
  * *Setup:* A leaderless store suffers a partial partition where nodes can still talk, but slowly. Client retries hammer multiple replicas and read latency explodes.
  * *Challenge:* Tune client backoff, timeouts, speculative retries, and quorum levels so the cluster degrades gracefully instead of amplifying congestion.

## Consistency Models

* **CAP Theorem:** State CAP precisely. Why is the real choice "consistency or availability *during a partition*", and why do labels like "CP database" oversimplify? Classify HBase, CockroachDB, Cassandra, and DynamoDB anyway.
* **PACELC:** How does PACELC extend CAP with the latency vs consistency trade-off when there is no partition? Place a few databases on it.
* **Linearizability:** Define linearizability: the system behaves as if there were one copy of the data and each operation takes effect atomically at some point between its start and end. What does it cost in latency and availability?
* **Linearizability vs Serializability:** Contrast linearizability (a recency guarantee on single objects) with serializability (an isolation guarantee for multi-object transactions). What is strict serializability?
* **Sequential Consistency:** How does sequential consistency relax linearizability by dropping real-time ordering while keeping each client's program order?
* **Causal Consistency:** What does causal consistency guarantee, and why is it the strongest model that can stay available during a network partition?
* **Eventual Consistency:** What exactly does eventual consistency promise (convergence once writes stop), what doesn't it promise, and when should an architect accept it instead of strong consistency? How does that choice change UX design?

## Multi-Region

* **Multi-Region Topologies:** Contrast warm standby, active-passive, and active-active multi-region designs regarding replication lag, RPO/RTO, write latency, and conflict handling. Why is active-active much harder for writes than for reads?

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Replication chapter (leaders, lag anomalies, multi-leader, leaderless, quorums) and the Consistency and Consensus chapter (linearizability, CAP, causal ordering) cover most of this deck.
  * *Database Internals* (Alex Petrov): the chapters on replication and consistency (consistency models, session guarantees, quorums, CRDTs) and on anti-entropy (read repair, hinted handoff, Merkle trees).
  * *Distributed Systems* (Maarten van Steen & Andrew S. Tanenbaum, free from the authors): the Consistency and Replication chapter, for data-centric and client-centric consistency models.
* **Official docs:** the PostgreSQL manual's "High Availability, Load Balancing, and Replication" and "Logical Replication" chapters; the MySQL manual's replication chapter (semi-synchronous replication, binary log formats); the MongoDB manual's sections on read concern, write concern and causal consistency; the Cassandra docs on consistency levels and repair; and the Patroni documentation.
* **Papers:** "Dynamo: Amazon's Highly Available Key-value Store" (DeCandia et al., 2007); "Session Guarantees for Weakly Consistent Replicated Data" (Terry et al., 1994); "Linearizability: A Correctness Condition for Concurrent Objects" (Herlihy & Wing, 1990); "Conflict-free Replicated Data Types" (Shapiro, Preguiça, Baquero & Zawirski, 2011); "CAP Twelve Years Later: How the 'Rules' Have Changed" (Brewer, 2012); "Consistency Tradeoffs in Modern Distributed Database System Design" (Abadi, 2012, the PACELC paper).
* **Related technologies:** compare PostgreSQL and MySQL (single leader, physical vs logical logs), Patroni and Orchestrator (failover), Cassandra and Riak (leaderless), CouchDB (multi-leader with conflicts), Automerge and Yjs (CRDT libraries), and Spanner or CockroachDB (strongly consistent multi-region).
* **Search for:** `read-your-writes consistency`, `monotonic reads`, `semi-synchronous replication`, `sloppy quorum hinted handoff`, `Merkle tree anti-entropy`, `OR-Set CRDT`, `linearizability vs serializability`, and the consistency models map on the Jepsen site.
* **Hands-on:** run a PostgreSQL primary with an asynchronous replica in Docker, pause replay with `pg_wal_replay_pause()`, reproduce the stale profile read, then build LSN-based read-your-writes routing using `pg_current_wal_lsn()` and `pg_last_wal_replay_lsn()`.
