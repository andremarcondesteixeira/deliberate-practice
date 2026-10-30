# AWS Core Architecture & Engineering Practice (200 Challenges)

## Phase 1: Compute (EC2, Lambda, Auto Scaling, Containers)

* **Card 1 (EC2 Purchasing Options):** Contrast On-Demand, Reserved Instances, Savings Plans, Spot Instances, and Dedicated Hosts regarding cost optimization and interruption risk.
* **Card 2 (AMI Composition):** What elements comprise an Amazon Machine Image (AMI), and how do region-specific AMIs impact multi-region disaster recovery?
* **Card 3 (Instance Metadata Service):** Differentiate between IMDSv1 and IMDSv2. How does IMDSv2 mitigate Server-Side Request Forgery (SSRF) security vulnerabilities?
* **Card 4 (EBS-Optimized Instances):** What architectural purpose do EBS-optimized instance configurations serve regarding network bandwidth separation for storage I/O?
* **Card 5 (Auto Scaling Lifecycle Hooks):** How do Auto Scaling lifecycle hooks allow custom scripts to execute before an instance is terminated or fully put into service?
* **Card 6 (Auto Scaling Policies):** Contrast Target Tracking Scaling, Step Scaling, and Simple Scaling policies in EC2 Auto Scaling groups.
* **Card 7 (Lambda Execution Lifecycle):** Explain the lifecycle of an AWS Lambda execution environment (Cold Start vs Warm Start, initialization phase vs invocation phase).
* **Card 8 (Lambda Concurrency Limits):** How do Reserved Concurrency and Provisioned Concurrency prevent throttling and eliminate cold starts in Lambda functions?
* **Card 9 (Lambda VPC Integration):** How did AWS modernize Lambda VPC networking (ENI management via Hyperplane) to eliminate the historical cold-start latency penalty for VPC-connected functions?
* **Card 10 (ECS Launch Types):** Compare ECS on EC2 versus ECS on AWS Fargate regarding operational responsibility, cluster scaling, and cost efficiency.
* **Card 11 (ECS Task Definitions):** What parameters in an ECS Task Definition dictate CPU/memory allocation, container logging, and network mode?
* **Card 12 (EC2 Placement Groups):** Contrast Spread, Partition, and Cluster placement groups in EC2. When should you use each for high-availability workloads?
* **Card 13 (Elastic Inference / GPUs):** When do workloads require EC2 GPU instances (P and G series) versus CPU-optimized instances?
* **Card 14 (Lambda Layer Architecture):** What is the purpose of Lambda Layers, and how do they promote code reuse and reduce deployment package size?
* **Card 15 (Lambda Error Handling):** How do destinations, dead-letter queues (DLQs), and asynchronous retry behavior handle failed Lambda invocations?
* **Card 16 (EC2 Hibernate Mechanics):** How does EC2 instance hibernation save RAM state to root EBS volumes during stop/start cycles?
* **Card 17 (Spot Instance Interruption Notice):** How do applications handle the 2-minute EC2 Spot Instance interruption warning gracefully?
* **Card 18 (AWS Batch Architecture):** How does AWS Batch utilize ECS and Spot fleets to orchestrate large-scale batch computing jobs automatically?
* **Card 19 (Elastic Beanstalk Abstraction):** What are the architectural advantages and control limitations of using Elastic Beanstalk for application deployment?
* **Card 20 (Lambda Function URLs):** When should you use Lambda Function URLs versus configuring an API Gateway in front of a Lambda function?
* **Card 21 (EC2 Nitro System Architecture):** How do AWS Nitro cards offload virtualization, storage, and networking tasks from the host CPU?
* **Card 22 (ECS Service Rolling Updates):** How do `maximumPercent` and `minimumHealthyPercent` parameters control rolling updates in ECS services?
* **Card 23 (Lambda Extensions API):** What use cases do Lambda Extensions support by running companion processes alongside the main function handler?
* **Card 24 (Auto Scaling Refresh Instances):** How does the Instance Refresh feature in Auto Scaling groups perform rolling updates of underlying AMIs?
* **Card 25 (Compute Optimizer Recommendations):** How does AWS Compute Optimizer use machine learning to analyze CloudWatch metrics and recommend optimal instance sizing?

## Phase 2: Storage (S3, EBS, EFS, Storage Gateway)

