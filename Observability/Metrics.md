# Metrics & Monitoring

## Foundations

* **Monitoring vs Observability & the Three Pillars:** What's the difference between monitoring (known failure modes) and observability (asking new questions of a system's outputs)? What does each pillar (metrics, logs, traces) answer best, and how do you correlate them during an incident?
* **OpenTelemetry:** How does OpenTelemetry standardize metrics, logs, and traces across languages (API vs SDK, semantic conventions, OTLP)? What are its metric instruments (counter, up-down counter, histogram, gauge; synchronous vs asynchronous)?
* **RED, USE & Golden Signals:** Contrast RED (rate, errors, duration) for services, USE (utilization, saturation, errors) for resources, and Google's four golden signals (latency, traffic, errors, saturation).
* **Whitebox vs Blackbox Monitoring:** Contrast whitebox monitoring (internal metrics) with blackbox probing from outside. Which one catches DNS, TLS, or load balancer failures?
* **RUM vs Synthetic Monitoring:** Contrast real user monitoring (Core Web Vitals, real devices and networks, JS errors) with synthetic checks (scripted journeys from fixed locations). Why do you need both?

## Prometheus

* **Pull vs Push:** Why does Prometheus pull (scrape) metrics, and how does service discovery (Kubernetes, Consul, DNS) find ephemeral targets? When do you still need push (Pushgateway, OTLP push), and what are its pitfalls?
* **Metric Types:** When do you use a counter, a gauge, a histogram, or a summary? Why can't you aggregate summary quantiles across instances?
* **rate, irate & increase:** What's the difference between `rate()`, `irate()`, and `increase()`? How do they handle counter resets, why does `increase()` return non-integers, and why should the range be at least 4× the scrape interval?
* **Histograms & Quantiles:** How do cumulative `le` buckets let `histogram_quantile()` estimate percentiles? How does the bucket layout affect accuracy, and what do native (exponential) histograms improve?
* **Recording & Alerting Rules:** When should you precompute expensive queries with recording rules? How does the `for` clause in an alerting rule avoid flapping, and what does `keep_firing_for` add?
* **Scaling Prometheus:** Compare federation with remote write to long-term stores (Thanos, Cortex, Mimir) for global views, high availability, and retention.
* **Exemplars:** How do exemplars attach trace IDs to histogram samples so you can jump from a latency spike straight to an example trace?
* **Lab — Cardinality Explosion:**
  * *Setup:* A developer adds raw client IPs and user IDs as metric labels. Prometheus memory explodes, the TSDB crashes, and alerts stop firing.
  * *Challenge:* Find the offending metric (TSDB status page, `topk(10, count by (__name__)({__name__=~".+"}))`), drop or rewrite labels with `metric_relabel_configs`, set per-scrape sample and label limits, and establish label design rules (bounded values only).
