# Kubernetes Practice

## Phase 1: Architecture & Control Plane

* **Card 1 (API Server Role):** What are the primary responsibilities of the `kube-apiserver`, and how does it interact with `etcd`?
* **Card 2 (etcd Consistency):** Explain how `etcd` uses the Raft consensus algorithm to handle split-brain scenarios and leader election.
* **Card 3 (Kube-Scheduler Mechanics):** Deconstruct the two-phase scheduling cycle in `kube-scheduler`: **Scheduling Queue/Filtering (Predicates)** and **Scoring (Priorities)**.
* **Card 4 (Kubelet Lifecycle):** What is the exact loop execution flow of the `kubelet` when syncing pod specs from the API server with node runtimes?
* **Card 5 (Kube-Proxy Modes):** Compare `iptables` mode versus `IPVS` mode in `kube-proxy`. Under what scale conditions does IPVS become mandatory?
* **Card 6 (Control Plane High Availability):** How do you configure an external multi-node `etcd` cluster alongside stacked control plane nodes for true HA?
* **Card 7 (Garbage Collection):** Explain how the Kubernetes garbage collector handles cascading deletions and owner references for orphan resources.
* **Card 8 (Dynamic Admission Control):** Differentiate between `ValidatingWebhookConfiguration` and `MutatingWebhookConfiguration`. What happens if a webhook times out?
* **Card 9 (CRDs vs Aggregated APIs):** When should you build a Custom Resource Definition (CRD) versus an Aggregated API Server?
* **Card 10 (Node Condition Taints):** What triggers the `node.kubernetes.io/unreachable` taint, and how does the node lifecycle controller evict pods?

## Phase 2: Workloads, Pods & Lifecycle

* **Card 11 (Pod Ephemerality):** Why share a network and IPC namespace inside a Pod? Give an architectural use case for sidecar containers.
* **Card 12 (Container Lifecycle Hooks):** Compare `postStart` and `preStop` hooks. What is the execution blocking behavior and failure impact of each?
* **Card 13 (Probes Deep Dive):** Contrast `livenessProbe`, `readinessProbe`, and `startupProbe`. Why can misconfigured startup probes cause cascading restart loops?
* **Card 14 (Deployment Strategies):** Compare `RollingUpdate` and `Recreate` strategies. How do `maxSurge` and `maxUnavailable` parameters control rolling deployments?
* **Card 15 (DaemonSet Scheduling):** How do DaemonSets bypass the standard scheduler, and how do they interact with node taints and tolerations?
* **Card 16 (StatefulSet Guarantees):** What are the four specific guarantees provided by StatefulSets regarding network identities and storage persistence?
* **Card 17 (Job vs CronJob):** How does a Kubernetes `Job` handle pod failures, backoff limits, and completion modes (`Indexed` vs `NonIndexed`)?
* **Card 18 (Pod Disruption Budgets):** Explain the difference between `minAvailable` and `maxUnavailable` in a PDB during voluntary node drains.
* **Card 19 (Init Containers):** What happens if an init container fails repeatedly in a Pod specification? How does it affect restart policies?
* **Card 20 (Ephemeral Containers):** What are Ephemeral Containers used for, and why can you not add them to an existing running pod without debugging privileges?

## Phase 3: Networking, Services & Ingress

* **Card 21 (CNI Plugins):** Explain how Container Network Interface (CNI) plugins (like Calico or Cilium) allocate IP addresses and manage node-to-node encapsulation (VXLAN vs BGP).
* **Card 22 (Service Types):** Compare `ClusterIP`, `NodePort`, `LoadBalancer`, and `ExternalName`. How does traffic route from client to container for each?
* **Card 23 (Headless Services):** What defines a Headless Service (`clusterIP: None`), and how do DNS resolution records differ for it compared to standard services?
* **Card 24 (Network Policies):** By default, how do Kubernetes NetworkPolicies behave? Explain ingress and egress rule isolation mechanics.
* **Card 25 (Ingress Controllers):** How does an Ingress Controller decouple routing rules from Services? Explain how path-based and host-based routing work under the hood.
* **Card 26 (Gateway API):** Contrast the Kubernetes Gateway API (`Gateway`, `HTTPRoute`) with traditional Ingress resources. Why was Gateway API introduced?
* **Card 27 (DNS Resolution & ndots):** Explain how container DNS resolution works via `CoreDNS`. What is the performance impact of high `ndots` settings in `/etc/resolv.conf`?
* **Card 28 (Service Mesh Sidecars):** How do service meshes (like Istio or Linkerd) inject sidecars to intercept traffic using `iptables` and eBPF?
* **Card 29 (EndpointSlices):** Why were `EndpointSlices` introduced to replace legacy `Endpoints` in large clusters with thousands of pods per service?
* **Card 30 (IPv4/IPv6 Dual-Stack):** How do you configure dual-stack networking in Kubernetes, and how does `clusterIP` allocation function for dual-stack services?

## Phase 4: Storage, StatefulSets & Configs

