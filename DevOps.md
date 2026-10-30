# DevOps, Platform Engineering & SRE Practice (100 Challenges)

## Phase 1: CI/CD Pipelines & Version Control Workflows (1–15)

* **Card 1 (Trunk-Based Development vs GitFlow):** Contrast Trunk-Based Development (frequent short-lived branches merged directly to main) with GitFlow regarding release velocity and integration friction.
* **Card 2 (CI Pipeline Stage Anatomy):** What is the standard execution sequence of a mature CI pipeline (Lint, Unit Test, Build, Integration Test, Security Scan)?
* **Card 3 (Artifact Registries & Versioning):** How do immutable artifact repositories (Nexus, Artifactory, GitHub Packages) manage versioned build outputs using Semantic Versioning (SemVer)?
* **Card 4 (CI Runner Caching Strategies):** How do you configure runner caches for dependency directories (`node_modules`, `.m2`, `vendor`) to accelerate pipeline execution times?
* **Card 5 (Matrix Builds & Parallelization):** How do matrix build strategies test software across multiple OS, architecture, and runtime language versions simultaneously?
* **Card 6 (Branch Protection & Pull Request Rules):** How do branch protection rules (required status checks, code owners, review counts) enforce quality gates before merging?
* **Card 7 (Semantic Release Automation):** How do commit message conventions (Conventional Commits) automate version bumping and changelog generation?
* **Card 8 (Deterministic and Reproducible Builds):** What practices ensure a build is reproducible (pinning dependencies, locking lockfiles, containerized build environments)?
* **Card 9 (Ephemeral Build Environments):** How do dynamic ephemeral environments (review apps) spin up per pull request for isolated integration testing?
* **Card 10 (Pipeline-as-Code Patterns):** What are the benefits of defining CI/CD pipelines as code (`.github/workflows`, `.gitlab-ci.yml`) stored directly within the repository?
* **Card 11 (Flaky Test Quarantine):** How do platforms handle non-deterministic "flaky" tests to prevent false pipeline failures without disabling test suites entirely?
* **Card 12 (Webhook Security & Pipeline Triggers):** How do repository webhooks authenticate and trigger secure external build pipelines?
* **Card 13 (Zero-Downtime Deployment Topologies):** Contrast Blue-Green deployments (instant traffic switch) with Canary releases (gradual percentage traffic shift).
* **Card 14 (Automated Rollback Triggers):** How do deployment pipelines automatically roll back releases upon detecting error rate spikes or latency degradation?
* **Card 15 (Pipeline Observability and Metrics):** What key metrics (lead time for changes, deployment frequency, mean time to recovery - MTTR, change failure rate) define DORA metrics in CI/CD?

## Phase 2: Infrastructure as Code (IaC) & Immutable Infrastructure (16–30)

* **Card 16 (Declarative vs Imperative IaC):** Contrast declarative IaC (Terraform, CloudFormation) with imperative scripting (Bash, AWS CLI scripts) regarding desired-state convergence.
* **Card 17 (Terraform State Management & Locking):** Why is remote state storage with distributed locking (S3 + DynamoDB) mandatory for team-based Terraform workflows?
* **Card 18 (Terraform Modules Reusability):** How do modularized Terraform configurations enforce enterprise compliance and DRY infrastructure definitions?
* **Card 19 (Terraform Plan & Drift Detection):** How do execution plans (`terraform plan`) and drift detection commands identify discrepancies between actual cloud resources and state definitions?
* **Card 20 (Ansible Configuration Management & Idempotency):** How does Ansible achieve idempotency so that running a playbook multiple times produces identical target state without unintended side effects?
* **Card 21 (Immutable Infrastructure Philosophy):** Why does replacing servers entirely rather than in-house patching eliminate configuration drift and "snowflake" server vulnerabilities?
* **Card 22 (Golden Images & Packer):** How do automated AMI/VM image builders (HashiCorp Packer) bake pre-configured dependencies into immutable machine images?
* **Card 23 (Cloud-Init and Server Bootstrapping):** How do cloud-init scripts configure user accounts, SSH keys, and initial startup commands during cloud instance provisioning?
* **Card 24 (State File Security & Sensitive Outputs):** Why do Terraform state files pose security risks when containing plaintext secrets, and how do you protect sensitive outputs?
* **Card 25 (Importing Existing Infrastructure):** How does `terraform import` bring unmanaged cloud resources under IaC management without recreating them?
* **Card 26 (Workspace vs Directory Environment Isolation):** Compare Terraform workspaces with directory-based multi-environment separation (`dev`/`staging`/`prod`).
* **Card 27 (Policy-as-Code with OPA):** How do Open Policy Agent (OPA) or Sentinel validate IaC plans against security and compliance rules before deployment?
* **Card 28 (FinOps Automation via IaC):** How do IaC tags, automated resource tagging policies, and TTL auto-termination scripts enforce cloud cost governance?
* **Card 29 (Zero-Touch Provisioning - ZTP):** How do automated boot-strapping mechanisms provision bare-metal data center servers without manual intervention?
* **Card 30 (CloudFormation vs Terraform vs Pulumi):** Contrast cloud-native CloudFormation, HCL-based Terraform, and general-purpose programming languages in Pulumi for IaC.

