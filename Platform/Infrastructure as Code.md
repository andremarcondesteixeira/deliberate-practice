# Infrastructure as Code

## Principles

* **Declarative vs Imperative IaC:** Contrast declarative tools (Terraform, CloudFormation) with imperative scripts (Bash, CLI calls) regarding desired-state convergence, idempotency, and drift.
* **CloudFormation vs Terraform vs Pulumi/CDK:** Compare a cloud-native service with managed state (CloudFormation), HCL with self-managed state (Terraform/OpenTofu), and general-purpose languages (Pulumi, CDK).
* **Immutable Infrastructure:** Why does replacing servers instead of patching them in place remove configuration drift, snowflake servers, and attacker persistence? What does it require from the delivery pipeline?
* **Golden Images:** How does Packer bake dependencies into machine images, and how do you balance baking at build time against configuring at boot (cloud-init)?
* **Configuration Management & Idempotency:** How does Ansible achieve idempotency so repeated runs converge to the same state? How do configuration management tools detect manual drift, and where do they still fit in an immutable world?

## Terraform

* **State & Locking:** Why does team Terraform need remote state with locking? How does the S3 backend lock (native S3 lockfile since Terraform 1.10; DynamoDB before that, now deprecated), and what happens if two applies run concurrently without a lock?
* **State Secrets:** Why can Terraform state contain plaintext secrets even when variables are marked `sensitive`, and how do you protect it?
* **Plan & Drift:** How does `terraform plan` detect differences between code, state, and real resources? How do you handle drift that shows up in a plan?
* **Modules:** How do you design reusable modules (small interfaces, versioning, no provider configuration inside, composition over deep nesting) for many teams?
* **Environment Isolation:** Compare workspaces with separate directories/state per environment. Why do many teams avoid workspaces for separating prod from dev?
* **Importing Existing Resources:** How do `terraform import` and `import` blocks bring unmanaged resources under management without recreating them?

## Governance

* **Policy as Code & IaC Scanning:** How do OPA/Conftest, Sentinel, Checkov, or tfsec check plans and manifests for security and compliance problems before apply?
* **FinOps:** How do tagging policies, cost allocation per team/service/namespace, budgets, automatic shutdown of non-prod resources, and spot capacity tie cloud spend to business value?
* **Lab — Golden Image Drift:**
  * *Setup:* An auto scaling group launches new instances that fail to boot because someone manually changed the base image out of band.
  * *Challenge:* Redesign the image pipeline: images built only by Packer in CI from versioned code, tested before promotion, immutable once published, with launch templates pointing at explicit versions.
