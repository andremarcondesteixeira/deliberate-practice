# Microservices

## Decomposition

* **Service Granularity:** What are the operational and performance trade-offs of fine-grained "nano-services" versus coarser domain services? Which heuristics help you choose the size?
* **Conway's Law & Team Topology:** Explain Conway's Law and the Reverse Conway Maneuver. How do cross-functional teams owning business capabilities reduce coordination?
* **Database per Service:** Why is a database shared across services an anti-pattern? What does database-per-service cost for cross-domain queries, reporting, and joins, and how do you handle them (API composition, CQRS views, a data warehouse)?
* **Shared Entity Data:** When several services need the same entity (User, Product), how do you choose between one owning service with synchronous lookups and denormalized local copies kept fresh by events?
* **Strangler Fig Migration:** How does the strangler fig pattern let you carve services out of a monolith incrementally behind a routing facade? How do brownfield extractions differ from greenfield designs?
* **Splitting the Monolith's Data:** Which zero-downtime steps split a monolith's table into a new service's datastore (sync via dual writes or CDC, backfill, switch reads, transfer ownership)?
* **Lab — The Distributed Monolith:**
  * *Setup:* Two "independent" services need coordinated schema changes deployed together, and another new pair of services needs frequent transactional joins across each other's databases.
  * *Challenge:* List the symptoms of a distributed monolith (lockstep deploys, shared schemas, chatty synchronous calls), then decouple using redrawn boundaries, event contracts, API versioning, and data duplication.

## Communication

* **API Gateway:** What belongs at the gateway (TLS termination, authentication, rate limiting, routing, request shaping) versus inside services (authorization on business objects)? How do you keep the gateway from becoming a monolith?
* **Backend for Frontend:** When should you build a BFF per client type (web, mobile, partners), and who should own it?
* **Service Discovery & Client-Side Load Balancing:** Contrast client-side discovery (Eureka/Consul clients, gRPC resolvers) with server-side discovery (a load balancer, Kubernetes Services). How do client-side load balancers pick instances?
* **Consumer-Driven Contract Testing:** How do consumer-driven contracts (Pact, Spring Cloud Contract) catch breaking changes between services before deployment, and how is that different from end-to-end tests?
* **Lab — Service Discovery Storm:**
  * *Setup:* After a network partition heals, thousands of instances hit the service registry at once and crash it.
  * *Challenge:* Add jittered backoff, client-side caching of the last known registry state, and rate limits so the registry survives reconnect storms.

## Data & Compliance

* **Cascading Deletion & GDPR:** How do you honor a "delete my data" request across many services with polyglot datastores, caches, logs, backups, and event streams (deletion events, crypto-shredding)?
