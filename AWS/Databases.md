# AWS Databases

## RDS & Aurora

* **Multi-AZ vs Read Replicas:** Contrast Multi-AZ instances (synchronous standby for failover), Multi-AZ DB clusters (two readable standbys), and read replicas (asynchronous, for read scaling). How does failover reach the application (DNS), and what must the app do?
* **Backups vs Snapshots:** Contrast automated backups (point-in-time restore within a retention of up to 35 days) with manual snapshots. Why does a restore always create a new instance?
* **Aurora Storage:** How does Aurora separate compute from a distributed storage layer with 6 copies across 3 AZs, a write quorum of 4/6, and a read quorum of 3/6? Why does that make replicas and failover faster than in RDS?
* **Aurora Serverless v2:** How does Serverless v2 scale capacity in fine-grained ACU steps, and what are its limits and cost trade-offs compared with provisioned instances?
* **Aurora Global Database:** How do Aurora Global Databases replicate across regions with typically sub-second lag, and how do managed switchover and failover differ?
* **RDS Proxy & Connection Storms:** How does RDS Proxy pool and multiplex connections to protect databases from Lambda or autoscaling connection storms? What causes connection pinning?
* **IAM Database Authentication:** How do IAM auth tokens replace stored database passwords, and what are their limits (token lifetime, connection rate)?

## DynamoDB

* **Keys & Indexes:** Explain partition keys, sort keys, GSIs, and LSIs. Why must LSIs be created with the table, and why are GSI reads always eventually consistent?
* **Capacity Modes:** Contrast provisioned capacity (with auto scaling) with on-demand. How do RCUs and WCUs relate to item size and read consistency?
* **Conditional Writes & Transactions:** How do condition expressions implement optimistic locking, and what do `TransactWriteItems`/`TransactGetItems` cost and guarantee?
* **Streams, TTL & DAX:** How do DynamoDB Streams drive event-driven processing, how do TTL deletions show up in the stream, and when is DAX the right cache (and when not, e.g., for strongly consistent reads)?
* **Lab — Hot Partition Throttling:**
  * *Setup:* During a flash sale, a table throws `ProvisionedThroughputExceededException` even though total table capacity looks sufficient.
  * *Challenge:* Explain per-partition limits (3,000 RCU / 1,000 WCU), why low-cardinality keys like a date or country create hot partitions, how adaptive capacity only partly helps, and fix it with write sharding (key suffixes) or a better key design.

## Other Engines

* **ElastiCache Redis/Valkey vs Memcached:** Compare Redis/Valkey (data structures, replication, persistence, cluster mode) with Memcached (simple, multi-threaded, no replication). When does Memcached still win?
* **Database Migration Service:** How does DMS migrate databases with a full load plus ongoing CDC, and what does schema conversion handle in heterogeneous migrations?
* **Lab — Slow Redshift Queries:**
  * *Setup:* Redshift reporting queries run for hours and occupy every query slot.
  * *Challenge:* Explain columnar storage and MPP, then diagnose distribution styles (`KEY`, `ALL`, `EVEN`, `AUTO`) that force data redistribution, sort keys that don't match filters, missing `VACUUM`/`ANALYZE`, and workload management queue settings.
