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

## Study Guide

* **Books:**
  * *The Java Module System* (Nicolai Parlog): the most thorough guide to JPMS, including the chapters on migrating to modules, strong encapsulation, `--add-opens`/`--add-exports`, and reflection.
  * *Java 9 Modularity* (Sander Mak & Paul Bakker): a shorter, practical take on module descriptors and on migrating existing applications and libraries.
  * *Core Java, Volume II: Advanced Features* (Cay S. Horstmann): the chapters on networking (the HTTP client) and the module system.
* **Official docs:** Oracle's "JDK Migration Guide" for each release (removed APIs, strong encapsulation, deprecations); JEP 320 (Remove the Java EE and CORBA Modules), JEP 403 (Strongly Encapsulate JDK Internals), JEP 411 and JEP 486 (deprecating and then permanently disabling the Security Manager), JEP 321 (HTTP Client), JEP 454 (Foreign Function & Memory API), JEP 484 (Class-File API), JEP 508 (Vector API, tenth incubator) and JEP 401 (value classes); the `java.lang.foreign` package javadoc (the `Arena` docs explain each scope); and Brian Goetz's "State of Valhalla" documents.
* **Related technologies:** compare JNI, JNA and the `jextract` tool (which generates FFM bindings from C headers); ASM and Byte Buddy (what the Class-File API replaces inside the JDK and many tools); OpenRewrite migration recipes and the Eclipse Transformer for `javax` to `jakarta`; and the `jdeps` and `jdeprscan` tools for finding internal and deprecated API use.
* **Search for:** `jdeps --jdk-internals`, `illegal reflective access`, `add-opens migration`, `javax to jakarta migration`, `Arena ofConfined vs ofShared`, `jextract`, `OpenRewrite Java 21 migration`, `Valhalla value classes`.
* **Hands-on:** take an old Java 8 project, run `jdeps --jdk-internals` and `jdeprscan` against it, then build and test it on Java 11, 17, 21 and 25 in turn and write down what breaks at each hop.
