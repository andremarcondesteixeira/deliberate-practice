# Data Models & Encoding

## Data Models

* **Relational vs Document Models:** Compare the relational model (normalized tables, schema-on-write, joins) with the document model (nested JSON, schema-on-read, locality). When is the document model clearly better, and what is the write penalty for updating a small field inside a large document?
* **Many-to-One & Many-to-Many:** Why do many-to-one and many-to-many relationships push document databases back toward relational ideas? What did the CODASYL network model get wrong with manual access paths?
* **Graph Models:** Compare property graphs (Neo4j, Cypher) with triple stores (RDF, SPARQL). How does index-free adjacency speed up multi-hop traversals, and how does Datalog express recursive queries?
* **Declarative vs Imperative Queries:** Why does a declarative language like SQL let the optimizer (and parallel execution) improve performance without changing application code?

## Encoding & Evolution

* **Backward & Forward Compatibility:** Define backward compatibility (new code reads old data) and forward compatibility (old code reads new data). Why does "data outlives code" mean databases need both during rolling deploys?
* **Text Formats:** What are the drawbacks of JSON, XML, and CSV regarding number precision (integers above $2^{53}$), binary data, and schemas?
* **Protobuf, Thrift & Avro:** Compare how Protocol Buffers and Thrift (field tags) and Avro (no tags, writer schema) encode data. Which schema changes are safe in each (adding/removing fields, renaming, changing types)?
* **Avro Schema Resolution:** How does Avro resolve the writer's schema against the reader's schema, and how does the reader learn which writer schema was used (file header, schema registry ID)?
* **Schema Registries & Event Evolution:** How does a schema registry enforce `BACKWARD`, `FORWARD`, and `FULL` compatibility for Kafka topics, and how does that let producers and consumers upgrade independently?
