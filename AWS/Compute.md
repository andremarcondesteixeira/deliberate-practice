# AWS Compute

## EC2 & Auto Scaling

* **Purchasing Options:** Contrast On-Demand, Savings Plans, Reserved Instances, Spot, and Dedicated Hosts regarding cost and interruption risk. How should an application handle the 2-minute Spot interruption notice and rebalance recommendations?
* **AMIs:** What does an AMI consist of (root volume snapshot, block device mapping, launch permissions)? Why do regional AMIs matter for multi-region disaster recovery?
* **Nitro:** How does the Nitro system offload networking, storage, and security to dedicated cards, and what does that enable (near-bare-metal performance, Nitro Enclaves)?
* **Placement Groups:** Contrast cluster, spread, and partition placement groups. When do you use each?
* **Lifecycle Hooks & Instance Refresh:** How do Auto Scaling lifecycle hooks run custom actions before an instance enters service or terminates, and how does instance refresh roll out a new AMI or launch template version?
* **Lab — Auto Scaling Thrashing:**
  * *Setup:* An Auto Scaling group adds and removes instances every few minutes under steady load.
  * *Challenge:* Compare target tracking, step, and simple scaling policies, then fix the thrashing with the right metric, cooldowns, instance warm-up, and scale-in protection.

## Lambda

* **Execution Lifecycle:** Explain the init, invoke, and shutdown phases, cold vs warm starts, and which code belongs outside the handler. How did Hyperplane ENIs remove the old VPC cold-start penalty, and what does SnapStart do for Java?
* **Concurrency:** How do the account concurrency limit, reserved concurrency (a cap and a guarantee), and provisioned concurrency (pre-initialized environments) interact? How can one function starve the others?
* **Layers & Extensions:** What are Lambda layers for, and how do extensions (e.g., telemetry agents) run alongside the handler? What do they add to cold start time?
* **Async Error Handling:** How do retries, maximum event age, on-failure destinations, and DLQs handle failed asynchronous invocations? How is that different for SQS and Kinesis event source mappings (partial batch failures, batch bisecting)?
* **Function URLs vs API Gateway:** When is a Lambda function URL enough, and when do you need API Gateway (auth options, throttling, usage plans, custom domains, WAF)?
* **Lab — The Silent Timeout:**
  * *Setup:* A Lambda processing S3 events stops halfway with no error in the business logs. CloudWatch shows every invocation ending at exactly 3 seconds.
  * *Challenge:* Explain the 3-second default timeout, how async retries make it worse, and how to set timeouts relative to downstream timeouts and the event source (e.g., an SQS visibility timeout of at least 6× the function timeout).
* **Lab — Payload Too Large:**
  * *Setup:* A Lambda behind API Gateway fails on large JSON uploads with payload size errors.
  * *Challenge:* Explain the payload limits along the path (API Gateway 10MB, synchronous Lambda invocation 6MB, and the much smaller limits of SQS/SNS/EventBridge), then redesign with presigned S3 uploads and the claim-check pattern (passing S3 references, as the SQS Extended Client Library does).

## Containers

* **ECS on EC2 vs Fargate:** Compare operational responsibility, scaling, cost, and constraints (no host access or daemons on Fargate, limited GPU support).
* **Task Definitions & Roles:** What do task definitions control (CPU/memory, network mode, logging, secrets)? What is the difference between the task execution role and the task role?
* **ECS Rolling Updates:** How do `minimumHealthyPercent`, `maximumPercent`, and the deployment circuit breaker control ECS rolling deployments?
* **Lab — ECS Task Restart Loop:**
  * *Setup:* A new ECS task definition cycles `PROVISIONING` → `RUNNING` → `STOPPED` forever.
  * *Challenge:* Read the stopped reason and exit code, then check health check commands, missing environment variables or secrets (execution role permissions), image pull errors, and entrypoint failures.
* **Lab — ALB 502 Bad Gateway:**
  * *Setup:* An ALB in front of ECS returns intermittent 502s.
  * *Challenge:* Explain the usual causes: targets closing keep-alive connections before the ALB does (app idle timeout shorter than the ALB's), wrong port mappings, tasks killed during deploys without enough deregistration delay, and failing health checks.
