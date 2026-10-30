# Microservices Architecture & Distributed Systems Practice

## Phase 1: Service Decomposition & Boundaries

* **Card 1 (Domain-Driven Service Boundaries):** Why should microservice boundaries align with DDD Bounded Contexts rather than technical layers (e.g., UI, service, data)?
* **Card 2 (The Distributed Monolith Anti-Pattern):** What are the structural symptoms of a distributed monolith, and how do tightly coupled deployments defeat the core purpose of microservices?
* **Card 3 (Shared Database Anti-Pattern):** Why is sharing a single database across multiple microservices considered an architectural anti-pattern, and what risks does it introduce?
* **Card 4 (Decomposition Drivers):** What organizational and technical metrics (e.g., team scaling velocity, independent release cycles, resource isolation) justify splitting a monolith?
* **Card 5 (Entity Ownership in Distributed Domains):** How do you handle scenarios where multiple microservices require access to the same core entity data (e.g., User or Product profiles)?
* **Card 6 (Service Granularity Trade-offs):** What are the operational and performance trade-offs of fine-grained nano-services versus coarser domain services?
* **Card 7 (Strangler Fig Migration Strategy):** How does the Strangler Fig pattern allow teams to incrementally carve out microservices from a legacy monolith safely?
* **Card 8 (Greenfield vs Brownfield Decomposition):** How do migration strategies differ when designing microservices from scratch versus extracting them from an established legacy codebase?
* **Card 9 (Team Autonomy and Conway's Law):** How does structuring cross-functional product teams around business capabilities eliminate friction in microservice ownership?
* **Card 10 (Data Migration During Extraction):** What zero-downtime database refactoring patterns are used to split a monolithic database table into separate service datastores?

## Phase 2: Inter-Service Communication & Protocols

* **Card 11 (Synchronous vs Asynchronous Trade-offs):** When should architects choose synchronous request-response protocols (REST/gRPC) over asynchronous event-driven messaging?
* **Card 12 (gRPC vs REST for Internal Traffic):** Compare gRPC (HTTP/2, Protocol Buffers) with REST (JSON, HTTP/1.1) regarding performance, contract enforcement, and client tooling.
* **Card 13 (API Gateway Pattern):** What architectural responsibilities belong at the API Gateway level (rate limiting, auth, SSL termination) versus internal microservices?
* **Card 14 (Backend for Frontend - BFF):** When should an architecture implement the BFF pattern to tailor APIs for different client platforms (web, mobile, third-party)?
* **Card 15 (Event-Driven Choreography vs Orchestration):** Contrast choreography (decentralized event reaction) with orchestration (centralized workflow coordinator) in distributed transactions.
* **Card 16 (Message Broker Design - Kafka vs RabbitMQ):** Compare log-based brokers (Apache Kafka) with queue-based brokers (RabbitMQ) regarding message replay, retention, and consumer models.
* **Card 17 (Schema Evolution in Event Streams):** How do schema registries and backward/forward compatibility rules prevent breaking changes when producers update event payloads?
* **Card 18 (Service Discovery Mechanics):** Contrast client-side service discovery with server-side service discovery in dynamic containerized environments.
* **Card 19 (Client-Side Load Balancing):** How do client-side load balancers (like Netflix Ribbon or gRPC resolvers) distribute requests across multiple service instances?
* **Card 20 (API Contract Testing):** How do consumer-driven contract tests (e.g., Pact) prevent breaking changes between microservice producers and consumers?

## Phase 3: Data Management & Distributed Transactions

* **Card 21 (The Dual-Write Problem):** Why does updating a database and publishing an event in two separate calls risk data inconsistency, and how does the Outbox Pattern solve it?
* **Card 22 (Saga Pattern Implementation):** How does the Saga pattern manage long-running distributed transactions through a sequence of local transactions and compensating actions?
* **Card 23 (Eventual Consistency UX Design):** How do front-end architectures handle eventual consistency lags (e.g., optimistic UI updates, polling, or WebSocket notifications)?
* **Card 24 (CQRS for Cross-Service Queries):** How does Command Query Responsibility Segregation simplify complex reporting and queries that span multiple microservice boundaries?
* **Card 25 (Distributed Locking Pitfalls):** Why are distributed locks across microservice databases discouraged, and what alternative design patterns eliminate lock contention?
* **Card 26 (Idempotency Key Design):** How do you design idempotent API endpoints and message consumers to safely handle duplicate message deliveries and network retries?
* **Card 27 (Event Sourcing and Replayability):** What are the architectural benefits of storing microservice state changes as an immutable stream of domain events?
* **Card 28 (Reference by ID vs Data Duplication):** When should a microservice store a denormalized copy of reference data versus fetching it synchronously via API calls?
* **Card 29 (Distributed Data Purging / GDPR):** How do microservice architectures handle cascading data deletion requests across disparate polyglot datastores for compliance (GDPR/CCGP)?
* **Card 30 (Read-Your-Own-Writes Consistency):** How do architectures guarantee that a user immediately sees their own updates despite asynchronous replication lags?

## Phase 4: Resiliency, Fault Tolerance & Observability

* **Card 31 (Circuit Breaker State Machine):** Explain how Closed, Open, and Half-Open states prevent failing microservices from crashing upstream callers.
* **Card 32 (Bulkhead Resource Isolation):** How does the Bulkhead pattern isolate thread pools and connection pools so a failure in one domain doesn't starve others?
* **Card 33 (Timeout and Deadline Propagation):** Why is propagating execution timeouts across microservice call graphs critical for freeing up blocked worker threads?
* **Card 34 (Retry Storm Mitigation):** How do exponential backoff, randomized jitter, and retry budgets prevent synchronized retry storms from overwhelming services?
* **Card 35 (Distributed Tracing Propagation):** How do tracing systems inject and extract trace context headers (e.g., W3C traceparent) across HTTP and messaging boundaries?
* **Card 36 (Centralized Log Aggregation):** Why are structured JSON logs and correlation IDs mandatory for debugging distributed request flows across multiple microservices?
* **Card 37 (Metrics, Logs and Traces (OTel)):** What is the role of OpenTelemetry in standardizing metrics, logs, and traces across heterogeneous microservice tech stacks?
* **Card 38 (Graceful Degradation and Fallbacks):** How do fallback responses maintain core user functionality when non-critical downstream microservices fail?
* **Card 39 (Load Shedding and Backpressure):** How do reactive streams and system load indicators handle backpressure to prevent buffer overflows under heavy load?
* **Card 40 (Chaos Engineering in Production):** How do proactive failure injection experiments (like Latency Injection or Pod Killer) validate microservice resilience hypotheses?

## Phase 5: Advanced Troubleshooting & Architecture Scenarios

* **Card 41 (Lab Scenario A - Cascading Timeout Failure):**
  * *The Setup:* A slow third-party payment gateway causes worker threads across six upstream internal microservices to back up, leading to a total platform outage.
  * *The Challenge:* Implement a resilience strategy combining circuit breakers, bulkhead isolation, request timeouts, and asynchronous fallback queues.

* **Card 42 (Lab Scenario B - The Distributed Deadlock):**
  * *The Setup:* Two microservices update shared database rows in opposing transactional sequences during high concurrency, causing frequent database deadlocks.
  * *The Challenge:* Redesign the interaction flow using ordered resource acquisition or optimistic concurrency control (OCC).

* **Card 43 (Lab Scenario C - Event Stream Consumer Lag):**
  * *The Setup:* A sudden spike in e-commerce traffic causes Kafka consumer lag to grow by 30 minutes, delaying inventory updates and notification dispatches.
  * *The Challenge:* Architect a partition scaling and consumer concurrency strategy to process high-velocity event spikes without lagging.

* **Card 44 (Lab Scenario D - Ghost Orders from Network Retries):**
  * *The Setup:* A client times out waiting for an HTTP POST response from an order service, retries the request, and inadvertently creates duplicate orders.
  * *The Challenge:* Implement client-generated idempotency keys and database unique constraints to make order creation safely idempotent.

* **Card 45 (Lab Scenario E - The Distributed Monolith Tight Coupling Trap):**
  * *The Setup:* Two microservices require synchronous database schema changes deployed simultaneously across separate CI/CD pipelines, causing breaking deployment failures.
  * *The Challenge:* Decouple the services using asynchronous event contracts, API versioning, and database schema decoupling patterns.

* **Card 46 (Lab Scenario F - Service Discovery Storm):**
  * *The Setup:* Following a network partition heal, thousands of microservice instances simultaneously query the service discovery registry, crashing it due to CPU exhaustion.
  * *The Challenge:* Implement randomized client backoff timers, aggressive local caching, and rate limiting on service discovery queries.

* **Card 47 (Lab Scenario G - The Split-Brain Leader Election Failure):**
  * *The Setup:* A replicated microservice worker pool experiences a network split, causing two nodes to assume they are the active coordinator, processing duplicate tasks.
  * *The Challenge:* Configure distributed consensus (Raft/Paxos) or lease-based heartbeats with fencing tokens to guarantee single active leadership.

* **Card 48 (Lab Scenario H - Config Drift Across Microservices):**
  * *The Setup:* A configuration change applied to an upstream service breaks downstream consumers because environment variables drifted across deployment environments.
  * *The Challenge:* Implement centralized configuration management (Consul, Spring Cloud Config, or K8s ConfigMaps) with schema validation and git-backed version control.

* **Card 49 (Lab Scenario I - Memory Leak in Long-Lived Workers):**
  * *The Setup:* A background worker microservice consumes increasing memory over several days until the container is terminated by the orchestrator with OOMKilled.
  * *The Challenge:* Diagnose unclosed database cursors, event listener leaks, or unbounded collections, and establish memory profiling monitoring.

* **Card 50 (Lab Scenario J - Cascading Retry Storms):**
  * *The Setup:* An intermittent database timeout causes 50 client instances to retry their requests 3 times instantly, multiplying database load by 150x and causing a total outage.
  * *The Challenge:* Configure exponential backoff with full jitter and implement global rate-limiting guards at the API boundary.