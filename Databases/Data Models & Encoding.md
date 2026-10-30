# Data Models & Encoding

## Data Models

* **Relational vs Document Models:** Compare the relational model (normalized tables, schema-on-write, joins) with the document model (nested JSON, schema-on-read, locality). When is the document model clearly better, and what is the write penalty for updating a small field inside a large document?
* **Many-to-One & Many-to-Many:** Why do many-to-one and many-to-many relationships push document databases back toward relational ideas? What did the CODASYL network model get wrong with manual access paths?
* **Declarative vs Imperative Queries:** Why does a declarative language like SQL let the optimizer (and parallel execution) improve performance without changing application code?

## Encoding & Evolution

* **Backward & Forward Compatibility:** Define backward compatibility (new code reads old data) and forward compatibility (old code reads new data). Why does "data outlives code" mean databases need both during rolling deploys?
* **Text Formats:** What are the drawbacks of JSON, XML, and CSV regarding number precision (integers above $2^{53}$), binary data, and schemas?
* **Protobuf, Thrift & Avro:** Compare how Protocol Buffers and Thrift (field tags) and Avro (no tags, writer schema) encode data. Which schema changes are safe in each (adding/removing fields, renaming, changing types)?
* **Avro Schema Resolution:** How does Avro resolve the writer's schema against the reader's schema, and how does the reader learn which writer schema was used (file header, schema registry ID)?
* **Schema Registries & Event Evolution:** How does a schema registry enforce `BACKWARD`, `FORWARD`, and `FULL` compatibility for Kafka topics, and how does that let producers and consumers upgrade independently?

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Data Models and Query Languages chapter covers relational vs document models and CODASYL, and the Encoding and Evolution chapter covers compatibility, the pitfalls of JSON, Protobuf/Thrift field tags and Avro schema resolution. Together they cover almost this entire deck.
  * *Kafka: The Definitive Guide* (Gwen Shapira, Todd Palino, Rajini Sivaram & Krit Petty): the Kafka Producers chapter, for Avro serialization and how a schema registry plugs into producers and consumers.
* **Official docs:** the Apache Avro specification's "Schema Resolution" and "Object Container Files" sections; the Protocol Buffers Language Guide, especially "Updating A Message Type"; and Confluent's Schema Registry documentation on schema evolution and compatibility types.
* **Papers:** "A Relational Model of Data for Large Shared Data Banks" (E. F. Codd, 1970); "What Goes Around Comes Around" (Michael Stonebraker & Joseph M. Hellerstein, 2005), a tour of data models from CODASYL onward and why old ideas keep coming back.
* **Related technologies:** compare PostgreSQL `JSONB` with MongoDB (document vs relational in practice) and Protobuf vs Avro vs Thrift vs MessagePack for encoding.
* **Search for:** `schema-on-read vs schema-on-write`, `protobuf reserved field numbers`, `Avro writer schema reader schema`, `schema registry compatibility types`, `JSON number precision 2^53`, and Kleppmann's blog post "Schema evolution in Avro, Protocol Buffers and Thrift".
* **Hands-on:** define the same record in Protobuf and Avro, serialize it, then add, remove and rename a field and check which old and new readers can still decode the bytes.