* **Card 26 (S3 Consistency Model):** Explain the S3 strong read-after-write consistency model for PUT and DELETE operations across all AWS regions.
* **Card 27 (S3 Storage Classes):** Compare S3 Standard, S3 Intelligent-Tiering, S3 Standard-IA, S3 One Zone-IA, S3 Glacier Instant Retrieval, and S3 Glacier Flexible Retrieval.
* **Card 28 (S3 Lifecycle Policies):** How do lifecycle rules automate object transitions between storage classes and manage multipart upload cleanup?
* **Card 29 (S3 Versioning and MFA Delete):** How do S3 versioning, object locks (Compliance vs Governance modes), and MFA Delete protect against accidental or malicious data deletion?
* **Card 30 (S3 Bucket Policies vs ACLs):** Why are Access Control Lists (ACLs) deprecated in favor of IAM policies and S3 Bucket Policies for access governance?
* **Card 31 (S3 Presigned URLs):** How do S3 presigned URLs grant temporary, secure download or upload access to private objects without exposing AWS credentials?
* **Card 32 (S3 Performance Optimization):** How do prefix naming conventions and parallel request distribution optimize S3 request throughput beyond 3,500 PUT/COPY/POST and 5,500 GET requests per second per prefix?
* **Card 33 (EBS Volume Types):** Contrast gp2/gp3 (General Purpose SSD), io1/io2 (Provisioned IOPS), and st1/sc1 (HDD volumes) regarding IOPS, throughput, and burst credits.
* **Card 34 (EBS Snapshots & Incremental Backups):** Explain how EBS snapshots work as incremental, point-in-time backups stored in Amazon S3.
* **Card 35 (EBS Encryption Mechanics):** How does EBS encryption secure data at rest, data in transit between instance and storage, and snapshots transparently?
* **Card 36 (EFS File System Architecture):** How does Amazon EFS provide scalable shared file storage using NFSv4, and what is the difference between General Purpose and Bursting/Provisioned throughput modes?
* **Card 37 (EFS Storage Tiers):** How do EFS Lifecycle Management policies automatically transition files between Standard and Infrequent Access (IA) storage classes?
* **Card 38 (EFS vs EBS):** When should an architecture choose EFS (multi-AZ shared filesystem) versus EBS (single-AZ block storage)?
* **Card 39 (S3 Select and Glacier Select):** How do S3 Select and Glacier Select allow applications to retrieve only subset data from objects using SQL expressions?
* **Card 40 (S3 Cross-Region Replication):** What prerequisites and replication rules are required to configure S3 Cross-Region Replication (CRR) for disaster recovery?
* **Card 41 (EBS Multi-Attach):** What are the concurrency and clustering requirements for attaching a single EBS io1/io2 volume to multiple EC2 instances in the same Availability Zone?
* **Card 42 (S3 Object Lambda):** How do S3 Object Lambda access points modify data on the fly as it is being retrieved by an application?
* **Card 43 (AWS Storage Gateway Types):** Contrast File Gateway, Volume Gateway, and Tape Gateway for hybrid cloud storage integration.
* **Card 44 (S3 Batch Operations):** How do S3 Batch Operations execute large-scale batch jobs (like tag updates or encryption changes) across billions of objects?
* **Card 45 (EBS Volume Modification):** How can you resize or change the performance tier of a live EBS volume without detaching it from an EC2 instance?
* **Card 46 (S3 Access Points):** How do S3 Access Points simplify permission management for distinct applications sharing a single bucket with customized network restrictions?
* **Card 47 (FSx for Windows File Server):** When should you deploy Amazon FSx for Windows File Server for legacy enterprise SMB shares?
* **Card 48 (FSx for Lustre):** Why is Amazon FSx for Lustre optimized for high-performance computing (HPC), machine learning, and financial modeling workloads?
* **Card 49 (S3 Inventory Reports):** What is the purpose of S3 Inventory, and how does it assist with auditing encryption and replication status across large buckets?
* **Card 50 (Storage Cost Governance):** How do AWS Cost Explorer and S3 Storage Lens identify unoptimized storage, oversized EBS volumes, and abandoned snapshots?

## Phase 3: Networking & Content Delivery (VPC, Route 53, CloudFront, API Gateway)

