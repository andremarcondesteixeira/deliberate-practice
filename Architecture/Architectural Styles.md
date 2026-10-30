# Architectural Styles

* **Modular Monolith vs Microservices:** When should a team start with a modular monolith, and which signals (team count, independent release cadence, scaling or isolation needs) justify extracting services? What hidden costs (network failures, latency, distributed transactions) does premature decomposition bring?
* **Enforcing Module Boundaries:** How do you keep a modular monolith modular (module visibility, ArchUnit or Spring Modulith tests, no shared tables, no cyclic dependencies) before ever extracting a service?
* **Event-Driven vs Request-Response:** When should services communicate synchronously (REST/gRPC) versus through events? Compare coupling, latency, operational complexity, debuggability, and consistency.
* **Layered vs Clean/Hexagonal Architecture:** How do Clean and Hexagonal architectures invert dependencies so the domain doesn't depend on frameworks or databases? Explain ports, and driving (primary) vs driven (secondary) adapters.
* **SOA vs Microservices:** What are the philosophical differences between ESB-centric SOA ("smart pipes") and microservices ("smart endpoints, dumb pipes")?
* **Serverless Trade-offs:** What are the trade-offs of FaaS regarding cold starts, execution limits, state, local testing, cost under steady high load, and vendor lock-in?
* **Micro-Frontends:** When are micro-frontends justified, and which integration options (build-time, iframes, web components, module federation) and pitfalls (shared dependencies, consistent UX, performance) come with them?
* **Space-Based Architecture:** How does space-based architecture remove the central database bottleneck with replicated in-memory data grids and asynchronous write-behind?
* **Pipes & Filters:** Where does the pipes-and-filters style shine, and how does backpressure keep a slow filter from overflowing buffers?
* **Microkernel (Plugin) Architecture:** How does a plugin architecture separate a minimal core from extensions, and how do you version the plugin contract?
* **Actor Model:** How do actors (Akka, Orleans, Erlang) manage state and concurrency through message passing instead of locks? What are mailboxes, supervision, and location transparency?

## Study Guide

* **Books:**
  * *Fundamentals of Software Architecture* (Mark Richards & Neal Ford): the part on architecture styles has a chapter for nearly every card here: layered, pipeline, microkernel, event-driven, space-based, orchestration-driven SOA, and microservices, each rated on the same trade-offs.
  * *Clean Architecture* (Robert C. Martin): the chapters on the dependency rule and the Clean Architecture itself, for inverting dependencies so the domain owns its ports.
  * *Building Microservices* (Sam Newman): the opening chapters on what microservices are, the modular monolith, and when not to adopt microservices.
  * *Micro Frontends in Action* (Michael Geers): the chapters on server-side and client-side composition, shared dependencies, and keeping a consistent UX across teams.
* **Official docs:** the Spring Modulith reference documentation ("Verifying application module structure") and the ArchUnit User Guide for boundary tests; the AWS Lambda Developer Guide's sections on quotas and the execution environment lifecycle (cold starts); the Akka and Microsoft Orleans documentation on actors, supervision, and location transparency; the webpack documentation on Module Federation.
* **Papers:** "On the Criteria To Be Used in Decomposing Systems into Modules" (David Parnas, 1972); "Making reliable distributed systems in the presence of software errors" (Joe Armstrong's PhD thesis, 2003), for actors, supervision, and "let it crash".
* **Related technologies:** compare Spring Modulith and ArchUnit (module boundaries), AWS Lambda and Azure Functions (FaaS), Hazelcast and Apache Ignite (in-memory data grids for space-based designs), Akka, Orleans, and Erlang/Elixir OTP (actors), and Akka Streams or Project Reactor (backpressure in pipelines).
* **Search for:** `modular monolith`, `hexagonal architecture ports and adapters` (Alistair Cockburn's original article), `smart endpoints and dumb pipes` (Lewis & Fowler's "Microservices" article), `serverless cold start mitigation`, `module federation micro-frontends`, `space-based architecture`, `actor supervision tree`.
* **Hands-on:** take a small app with layered packages, move it to ports and adapters, and add an ArchUnit test that fails the build when the domain package imports a framework or persistence class.
