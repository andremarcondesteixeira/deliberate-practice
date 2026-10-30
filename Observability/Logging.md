# Logging

* **Structured Logging & Correlation IDs:** Why is structured JSON logging better than free text for parsing, querying, and indexing? Why must every log line in a distributed request carry a correlation/trace ID?
* **Log Levels:** Which criteria decide `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`? Why is logging expected failures as `ERROR` harmful, and how do you change levels at runtime?
* **Log Pipelines:** Deconstruct a typical pipeline: collector agents (Fluent Bit, Vector, OTel Collector) → buffer (Kafka) → storage (Loki, Elasticsearch). How do you parse legacy unstructured logs (regex/Grok)?
* **DaemonSet vs Sidecar Collection:** Contrast node-level log agents with per-pod sidecars on Kubernetes. When is a sidecar justified?
* **Loki vs Elasticsearch:** Why does Loki index only labels and compress raw log chunks, while Elasticsearch indexes full text? How does that change query style (LogQL stream selectors and line filters), cost, and label cardinality rules?
* **Retention & Tiering:** How do you balance hot, searchable storage with cheap cold object storage for compliance retention?
* **Sampling & Throttling:** How do high-volume systems sample or rate-limit logs during spikes without losing the rare error events you need?
* **Async Logging:** How do asynchronous appenders (e.g., Log4j2 with the LMAX Disruptor) keep logging I/O off hot paths, and what can you lose on a crash or when the buffer is full?
* **Log-Trace Correlation:** How do logging libraries inject the active trace and span IDs into log records automatically?
* **Logs to Metrics:** When should you derive metrics from logs (counting error events), and why is emitting a metric directly usually better?
* **Audit Logs & Forensics:** What makes an audit log trustworthy (append-only/immutable storage, who/what/when/where, synchronized clocks, retention), and which telemetry must exist *before* a breach for investigators to reconstruct the attack?
* **Lab — PII in Logs:**
  * *Setup:* Request-body logging added for debugging has been writing card numbers and SSNs to plain-text logs.
  * *Challenge:* Stop the leak at the source (log allowlisted fields instead of whole payloads), add redaction in the logging library and the pipeline, and deal with the logs that already exist.
* **Lab — Log Pipeline Backpressure:**
  * *Setup:* A traffic surge makes log shippers buffer in memory, drop logs, and finally get OOMKilled.
  * *Challenge:* Configure filesystem-backed buffers, backpressure behavior, and adaptive sampling. Decide which logs you're willing to drop first.