* **Card 51 (VPC CIDR Block Sizing):** What are the rules and constraints when sizing a VPC CIDR block (minimum `/28`, maximum `/16`), and can you add secondary CIDR blocks later?
* **Card 52 (Subnet Architecture):** Differentiate between Public Subnets and Private Subnets. What core component differentiates their routing table configuration?
* **Card 53 (Internet Gateways vs NAT Gateways):** Contrast the bi-directional routing of an Internet Gateway (IGW) with the outbound-only NAT Gateway / NAT Instance architecture.
* **Card 54 (Security Groups vs NACLs):** Contrast stateful Security Groups (instance level) with stateless Network ACLs (subnet level) regarding rule evaluation and traffic flow.
* **Card 55 (VPC Peering vs Transit Gateway):** When should you use point-to-point VPC Peering versus a centralized AWS Transit Gateway hub-and-spoke architecture?
* **Card 56 (VPC Endpoints - Gateway vs Interface):** Contrast Gateway VPC Endpoints (for S3 and DynamoDB via route tables) with Interface VPC Endpoints powered by AWS PrivateLink.
* **Card 57 (Route 53 Routing Policies):** Compare Simple, Weighted, Latency, Failover, Geolocation, Geoproximity, and Multivalue Answer routing policies in Route 53.
* **Card 58 (Route 53 Health Checks):** How do Route 53 health checks monitor endpoint availability and automate DNS failover to backup targets?
* **Card 59 (CloudFront Edge Architecture):** How does Amazon CloudFront use global Edge Locations and Regional Edge Caches to accelerate content delivery and reduce origin load?
* **Card 60 (CloudFront Cache Behaviors):** How do cache keys, query string forwarding, cookie handling, and TTL settings influence CloudFront cache hit ratios?
* **Card 61 (API Gateway - REST vs HTTP APIs):** Compare API Gateway REST APIs (feature-rich, higher cost) with HTTP APIs (low latency, built for microservices, lower cost).
* **Card 62 (API Gateway Custom Authorizers):** How do Lambda authorizers (token-based or request-based) secure API Gateway endpoints using external identity providers?
* **Card 63 (Direct Connect vs VPN):** Contrast AWS Direct Connect (dedicated physical network connection) with AWS Site-to-Site VPN (encrypted IPsec tunnel over public internet).
* **Card 64 (Elastic Load Balancers):** Compare Application Load Balancers (ALB - Layer 7), Network Load Balancers (NLB - Layer 4), and Gateway Load Balancers (GWLB - Layer 3/Firewalls).
* **Card 65 (ALB Target Group Routing):** How do ALB rule priorities, path-based routing, host-based routing, and weighted target groups distribute traffic?
* **Card 66 (NLB Static IP Capabilities):** Why do enterprise applications requiring whitelisting choose Network Load Balancers for their static IP and elastic IP binding features?
* **Card 67 (VPC Flow Logs):** What network traffic metadata do VPC Flow Logs capture, and how do you query them using Amazon Athena and CloudWatch Logs Insights?
* **Card 68 (Route 53 Resolver):** How do Route 53 Resolver inbound and outbound endpoints enable hybrid DNS resolution between AWS and on-premises datacenters?
* **Card 69 (CloudFront Signed URLs/Cookies):** How do CloudFront signed URLs and cookies secure private media or premium content distribution?
* **Card 70 (Global Accelerator Architecture):** How does AWS Global Accelerator use Anycast IP addresses to route user traffic over the AWS global network rather than the public internet?
* **Card 71 (API Gateway Usage Plans and API Keys):** How do API Gateway usage plans throttle and meter client access using API keys and rate limits?
* **Card 72 (VPC IPAM):** What is VPC IP Address Manager (IPAM), and how does it automate IP address planning across multi-account AWS environments?
* **Card 73 (Client VPN Architecture):** How does AWS Client VPN provide secure, managed TLS-based client access to VPC resources?
* **Card 74 (CloudFront Functions vs Lambda@Edge):** Contrast lightweight CloudFront Functions (JavaScript at viewer request/response) with feature-rich Lambda@Edge (Node.js/Python at origin request/response).
* **Card 75 (Transit Gateway Multicast & Peering):** How do Transit Gateway multicast support and inter-region peering interconnect complex enterprise topologies?

## Phase 4: Databases (RDS, DynamoDB, Aurora, ElastiCache)

