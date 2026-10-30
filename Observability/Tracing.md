# Distributed Tracing

* **Anatomy of a Trace:** Deconstruct a trace into trace ID, root span, child spans, span context, and span kinds (server, client, producer, consumer). How do backends build service maps from spans?
* **Context Propagation:** How do W3C `traceparent`/`tracestate` headers carry context across HTTP, and how is the same context carried in gRPC metadata and message headers?
* **Baggage:** How does OpenTelemetry Baggage carry key-value context downstream, and what are its pitfalls (header size, leaking sensitive data to third parties, accidental high cardinality)?
* **Span Attributes vs Events:** Contrast span attributes (metadata on the span) with span events (timestamped occurrences inside a span, such as exceptions). What belongs on the span, and what belongs in a log?
* **OpenTelemetry Collector:** What do receivers, processors (batching, filtering, tail sampling), and exporters do, and why deploy collectors as agents plus a gateway tier?
* **Auto vs Manual Instrumentation:** How do Java agents (bytecode instrumentation) and monkey-patching instrument HTTP clients, JDBC, and gRPC without code changes? When do you add manual spans and attributes for business operations?
* **Async Context Loss:** Why does trace context get lost across thread pools, callbacks, `CompletableFuture`, and reactive pipelines, and how do instrumentation libraries restore it?
* **Tracing Through Message Brokers:** How do producers inject context into Kafka/RabbitMQ message headers, and how do consumers extract it? Should the consumer span be a child of the producer span or a link?
* **Tracing Serverless:** Which challenges do cold starts, short lifetimes, and async triggers (SQS, EventBridge) create for trace collection in Lambda?
* **Lab — The Unsampled Error:**
  * *Setup:* A payment bug affects 0.01% of transactions, but with 1% head-based sampling almost none of the failing traces are kept.
  * *Challenge:* Contrast head-based and tail-based sampling, configure tail sampling in the OTel Collector to keep 100% of error and slow traces plus a baseline sample, and explain its memory and routing cost (all spans of a trace must reach the same collector).
* **Lab — Negative Span Durations:**
  * *Setup:* Traces show child spans starting before their parents and negative durations, and logs from different services appear out of order. Node clocks have drifted by 800ms.
  * *Challenge:* Explain why cross-host timestamps can't be trusted for ordering, fix time sync (chrony/NTP) on the hosts, and describe how tracing backends adjust for clock skew.
