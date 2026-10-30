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
