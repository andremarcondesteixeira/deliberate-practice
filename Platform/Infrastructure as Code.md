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

## Study Guide

* **Books:**
  * *Terraform: Up & Running* (Yevgeniy Brikman): the chapters on managing state, modules, production-grade code and working as a team, which cover the whole Terraform section.
  * *Infrastructure as Code* (Kief Morris): the parts on core practices, stacks, server images and delivery pipelines, for declarative vs imperative, immutable servers, golden images and drift.
  * *Ansible for DevOps* (Jeff Geerling): the early chapters on playbooks and the later ones on testing, for idempotency and where configuration management still fits.
  * *Cloud FinOps* (J.R. Storment & Mike Fuller): the chapters on cost allocation, tagging and optimization, for the FinOps card.
* **Official docs:** the Terraform docs on state, state locking, the S3 backend (`use_lockfile`), sensitive data in state, `import` blocks and module development; the OpenTofu docs (including state encryption); the AWS CloudFormation docs on drift detection; the Packer docs on templates and provisioners; the Ansible docs on check mode and diff mode; the OPA, Conftest and Checkov docs; the FinOps Foundation's FinOps Framework.
* **Related technologies:** OpenTofu, Pulumi, AWS CDK, Crossplane, Terragrunt, Atlantis and Spacelift for pull-request-driven applies, Infracost, cloud-init, EC2 Image Builder, and Chef and Puppet as other configuration management tools.
* **Search for:** `terraform state locking`, `terraform s3 use_lockfile`, `terraform import block`, `terraform workspaces vs separate state`, `phoenix server`, `snowflake server`, `bake vs fry ami`, `conftest terraform plan json`.
* **Hands-on:** create a resource with Terraform, change it by hand in the console or CLI and read the plan that shows the drift; then create a second resource by hand and bring it under management with an `import` block without recreating it.
