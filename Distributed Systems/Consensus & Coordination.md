# Consensus & Coordination

## Fault Models & Impossibility

* **Unreliable Networks:** Why must distributed systems assume packets can be delayed, duplicated, reordered, or lost indefinitely? Why can a sender never distinguish a dead node from a slow network or a lost reply?
* **Fault Models & Byzantine Tolerance:** Contrast crash-stop, crash-recovery, and Byzantine fault models. Why does Byzantine tolerance (e.g., PBFT) need $3f + 1$ nodes to tolerate $f$ faulty ones versus $2f + 1$ for crash faults, and when is it worth it?
* **Safety vs Liveness:** Define safety ("nothing bad happens") and liveness ("something good eventually happens"). Classify "no two leaders in the same term" and "a leader is eventually elected".
* **FLP Impossibility:** What does the FLP result say about deterministic consensus in an asynchronous network with even one crash? How do real systems sidestep it (timeouts, partial synchrony, randomization)?

## Consensus Algorithms

* **Basic Paxos:** How do proposers, acceptors, and learners reach agreement in two phases (Prepare/Promise, Accept/Accepted)? Why must a proposer adopt the highest-numbered value it learns in phase 1?
* **Multi-Paxos:** How does a stable leader skip the Prepare phase for later log slots, reducing consensus to one round trip?
* **Raft:** How does Raft split consensus into leader election, log replication, and safety? When is an entry committed, and how do distributed SQL databases (CockroachDB, YugabyteDB, TiKV) run one Raft group per range?
* **Raft Elections & Terms:** How do terms and randomized election timeouts prevent split votes? Why must a candidate have an up-to-date log to win, and what does Pre-Vote prevent?
* **Zab & Viewstamped Replication:** How do Zab (ZooKeeper) and Viewstamped Replication implement primary-backup total-order broadcast with epochs/views? How do they relate to Raft?
* **Total Order Broadcast:** Define total order broadcast and explain why it is equivalent to consensus. How does it let you build a linearizable compare-and-set register?
* **Membership Changes:** Why is changing cluster membership dangerous, and how do Raft's joint consensus and single-server changes prevent two disjoint majorities from forming?
* **Linearizable Reads:** Why can a leader serving reads from local state return stale data? Compare ReadIndex (heartbeat confirmation), lease-based reads (and their clock assumptions), and sending reads through the log.

## Failure Detection & Membership

* **Failure Detectors:** Compare fixed-timeout heartbeats with adaptive φ (phi) accrual failure detectors. What is the trade-off between detection speed and false positives?
* **Gossip & SWIM:** How do gossip (epidemic) protocols spread membership and state with eventual consistency? How does SWIM reduce detection overhead with indirect probes and suspicion states?
* **Leases & Heartbeats:** How do time-based leases grant temporary exclusive ownership (leadership, a lock, a shard) without permanent locks? What clock and pause assumptions do they rely on?
* **Process Pauses:** How can GC stop-the-world pauses, VM migration, or swapping make a node lose its lease without noticing and then act on stale authority? How do long pauses also trigger false failure detection and needless rebalancing?
* **Split-Brain:** What causes split-brain during a partition, and how does requiring a strict majority quorum prevent conflicting writes?

## Scenarios

* **Lab — Two Active Coordinators:**
  * *Setup:* A worker pool elects a coordinator with a lease. After a 20-second GC pause, the old coordinator wakes up and keeps processing tasks while a new coordinator has already taken over, so tasks run twice.
  * *Challenge:* Explain why leases alone can't prevent this, how monotonically increasing fencing tokens checked *by the resource* fix it, and why a Redis Redlock without fencing is considered unsafe.
* **Lab — The Isolated Leader:**
  * *Setup:* A partition splits a 5-node Raft cluster into 2 nodes (including the old leader) and 3 nodes. Clients on the minority side keep sending writes.
  * *Challenge:* Explain why the old leader can't commit anything, how the majority elects a new leader with a higher term, what happens to the old leader's uncommitted entries when the partition heals, and how minority-side reads can still be stale without ReadIndex or leases.
* **Lab — The Even-Numbered Cluster:**
  * *Setup:* A 4-node consensus cluster suffers a clean 2-and-2 partition, and all writes halt.
  * *Challenge:* Explain why neither side has a majority, why 4 nodes tolerate no more failures than 3, and how a witness/tie-breaker node restores availability.
* **Lab — Cascading GC Pauses:**
  * *Setup:* Node A stalls in a 30-second GC pause, heartbeats fail, and the cluster rebalances. As A recovers, the extra load pushes Node B into its own pause.
  * *Challenge:* Break the cascade with adaptive failure-detector thresholds, rebalancing delays, and JVM/GC tuning.
