# Java Concurrency

## Memory Model & Primitives

* **Java Memory Model:** How does the JMM's happens-before relation define visibility between threads? List the main happens-before edges (monitor unlock → lock, volatile write → read, thread start and join, final field freeze).
* **volatile:** What does `volatile` guarantee (visibility, ordering) and not guarantee (atomicity of `count++`)? Why does double-checked locking need it?
* **CAS & Atomics:** How do compare-and-swap instructions power `AtomicInteger`, `AtomicReference`, and lock-free algorithms? What is the ABA problem, and why does `LongAdder` beat `AtomicLong` under contention?
* **StampedLock:** How do optimistic reads in `StampedLock` beat `ReentrantReadWriteLock` for read-heavy workloads, and why isn't `StampedLock` reentrant?
* **Synchronizers:** Contrast `CountDownLatch` (one-shot), `CyclicBarrier` (reusable), `Phaser` (dynamic parties), and `Semaphore`.
* **ThreadLocal Leaks:** Why do `ThreadLocal`s leak memory in thread pools and app servers (including classloader leaks), and why must you `remove()` them?
* **Deadlock Detection:** How do thread dumps (`jstack`, `jcmd Thread.print`) and `ThreadMXBean.findDeadlockedThreads()` reveal deadlocks?

## Executors & Async

* **ThreadPoolExecutor:** How do core size, max size, the work queue, keep-alive, and the rejection policy interact? Why does an unbounded queue mean the pool never grows past its core size?
* **ForkJoinPool & Work Stealing:** How does work stealing balance tasks across worker deques, and which workloads suit it?
* **CompletableFuture:** How do `thenApply`, `thenCompose`, `thenCombine`, `allOf`, and `exceptionally`/`handle` compose async work? Which executor runs each stage if you don't pass one, and why does that matter?

## Virtual Threads & Structured Concurrency

* **Virtual Threads:** How do virtual threads differ from platform threads? How does the JVM mount them on carrier threads and unmount them on blocking I/O, and how do you create them (`Thread.ofVirtual()`, `Executors.newVirtualThreadPerTaskExecutor()`)? Why shouldn't you pool them?
* **Lab — Virtual Thread Pinning:**
  * *Setup:* A Java 21 service on virtual threads shows carrier thread starvation and latency spikes. Thread dumps show many virtual threads pinned inside `synchronized` blocks doing I/O.
  * *Challenge:* Explain pinning and how to detect it (`jdk.VirtualThreadPinned` JFR events, `jcmd <pid> Thread.dump_to_file`). Compare the Java 21 fix (replacing `synchronized` with `ReentrantLock`) with upgrading to Java 24+, where JEP 491 removed pinning for `synchronized`. What still pins (native frames/JNI)?
* **Virtual Threads & Resource Limits:** Why can switching to virtual threads overwhelm databases and downstream services, and why limit concurrency with semaphores or connection pools instead of thread pool sizes?
* **Structured Concurrency:** How does `StructuredTaskScope` treat related subtasks as one unit for cancellation and error handling? How did the API change from Java 21 (`ShutdownOnFailure`/`ShutdownOnSuccess`) to the Java 25 preview (`StructuredTaskScope.open()` with `Joiner`s)?
* **Scoped Values:** How do `ScopedValue`s (final in Java 25) share immutable context with a bounded lifetime, and why are they a better fit than `ThreadLocal` for virtual threads and request context?

## Study Guide

* **Books:**
  * *Java Concurrency in Practice* (Brian Goetz et al.): still the best foundation for this deck. Read the chapters on the Java Memory Model, building blocks (synchronizers), task execution and thread pools, explicit locks, and atomic variables and nonblocking synchronization.
  * *The Art of Multiprocessor Programming* (Maurice Herlihy & Nir Shavit): the chapters on consensus, spin locks and concurrent queues (where the ABA problem is explained), for the theory behind CAS and lock-free algorithms.
  * *Modern Java in Action* (Raoul-Gabriel Urma, Mario Fusco & Alan Mycroft): the chapters on parallel data processing (fork/join, work stealing) and on `CompletableFuture`, for composing async pipelines.
* **Official docs:** the Java Language Specification chapter "Threads and Locks" (the memory model section); the "Memory Consistency Properties" section of the `java.util.concurrent` package summary in the JDK API docs, which lists the happens-before edges; the "Virtual Threads" chapter of Oracle's Core Libraries guide; and JEP 444 (Virtual Threads), JEP 491 (Synchronize Virtual Threads without Pinning), JEP 505 (Structured Concurrency, fifth preview in Java 25) and JEP 506 (Scoped Values).
* **Papers:** "The Java Memory Model" (Manson, Pugh & Adve, 2005); "A Java Fork/Join Framework" (Doug Lea, 2000); and Doug Lea's "The JSR-133 Cookbook for Compiler Writers", for how memory barriers implement happens-before.
* **Related technologies:** compare Kotlin coroutines and Go goroutines (the same many-to-few scheduling idea as virtual threads), Project Reactor and RxJava (the async style virtual threads aim to replace for I/O-bound code), Akka actors, and the C++ memory model (`std::atomic` memory orders).
* **Search for:** `happens-before`, `safe publication`, `double-checked locking volatile`, `ABA problem`, `LongAdder vs AtomicLong`, `ThreadPoolExecutor rejection policy`, `virtual thread pinning`, `jdk.VirtualThreadPinned`, and Aleksey Shipilëv's "Java Memory Model Pragmatics" talk.
* **Hands-on:** use OpenJDK's jcstress harness to write tests that show a non-`volatile` stop flag and an unsynchronized `count++` misbehaving, then fix each one and rerun.
