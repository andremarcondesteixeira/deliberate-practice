# Software Architecture & Engineering Networking Practice

## Phase 1: Transport & Socket Fundamentals

* **Card 1 (TCP Handshake Latency):** How does the 3-way handshake impact initial request latency (RTT overhead), and how do TLS 1.3 and TCP Fast Open optimize this?
* **Card 2 (TIME_WAIT Socket Exhaustion):** What causes a high volume of sockets in `TIME_WAIT` state on a high-throughput API server, and how does it affect ephemeral port availability?
* **Card 3 (CLOSE_WAIT State):** Diagnose a scenario where backend service nodes accumulate thousands of sockets in `CLOSE_WAIT`. What does this indicate about application code?
* **Card 4 (Connection Pooling Mechanics):** Why are connection pools critical for HTTP/1.1 backend clients, and what are the concurrency risks of oversized or undersized pools?
* **Card 5 (Nagle's Algorithm vs Latency):** How does Nagle's algorithm interact with delayed ACKs, and why do low-latency RPC frameworks disable it via `TCP_NODELAY`?
* **Card 6 (TCP Keep-Alives vs Heartbeats):** Contrast transport-layer TCP Keep-Alives with application-layer heartbeats for detecting dead microservice connections behind load balancers.
* **Card 7 (TCP Head-of-Line Blocking):** Explain how packet loss on a single TCP stream blocks all streams multiplexed within that connection. How does QUIC solve this?
* **Card 8 (UDP Trade-offs for Backends):** When should backend systems or internal service meshes choose UDP-based protocols over TCP? What reliability guarantees must the application layer assume?

## Phase 2: Application Layer, Web & RPC Protocols

* **Card 9 (HTTP/1.1 Connection Reuse):** Explain HTTP/1.1 persistent connections, pipelining limitations, and why head-of-line blocking occurs at the application layer.
* **Card 10 (HTTP/2 Multiplexing):** How do HTTP/2 binary framing and stream multiplexing eliminate application-layer head-of-line blocking over a single TCP connection?
* **Card 11 (HTTP/3 & QUIC Migration):** How does QUIC run over UDP, and how does connection migration maintain client sessions across network changes (e.g., Wi-Fi to cellular)?
* **Card 12 (gRPC vs REST Architecture):** Compare gRPC (over HTTP/2) and REST (over HTTP/1.1) regarding payload serialization (Protocol Buffers vs JSON), streaming support, and browser compatibility.
* **Card 13 (WebSockets vs SSE):** Contrast WebSockets (full-duplex TCP socket) with Server-Sent Events (SSE - unidirectional HTTP stream) for real-time notification systems.
* **Card 14 (REST Idempotency):** Which HTTP methods are idempotent by specification (`GET`, `PUT`, `DELETE`), and why is idempotency crucial for handling network retries?
* **Card 15 (Content Negotiation):** How do `Accept`, `Content-Type`, and `Content-Encoding` headers drive negotiation between clients and servers?
* **Card 16 (Payload Compression Trade-offs):** When should an architect enable Gzip, Brotli, or Zstd compression for API payloads, and what are the CPU versus network bandwidth trade-offs?
* **Card 17 (GraphQL Over HTTP):** Why do GraphQL APIs typically use HTTP `POST` for queries, and how does this impact standard HTTP caching strategies at proxies/CDNs?
* **Card 18 (HTTP Status Code Semantics):** Distinguish between `401 Unauthorized`, `403 Forbidden`, `429 Too Many Requests`, and `503 Service Unavailable` in distributed error handling.

## Phase 3: DNS, Routing & Load Balancing

* **Card 19 (DNS Resolution & TTL Caching):** Walk through client DNS lookup resolution. What are the caching pitfalls of low versus high TTL values when failing over database endpoints?
* **Card 20 (L4 vs L7 Load Balancers):** Contrast Layer 4 (Transport) load balancers with Layer 7 (Application) load balancers. Which layer is required for cookie-based session affinity and path routing?
* **Card 21 (Reverse Proxy Header Propagation):** Why are `X-Forwarded-For`, `X-Forwarded-Proto`, and `X-Request-ID` essential when requests pass through multiple reverse proxies and load balancers?
* **Card 22 (Anycast Global Routing):** How do Content Delivery Networks (CDNs) and global API gateways leverage IP Anycast to route clients to the nearest topological data center?
* **Card 23 (Rate Limiting Algorithms):** Compare Token Bucket, Leaky Bucket, and Fixed/Sliding Window algorithms for API rate limiting in distributed architectures.
* **Card 24 (Service Discovery Patterns):** Contrast client-side service discovery (e.g., Eureka/Consul clients) with server-side service discovery (load balancer fronting internal clusters).
* **Card 25 (Circuit Breaker State Machine):** Explain the Closed, Open, and Half-Open states of a circuit breaker pattern and how network failure thresholds govern state transitions.
* **Card 26 (CDN Edge Caching Mechanics):** How do `Cache-Control`, `ETag`, and `Vary` headers dictate edge caching behavior and cache invalidation workflows?
* **Card 27 (DNS Round-Robin Limitations):** Why is DNS Round-Robin considered a crude load balancing mechanism for microservices, and how do smart load balancers supersede it?
* **Card 28 (Proxy Protocol Specification):** What problem does the HAProxy Proxy Protocol solve when passing original client connection metadata through intermediate load balancers?

## Phase 4: Security, Encryption & Identity

* **Card 29 (TLS 1.3 Handshake Optimization):** How does the TLS 1.3 handshake reduce connection setup latency to 1-RTT (and 0-RTT for resumption) compared to TLS 1.2?
* **Card 30 (Mutual TLS - mTLS):** Explain how mTLS provides both encryption and cryptographic zero-trust workload identity verification in service meshes like Istio.
* **Card 31 (Certificate Validation Chains):** Walk through what happens when a client validates an SSL/TLS certificate chain, including root CAs, intermediates, and CRL/OCSP revocation checks.
* **Card 32 (CORS Preflight Mechanics):** Why do browser-based AJAX requests trigger an `OPTIONS` preflight request for cross-origin resources, and what headers control CORS policy?
* **Card 33 (JWT Network Overhead):** What are the architectural pros and cons of using self-contained JSON Web Tokens (JWTs) versus opaque reference tokens in distributed auth?
* **Card 34 (API Key Leakage Vectors):** Why are API keys passed in URL query parameters less secure than authorization headers (`Bearer`) in transit and access log storage?
* **Card 35 (OAuth2/OIDC Network Flows):** Describe the Authorization Code Flow with PKCE (Proof Key for Code Exchange) for securing modern single-page and mobile applications over the network.
* **Card 36 (WAF and Payload Inspection):** How do Web Application Firewalls (WAF) inspect Layer 7 traffic payload patterns to mitigate SQL injection and XSS attacks?

## Phase 5: Resiliency & Distributed Network Patterns

* **Card 37 (Retries with Jitter):** Why can naive retrystorms crash recovering downstream services, and how do exponential backoff and randomized jitter prevent thundering herds?
* **Card 38 (Timeout Cascades):** Explain how unaligned timeout budgets across a deep call stack of microservices lead to wasted compute resources on downstream services.
* **Card 39 (Backpressure in Streaming):** How do reactive streams and gRPC streaming handle backpressure to prevent fast producers from overwhelming slow consumers' network buffers?
* **Card 40 (Network Partitions & CAP Theorem):** In the context of partition tolerance (P), how do partition events force distributed systems to choose between Consistency (C) and Availability (A)?
* **Card 41 (Idempotency Keys in RPCs):** How do developers design network payment or transactional APIs using client-generated idempotency keys to safely handle network timeouts and retries?
* **Card 42 (Distributed Tracing Context Propagation):** How do distributed tracing systems inject and extract trace headers (e.g., W3C `traceparent`) across HTTP/gRPC boundaries?
* **Card 43 (Split-Brain Mitigation):** How do distributed consensus systems (like Raft or Paxos) use network heartbeats and quorum majorities to prevent split-brain states?
* **Card 44 (Keep-Alive Load Balancer Idle Drops):** Why do intermediate firewalls or load balancers silently drop idle TCP connections, and how do keep-alive probes prevent this?

## Phase 6: Practical Architecture & Troubleshooting Scenarios

* **Card 45 (Lab Scenario A - Connection Pool Exhaustion):**
  * *The Setup:* A high-traffic web service experiences intermittent `504 Gateway Timeouts` during peak traffic. Monitoring shows the database connection pool is fully saturated.
  * *The Challenge:* Trace how slow queries tie up connection pool slots, cause request queue backups, and explain how to tune pool timeouts and acquire limits.

* **Card 46 (Lab Scenario B - TIME_WAIT Port Starvation):**
  * *The Setup:* An internal microservice client making rapid short-lived HTTP connections to a downstream API suddenly fails with `EADDRNOTAVAIL` (Cannot assign requested address).
  * *The Challenge:* Diagnose why ephemeral ports are exhausted due to `TIME_WAIT` persistence, and explain architectural fixes (connection reuse, HTTP/2 connection pooling, or `SO_REUSEADDR`).

* **Card 47 (Lab Scenario C - The DNS ndots Latency Spike):**
  * *The Setup:* Containerized applications in Kubernetes experience consistent 5-second delays when performing external HTTP requests.
  * *The Challenge:* Explain how glibc's default `ndots: 5` setting forces multiple failed DNS search-domain queries (`.svc.cluster.local`, etc.) before querying the root domain, causing severe latency.

* **Card 48 (Lab Scenario D - Asymmetric Routing & Firewalls):**
  * *The Setup:* A stateful firewall drops legitimate TCP packets intermittently between two datacenters. Packet capture shows traffic takes Path A outbound but Path B on return.
  * *The Challenge:* Explain why stateful firewalls drop asymmetric paths (missing TCP state table entries) and how routing symmetry or firewall session sync resolves it.

* **Card 49 (Lab Scenario E - The Slowloris Attack Vector):**
  * *The Setup:* A backend web server runs out of worker threads and refuses new connections even though CPU utilization is minimal. Incoming requests are sending HTTP headers extremely slowly line-by-line.
  * *The Challenge:* Detail how Slowloris exhausts server connection concurrency limits and how proxy read-timeouts and concurrency guards mitigate it.

* **Card 50 (Lab Scenario F - MTU Black Hole in Tunnels):**
  * *The Setup:* Clients can ping an internal server and load static pages, but submitting large form payloads or streaming gRPC messages causes the connection to hang indefinitely.
  * *The Challenge:* Diagnose an MTU black hole caused by VPN/overlay tunnels encapsulating packets above the path MTU while ICMP "Fragmentation Needed" messages are blocked by intermediate firewalls.