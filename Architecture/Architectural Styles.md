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