## Phase 3: Containerization & Orchestration (Docker & Kubernetes) (31–50)

* **Card 31 (Container Multi-Stage Builds):** How do multi-stage Dockerfiles reduce final production image sizes by stripping out build-time compilers and dependencies?
* **Card 32 (OCI Standards & Runtimes):** What is the Open Container Initiative (OCI), and how do runtimes like `containerd` and CRI-O execute container images?
* **Card 33 (Docker Layer Caching Optimization):** How does instruction ordering in a Dockerfile maximize layer caching efficiency during frequent code changes?
* **Card 34 (Kubernetes Control Plane Architecture):** Deconstruct the core Kubernetes control plane components: API Server, `etcd`, Scheduler, and Controller Manager.
* **Card 35 (Pod Architecture & Shared Namespaces):** Why are Pods the atomic unit of scheduling in Kubernetes, and what namespaces (network, IPC, UTS) do containers within a Pod share?
* **Card 36 (Deployments vs StatefulSets vs DaemonSets):** Contrast stateless Deployments with StatefulSets (stable network IDs/persistent storage) and DaemonSets (node-level agents).
* **Card 37 (Kubernetes Service Types):** Compare ClusterIP (internal), NodePort (static port on nodes), and LoadBalancer (cloud provider integration) service types.
* **Card 38 (Ingress Controllers & Gateway API):** How do Ingress Controllers and modern Gateway APIs manage external HTTP/HTTPS routing, TLS termination, and path mapping?
* **Card 39 (Persistent Volumes & Claims):** How do PersistentVolumes (PV), PersistentVolumeClaims (PVC), and StorageClasses decouple storage provisioning from Pod lifecycles?
* **Card 40 (ConfigMaps and Secrets Management):** How do ConfigMaps and Secrets inject non-sensitive configuration and encrypted credentials into container files or environment variables?
* **Card 41 (Helm Charts & Package Management):** How do Helm charts parameterize Kubernetes manifests for versioned application packaging and release management?
* **Card 42 (Kustomize Overlays):** How does Kustomize manage declarative customization of Kubernetes manifests without templating engines?
* **Card 43 (NetworkPolicies for Isolation):** How do Kubernetes NetworkPolicies enforce micro-segmentation and firewall rules between Pod namespaces?
* **Card 44 (RBAC & ServiceAccounts):** How do ClusterRoles, Roles, RoleBindings, and ServiceAccounts enforce least-privilege access control within the cluster?
* **Card 45 (Liveness, Readiness & Startup Probes):** How do health probes prevent routing traffic to crashing containers (`readiness`) or restart deadlocked applications (`liveness`)?
* **Card 46 (Horizontal Pod Autoscaler - HPA):** How does the HPA dynamically scale Pod replicas based on CPU utilization or custom Prometheus metrics?
* **Card 47 (Cluster Autoscaling & Node Pools):** How do cluster autoscalers provision new cloud worker nodes when pending pods lack cluster compute resources?
* **Card 48 (Cordon, Drain and Eviction):** How do `kubectl cordon` and `kubectl drain` safely evacuate workloads from worker nodes during maintenance?
* **Card 49 (Custom Resource Definitions - CRDs):** How do CRDs and custom Operators extend the Kubernetes API to manage custom domain-specific resources?
* **Card 50 (Service Mesh Architecture):** How do service meshes (Istio, Linkerd) handle mTLS, traffic splitting, and distributed tracing via sidecar proxies?

