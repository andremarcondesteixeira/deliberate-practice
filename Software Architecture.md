# Software Architecture & System Design Practice (100 Challenges)

## Phase 1: Architectural Styles & Structural Patterns

* **Card 1 (Modular Monolith vs Microservices):** When should an architectural team start with a modular monolith instead of microservices, and what organizational metrics drive the transition?
* **Card 2 (Event-Driven Architecture Trade-offs):** Contrast event-driven asynchronous architectures with synchronous request-response systems regarding operational complexity and eventual consistency.
* **Card 3 (Layered vs Clean Architecture):** How does Clean Architecture (or Hexagonal Architecture) invert dependencies compared to classic N-Tier Layered architecture to protect domain business logic?
* **Card 4 (Serverless Architecture Limits):** What are the architectural trade-offs of serverless (FaaS) computing regarding cold-start latency, vendor lock-in, and state management?
* **Card 5 (Micro-Frontend Complexity):** When are micro-frontends justified in enterprise applications, and what runtime integration challenges do they introduce (iframe vs web components)?
* **Card 6 (Space-Based Architecture):** How does space-based architecture achieve extreme horizontal scalability by eliminating the central database bottleneck through in-memory data grids?
* **Card 7 (Pipes and Filters Pattern):** Where is the Pipes and Filters architectural style most effective, and how do backpressure mechanisms prevent pipeline buffer overflows?
* **Card 8 (Service-Oriented vs Microservices):** What are the core philosophical and technological differences between enterprise SOA (ESB-centric) and decentralized Microservices architectures?
* **Card 9 (Plugin/Kernel Architecture):** How does a plugin architecture decouple core system processing logic from extensible feature modules using inversion of control?
* **Card 10 (Monolithic to Distributed Migration Risks):** What are the hidden network, latency, and transactional boundary traps when decomposing a tightly coupled monolith prematurely?
* **Card 11 (Actor Model Concurrency Architecture):** How does the Actor Model (e.g., Akka, Orleans) handle shared state and concurrency via asynchronous message passing without explicit locks?
* **Card 12 (Blackboard Architecture Pattern):** In what types of complex AI or data-synthesis problem domains is the Blackboard architectural pattern utilized for decentralized problem solving?
* **Card 13 (Layered Monolith Refactoring Strategies):** How do you enforce strict package boundaries and prevent circular dependencies within a modular monolith prior to microservice extraction?
* **Card 14 (Peer-to-Peer vs Client-Server Topologies):** Contrast network topologies, discovery challenges, and security models between traditional client-server systems and pure P2P networks.
* **Card 15 (Hexagonal Architecture Ports & Adapters):** Explain how driving (primary) and driven (secondary) adapters interact with core domain ports in Hexagonal Architecture.

## Phase 2: Domain-Driven Design (DDD) & Strategic Modeling

* **Card 16 (Ubiquitous Language):** Why is establishing a shared Ubiquitous Language between domain experts and software engineers critical for preventing translation bugs?
* **Card 17 (Bounded Contexts & Context Mapping):** How do you define Bounded Context boundaries, and what are the primary relationship patterns in a Context Map (Upstream/Downstream, Shared Kernel, Customer-Supplier)?
* **Card 18 (Entities vs Value Objects):** Contrast Entities (defined by identity and lifecycle) with Value Objects (defined entirely by their attributes and immutability).
* **Card 19 (Aggregate Roots & Transactional Boundaries):** What rules govern Aggregate Design in DDD regarding consistency boundaries, root access, and referencing other aggregates via IDs rather than direct object references?
* **Card 20 (Domain Events vs Integration Events):** Distinguish between internal Domain Events (within a bounded context) and integration events (published across context boundaries).
* **Card 21 (Repositories & Factories):** What is the separation of responsibilities between Repositories (persistence abstraction) and Factories (complex object creation)?
* **Card 22 (Anti-Corruption Layer - ACL):** How does an Anti-Corruption Layer protect a modern domain model from being polluted by legacy external system schemas or semantics?
* **Card 23 (Strategic vs Tactical DDD):** Differentiate between Strategic DDD (business alignment, bounded contexts) and Tactical DDD (code patterns like aggregates, services, repositories).
* **Card 24 (Domain Services vs Application Services):** Where does business logic belong when it spans multiple aggregates or domain objects—in an Application Service or a Domain Service?
* **Card 25 (Domain Model Anemic Anti-Pattern):** Why is an anemic domain model (where objects are mere data structures with logic trapped in service classes) considered an anti-pattern in DDD?
* **Card 26 (Specification Pattern in DDD):** How does the Specification pattern encapsulate complex business rules into reusable, combinable domain predicate objects?
* **Card 27 (Domain Event Sourcing & Snapshots):** How do event snapshots optimize aggregate reconstruction performance in an event-sourced domain model with millions of historical events?
* **Card 28 (Bounded Context Upstream/Downstream Relationships):** Explain how Conformist, Open Host Service (OHS), and Published Language patterns govern upstream/downstream context interactions.
* **Card 29 (Shared Kernel Pitfalls in Enterprise DDD):** Why is the Shared Kernel context relationship discouraged in large organizations, and what synchronization challenges does it trigger?
* **Card 30 (Aggregate Size and Performance Trade-offs):** Why must aggregates remain small, and what concurrency or performance degradation occurs when designing overly large aggregates?

