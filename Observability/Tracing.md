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

## Study Guide

* **Books:**
  * *Mastering Distributed Tracing* (Yuri Shkuro): the creator of Jaeger on trace anatomy, instrumentation, context propagation, and sampling strategies.
  * *Distributed Tracing in Practice* (Austin Parker, Daniel Spoonhower, Jonathan Mace, Ben Sigelman & Rebecca Isaacs): the chapters on instrumentation, sampling, and turning traces into insight.
  * *Learning OpenTelemetry* (Ted Young & Austin Parker): the chapters on the OpenTelemetry architecture, instrumenting libraries and applications, and running Collector pipelines.
  * *Cloud Native Observability with OpenTelemetry* (Alex Boten): the hands-on chapters on tracing with the SDK, propagators, and the Collector.
* **Official docs:** the W3C Trace Context Recommendation (`traceparent`, `tracestate`) and the W3C Baggage specification; the OpenTelemetry specification (Trace API, context propagation, Baggage, span links) and its semantic conventions for messaging and FaaS; the OpenTelemetry Collector documentation and the `tailsamplingprocessor` and `loadbalancingexporter` READMEs in the collector-contrib repository; the OpenTelemetry Java agent documentation; the AWS Distro for OpenTelemetry documentation for Lambda.
* **Papers:** "Dapper, a Large-Scale Distributed Systems Tracing Infrastructure" (Sigelman et al., 2010); "Time, Clocks, and the Ordering of Events in a Distributed System" (Leslie Lamport, 1978), for why wall-clock timestamps can't order events across hosts.
* **Related technologies:** compare Jaeger, Zipkin, Grafana Tempo, and AWS X-Ray (backends), the OpenTelemetry Collector (pipelines and tail sampling), chrony and NTP (clock sync), and the Java agent vs language SDKs (auto vs manual instrumentation).
* **Search for:** `W3C traceparent header`, `OpenTelemetry context propagation async`, `span links vs parent child`, `tail sampling OpenTelemetry Collector`, `head vs tail sampling`, `Kafka trace context headers`, `OpenTelemetry baggage security`, `tracing clock skew adjustment`.
* **Hands-on:** run two small services, Kafka, the OpenTelemetry Collector, and Jaeger with Docker Compose, trace a request across HTTP and Kafka, then switch the Collector to tail sampling and confirm every error trace is kept.
