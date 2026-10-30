# JVM Internals & Garbage Collection

## Memory & Class Loading

* **JVM Memory Areas:** Deconstruct the JVM memory layout: heap, metaspace, thread stacks, code cache, and other native memory (direct buffers, GC structures). Which areas does `-Xmx` not cover?
* **Metaspace & OutOfMemoryError Types:** Why did metaspace replace PermGen in Java 8? Differentiate `Java heap space`, `Metaspace`, `GC overhead limit exceeded`, `Direct buffer memory`, and `unable to create native thread`.
* **Off-Heap Memory:** How do direct `ByteBuffer`s allocate native memory, how does GC eventually free it, and how does `-XX:MaxDirectMemorySize` limit it?
* **Class Loading:** Walk through the delegation model (bootstrap, platform, application loaders) and the loading, linking, and initialization phases. How do classloader leaks happen?
* **String Interning & Deduplication:** How do the string pool and `String.intern()` work, and how does G1 string deduplication differ?
* **Lab — OOMKilled Container:**
  * *Setup:* A containerized Java service dies with exit code 137, and the host's `dmesg` shows `Memory cgroup out of memory`, yet the heap never reached `-Xmx`.
  * *Challenge:* Explain how heap plus metaspace, thread stacks, code cache, direct buffers, and GC overhead exceeded the cgroup limit. How does the JVM detect container limits (cgroups v1/v2), and why use `-XX:MaxRAMPercentage` and Native Memory Tracking instead of a fixed `-Xmx` equal to the limit?

## Garbage Collection

* **GC Roots & Reachability:** What counts as a GC root (thread stacks, static fields, JNI references, ...), and how do soft, weak, and phantom references change reachability?
* **Choosing a Collector:** When would you use Serial, Parallel, G1, ZGC, Shenandoah, or Epsilon (no-op, for testing)? What does each optimize: footprint, throughput, or latency?
* **G1:** How does G1 split the heap into regions, use remembered sets, and pick regions to meet a pause-time goal (`MaxGCPauseMillis`)? What are mixed collections and humongous objects?
* **ZGC:** How does ZGC use colored pointers and load barriers to relocate objects concurrently with sub-millisecond pauses? What did Generational ZGC (Java 21; the only ZGC mode since Java 24) improve?
* **Safepoints:** What is a safepoint, why must threads reach one for some GC phases, and how can time-to-safepoint (e.g., long counted loops) cause pauses that GC logs don't explain?
* **GC Logs & Telemetry:** Which signals in GC logs and JFR matter most: allocation rate, promotion rate, pause times and their distribution, time-to-safepoint, and heap occupancy after GC? How do you enable unified logging (`-Xlog:gc*`)?

## JIT, AOT & Startup

* **Tiered Compilation:** How do the interpreter, C1, and C2 work together, what triggers compilation, and what is deoptimization?
* **Escape Analysis:** How does escape analysis enable scalar replacement and lock elision, and why doesn't HotSpot literally allocate objects on the stack?
* **CDS & AOT Cache:** How do Class Data Sharing, AppCDS, and the AOT cache (JEP 483 in Java 24, JEPs 514/515 in Java 25) cut startup and warm-up time by storing loaded/linked classes and method profiles?
* **AOT vs JIT:** Compare GraalVM Native Image (closed world, fast startup, small footprint, no runtime profiling) with JIT (peak performance after warm-up). What breaks under a closed-world assumption (reflection, dynamic proxies)?

## Diagnostics

* **Java Flight Recorder:** What is JFR, why is its overhead low enough for production, and how do you start, dump, and analyze recordings (`jcmd JFR.start`, JDK Mission Control)?
* **Production Diagnostic Flags:** Which flags should every production JVM have (`-XX:+HeapDumpOnOutOfMemoryError`, `-XX:HeapDumpPath`, `-Xlog:gc*`, `-XX:+ExitOnOutOfMemoryError`), and why?

## Study Guide

* **Books:**
  * *Java Performance* (Scott Oaks): the chapters on garbage collection, heap memory, native memory, the JIT compiler and performance tools. This is the most practical single source for this deck.
  * *Optimizing Cloud Native Java* (Benjamin J. Evans & James Gough): the material on garbage collection, running the JVM in containers, and observability, for the cgroup and production-diagnostics cards.
  * *The Garbage Collection Handbook* (Richard Jones, Antony Hosking & Eliot Moss): the chapters on generational collection and on concurrent marking, copying and compaction, for the algorithms behind G1, ZGC and Shenandoah.
* **Official docs:** the Java Virtual Machine Specification chapter "Loading, Linking, and Initializing"; Oracle's "HotSpot Virtual Machine Garbage Collection Tuning Guide" (one chapter per collector); the "Java Platform, Standard Edition Troubleshooting Guide" (OutOfMemoryError types, Native Memory Tracking, JFR and `jcmd`); and JEP 122 (Remove the Permanent Generation), JEP 439 (Generational ZGC), JEP 158 (Unified JVM Logging), and JEPs 483, 514 and 515 for the AOT cache.
* **Papers:** "Garbage-First Garbage Collection" (Detlefs, Flood, Heller & Printezis, 2004); "The Pauseless GC Algorithm" (Click, Tene & Wolf, 2005), the ancestor of ZGC's load barriers; "Escape Analysis for Java" (Choi et al., 1999).
* **Related technologies:** compare GraalVM (Native Image and the Graal JIT), Eclipse OpenJ9, Azul Platform Prime (the C4 collector), CRaC (Coordinated Restore at Checkpoint) and Project Leyden; for tooling, async-profiler, Eclipse Memory Analyzer and JDK Mission Control.
* **Search for:** `MaxRAMPercentage container`, `Native Memory Tracking`, `time to safepoint`, `G1 humongous allocation`, `ZGC colored pointers load barriers`, `Xlog gc unified logging`, `PrintCompilation deoptimization`, and Aleksey Shipilëv's "JVM Anatomy Quarks" series.
* **Hands-on:** run a small service in Docker with a tight memory limit and `-XX:NativeMemoryTracking=summary`, compare `jcmd <pid> VM.native_memory summary` with the container's memory usage, then raise the thread count and direct buffer use until it gets OOMKilled.