## Phase 4: Observability: Logging, Metrics & Tracing (51–65)

* **Card 51 (The Three Pillars of Observability):** Deconstruct the foundational pillars: Metrics (numerical aggregations), Logs (discrete events), and Traces (request journeys).
* **Card 52 (Prometheus Pull-Based Scraping):** Why does Prometheus use a pull-based scraping model over push architectures, and how does service discovery locate targets?
* **Card 53 (PromQL Time-Series Querying):** How do PromQL range vectors (`rate()`, `increase()`, `histogram_quantile()`) aggregate metrics over time?
* **Card 54 (Grafana Dashboard Best Practices):** How do you design high-performance Grafana dashboards using variables, templating, and appropriate visualization types?
* **Card 55 (Structured Logging Formats):** Why are plaintext logs inferior to structured JSON logging regarding machine parsing and query indexing?
* **Card 56 (Centralized Logging Architectures):** Contrast log aggregation pipelines (e.g., FluentBit -> Kafka -> Grafana Loki / Elasticsearch).
* **Card 57 (Distributed Tracing & OpenTelemetry):** How does OpenTelemetry standardize trace context propagation across asynchronous service boundaries using W3C Trace Context headers?
* **Card 58 (Spans, Trace IDs, and Baggage):** What are Trace IDs and Spans, and how does baggage carry contextual metadata across downstream RPC calls?
* **Card 59 (SLIs, SLOs and Error Budgets):** Define Service Level Indicators (SLIs), Service Level Objectives (SLOs), and how Error Budgets balance feature velocity with reliability.
* **Card 60 (Alert Fatigue & Routing Rules):** How do PagerDuty or Alertmanager routing trees, grouping, and silencing rules prevent alert fatigue for on-call engineers?
* **Card 61 (Synthetic Monitoring & Blackbox Probing):** How do synthetic transactions and blackbox probes validate end-user functionality from external vantage points?
* **Card 62 (Production Profiling & Flamegraphs):** How do continuous profilers (`pprof`) generate CPU and memory flamegraphs to pinpoint hot code paths?
* **Card 63 (Log Retention & Cold Storage Tiering):** How do organizations balance hot search storage costs with cold S3 object storage tiering for long-term log compliance?
* **Card 64 (High-Cardinality Metric Explosion):** What causes cardinality explosions in Prometheus (e.g., indexing raw user IDs), and how do metric relabeling rules prevent memory crashes?
* **Card 65 (RUM vs Synthetic APM):** Contrast Real-User Monitoring (RUM) capturing actual client browser performance with synthetic transaction monitoring.

## Phase 5: Configuration & Secret Management (66–80)

* **Card 66 (Externalized Configuration Patterns):** Why must configuration be strictly decoupled from application binaries according to 12-Factor App principles?
* **Card 67 (Environment Variables vs Config Files):** What are the security limitations of passing secrets via OS environment variables (visible in process lists) compared to files?
* **Card 68 (HashiCorp Vault Architecture):** How does Vault manage dynamic secrets, lease expirations, and secure token authentication?
* **Card 69 (Dynamic Database Credentials):** How do platforms issue ephemeral, time-bounded database credentials via Vault database secrets engines?
* **Card 70 (Automated Secret Rotation):** How do event-driven webhooks or scheduled jobs rotate long-lived database passwords and API tokens without downtime?
* **Card 71 (Encryption at Rest and in Transit):** How do KMS keys protect stored secrets, and how does TLS enforce security in transit?
* **Card 72 (Sealed Secrets in Kubernetes):** How do Bitnami SealedSecrets allow safe storage of encrypted secrets inside public Git repositories?
* **Card 73 (External Secrets Operator - ESO):** How does ESO synchronize external secret managers (AWS Secrets Manager, Vault) directly into Kubernetes Secret objects?
* **Card 74 (Principal of Least Privilege for Secrets):** How do fine-grained IAM roles and policies restrict service account access exclusively to required secrets?
* **Card 75 (Auditing Secret Access):** How do audit logging pipelines monitor who requested or accessed sensitive credentials and when?
* **Card 76 (Configuration Drift Detection):** How do config management tools detect out-of-band manual modifications to server configurations?
* **Card 77 (Feature Flag Management):** How do feature flag platforms (LaunchDarkly, Unleash) decouple code deployments from feature releases?
* **Card 78 (Environment-Specific Overlays):** How do configuration overlays manage environment-specific differences across development, staging, and production?
* **Card 79 (Immutable Runtime Configuration):** Why should runtime configuration be read-only once an application container boots up?
* **Card 80 (Multi-Region Secret Synchronization):** How do global applications replicate and sync encrypted secrets securely across multiple cloud regions?

