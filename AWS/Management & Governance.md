# AWS Management & Governance

## Monitoring

* **CloudWatch Metrics, Logs & Alarms:** Contrast metrics (time series with dimensions), logs, and alarms. What are high-resolution metrics, the embedded metric format, and composite alarms for?
* **Metric Filters & Logs Insights:** How do metric filters turn log patterns into metrics for alarms, and how do Logs Insights queries search and aggregate logs (`fields`, `filter`, `stats`)?

## Systems Manager

* **Systems Manager Toolbox:** What do Run Command, Patch Manager, State Manager, Inventory, Automation, and Parameter Store each do, and what does the SSM Agent need to work (an instance profile, a network path to the SSM endpoints)?
* **Lab — Session Manager TargetNotConnected:**
  * *Setup:* An admin tries to open a Session Manager shell on a private instance and gets `TargetNotConnected`.
  * *Challenge:* Explain why Session Manager needs no inbound ports or bastion host, then check the SSM Agent, the instance profile (`AmazonSSMManagedInstanceCore`), and outbound HTTPS to the `ssm`, `ssmmessages`, and `ec2messages` endpoints via NAT or VPC endpoints.

## CloudFormation & CDK

* **Stack Lifecycle & Change Sets:** Explain stack create, update, delete, and rollback. How do change sets preview replacements, and why do some property changes replace resources? How do `DeletionPolicy` and stack policies protect data?
* **Custom Resources:** How do custom resources run Lambda code during stack create, update, and delete, and what happens if the function never responds?
* **Nested Stacks vs StackSets:** Contrast nested stacks (modularizing one deployment) with StackSets (deploying the same template across many accounts and regions).
* **CDK:** How does the CDK synthesize constructs (L1, L2, L3) into CloudFormation templates, and what do `cdk diff` and bootstrapping do?
* **Lab — Drift Breaks a Stack Update:**
  * *Setup:* Someone manually changed a security group rule in the console, and the next CloudFormation update fails.
  * *Challenge:* Run drift detection, decide whether to bring the change into the template or revert it, and prevent console changes with permissions/SCPs and pipelines.

## Accounts & Cost

* **Control Tower & Landing Zones:** How does Control Tower set up a multi-account landing zone with controls (preventive SCPs, detective Config rules) and account vending?
* **Cost Management:** How do Cost Explorer, cost allocation tags, AWS Budgets, and Cost Anomaly Detection give visibility and early warning on spend? What does Trusted Advisor add?

## Study Guide

* **Books:**
  * *Infrastructure as Code* (Kief Morris): the parts on stacks, making changes safely, testing infrastructure and configuration drift, the tool-neutral ideas behind CloudFormation and CDK.
  * *Amazon Web Services in Action* (Andreas Wittig & Michael Wittig): the chapters on automating infrastructure with CloudFormation and monitoring with CloudWatch.
  * *Site Reliability Engineering* (Betsy Beyer, Chris Jones, Jennifer Petoff & Niall Richard Murphy, eds.): the chapter on monitoring distributed systems, for what to measure and when to alert.
  * *Cloud FinOps* (J.R. Storment & Mike Fuller): the parts on cost allocation, tagging, budgets and anomaly detection.
* **Official docs:** the Amazon CloudWatch User Guide (metrics, alarms, composite alarms, embedded metric format) and CloudWatch Logs User Guide (metric filters, Logs Insights query syntax), the AWS Systems Manager User Guide (Session Manager setup and troubleshooting, VPC endpoints for Systems Manager), the AWS CloudFormation User Guide (change sets, update behaviors of stack resources, `DeletionPolicy`, custom resources, StackSets, drift detection), the AWS CDK Developer Guide (constructs, bootstrapping), the AWS Control Tower User Guide, the AWS Cost Management docs, and the Operational Excellence and Cost Optimization pillars of the Well-Architected Framework.
* **Related technologies:** compare Terraform/OpenTofu and Pulumi (CloudFormation and CDK), Azure Bicep and Azure Policy, Azure Monitor and Google Cloud Monitoring, Prometheus and Grafana (CloudWatch), and Ansible (fleet management like Systems Manager).
* **Search for:** `CloudFormation update requires replacement`, `CloudFormation custom resource timeout`, `cdk bootstrap`, `CloudFormation drift detection`, `Session Manager TargetNotConnected`, `CloudWatch embedded metric format`, `CloudWatch composite alarms`, `Logs Insights stats`, `Control Tower Account Factory`, `cost allocation tags`.
* **Hands-on:** deploy a small CloudFormation stack (a security group and an S3 bucket with `DeletionPolicy: Retain`), change a rule in the console, run drift detection, then preview a property change with a change set and see which changes show `Replacement: True`.