* **Card 76 (RDS Multi-AZ vs Read Replicas):** Contrast RDS Multi-AZ deployments (synchronous replication for high availability/failover) with Read Replicas (asynchronous replication for read scaling).
* **Card 77 (Aurora Storage Architecture):** How does Amazon Aurora decouple compute from storage, replicating 6 copies of data across 3 Availability Zones?
* **Card 78 (Aurora Serverless v2):** How does Aurora Serverless v2 scale database capacity instantly in fine-grained increments based on workload demands?
* **Card 79 (DynamoDB Core Concepts):** Explain Primary Keys (Partition Key vs Sort Key), Global Secondary Indexes (GSIs), and Local Secondary Indexes (LSIs) in DynamoDB.
* **Card 80 (DynamoDB Provisioned vs On-Demand):** Contrast Provisioned throughput (with Auto Scaling) with On-Demand capacity mode regarding cost predictability and traffic spikes.
* **Card 81 (DynamoDB Streams and DAX):** How do DynamoDB Streams power event-driven architectures, and how does DynamoDB Accelerator (DAX) provide in-memory caching?
* **Card 82 (ElastiCache - Redis vs Memcached):** Compare ElastiCache Redis (persistence, replication, data structures, pub/sub) with Memcached (simple distributed key-value memory store, multi-threaded).
* **Card 83 (Database Migration Service - DMS):** How does AWS DMS orchestrate heterogeneous database migrations with minimal downtime using change data capture (CDC)?
* **Card 84 (RDS Automated Backups vs Snapshots):** Contrast RDS automated backups (point-in-time recovery retention window up to 35 days) with manual DB snapshots.
* **Card 85 (Aurora Global Databases):** How do Aurora Global Databases achieve low-latency global reads and fast cross-region disaster recovery with sub-second replication lag?
* **Card 86 (DynamoDB TTL):** How does DynamoDB Time-to-Live (TTL) automatically expire and delete old items without consuming write capacity units?
* **Card 87 (RDS Proxy Architecture):** How does RDS Proxy pool and share database connections to protect relational databases from connection exhaustion under high concurrency?
* **Card 88 (ElastiCache Cluster Mode):** Explain how ElastiCache Redis Cluster mode shards data across multiple node groups for horizontal scaling.
* **Card 89 (Aurora Multi-Master):** What use cases require Aurora Multi-Master cross-AZ writable instances, and what are the application conflict resolution requirements?
* **Card 90 (DynamoDB Conditional Writes):** How do conditional writes and transactions in DynamoDB prevent race conditions during concurrent updates?
* **Card 91 (RDS IAM Database Authentication):** How do IAM database authentication tokens eliminate hardcoded database credentials for applications connecting to RDS?
* **Card 92 (DocumentDB Compatibility):** How does Amazon DocumentDB provide MongoDB-compatible document database workloads on AWS storage infrastructure?
* **Card 93 (Amazon Neptune Graph DB):** What architectural graph models (Property Graph and W3C RDF) does Amazon Neptune support for connected data applications?
* **Card 94 (Timestream Time-Series DB):** Why is Amazon Timestream optimized for high-write-throughput time-series data (IoT, DevOps telemetry)?
* **Card 95 (Amazon Redshift Architecture):** How does Redshift use columnar storage, massively parallel processing (MPP), and data compression for data warehousing analytics?
* **Card 96 (Redshift Concurrency Scaling):** How does Redshift Concurrency Scaling automatically add cluster capacity to handle spikes in concurrent read queries?
* **Card 97 (RDS Storage Autoscaling):** How does RDS automatically detect storage exhaustion and expand EBS volume allocations without application downtime?
* **Card 98 (DynamoDB Partition Key Design):** Why is high cardinality and even distribution of partition keys critical for avoiding hot partitions in DynamoDB?
* **Card 99 (ElastiCache Backup and Restore):** How do ElastiCache snapshots and Redis RDB/AOF persistence mechanisms protect cache data against node failures?
* **Card 100 (Database Encryption at Rest):** How do AWS KMS customer managed keys (CMKs) integrate with RDS, DynamoDB, and Aurora encryption at rest?

## Phase 5: Identity, Access & Security (IAM, KMS, Shield, WAF, Secrets Manager)

* **Card 101 (IAM Policy Evaluation Logic):** Walk through the IAM policy evaluation sequence: Explicit Deny -> Organizations SCP -> Resource-Based Policy -> IAM Permission Boundary -> Session Policy -> Identity-Based Policy.
* **Card 102 (IAM Roles vs Users):** Why are IAM roles preferred over long-lived IAM user credentials for applications and cross-account access?
* **Card 103 (Cross-Account IAM AssumeRole):** How do external roles and trusted relationship trust policies enable secure cross-account access without sharing credentials?
* **Card 104 (IAM Permission Boundaries):** How do permission boundaries restrict the maximum permissions an IAM entity can delegate to itself or others?
* **Card 105 (AWS KMS Key Types):** Contrast AWS Managed Keys, Customer Managed Keys (CMKs), and AWS Owned Keys regarding control, auditing, and billing.
* **Card 106 (KMS Envelope Encryption):** Explain the concept of envelope encryption in KMS (Data Key encryption via Master Key). Why is this necessary for large payloads?
* **Card 107 (Secrets Manager vs Parameter Store):** Compare AWS Secrets Manager (automatic secret rotation, encryption via KMS, higher cost) with Systems Manager Parameter Store (hierarchical keys, free standard tier).
* **Card 108 (AWS WAF Architecture):** How do AWS WAF web ACLs inspect HTTP/HTTPS requests against managed and custom rules to block SQL injection and XSS?
* **Card 109 (Shield Standard vs Advanced):** Contrast AWS Shield Standard (automatic, always-on L3/L4 DDoS protection) with Shield Advanced (cost protection, 24/7 DDoS Response Team support, L7 mitigation).
* **Card 110 (GuardDuty Threat Detection):** How does Amazon GuardDuty use machine learning and threat intelligence to analyze VPC Flow Logs, CloudTrail, and DNS logs for malicious activity?
* **Card 111 (AWS Config Compliance):** How do AWS Config rules and conformance packs evaluate resource configurations continuously against desired compliance baselines?
* **Card 112 (CloudTrail Auditing):** What is the difference between management events and data events in AWS CloudTrail, and why should trails be logged to a centralized S3 bucket?
* **Card 113 (IAM Service Roles and Service-Linked Roles):** What is the purpose of Service-Linked Roles, and how do they delegate permissions automatically to AWS services?
* **Card 114 (IAM Conditions & Attribute-Based Access):** How do IAM condition keys (`aws:PrincipalTag`, `aws:SourceIp`) enable Attribute-Based Access Control (ABAC)?
* **Card 115 (AWS Organizations & SCPs):** How do Service Control Policies (SCPs) at the root, OU, or account level establish boundaries for member accounts in AWS Organizations?
* **Card 116 (Amazon Inspector Vulnerability Scanning):** How does Amazon Inspector automatically discover and scan EC2 instances, ECR container images, and Lambda functions for software vulnerabilities?
* **Card 117 (AWS IAM Access Analyzer):** How does Access Analyzer use automated reasoning to identify resources shared externally with external principals?
* **Card 118 (Security Hub Aggregation):** How does AWS Security Hub aggregate security alerts and findings across multiple AWS accounts into a single dashboard?
* **Card 119 (AWS Artifact Compliance):** What is the purpose of AWS Artifact, and how do you access compliance reports and ISO/SOC certifications?
* **Card 120 (AWS Certificate Manager - ACM):** How does ACM automate public and private SSL/TLS certificate provisioning and renewal for CloudFront, ALBs, and APIs?
* **Card 121 (IAM Identity Center / SSO):** How does AWS IAM Identity Center centralize single sign-on access across multiple AWS accounts and enterprise identity providers?
* **Card 122 (Resource Access Manager - RAM):** How does AWS RAM securely share specific AWS resources (like VPC subnets or Transit Gateways) across AWS accounts?
* **Card 123 (AWS Macie Data Security):** How does Amazon Macie use machine learning to discover, classify, and protect sensitive data (like PII) stored in S3?
* **Card 124 (AWS Firewall Manager):** How does Firewall Manager centrally configure WAF rules, Shield protections, and Security Groups across an entire AWS Organization?
* **Card 125 (KMS Key Rotation):** Explain how automatic annual key rotation works for KMS customer managed keys without altering the key ID or re-encrypting existing data.

