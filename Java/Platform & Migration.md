# Java Platform & Migration

* **HTTP Client:** How does `java.net.http.HttpClient` (Java 11) support HTTP/2, async requests with `CompletableFuture`, and WebSockets? Why should you reuse one client instance?
* **Modules & Strong Encapsulation:** What does the module system (JPMS) provide (`module-info.java`, `exports`, `requires`, `opens`), and how did Java 16/17 strongly encapsulate JDK internals? What do `--add-opens` and `--add-exports` do, and why are they a migration crutch?
* **Foreign Function & Memory API:** How does the FFM API (final in Java 22) replace JNI and `Unsafe` for calling native libraries and managing off-heap memory? How do `Arena` scopes (confined, shared, auto, global) prevent leaks and use-after-free?
* **Lab — Native Memory Leak with FFM:**
  * *Setup:* A native library integration using the FFM API leaks off-heap memory until the container is killed.
  * *Challenge:* Find allocations made in a global or auto arena that are never freed, switch to confined arenas in `try-with-resources`, and confirm the fix with Native Memory Tracking.
* **Vector API:** How does the Vector API (still incubating in Java 25) express SIMD computations that compile to hardware vector instructions, and why is it waiting on Project Valhalla?
* **Project Valhalla:** What are value classes (JEP 401), and how do they drop object identity and headers to allow flat, dense memory layouts? Why aren't they in Java 25, and what would "generics over primitives" add later?
* **Class-File API:** Why did the JDK add a standard class-file API (final in Java 24) as an alternative to ASM, and who benefits?
* **Lab — Java 8 to 25 Upgrade Plan:**
  * *Setup:* A portfolio of Java 8 services needs a phased path to Java 25.
  * *Challenge:* Plan the hops (8 → 11 → 17 → 21 → 25) and the breaking changes at each: removed Java EE/CORBA modules (11), strong encapsulation (16/17), the Security Manager deprecated (17) and permanently disabled (24), `javax` → `jakarta` in frameworks, and library upgrades. Where do you adopt records, virtual threads, and new GC defaults?
