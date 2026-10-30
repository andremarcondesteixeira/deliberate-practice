# Time, Clocks & Ordering

## Physical Time

* **Clock Drift & Uncertainty:** Why is it impossible to synchronize physical clocks perfectly across nodes? What causes drift, and how large can skew realistically get between NTP-synced machines?
* **Time-of-Day vs Monotonic Clocks:** Contrast time-of-day clocks (NTP-adjusted, can jump backwards) with monotonic clocks (`CLOCK_MONOTONIC`, `System.nanoTime()`). Which must you use for timeouts and durations, and why are monotonic values meaningless across machines?
* **NTP Steps, Slewing & Leap Seconds:** How can an NTP step adjustment or a leap second corrupt transaction logs, lease expirations, and cache TTLs? How do slewing and leap-second smearing avoid the jump?
* **Clock Skew Detection:** How can a system detect a node whose clock has drifted out of bounds before it causes consistency anomalies, and what should that node do (refuse to serve, self-fence)?
* **TrueTime & Commit Wait:** How does Google TrueTime use GPS and atomic clocks to expose time as an interval $[t - \epsilon, t + \epsilon]$, and how does Spanner's commit wait use that interval to guarantee external consistency without a global lock?

## Logical Time & Causality

* **Happens-Before:** Define Lamport's happens-before relation ($\rightarrow$). When are two events concurrent, and why is "concurrent" about knowledge rather than wall-clock simultaneity?
* **Lamport Timestamps:** How do Lamport timestamps produce a total order consistent with causality using only counters? Why can't they tell you whether two events were concurrent, and why isn't that order enough to enforce constraints such as unique usernames?
* **Vector Clocks & Version Vectors:** How do vector clocks (or version vectors) detect whether two writes are causally related or concurrent? What are their size and pruning trade-offs compared with Lamport timestamps?
* **Hybrid Logical Clocks:** How do HLCs combine wall-clock time with a logical counter so timestamps stay close to physical time but still respect causality? Which databases use them (CockroachDB, YugabyteDB)?
* **Causal Broadcast:** How does causally ordered broadcast hold back a message until all of its causal predecessors have been delivered?
* **Logical Time in Event Sourcing:** Why do event-sourced systems order events by per-stream sequence numbers instead of wall-clock timestamps, and how do those numbers enable optimistic concurrency on append?

## Scenarios

* **Lab — Clock Drift Data Loss:**
  * *Setup:* A multi-leader key-value store resolves conflicts with Last-Write-Wins on wall-clock timestamps. NTP fails on Node 1, which drifts 5 seconds ahead.
  * *Challenge:* Explain why Node 1 now silently overwrites newer writes from other nodes, why the loss is invisible to clients, and design a clock-independent alternative (version vectors with sibling resolution, or CRDTs).

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Trouble with Distributed Systems chapter's section on unreliable clocks (drift, monotonic clocks, LWW, TrueTime) and the Consistency and Consensus chapter's section on ordering guarantees (Lamport timestamps, total order broadcast).
  * *Distributed Systems* (Maarten van Steen & Andrew S. Tanenbaum, free from the authors): the Coordination chapter, for clock synchronization, Lamport clocks and vector clocks.
  * *Patterns of Distributed Systems* (Unmesh Joshi): the Lamport Clock, Hybrid Clock, Clock-Bound Wait and Version Vector patterns, each tied to how real databases implement them.
* **Official docs:** the chrony documentation (slewing vs stepping, `chronyc tracking`), the Linux `clock_gettime(2)` man page (`CLOCK_REALTIME` vs `CLOCK_MONOTONIC`), the Google Cloud Spanner docs on TrueTime and external consistency, and the CockroachDB docs on the transaction layer and the maximum clock offset setting.
* **Papers:** "Time, Clocks, and the Ordering of Events in a Distributed System" (Lamport, 1978); "Virtual Time and Global States of Distributed Systems" (Mattern, 1989); "Spanner: Google's Globally-Distributed Database" (Corbett et al., 2012); "Logical Physical Clocks and Consistent Snapshots in Globally Distributed Databases" (Kulkarni et al., 2014, the HLC paper).
* **Related technologies:** compare Spanner (TrueTime), CockroachDB and YugabyteDB (HLCs), Riak (version vectors and siblings), Cassandra (LWW on client timestamps), EventStoreDB (per-stream sequence numbers), and AWS ClockBound (bounded clock error on EC2).
* **Search for:** `happens-before relation`, `vector clock vs version vector`, `hybrid logical clock`, `commit wait`, `leap second smearing`, `monotonic clock`, `last write wins clock skew`, and Kleppmann's Cambridge "Distributed Systems" lecture series, which covers this deck's logical-time material.
* **Hands-on:** simulate three processes exchanging messages in a short script, attach Lamport timestamps and vector clocks to every event, and check which pairs each scheme can identify as concurrent; then add a node whose wall clock runs five seconds ahead and watch LWW drop writes.