## Phase 3: Distributed Systems, Data Consistency & CQRS

* **Card 31 (CAP Theorem Trade-offs):** In the presence of a network partition (P), why must distributed data stores choose between Consistency (C) and Availability (A)?
* **Card 32 (Eventual vs Strong Consistency):** When should an architect choose eventual consistency over ACID transactions, and how does it impact user experience design?
* **Card 33 (Distributed Transactions & 2PC):** Why are Two-Phase Commit (2PC) protocols generally avoided in high-throughput cloud-native microservices architectures?
* **Card 34 (Saga Pattern - Orchestration vs Choreography):** Contrast choreography-based sagas (event-driven) with orchestration-based sagas (central coordinator) for managing distributed transactions.
* **Card 35 (CQRS Architectural Pattern):** How does Command Query Responsibility Segregation (CQRS) allow independent scaling and optimization of write models versus read models?
* **Card 36 (Event Sourcing Mechanics):** What are the core architectural benefits and auditing advantages of storing system state as an immutable sequence of domain events rather than current state tables?
* **Card 37 (Database-per-Service Pattern):** Why does the database-per-service pattern prevent tight coupling, and what challenges does it introduce for cross-domain reporting and joins?
* **Card 38 (Outbox Pattern for Reliable Messaging):** How does the Transactional Outbox pattern solve the dual-write problem when updating a database and publishing an event simultaneously?
* **Card 39 (Idempotency in Distributed Workflows):** Why must distributed message consumers and API endpoints be idempotent, and what techniques (idempotency keys, version numbers) enforce it?
* **Card 40 (Distributed Locking & Split-Brain):** What are the pitfalls of using distributed locks (e.g., Redlock) across asynchronous networks, and how do fencing tokens prevent race conditions?
* **Card 41 (Read-Your-Own-Writes Consistency Models):** How do architectures guarantee that a user immediately sees their own data updates despite eventual consistency replication lags?
* **Card 42 (Distributed Consensus via Raft/Paxos):** How do consensus algorithms like Raft elect a leader and maintain a replicated state machine across an unreliable network?
* **Card 43 (Two-Phase Commit vs Three-Phase Commit):** What non-blocking improvements does 3PC attempt to introduce over 2PC, and why is it still rarely used in production?
* **Card 44 (Compensating Transactions in Sagas):** How do compensating transactions reverse previously completed local steps when a saga workflow fails midway?
* **Card 45 (Distributed Cache Invalidation Strategies):** Contrast write-through, write-behind, and cache-aside patterns regarding consistency risks in multi-instance web applications.

## Phase 4: Resilience, Fault Tolerance & Reliability

* **Card 46 (Circuit Breaker State Machine):** Explain how the Closed, Open, and Half-Open states of a circuit breaker protect downstream services from cascading failures.
* **Card 47 (Bulkhead Isolation Pattern):** How does the Bulkhead pattern isolate system failures (e.g., partitioning thread pools or connection pools per upstream dependency)?
* **Card 48 (Timeout and Deadline Propagation):** Why is propagating request deadlines across deep microservice call trees essential for aborting wasted compute cycles?
* **Card 49 (Rate Limiting and Load Shedding):** Contrast rate limiting (throttling requests at entry points) with load shedding (dropping work internally when resource thresholds are breached).
* **Card 50 (Retry Storms & Jitter):** How do exponential backoff and randomized jitter prevent synchronized retry storms from overwhelming a recovering service?
* **Card 51 (Graceful Degradation & Fallbacks):** How do fallback strategies maintain core user functionality when non-critical downstream dependencies fail or time out?
* **Card 52 (Chaos Engineering Principles):** What is the core philosophy of Chaos Engineering, and how do proactive failure injections validate system resilience hypotheses?
* **Card 53 (Health Check Probes):** Differentiate between liveness probes (restart container if dead) and readiness probes (stop traffic if overloaded) in resilient architectures.
* **Card 54 (RPO and RTO Metrics):** Define Recovery Point Objective (RPO) and Recovery Time Objective (RTO) in disaster recovery and high-availability planning.
* **Card 55 (Cascading Failures and Thundering Herds):** How do system interdependencies cause localized faults to cascade into total system outages, and how do load limiters prevent it?
* **Card 56 (Heartbeat and Lease Mechanisms):** How do heartbeat and lease systems detect node liveness and manage automatic resource ownership relinquishment?
* **Card 57 (Load Shedding Mechanisms at L7):** What indicators (queue depth, CPU saturation, latency quantiles) trigger automatic load shedding in edge proxies?
* **Card 58 (Graceful Shutdown & Drain Cycles):** How do containerized services coordinate graceful connection draining and signal handling during rolling deployments?
* **Card 59 (Distributed Dead Letter Queue Patterns):** How do dead letter queues (DLQs) isolate poison pill messages without halting processing pipelines?
* **Card 60 (Disaster Recovery Warm vs Hot Standby):** Contrast warm standby and active-active multi-region architectures regarding data replication complexity and switchover time.

