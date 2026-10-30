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

## Study Guide

* **Books:**
  * *Systems Performance* (Brendan Gregg): the chapters on CPUs (profiling and flame graphs), memory, disks (`iostat`, latency, saturation), and networks; the main reference for both I/O and leak investigations.
  * *BPF Performance Tools* (Brendan Gregg): the chapters on CPUs, memory, disk I/O, and networking, for ready-made eBPF tools and off-CPU analysis.
  * *Learning eBPF* (Liz Rice): the chapters on how eBPF programs are loaded and on the verifier, for the safety guarantees card.
  * *Practical Packet Analysis* (Chris Sanders): the chapters on TCP and on troubleshooting slow networks with Wireshark.
* **Official docs:** the async-profiler README and the Go `pprof` documentation; the Grafana Pyroscope and Parca documentation; the Linux kernel documentation on PSI (pressure stall information); the Kubernetes documentation on the resource metrics pipeline and the kube-state-metrics documentation; the Eclipse Memory Analyzer (MAT) help on dominator trees; the Wireshark User's Guide; the OpenTelemetry semantic conventions for feature flags.
* **Papers:** "Google-Wide Profiling: A Continuous Profiling Infrastructure for Data Centers" (Ren et al., 2010); "The BSD Packet Filter: A New Architecture for User-level Packet Capture" (McCanne & Jacobson, 1993), the ancestor of eBPF and `tcpdump` filters.
* **Related technologies:** compare async-profiler, pprof, Pyroscope, and Parca (profilers), bcc and bpftrace (eBPF tooling), Cilium/Hubble and Pixie (eBPF-based observability), Eclipse MAT, Chrome DevTools, and `dotnet-gcdump` (heap analysis), and OpenFeature (flag telemetry).
* **Search for:** `how to read flame graphs`, `off-CPU analysis`, `eBPF verifier`, `TCP retransmissions ss -ti`, `iostat await util`, `PSI pressure stall information`, `CPU throttling CFS quota Kubernetes`, `heap dump dominator tree`, `synthetic monitoring false positives`.
* **Hands-on:** write a small service with a deliberate memory leak and a CPU hot loop, profile it with your language's profiler, generate a flame graph, and take two heap dumps an hour apart to find the leak in the dominator tree.
