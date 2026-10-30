# Batch & Stream Processing

## Batch

* **MapReduce:** Explain the map, shuffle, and reduce stages. Why is the shuffle usually the most expensive part?
* **Unix Philosophy in Data Systems:** How do Unix ideas (small tools, uniform interfaces, immutable inputs) carry over to distributed batch processing and dataflow engines?
* **Distributed Join Strategies:** Compare sort-merge joins, broadcast hash joins, and partitioned hash joins in batch pipelines. When does each one win?
* **Batch Fault Tolerance:** How do MapReduce and Spark recover from a failed worker mid-job without restarting the whole pipeline (materialized intermediates vs lineage recomputation)?

## Streams

* **Batch vs Stream Processing:** Contrast bounded batch processing over historical data with unbounded stream processing. Why is "batch is a special case of streaming" a useful mental model?
* **Event Time vs Processing Time:** Why must windows be computed by event time (when it happened) instead of processing time (when it arrived)? What goes wrong after a consumer outage if you use processing time?
* **Windowing:** Contrast tumbling, hopping (sliding), and session windows, with an example use case for each.
* **Watermarks & Late Events:** What is a watermark in Flink or Beam, and what are your options when an event arrives after the watermark has passed?
* **Stream Joins:** Compare stream-stream (windowed), stream-table (enrichment), and table-table (materialized view) joins. What state must each one keep?
* **Exactly-Once Stream Processing:** How do idempotent sinks, transactional commits, and Chandy-Lamport-style checkpoints combine to give end-to-end exactly-once results? Why is "exactly-once delivery" a misnomer?

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Batch Processing chapter (Unix tools, MapReduce, joins, dataflow engines) and the Stream Processing chapter (event time, windows, stream joins, fault tolerance) cover almost the whole deck.
  * *Streaming Systems* (Tyler Akidau, Slava Chernyak & Reuven Lax): the chapters on watermarks, advanced windowing, exactly-once and side effects, streams and tables, and streaming joins go deeper than anything else on the Streams section.
  * *Stream Processing with Apache Flink* (Fabian Hueske & Vasiliki Kalavri): the chapters on time-based operators and on state and fault tolerance, for how watermarks and checkpoints work in a real engine.
  * *Spark: The Definitive Guide* (Bill Chambers & Matei Zaharia): the parts on joins, RDD lineage and Structured Streaming, for batch join strategies and recomputation-based recovery.
* **Official docs:** the Apache Flink documentation's "Concepts" pages ("Timely Stream Processing" and "Stateful Stream Processing") and its checkpointing guide; the Apache Beam Programming Guide's sections on windowing, watermarks and triggers; the Spark SQL performance tuning guide (join strategy hints) and the Structured Streaming Programming Guide.
* **Papers:** "MapReduce: Simplified Data Processing on Large Clusters" (Dean & Ghemawat, 2004); "Resilient Distributed Datasets: A Fault-Tolerant Abstraction for In-Memory Cluster Computing" (Zaharia et al., 2012); "The Dataflow Model" (Akidau et al., 2015); "Distributed Snapshots: Determining Global States of Distributed Systems" (Chandy & Lamport, 1985); "Lightweight Asynchronous Snapshots for Distributed Dataflows" (Carbone et al., 2015).
* **Related technologies:** compare Hadoop MapReduce (materialized intermediates), Spark (lineage), Flink (checkpointed streaming state), Apache Beam/Google Cloud Dataflow (the unified model), and Kafka Streams/ksqlDB (streaming on top of Kafka).
* **Search for:** `shuffle sort merge join vs broadcast hash join`, `event time vs processing time`, `watermark allowed lateness`, `session windows`, `Flink checkpoint barriers`, `two-phase commit sink`, and Akidau's articles "Streaming 101" and "Streaming 102".
* **Hands-on:** run Flink locally against a Kafka topic, feed it events with out-of-order timestamps, and watch which ones a tumbling event-time window counts, drops or sends to a late-data side output as you change the watermark delay.