* **Card 31 (Storage Architecture):** Explain the separation of concerns between `PersistentVolume` (PV), `PersistentVolumeClaim` (PVC), and `StorageClass` (SC).
* **Card 32 (Access Modes):** Compare `RWO` (ReadWriteOnce), `ROX` (ReadOnlyMany), `RWX` (ReadWriteMany), and `RWOP` (ReadWriteOncePod).
* **Card 33 (Dynamic Provisioning):** What is the role of the external provisioner controller in dynamic volume provisioning?
* **Card 34 (Volume Expansion):** How does online volume expansion (`allowVolumeExpansion: true`) work without restarting pods, and what are cloud provider limitations?
* **Card 35 (ConfigMaps vs Secrets):** Contrast mounting ConfigMaps/Secrets as environment variables versus file volumes. How does dynamic reloading differ between the two?
* **Card 36 (Secrets Encryption at Rest):** How do you configure encryption providers for `etcd` secrets data at rest using AES-CBC or KMS plugins?
* **Card 37 (Ephemeral Storage Limits):** How does Kubernetes manage ephemeral local storage (`emptyDir`, logs, scratch space) and enforce node eviction thresholds?
* **Card 38 (CSI Driver Architecture):** Explain the Container Storage Interface (CSI) sidecars: `node-driver-registrar`, `external-provisioner`, and `external-attacher`.
* **Card 39 (Volume Snapshotting):** How do `VolumeSnapshot`, `VolumeSnapshotContent`, and `VolumeSnapshotClass` enable backup and restore workflows?
* **Card 40 (SubPath Mounts):** What are the caveats and gotchas when mounting ConfigMaps or Volumes using `subPath` regarding file updates and inode synchronization?

## Phase 5: Security, RBAC & Policies

* **Card 41 (Authentication Mechanisms):** What are the core authentication modules built into the Kubernetes API server (X509 certs, Bearer Tokens, OIDC, Service Account tokens)?
* **Card 42 (RBAC Hierarchy):** Differentiate between `Role`, `ClusterRole`, `RoleBinding`, and `ClusterRoleBinding`. How do aggregation rules work on ClusterRoles?
* **Card 43 (ServiceAccount Tokens):** Explain projected service account tokens and token volume projection security improvements over static tokens.
* **Card 44 (Pod Security Standards):** Compare the three Pod Security Standards levels: `Privileged`, `Baseline`, and `Restricted`. What fields does Restricted disallow?
* **Card 45 (Security Contexts):** How do `runAsNonRoot`, `readOnlyRootFilesystem`, and `allowPrivilegeEscalation` secure container execution at the kernel level?
* **Card 46 (Network Policies & Egress Filtering):** How do you restrict egress traffic from a namespace to specific external IP CIDRs and ports using NetworkPolicies?
* **Card 47 (OPA Gatekeeper / Kyverno):** How do policy engines like Kyverno or OPA Gatekeeper validate and mutate incoming Kubernetes manifests via admission webhooks?
* **Card 48 (Secret Management Externalizers):** How do tools like External Secrets Operator or HashiCorp Vault sync external secrets securely into Kubernetes secrets?
* **Card 49 (Kernel Capabilities):** How do you drop default Linux capabilities (`ALL`) and selectively add back required capabilities (e.g., `NET_BIND_SERVICE`) in a Pod?
* **Card 50 (API Request Auditing):** How do you configure Kubernetes audit logging policies to capture metadata vs request body payloads for security compliance?

## Phase 6: Advanced Troubleshooting & Edge Cases

* **Lab Scenario A (The CrashLoopBackOff Mystery):**
  * *The Setup:* A critical application pod enters a continuous `CrashLoopBackOff` state immediately after a node reboot. `kubectl describe pod` shows exit code 137.
  * *The Challenge:* Diagnose the root cause of exit code 137, identify whether it was OOMKilled or SIGKILLed, and trace how to inspect container logs from the underlying CRI runtime (containerd/CRI-O).

* **Lab Scenario B (The Silent Network Partition):**
  * *The Setup:* Pods on Node A cannot communicate with pods on Node B. `kubectl get nodes` shows both nodes as Ready, but TCP connections time out across nodes.
  * *The Challenge:* Outline the diagnostic commands to inspect CNI interface status, bridge routing tables, `iptables`/`ipvs` rules, and MTU mismatch issues across worker nodes.

* **Lab Scenario C (The Etcd Quorum Loss):**
  * *The Setup:* Following a power outage in a bare-metal cluster, the API server returns `connection refused` and cluster components fail to start.
  * *The Challenge:* Detail the exact disaster recovery steps to check etcd cluster health, inspect member lists, restore an etcd snapshot, and re-establish quorum.

* **Lab Scenario D (The Stuck Terminating Namespace):**
  * *The Setup:* A namespace remains stuck in the `Terminating` state for hours because finalizers on custom resources fail to clear.
  * *The Challenge:* Explain how to locate blocking finalizers using `kubectl api-resources`, clear finalizers via raw API proxy (`kubectl proxy`), and force-delete the namespace safely.

* **Lab Scenario E (The DNS Resolution Latency Spike):**
  * *The Setup:* Application pods experience intermittent 5-second DNS lookup delays when querying external databases or internal cluster services.
  * *The Challenge:* Trace how CoreDNS concurrency limits, `ndots` search path expansion, and Linux kernel conntrack table saturation (`nf_conntrack: table full`) combine to cause this latency.