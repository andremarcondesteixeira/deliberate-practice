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

## Study Guide

* **Books:**
  * *Building Microservices* (Sam Newman): the chapters on modeling services around business domains, communication styles, testing (including contract tests), and organizational structure.
  * *Monolith to Microservices* (Sam Newman): the chapters on splitting the monolith (strangler fig) and decomposing the database, step by step without downtime.
  * *Microservices Patterns* (Chris Richardson): the chapters on decomposition, querying across services (API composition, CQRS), external APIs (API gateway, BFF), and testing microservices.
  * *Team Topologies* (Matthew Skelton & Manuel Pais): the material on Conway's Law, the reverse Conway maneuver, and stream-aligned teams.
* **Official docs:** the Pact documentation (consumer-driven contracts, Pact Broker, can-i-deploy); the Spring Cloud Contract reference; the Kubernetes documentation on Services and DNS; the gRPC documentation on name resolution and load balancing; the Consul documentation on service discovery; the GDPR text itself (Article 17, the right to erasure).
* **Papers:** "How Do Committees Invent?" (Melvin Conway, 1968), the origin of Conway's Law.
* **Related technologies:** compare Kong, Envoy, and Spring Cloud Gateway (API gateways), Eureka, Consul, and Kubernetes Services (discovery), Istio or Linkerd (service mesh), Pact (contract testing), and Debezium (CDC for data extraction).
* **Search for:** `distributed monolith`, `database per service`, `strangler fig pattern`, `backend for frontend`, `consumer-driven contracts`, `client-side load balancing`, `thundering herd service registry`, `crypto-shredding GDPR`.
* **Hands-on:** take a small monolith, put a routing proxy in front of it, extract one capability into its own service and database behind the proxy, and add a Pact test between the two.