## Phase 6: SRE, GitOps & DevSecOps (81–100)

* **Card 81 (Site Reliability Engineering Principles):** What are Ben Treynor's core SRE tenets: embracing risk, service level objectives, eliminating toil, and monitoring?
* **Card 82 (Toil Reduction & Automation):** How do SREs distinguish engineering work from "toil" (manual, repetitive, tactical operations) and automate it away?
* **Card 83 (Blameless Post-Mortems):** How do blameless post-mortems analyze root causes of outages without assigning personal fault, fostering system resilience?
* **Card 84 (Chaos Engineering Principles):** How do Chaos Engineering tools (Chaos Mesh, Gremlin) inject controlled failures to test system resilience in production?
* **Card 85 (GitOps Philosophy):** What is GitOps? Why is Git established as the single source of truth for declarative infrastructure and application states?
* **Card 86 (ArgoCD / FluxCD Reconciliation Loops):** How do GitOps operators reconcile actual cluster state against the desired state stored in Git repositories?
* **Card 87 (Drift Detection in GitOps):** How do GitOps tools alert engineers when manual `kubectl` edits cause live cluster state to drift from Git?
* **Card 88 (Static Application Security Testing - SAST):** How do SAST tools scan source code repositories for vulnerabilities (SQLi, hardcoded keys) during CI builds?
* **Card 89 (Software Composition Analysis - SCA):** How do SCA tools scan third-party dependencies and transitive libraries for known CVE vulnerabilities?
* **Card 90 (Container Image Vulnerability Scanning):** How do tools like Trivy or Grype scan container layers and OS packages for security exploits before deployment?
* **Card 91 (Dynamic Application Security Testing - DAST):** How do DAST scanners perform black-box penetration testing against running web applications?
* **Card 92 (Secret Scanning in Source Control):** How do pre-commit hooks and repository scanners (Gitleaks) prevent committing private keys or API tokens?
* **Card 93 (Supply Chain Security - SLSA):** What is the Supply-chain Levels for Software Artifacts (SLSA) framework, and how does it secure build provenance?
* **Card 94 (Container Image Signing - Cosign):** How do cryptographic signatures (Sigstore Cosign) verify container image integrity before cluster admission?
* **Card 95 (Progressive Delivery with Argo Rollouts):** How do progressive delivery controllers coordinate automated canary promotions and metric-based analysis?
* **Card 96 (Disaster Recovery Metrics - RTO and RPO):** Contrast Recovery Time Objective (RTO) with Recovery Point Objective (RPO) in disaster recovery planning.
* **Card 97 (Chaos Testing Node Failures):** How do you simulate sudden cloud worker node termination to verify Kubernetes pod rescheduling resilience?
* **Card 98 (Incident Response Playbooks):** What constitutes an effective incident response playbook, escalation ladder, and bridge command structure?
* **Card 99 (FinOps Integration in Deployments):** How do cloud cost attribution tools track spending per microservice, namespace, or team tag?
* **Card 100 (Lab Scenario - The GitOps Outage Remediation):**
  * *The Setup:* A hotfix pushed directly to a production Kubernetes cluster via `kubectl edit` causes a crash loop. Ten minutes later, automated GitOps synchronization overwrites the manual fix with a broken manifest from Git.
  * *The Challenge:* Explain how GitOps controllers enforce single-source-of-truth convergence, and outline the proper workflow for reverting broken state via Git rather than hotfixing live clusters.