## Phase 6: Application Integration & Messaging (SQS, SNS, EventBridge, Step Functions)

* **Card 126 (SQS Standard vs FIFO):** Contrast SQS Standard queues (at-least-once delivery, best-effort ordering) with FIFO queues (exactly-once processing, strict ordering per message group).
* **Card 127 (SQS Visibility Timeout):** What is the role of the SQS visibility timeout, and what happens if a worker fails to process a message before it expires?
* **Card 128 (SQS Dead-Letter Queues):** How do SQS DLQs and maxReceiveCount settings isolate poison pill messages that fail processing repeatedly?
* **Card 129 (SNS Pub/Sub Architecture):** How does Amazon SNS fan out messages to multiple subscribers (SQS, Lambda, HTTP endpoints, email) simultaneously?
* **Card 130 (Amazon EventBridge Bus Architecture):** Contrast EventBridge event buses with SNS topics. How do event patterns and custom schemas route events intelligently?
* **Card 131 (Step Functions State Machine Types):** Compare Standard workflows (long-running, durable, exact-once execution history) with Express workflows (high-volume, short-duration, at-least-once execution).
* **Card 132 (SQS Long Polling):** How does SQS long polling (`ReceiveMessageWaitTimeSeconds`) reduce empty response polling costs and latency?
* **Card 133 (SNS Message Filtering):** How do SNS subscription filter policies allow consumers to receive only relevant messages without parsing the entire payload?
* **Card 134 (EventBridge Archive and Replay):** How do EventBridge event archives and replay capabilities assist with debugging and disaster recovery?
* **Card 135 (Step Functions Error Handling):** How do `Retrier` and `Catcher` blocks manage failures and retries natively in Step Functions state machines?
* **Card 136 (Amazon MQ Managed Brokers):** When should you choose Amazon MQ (managed ActiveMQ/RabbitMQ) over native AWS messaging services like SQS/SNS for legacy application migrations?
* **Card 137 (SQS FIFO Message Groups):** How do Message Group IDs in SQS FIFO queues ensure strict ordering for specific entities while allowing parallelism across different groups?
* **Card 138 (Step Functions Distributed Map):** How does the Step Functions Distributed Map state process millions of items in parallel datasets (like S3 object batch processing)?
* **Card 139 (EventBridge Schema Registry):** How does the EventBridge Schema Registry discover and serialize event structures into strongly typed code bindings?
* **Card 140 (SNS FIFO Topics):** How do SNS FIFO topics maintain message ordering when paired with SQS FIFO queues?
* **Card 141 (SQS Delay Queues):** How do SQS delay queues or message-level delivery delays postpone message visibility for specific background processing windows?
* **Card 142 (Step Functions Activity Workers):** What is the role of Step Functions activity workers when orchestrating workflows that execute on on-premises infrastructure or external servers?
* **Card 143 (EventBridge Partner Event Sources):** How do SaaS integrations (like Datadog, Zendesk, Auth0) push events directly into custom EventBridge event buses?
* **Card 144 (SNS Delivery Status Logging):** How do SNS delivery status logs track successful and failed deliveries for HTTP, Lambda, and SQS endpoints?
* **Card 145 (SQS Extended Client Library):** How does the SQS Extended Client Library handle message payloads exceeding the standard 256KB SQS limit using Amazon S3?
* **Card 146 (Step Functions Service Integrations):** How do optimized service integrations in Step Functions call AWS services directly without intermediary Lambda functions?
* **Card 147 (EventBridge Cross-Account Routing):** How do resource-based policies on EventBridge event buses enable secure event routing across separate AWS accounts?
* **Card 148 (SQS Temporary Queues):** What is the pattern for request-response messaging using SQS temporary queues for microservice RPC emulation?
* **Card 149 (Step Functions Express Sagas):** How do Express workflows support high-frequency event streaming and real-time data processing pipelines?
* **Card 150 (Messaging Dead-Letter Architecture Best Practices):** What alerting and alarm monitoring strategies should be paired with DLQs to catch silent data processing failures?

