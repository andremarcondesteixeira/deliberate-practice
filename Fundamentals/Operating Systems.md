# Operating Systems

## Processes & Threads

* **Processes vs Threads:** What does a thread share with the other threads in its process (address space, heap, file descriptors), and what is private (stack, registers)? Why is creating a platform thread expensive, and how does that explain thread pools and virtual threads in the JVM?
* **System Calls & Kernel Mode:** What happens when a program makes a system call (mode switch, kernel entry, return)? Why are syscalls expensive compared to function calls, how does the vDSO make `clock_gettime` cheap, and why does batching I/O into fewer syscalls matter?
* **Context Switches:** What does the kernel save and restore on a context switch, and what are the indirect costs (cold CPU caches, TLB misses)? Distinguish voluntary from involuntary switches, and explain how to measure them with `vmstat` and `pidstat -w`.
* **CPU Scheduling & Load Average:** How does the Linux scheduler share CPUs among runnable threads, and what do `nice` values change? What exactly does Linux load average count (runnable *and* uninterruptible tasks), and why can it be high while the CPUs are idle?
* **Signals & Exit Codes:** Contrast `SIGTERM`, `SIGINT`, `SIGKILL`, `SIGHUP`, and `SIGQUIT` (which makes the JVM print a thread dump). Which signals can a process catch? Why does an exit code of 137 or 143 tell you how a container died (128 + signal number)?

## Memory

* **Virtual Memory & Paging:** How do page tables and the TLB translate virtual addresses into physical ones? Why does every process appear to own a large private address space, and what is the difference between VSZ, RSS, and PSS when you read a process's memory use?
* **Page Faults:** Distinguish minor from major page faults. How does demand paging make memory allocation lazy, and why do major faults show up as latency spikes in a service that seems to have plenty of RAM?
* **Swap & Memory Pressure:** What do `vm.swappiness`, `kswapd`, and direct reclaim do as memory fills up? Why is swapping often worse than an OOM kill for a latency-sensitive service, and how does Pressure Stall Information (PSI) measure the stall time?
* **The OOM Killer:** How does Linux memory overcommit allow allocations beyond physical RAM? How does the OOM killer pick a victim (`oom_score`, `oom_score_adj`), and how does an OOM inside a cgroup differ from a host-wide OOM?
* **Memory-Mapped Files:** How does `mmap` map a file into the address space so that reads become page faults instead of `read()` calls? Why do Kafka's index files, Lucene, and many storage engines use it, and what are the risks (unpredictable faults, `SIGBUS` on truncated files)?
* **Native Memory & Allocators:** Why can a JVM's RSS keep growing even when the heap is stable? Explain glibc `malloc` arenas and fragmentation, why `MALLOC_ARENA_MAX` or switching to jemalloc helps, and which other native memory (thread stacks, metaspace, direct buffers) adds to RSS.

## Files & I/O

* **File Descriptors:** What is a file descriptor, and why are sockets, pipes, and epoll instances file descriptors too? Where do the limits come from (`ulimit -n`, `nofile`, `fs.file-max`), and how do you find a leak with `lsof` or `/proc/<pid>/fd`?
* **I/O Models:** Compare blocking, non-blocking, multiplexed (`select`/`poll` vs `epoll`), and completion-based (`io_uring`) I/O. Why does `epoll` scale to many connections when `select` does not, what is the difference between level-triggered and edge-triggered mode, and how do Java NIO and Netty build on it?
* **Page Cache & Durability:** Why does `write()` usually return before data reaches the disk? What do `fsync`, `fdatasync`, and `O_SYNC` guarantee, and why does safely replacing a file need the write-to-temp, `fsync`, `rename`, `fsync`-the-directory sequence?
* **Disk Latency & IOPS:** Compare HDD, SATA SSD, and NVMe in latency, IOPS, and the gap between sequential and random access. How do you read `iostat -x` (`await`, `aqu-sz`, `%util`), and why is `%util` misleading on devices that serve many requests in parallel?

## Labs

