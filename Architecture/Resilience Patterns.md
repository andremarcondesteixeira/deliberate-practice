# Resilience Patterns

## Protecting Callers

* **Timeouts & Deadline Propagation:** Why must every remote call have a timeout, and why should deadlines propagate down the call tree (e.g., gRPC deadlines) instead of each hop using its own fixed timeout? How do misaligned timeouts waste work downstream?
* **Circuit Breakers:** Explain the Closed, Open, and Half-Open states and the thresholds that move between them (failure rate, slow-call rate, minimum calls, wait duration). What should the caller do while the circuit is open?
* **Bulkheads:** How do bulkheads (separate thread pools, connection pools, or semaphores per dependency) keep one slow dependency from exhausting shared resources?
* **Graceful Degradation & Fallbacks:** How do fallbacks (cached data, defaults, reduced features) keep core functionality alive when non-critical dependencies fail? When is a fallback more dangerous than failing?
* **Lab — Retry Storm:**
  * *Setup:* An intermittent database timeout makes 50 client instances retry three times immediately, at each of three layers, multiplying load far beyond the original traffic and turning a blip into an outage.
  * *Challenge:* Explain retry amplification across layers, then fix it with exponential backoff and full jitter, retry budgets, retrying at only one layer, and retrying only idempotent, retryable errors.

## Protecting Servers

* **Rate Limiting Algorithms:** Compare token bucket, leaky bucket, fixed window, sliding log, and sliding window counter. How do you rate-limit consistently across many gateway instances (e.g., with Redis), and should limits key on IP, user, or API key?
* **Load Shedding & Adaptive Concurrency:** How does load shedding differ from rate limiting? Which signals (queue depth, in-flight requests, latency, CPU) should trigger it, and how do adaptive concurrency limits work? Which requests should be shed first?
* **Backpressure:** How do bounded queues, reactive streams (`request(n)`), and HTTP/2 or gRPC flow control push back on fast producers instead of buffering until memory runs out?
* **Graceful Shutdown & Draining:** How should a service handle `SIGTERM` during a rolling deploy: fail readiness, stop accepting new work, finish in-flight requests, close connections, then exit? Why do you sometimes need a short sleep before shutting down?

## Failure & Recovery

* **Lab — Cascading Failure:**
  * *Setup:* A slow third-party payment API ties up worker threads in the payment service, then in the five services that call it, until the whole platform is down.
  * *Challenge:* Explain why slowness propagates further than errors, and design defenses: timeouts, circuit breakers, bulkheads, an async queue for the payment call, fallbacks, and load shedding at the edge. How would traces and RED dashboards show where it started?
* **RTO & RPO:** Define recovery time objective and recovery point objective. Which architectures (backups, async replicas, sync replicas, active-active) achieve which RTO/RPO, and at what cost?
