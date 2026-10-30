# Transactions & Isolation

## Foundations

* **ACID vs BASE:** Deconstruct atomicity, consistency, isolation, and durability. Why is the "C" really an application property, and how does BASE (basically available, soft state, eventual consistency) trade these away?
* **Single-Object vs Multi-Object Transactions:** What guarantees do single-object atomic operations give (compare-and-set, atomic increment), and why are multi-object transactions hard in distributed datastores?
* **Isolation Levels Matrix:** Which anomalies (dirty read, dirty write, non-repeatable read, phantom, lost update, write skew) does each level prevent: Read Uncommitted, Read Committed, Repeatable Read/Snapshot, Serializable? Why does "Repeatable Read" mean different things in PostgreSQL and MySQL?

## Anomalies & Weak Isolation

* **Read Committed:** Define dirty reads and dirty writes, and explain how Read Committed prevents both (row locks for writes, last committed values for reads).
* **Read Skew & Snapshot Isolation:** What is read skew (non-repeatable read), and why does it break backups and long analytical queries? How does MVCC implement snapshot isolation so that readers never block writers and writers never block readers?
* **Snapshots per Statement vs per Transaction:** In MVCC engines, why does Read Committed take a new snapshot per statement while Repeatable Read keeps one for the whole transaction? What does a PostgreSQL Repeatable Read transaction do when it tries to update a row changed concurrently?
* **Lost Updates:** What causes lost updates in concurrent read-modify-write cycles? Compare atomic `UPDATE ... SET x = x + 1`, `SELECT ... FOR UPDATE`, compare-and-set with a version column, and automatic detection under snapshot isolation.
* **Explicit Row Locks:** Differentiate `SELECT ... FOR UPDATE`, `FOR SHARE`, `FOR NO KEY UPDATE`, and `SKIP LOCKED`. How does `SKIP LOCKED` turn a table into a job queue?
* **Lab — Write Skew in the On-Call Schedule:**
  * *Setup:* A doctor on-call system runs under Repeatable Read. Two doctors request leave at the same moment; both transactions check that "at least one other doctor is on call", both succeed, and nobody is on call.
  * *Challenge:* Explain why snapshot isolation misses this write skew caused by a phantom, then fix it three ways: `SERIALIZABLE` isolation, `SELECT ... FOR UPDATE` on the rows read, and materializing the conflict into lockable rows.

## Serializability

* **Serializability & Actual Serial Execution:** Define serializability. How do single-threaded engines (VoltDB, Redis) execute transactions literally one at a time, and what does that require (stored procedures, in-memory data, partitioning)?
* **Two-Phase Locking:** Walk through 2PL with shared and exclusive locks, including predicate and index-range (next-key/gap) locks for phantoms. Why does 2PL perform poorly under contention, and why is it unrelated to two-phase commit?
* **Serializable Snapshot Isolation:** How does SSI (PostgreSQL `SERIALIZABLE`) achieve serializability optimistically by tracking read-write antidependencies and aborting transactions that form a dangerous structure? What must the application do on serialization failures?
* **Deadlocks:** How do lock managers detect cycles in a wait-for graph and choose a victim? Which application practices (consistent lock ordering, short transactions, lock timeouts) prevent deadlocks?