* **Lab — Too Many Open Files:**
  * *Setup:* Under load, a Java service starts throwing `java.io.IOException: Too many open files`, and new connections are refused. Restarting fixes it for a few hours.
  * *Challenge:* Find out whether the cause is a descriptor leak or a limit that is too low. Inspect `/proc/<pid>/limits`, count `/proc/<pid>/fd`, group the descriptors with `lsof`, and explain how unclosed HTTP responses or sockets stuck in `CLOSE_WAIT` cause this.
* **Lab — High Load, Idle CPU:**
  * *Setup:* A host reports a load average of 40 on 8 cores, but `top` shows the CPUs 90% idle and the application is barely responding.
  * *Challenge:* Explain how tasks in uninterruptible sleep (`D` state) inflate load average. Use `ps -eo stat,pid,wchan,cmd`, `vmstat 1`, and `iostat -x 1` to find the slow disk or network filesystem they are waiting on.
* **Lab — Latency Spikes Without GC:**
  * *Setup:* A service's p99 latency jumps from 20 ms to 2 s for a few seconds at a time. GC logs are clean, and CPU usage is normal.
  * *Challenge:* Check for memory pressure: major page faults (`pidstat -r 1`), swap activity (`vmstat 1`), direct reclaim, and PSI (`/proc/pressure/memory`). Explain how page cache eviction of a memory-mapped index or swapped-out heap pages causes the stalls, and how to fix it.
* **Lab — Empty File After a Crash:**
  * *Setup:* A service saves its state by truncating and rewriting `state.json`. After a power loss, the file exists but is empty, and the service cannot start.
  * *Challenge:* Explain how the page cache and delayed allocation lose the data, then make the save crash-safe: write to a temporary file, `fsync` it, `rename` it over the old file, and `fsync` the directory. What does Java's `FileChannel.force` correspond to?

## Study Guide

* **Books:**
  * *Operating Systems: Three Easy Pieces* (Remzi H. Arpaci-Dusseau & Andrea C. Arpaci-Dusseau, free from the authors): the virtualization part (processes, scheduling, address spaces, paging, TLBs, swapping) and the persistence part (hard disks, SSDs, file systems, crash consistency) cover the theory behind this whole deck.
  * *The Linux Programming Interface* (Michael Kerrisk): the chapters on file I/O and buffering, processes, signals, memory mappings, and alternative I/O models (`epoll`), for exactly how the Linux APIs behave.
  * *Systems Performance* (Brendan Gregg): the chapters on operating systems, CPUs, memory, file systems, and disks, for measuring each of these in production and for the tools used in the labs.
  * *How Linux Works* (Brian Ward): a lighter introduction to processes, the kernel, devices, and file systems if the other books feel too dense.
* **Official docs:** the Linux man pages `proc(5)`, `epoll(7)`, `io_uring(7)`, `mmap(2)`, `fsync(2)`, `signal(7)`, and `getrlimit(2)`; the Linux kernel documentation on `vm` sysctls (`swappiness`, `overcommit_memory`, dirty page settings), Pressure Stall Information, and cgroup v2 memory control; and LWN.net's kernel articles (search "LWN" plus the topic, such as `LWN io_uring`).
* **Papers:** "All File Systems Are Not Created Equal: On the Complexity of Crafting Crash-Consistent Applications" (Pillai et al., 2014), on why applications lose data even on journaling file systems.
* **Related technologies:** Java NIO, Netty, and virtual threads (how the JVM uses `epoll` and blocking I/O); and the diagnostic tools `strace`, `perf`, `bpftrace`, `vmstat`, `pidstat`, `iostat`, and `lsof`.
* **Search for:** `minor vs major page fault`, `RSS vs PSS`, `Linux Load Averages: Solving the Mystery` (Brendan Gregg), `epoll edge triggered vs level triggered`, `the C10K problem` (Dan Kegel), `Efficient IO with io_uring` (Jens Axboe), `fsync rename directory durability`, `PostgreSQL fsyncgate`, `MALLOC_ARENA_MAX java RSS`, `PSI memory pressure`, `oom_score_adj`.
* **Hands-on:** in a Linux VM or container, run a small Java program that opens files without closing them and watch `/proc/<pid>/fd` grow until it hits `ulimit -n`. Then run a load test against any service while watching `vmstat 1`, `pidstat -w -r 1`, and `strace -c -p <pid>`, and name every number you see.