## Phase 7: Management, Governance & Monitoring (CloudWatch, CloudTrail, Systems Manager, CloudFormation)

* **Card 151 (CloudWatch Metrics vs Logs vs Alarms):** Contrast CloudWatch metrics (numerical time-series data), CloudWatch Logs (text/JSON data), and CloudWatch Alarms (automated evaluation thresholds).
* **Card 152 (CloudWatch Metric Filters):** How do CloudWatch log metric filters extract numerical metrics from unstructured log streams for real-time alerting?
* **Card 153 (CloudWatch Synthetics Canaries):** How do CloudWatch Synthetics canaries monitor web applications and API endpoints by running scripted browser tests?
* **Card 154 (CloudWatch Contributor Insights):** How do Contributor Insights analyze log data to identify top talkers, high-traffic IP addresses, or heavy database callers?
* **Card 155 (AWS Systems Manager Parameter Store):** How do SSM parameters store configuration data and secrets with hierarchical paths and encryption?
* **Card 156 (Systems Manager Run Command):** How does SSM Run Command execute scripts and administrative commands across fleet instances without SSH/RDP access?
* **Card 157 (Systems Manager Patch Manager):** How does SSM Patch Manager automate OS-level patch compliance and installation across EC2 and hybrid instances?
* **Card 158 (Systems Manager Session Manager):** How does SSM Session Manager provide secure, audited shell access to EC2 instances without opening inbound port 22/3389?
* **Card 159 (CloudFormation Stack Lifecycle):** Explain CloudFormation stack operations (Create, Update, Delete, Rollback) and how change sets preview modifications safely.
* **Card 160 (CloudFormation Custom Resources):** How do CloudFormation Custom Resources execute custom Lambda logic during stack creation or deletion phases?
* **Card 161 (AWS CDK Architecture):** How does the AWS Cloud Development Kit (CDK) synthesize high-level programming constructs into standard CloudFormation templates?
* **Card 162 (AWS Trusted Advisor):** What five categories of recommendations does AWS Trusted Advisor provide (Cost Optimization, Performance, Security, Fault Tolerance, Service Limits)?
* **Card 163 (AWS Cost Explorer and Budgets):** How do Cost Explorer, Cost Allocation Tags, and AWS Budgets establish cost tracking and proactive anomaly alerting?
* **Card 164 (AWS Control Tower):** How does AWS Control Tower automate multi-account landing zone provisioning with guardrails and account vending?
* **Card 165 (AWS CloudTrail Lake):** How does CloudTrail Lake provide managed data lakes with SQL query capabilities for security auditing and compliance logs?
* **Card 166 (CloudWatch Container Insights):** How does Container Insights collect metrics and logs from ECS, EKS, and Kubernetes clusters?
* **Card 167 (Systems Manager State Manager):** How does SSM State Manager maintain consistent OS configuration states using automated policy documents?
* **Card 168 (CloudFormation Nested Stacks):** How do nested stacks modularize large monolithic CloudFormation templates into reusable component templates?
* **Card 169 (AWS License Manager):** How does License Manager track and enforce software license compliance across hybrid cloud environments?
* **Card 170 (AWS Trusted Advisor Priority):** How does Trusted Advisor Priority surface critical security and cost recommendations tailored to enterprise environments?
* **Card 171 (CloudWatch Logs Retention & Insights):** How do CloudWatch Logs Insights queries use syntax to search and aggregate log events efficiently?
* **Card 172 (Systems Manager Inventory):** How does SSM Inventory collect software metadata and configuration inventories from managed instances?
* **Card 173 (AWS Health Dashboard):** How do Personal Health Dashboard alerts notify engineering teams of underlying AWS infrastructure events affecting their resources?
* **Card 174 (CloudFormation StackSets):** How do CloudFormation StackSets deploy templates across multiple AWS accounts and regions simultaneously?
* **Card 175 (Resource Groups and Tag Editor):** How do resource groups and standardized tagging strategies streamline resource organization and automation?

