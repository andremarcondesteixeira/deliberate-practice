# Profiling & Diagnostics

* **Continuous Profiling:** How do continuous profilers (pprof, Pyroscope, async-profiler, Parca) sample CPU stacks and allocations in production at low overhead?
* **Flame Graphs:** How do you read a CPU flame graph (width = time, x-order is meaningless)? How do you spot hot paths, lock contention, and blocking syscalls, and what do off-CPU flame graphs add?
* **eBPF:** How does eBPF enable zero-instrumentation observability: network tracing, syscall monitoring, and kernel-level profiling? What safety guarantees does the verifier provide?
* **Packet-Level Debugging:** How do you use `tcpdump`, Wireshark, `ss`, and retransmission counters to diagnose retransmits, resets, and slow handshakes?
* **Kubernetes Telemetry:** What do kube-state-metrics, cAdvisor, and the kubelet expose (desired vs actual state, container CPU/memory, CPU throttling, OOM kills, node pressure), and how do they differ?
* **Lab — Slow Memory Leak:**
  * *Setup:* A long-running worker's memory grows for four days until the container is OOMKilled. CPU looks normal.
  * *Challenge:* Tell a leak apart from a cache that's still warming up, take and compare heap snapshots/dumps, read retention paths (dominator tree), and check the usual suspects: unbounded collections, listeners never removed, unclosed cursors, captured closures.
* **Lab — Slow Disk I/O:**
  * *Setup:* Database read latency spikes unpredictably while CPU and memory sit at 20%.
  * *Challenge:* Use `iostat` (await, %util, queue depth), PSI, and cloud volume metrics (IOPS/throughput limits, burst credits) to prove storage saturation, then decide between more IOPS, more memory for caching, or query fixes.
* **Lab — Dark Launch Telemetry Gap:**
  * *Setup:* A feature released behind a flag has a high error rate, but dashboards show nothing because the new code path has no instrumentation.
  * *Challenge:* Define a telemetry checklist for new features: auto-instrumented HTTP/RPC, RED metrics tagged with the flag variant, flag evaluation counters, and an SLO-based release gate.
* **Lab — Synthetic Monitor False Positive:**
  * *Setup:* A synthetic probe fires a SEV1 for the login page, but the login service is healthy.
  * *Challenge:* Find the cause (regional DNS, a CDN bot challenge/CAPTCHA, ISP routing, an expired test account), and make probes trustworthy with multiple locations, retries, and a location quorum before paging.
