# AWS Application Integration

## SQS & SNS

* **SQS Standard vs FIFO:** Contrast standard queues (at-least-once, best-effort ordering, nearly unlimited throughput) with FIFO queues (ordering per message group ID, deduplication window, throughput limits). How do message group IDs allow parallelism while keeping per-entity order, and how do SNS FIFO topics fit in?
* **Visibility Timeout & Long Polling:** What does the visibility timeout do, and what happens if processing takes longer? How do you extend it, and how does long polling (`WaitTimeSeconds`) cut empty receives and cost?
* **SQS Dead-Letter Queues:** How do `maxReceiveCount` and redrive policies isolate poison messages, how do you redrive messages back to the source queue, and which alarms should watch the DLQ?
* **SNS Fan-Out & Filtering:** How does SNS fan out to SQS, Lambda, HTTP, and email subscribers, and how do subscription filter policies (on attributes or payload) cut unnecessary deliveries?
* **Amazon MQ:** When do you choose Amazon MQ (managed ActiveMQ or RabbitMQ) instead of SQS/SNS, e.g., to lift and shift JMS/AMQP applications?

## EventBridge

* **EventBridge vs SNS:** Contrast EventBridge (content-based rules, schema discovery, SaaS partner sources, archive and replay, cross-account buses) with SNS (high-throughput fan-out). When do you pick each?

## Step Functions

* **Standard vs Express Workflows:** Compare Standard (up to a year, exactly-once state transitions, full history) with Express (high volume, up to 5 minutes, at-least-once or at-most-once). Which fits order processing, and which fits streaming event transforms?
* **Error Handling:** How do `Retry` (with backoff and jitter) and `Catch` blocks handle failures in states, and how do you implement compensations (a saga) in a state machine?
* **Service Integrations:** How do direct service integrations call AWS APIs without Lambda glue, and what do the request-response, `.sync` (run a job), and `.waitForTaskToken` (callback) patterns do?
* **Distributed Map:** How does Distributed Map process millions of items (e.g., S3 objects) in parallel child executions, and how do you control concurrency and failure tolerance?
* **Lab — Execution History Limits:**
  * *Setup:* A Standard workflow processing large batches fails with payload size and history limit errors.
  * *Challenge:* Explain the 256KB payload and 25,000-event history limits, then redesign: pass S3 references instead of payloads, use Distributed Map or child workflows, and trim state with `ResultSelector`/`OutputPath`.
