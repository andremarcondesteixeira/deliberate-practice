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