## Phase 8: Architecture, Cost Optimization & Real-World Troubleshooting Scenarios

* **Card 176 (Lab Scenario A - NAT Gateway Cost Explosion):**
  * *The Setup:* An AWS monthly bill spikes unexpectedly due to high data processing charges from NAT Gateways. CloudWatch metrics show terabytes flowing through private subnets.
  * *The Challenge:* Explain why internal traffic destined for S3 or DynamoDB routed through NAT Gateways incurs data processing fees, and how Gateway VPC Endpoints eliminate this cost.

* **Card 177 (Lab Scenario B - Cross-AZ Data Transfer Latency and Cost):**
  * *The Setup:* A high-throughput microservices architecture deployed across multiple Availability Zones experiences high latency and massive cross-AZ data transfer charges.
  * *The Challenge:* Outline architectural strategies to keep traffic within the same Availability Zone (AZ affinity) and optimize inter-service communication.

* **Card 178 (Lab Scenario C - The Silent Lambda Timeout):**
  * *The Setup:* An asynchronous Lambda function processing S3 events fails silently without completing its work. CloudWatch logs show the invocation ending abruptly at 3 seconds.
  * *The Challenge:* Diagnose how the default 3-year-old or 3-second timeout setting impacts functions, and explain how to configure proper timeouts and async error handling.

* **Card 179 (Lab Scenario D - DynamoDB Provisioned Throughput Throttling):**
  * *The Setup:* A DynamoDB table experiences `ProvisionedThroughputExceededException` errors during flash sales, despite total table capacity appearing sufficient.
  * *The Challenge:* Diagnose hot partition issues caused by poor partition key cardinality and explain how adaptive capacity or sparse GSI design resolves it.

* **Card 180 (Lab Scenario E - ALB 502 Bad Gateway Errors):**
  * *The Setup:* An Application Load Balancer returns HTTP 502 Bad Gateway errors intermittently for requests forwarded to ECS container targets.
  * *The Challenge:* Trace how unhealthy target health checks, mismatched backend port bindings, or container startup delays cause ALB 502 errors.

* **Card 181 (Lab Scenario F - S3 403 Forbidden Access Denied):**
  * *The Setup:* An application attempting to read objects from an encrypted S3 bucket throws `AccessDenied` errors, even though the IAM role has `s3:GetObject` permissions.
  * *The Challenge:* Diagnose missing KMS decryption permissions (`kms:Decrypt`) on the IAM role when accessing S3 buckets encrypted with customer-managed KMS keys.

* **Card 182 (Lab Scenario G - RDS Connection Pool Exhaustion):**
  * *The Setup:* A multi-tier web application crashes during peak traffic with database connection timeout errors. Database CPU utilization is pegged at 100%.
  * *The Challenge:* Explain how unpooled application connections overwhelm RDS backends, and outline architectural fixes using RDS Proxy or connection pooling libraries.

* **Card 183 (Lab Scenario H - VPC Security Group Circular Dependency Trap):**
  * *The Setup:* Two EC2 instances in the same subnet cannot communicate over HTTP, even though both Security Groups reference each other's security group ID.
  * *The Challenge:* Verify whether stateful rules are misconfigured or if network ACL stateless rules are blocking return ephemeral ports.

* **Card 184 (Lab Scenario I - CloudFront Stale Cache Serving):**
  * *The Setup:* Developers deploy a hotfix to an origin web server, but users continue to see the old broken version for hours despite cache invalidation requests.
  * *The Challenge:* Diagnose misconfigured `Cache-Control` max-age headers, incorrect CloudFront invalidation path wildcards, or origin caching layers.

* **Card 185 (Lab Scenario J - ECS Task Infinite Restart Loop):**
  * *The Setup:* An ECS task enters a continuous `PROVISIONING` -> `RUNNING` -> `STOPPED` state loop immediately upon deployment.
  * *The Challenge:* Trace how misconfigured health check commands, missing environment variables, or failing container entrypoints trigger task failure loops.

* **Card 186 (Lab Scenario K - Auto Scaling Thrashing):**
  * *The Setup:* An EC2 Auto Scaling group adds and removes instances continuously every 5 minutes under steady-state load.
  * *The Challenge:* Explain how aggressive scaling metric thresholds and short cooldown periods cause scaling thrashing, and how to tune policies with warmup periods.

* **Card 187 (Lab Scenario L - Route 53 DNS Propagation Delay):**
  * *The Setup:* After updating a Route 53 CNAME record for a database migration, clients continue connecting to the old decommissioned database IP.
  * *The Challenge:* Explain how client-side, ISP, and OS DNS caching of TTL values dictate propagation delay, and how to plan low-TTL migrations.