## Phase 5: Evolution, Quality Attributes & Governance

* **Card 61 (Quality Attributes / NFRs):** How do non-functional requirements (scalability, maintainability, testability, security) dictate structural architectural choices?
* **Card 62 (Architectural Decision Records - ADRs):** What is the purpose of maintaining lightweight Architectural Decision Records (ADRs) in an engineering organization?
* **Card 63 (Technical Debt Management):** How should engineering leaders categorize and manage technical debt using deliberate versus inadvertent debt frameworks?
* **Card 64 (Strangler Fig Pattern):** How does the Strangler Fig pattern facilitate the safe, incremental migration of legacy monoliths to modern architectures?
* **Card 65 (Conway's Law & Reverse Conway Maneuver):** Explain Conway's Law and how organizations use the Reverse Conway Maneuver to align team structures with desired system architectures.
* **Card 66 (API Versioning Strategies):** Compare URI path versioning, header versioning, and content negotiation regarding client coupling and API lifecycle management.
* **Card 67 (Architecture Metrics):** How do metrics like afferent/efferent coupling, abstractness, and instability guide structural modularity assessments?
* **Card 68 (System Modularity Metrics):** How do coupling and cohesion metrics evaluate whether a component boundary is properly encapsulated?
* **Card 69 (Architectural Fitness Functions):** What is an architectural fitness function (from Evolutionary Architecture), and how do automated tests enforce non-functional constraints?
* **Card 70 (Technology Radar and Governance):** How do engineering teams use Technology Radars to manage technology lifecycles (Adopt, Trial, Assess, Hold)?
* **Card 71 (Documentation as Code - C4 Model):** How does the C4 model provide a hierarchical notation (Context, Containers, Components, Code) for visualizing software architecture?
* **Card 72 (Evolutionary Architecture Principles):** What principles allow an architecture to support guided, incremental change across multiple dimensions over time?
* **Card 73 (API Governance and Contract Testing):** How do consumer-driven contract testing frameworks (like Pact) prevent breaking changes between microservices?
* **Card 74 (Legacy Refactoring and Safe Migration Paths):** What strategies ensure zero-downtime database schema migrations during system refactoring?
* **Card 75 (Continuous Architecture and Tech Governance):** How do architecture principles adapt to fast-paced agile product delivery without devolving into bureaucratic oversight?

## Phase 6: Cloud-Native, Infrastructure & Platform Engineering

* **Card 76 (Immutable Infrastructure Principles):** Why does replacing servers entirely rather than in-place patching eliminate configuration drift and debugging uncertainty?
* **Card 77 (Service Mesh Architecture):** Contrast sidecar proxy data planes with ambient mesh architectures regarding resource overhead and latency overhead.
* **Card 78 (Kubernetes Operator Pattern):** How do Custom Resources and Operator controllers implement the control loop pattern for managing complex stateful workloads?
* **Card 79 (Multi-Tenant Architecture Isolation):** Contrast silo (database-per-tenant) and pool (shared database, row-level security) multi-tenancy models regarding noisy neighbors.
* **Card 80 (GitOps Deployment Workflows):** How do GitOps engines (like ArgoCD) ensure declarative desired state synchronization between Git repositories and Kubernetes clusters?
* **Card 81 (Infrastructure as Code Modularization):** What are the design best practices for structuring Terraform or OpenTofu modules for reuse across multiple product teams?
* **Card 82 (Zero Trust Network Architecture):** How does ZTNA replace implicit perimeter security with continuous identity verification and explicit authorization policies?
* **Card 83 (Secret Management & Dynamic Injection):** How do tools like HashiCorp Vault inject ephemeral secrets directly into memory without writing plaintext credentials to disk?
* **Card 84 (Observability Pillars):** How do metrics, structured logs, and distributed traces correlate to form a comprehensive telemetry framework for distributed debugging?
* **Card 85 (Horizontal vs Vertical Autoscaling):** Contrast HPA (Horizontal Pod Autoscaling) and VPA (Vertical Pod Autoscaling) regarding stateful workload limitations and restart impacts.
* **Card 86 (Ephemeral Environments for CI/CD):** How do ephemeral pull-request environments isolate preview deployments for testing complex multi-service interactions?
* **Card 87 (Edge Computing & CDN Architecture):** How do serverless workers at the edge (Cloudflare Workers, Lambda@Edge) shift compute closer to users for low-latency personalization?
* **Card 88 (Disaster Recovery Multi-Region Active-Active):** What are the data replication and conflict resolution challenges when building active-active multi-region write systems?
* **Card 89 (Cost Optimization and FinOps):** How do architectures incorporate resource tagging, spot instances, and auto-scaling policies to align cloud expenditure with business value?
* **Card 90 (Container Registry Supply Chain Security):** How do signed images (cosign), vulnerability scans, and immutable tags secure the container software supply chain?

## Phase 7: Advanced Architecture & Troubleshooting Scenarios

* **Card 91 (Lab Scenario A - The Distributed Lock Deadlock):**
  * *The Setup:* Two microservices acquire distributed locks across shared database rows in opposing orders, resulting in frequent deadlocks during peak concurrency.
  * *The Challenge:* Redesign the interaction flow using ordered resource acquisition or optimistic concurrency control (OCC) to eliminate lock contention.

* **Card 92 (Lab Scenario B - Eventual Consistency Race Condition):**
  * *The Setup:* A user updates their profile email address and immediately refreshes the page, but the old email appears because the read model update lagged behind the write model event.
  * *The Challenge:* Outline architectural solutions (command-query consistency tokens, UI optimistic updates, or read-your-own-writes consistency models) to resolve the race condition.

* **Card 93 (Lab Scenario C - The Monolith-to-Microservices Data Splitting Trap):**
  * *The Setup:* During a monolith decomposition, two newly created microservices still require frequent transactional joins across each other's databases.
  * *The Challenge:* Identify the architectural smell of distributed monoliths and redesign the domain boundaries using event collaboration or data duplication/caching.

* **Card 94 (Lab Scenario D - Cascading Failure in Synchronous Chains):**
  * *The Setup:* A slow third-party API provider causes worker threads across five upstream internal microservices to back up, bringing down the entire platform.
  * *The Challenge:* Implement a comprehensive resilience strategy combining circuit breakers, bulkheads, asynchronous queues, and fallback responses.

* **Card 95 (Lab Scenario E - CQRS Read Model Lag Outage):**
  * *The Setup:* An e-commerce flash sale causes message broker queue backpressure, delaying event projections to the search read model by 30 minutes, causing incorrect inventory listings.
  * *The Challenge:* Architect a scaling and partitioning strategy for the event consumer pipeline to handle high-velocity event spikes without read model lag.

* **Card 96 (Lab Scenario F - Multi-Tenant Data Isolation Breach Risk):**
  * *The Setup:* A B2B SaaS platform migrating to a shared-database multi-tenant architecture needs to guarantee zero risk of cross-tenant data leakage.
  * *The Challenge:* Compare row-level security (RLS) database patterns, schema-per-tenant patterns, and database-per-tenant patterns regarding isolation and operational scale.

* **Card 97 (Lab Scenario G - The Split-Brain Consensus Partition Failure):**
  * *The Setup:* A network partition splits a 5-node Raft cluster into a 2-node minority and a 3-node majority. Clients connected to the minority side experience errors.
  * *The Challenge:* Explain how quorum enforcement prevents conflicting writes on the minority side, and trace recovery behavior once the network heals.

* **Card 98 (Lab Scenario H - The Thundering Herd Cache Stampede):**
  * *The Setup:* When a popular cached object expires in Redis, thousands of concurrent requests simultaneously miss the cache and hammer the primary database, causing CPU exhaustion.
  * *The Challenge:* Architect a mitigation strategy combining probabilistic early expiration, request coalescing (single-flight), and distributed locking.

* **Card 99 (Lab Scenario I - The Connection Pool Exhaustion Cascade):**
  * *The Setup:* A sudden spike in traffic causes database connection pools across all web workers to saturate. Requests hang indefinitely waiting for available connections.
  * *The Challenge:* Implement bounded queue lengths, fast-fail timeouts, and connection leasing limits to prevent thread pool thread starvation.

* **Card 100 (Lab Scenario J - The Immutable Infrastructure Configuration Drift):**
  * *The Setup:* An auto-scaling group scales out new server instances, but the new instances fail to boot because an out-of-band manual configuration change was made directly to the base golden image.
  * *The Challenge:* Redesign the CI/CD pipeline using automated image baking (HashiCorp Packer) and strict configuration-as-code principles to prevent manual drift.