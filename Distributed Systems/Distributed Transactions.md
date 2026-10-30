# Distributed Transactions

## Atomic Commit

* **Two-Phase Commit:** Walk through the prepare and commit phases between a coordinator and its participants. Why is 2PC a blocking protocol, what happens to participant locks if the coordinator crashes after prepare (in-doubt transactions), and why do high-throughput cloud services avoid it?
* **Three-Phase Commit:** What does the extra pre-commit phase try to fix, and why does 3PC still fail under network partitions and see almost no production use?
* **XA Transactions:** What is the XA standard for 2PC across heterogeneous resources (databases, message brokers), and why is it an operational headache (coordinator logs, orphaned locks, lowest-common-denominator features)?
* **Distributed Snapshot Isolation:** How do distributed databases give a consistent multi-shard snapshot without stopping writes (timestamp oracles, HLCs, TrueTime)?
* **Optimistic Concurrency at Scale:** How do distributed stores use read/validate/write phases and version checks to run OCC without pessimistic locks? When does OCC collapse under contention?
* **Lab — Distributed Deadlock:**
  * *Setup:* Two services lock rows in two different databases in opposite orders. Under load, all worker threads end up blocked on each other, and no database's deadlock detector sees the cycle.
  * *Challenge:* Explain why local deadlock detection misses it, how wait-for graphs or timeouts would catch it, and redesign the flow with a global lock order, OCC, or a saga.

## Sagas

* **Sagas vs 2PC:** Why do microservice architectures prefer sagas (a sequence of local transactions with compensations) over distributed ACID transactions? What isolation does a saga give up?
* **Choreography vs Orchestration:** Contrast event-driven choreography with a central orchestrator for coordinating saga steps. How do visibility, coupling, and failure handling differ?
* **Compensations & Their Failures:** How do compensating transactions semantically undo completed steps? What happens when a compensation fails midway, and what are pivot transactions, retriable steps, and countermeasures such as semantic locks?
* **Try-Confirm-Cancel:** How does TCC reserve resources at the application layer (try), then confirm or cancel them, without holding database locks? How does it differ from a saga?

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Consistency and Consensus chapter's section on distributed transactions (2PC, in-doubt transactions, XA) and the Future of Data Systems chapter on designing around them.
  * *Database Internals* (Alex Petrov): the Distributed Transactions chapter (2PC, 3PC, Calvin, Spanner, Percolator-style snapshot isolation, coordination avoidance).
  * *Microservices Patterns* (Chris Richardson): the chapter on managing transactions with sagas (choreography vs orchestration, compensations, pivot transactions, countermeasures such as semantic locks).
  * *Principles of Transaction Processing* (Philip A. Bernstein & Eric Newcomer): the two-phase commit and transactional middleware material, for the classic view of XA and recovery.
* **Official docs:** The Open Group's "Distributed Transaction Processing: The XA Specification"; the PostgreSQL manual's `PREPARE TRANSACTION` page and `pg_prepared_xacts` view; and the CockroachDB architecture docs' "Transaction Layer" page.
* **Papers:** "Sagas" (Garcia-Molina & Salem, 1987); "Life beyond Distributed Transactions: an Apostate's Opinion" (Pat Helland, 2007); "Consensus on Transaction Commit" (Gray & Lamport, 2006); "Large-scale Incremental Processing Using Distributed Transactions and Notifications" (Peng & Dabek, 2010, the Percolator paper); "Spanner: Google's Globally-Distributed Database" (Corbett et al., 2012); "Calvin: Fast Distributed Transactions for Partitioned Database Systems" (Thomson et al., 2012).
* **Related technologies:** compare Spanner (TrueTime), CockroachDB and YugabyteDB (HLCs), TiDB (Percolator with a timestamp oracle), Narayana or Atomikos (XA transaction managers), and Temporal or AWS Step Functions (saga orchestration).
* **Search for:** `two-phase commit blocking`, `in-doubt transaction`, `XA heuristic outcome`, `saga orchestration vs choreography`, `compensating transaction`, `try-confirm-cancel`, `timestamp oracle`, and `distributed deadlock detection`.
* **Hands-on:** create two PostgreSQL databases with `max_prepared_transactions` above zero, run `PREPARE TRANSACTION` on both by hand, "crash" before committing, and inspect the locks the in-doubt transactions still hold.