* **Card 188 (Lab Scenario M - IAM Role Privilege Escalation):**
  * *The Setup:* A security audit reveals that a low-privilege IAM user can attach administrative policies to their own role due to permissive inline policies.
  * *The Challenge:* Identify dangerous IAM permissions (`iam:PassRole`, `iam:CreateAccessKey`, `iam:PutUserPolicy`) and explain how permission boundaries prevent escalation.

* **Card 189 (Lab Scenario N - SQS Duplicate Message Processing):**
  * *The Setup:* An asynchronous worker processing orders from an SQS queue occasionally processes the same order twice, creating duplicate customer billing records.
  * *The Challenge:* Explain why SQS Standard queues guarantee at-least-once delivery, and design idempotency checks using database unique constraints or deduplication IDs.

* **Card 190 (Lab Scenario O - EBS Volume Performance Degradation):**
  * *The Setup:* A database running on an EBS gp2 volume experiences sudden severe performance throttling and high I/O wait times.
  * *The Challenge:* Diagnose burst bucket credit exhaustion on gp2 volumes and explain why migrating to gp3 provides consistent baseline IOPS and throughput.

* **Card 191 (Lab Scenario P - API Gateway CORS Failure):**
  * *The Setup:* A frontend Single Page Application (SPA) hosted on a domain throws browser console errors when calling an API Gateway endpoint due to missing CORS headers.
  * *The Challenge:* Configure correct Access-Control-Allow-Origin, Methods, and Headers on API Gateway mock integrations or backend response headers.

* **Card 192 (Lab Scenario Q - Transit Gateway Asymmetric Routing):**
  * *The Setup:* Traffic passing through a centralized security firewall VPC connected via AWS Transit Gateway drops packets intermittently due to asymmetric routing paths.
  * *The Challenge:* Configure route table propagation and attachment routing rules in Transit Gateway to ensure return traffic traverses the exact same firewall appliance.

* **Card 193 (Lab Scenario R - ElastiCache Redis Out of Memory (OOM)):**
  * *The Setup:* An ElastiCache Redis cluster throws `OOM command not allowed when used memory > 'maxmemory'` errors and rejects write commands.
  * *The Challenge:* Diagnose unconfigured eviction policies (`volatile-lru`, `allkeys-lru`) and explain how to size clusters and monitor memory usage.

* **Card 194 (Lab Scenario S - Lambda Payload Size Exceeded):**
  * *The Setup:* A Lambda function attempting to process a large JSON payload from an API Gateway integration fails with `Payload Too Large` or memory exhaustion errors.
  * *The Challenge:* Redesign the data flow using Amazon S3 pre-signed URLs or SQS reference pointers for payloads exceeding the 6MB Lambda invocation limit.

* **Card 195 (Lab Scenario T - CloudFormation Drift Detection Failure):**
  * *The Setup:* An infrastructure engineer manually modifies an EC2 security group rule out-of-band in the AWS Console, causing CloudFormation stack updates to fail unexpectedly.
  * *The Challenge:* Explain how CloudFormation Drift Detection identifies out-of-band modifications and how to reconcile state files safely.

* **Card 196 (Lab Scenario U - Step Functions Execution History Bloat):**
  * *The Setup:* A Step Functions standard workflow processing large batch payloads fails with history size limit exceeded errors.
  * *The Challenge:* Explain how large state transitions bloat execution history, and redesign workflows to pass data pointers via S3 instead of embedding large payloads in state inputs.

* **Card 197 (Lab Scenario V - SSM Session Manager Connection Failure):**
  * *The Setup:* An administrator attempts to connect to a private EC2 instance via SSM Session Manager, but the connection times out with `TargetNotConnected`.
  * *The Challenge:* Diagnose missing SSM agent services, missing IAM instance profile permissions, or lack of outbound HTTPS access to SSM endpoints via NAT or VPC endpoints.

* **Card 198 (Lab Scenario W - Redshift Slow Query Performance):**
  * *The Setup:* An Amazon Redshift query running analytical reports takes hours to execute, consuming 100% of the cluster query queue slots.
  * *The Challenge:* Diagnose unoptimized table sort keys, distribution styles (`KEY`, `ALL`, `EVEN`), and missing vacuum/analyze maintenance routines.

* **Card 199 (Lab Scenario X - WAF False Positive Blocking):**
  * *The Setup:* An AWS WAF managed rule set blocks legitimate user submissions containing special characters in form inputs, disrupting checkout conversions.
  * *The Challenge:* Explain how to inspect CloudWatch WAF metric logs, identify specific rule match identifiers, and implement rule exclusions or count mode testing.

* **Card 200 (Lab Scenario Y - Multi-Account GuardDuty Alert Fatigue):**
  * *The Setup:* A security team managing 200 AWS accounts in an AWS Organization is overwhelmed by thousands of low-priority GuardDuty findings across member accounts.
  * *The Challenge:* Configure GuardDuty delegated administrator accounts, cross-account finding aggregation, and automated suppression rules to filter false positives.