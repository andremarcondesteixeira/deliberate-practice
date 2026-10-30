# Kubernetes

## Control Plane

* **Control Plane Components:** Deconstruct the control plane: API server, etcd, scheduler, and controller manager. Why does every component talk only to the API server, and how do watches drive reconciliation?
* **etcd Topology & Quorum:** Compare stacked etcd with an external etcd cluster for HA. Why run 3 or 5 members, what happens when quorum is lost, and why does disk latency matter so much?
* **Scheduler:** Walk through the scheduling cycle: filtering (resources, taints, affinity, topology spread) and scoring. Why do requests, not limits, drive scheduling?
* **Kubelet:** What does the kubelet's sync loop do: watch pod specs, call the CRI runtime, run probes, report status, and evict pods under node pressure?
* **kube-proxy Modes:** Compare `iptables`, `IPVS`, and `nftables` modes. Why does `iptables` mode degrade with thousands of Services, and how do eBPF dataplanes (Cilium) replace kube-proxy entirely?
* **Garbage Collection & Owner References:** How do owner references drive cascading deletion (foreground, background, orphan)?
* **Admission Control & Policy Engines:** Contrast mutating and validating admission webhooks. What happens when a webhook times out (`failurePolicy`), and how do Kyverno, OPA Gatekeeper, and `ValidatingAdmissionPolicy` (CEL) enforce policies?
* **CRDs vs Aggregated APIs:** When is a CRD enough, and when do you need an aggregated API server?
* **Operators:** How does the operator pattern encode operational knowledge in a reconcile loop over custom resources? Why must reconcilers be idempotent and level-triggered?
* **Node Failure & Taint-Based Eviction:** What sets the `node.kubernetes.io/unreachable` and `not-ready` taints, and how do tolerations with `tolerationSeconds` decide when pods get evicted?

## Workloads

* **Pods & Shared Namespaces:** Why is the Pod the scheduling unit? Which namespaces do its containers share (network, IPC, optionally PID), and what are typical sidecar use cases? How do native sidecars (init containers with `restartPolicy: Always`) change startup and shutdown order?
* **Init & Ephemeral Containers:** How do init containers run and restart, and how does a failing init container block the pod? What are ephemeral containers (`kubectl debug`) for?
* **Probes:** Contrast liveness, readiness, and startup probes. Why is a liveness probe that checks a downstream dependency dangerous, and how can misconfigured probes create restart loops?
* **Lifecycle Hooks & Termination:** How do `postStart` and `preStop` hooks behave? Walk through pod termination: removal from endpoints, `preStop`, `SIGTERM`, `terminationGracePeriodSeconds`, `SIGKILL`. Why do you see 502s during deploys without a `preStop` delay?
* **Deployments & Rollouts:** Compare `RollingUpdate` and `Recreate`. How do `maxSurge` and `maxUnavailable` shape a rollout, and how do you roll back?
* **StatefulSets:** What do StatefulSets guarantee (stable names and DNS, stable storage per replica, ordered deployment and scaling)? When would you rather use an operator?
* **DaemonSets:** How are DaemonSet pods scheduled onto every (matching) node, and how do they interact with taints and tolerations?
* **Jobs & CronJobs:** How do Jobs handle failures (`backoffLimit`, pod failure policy) and completion modes (`Indexed` vs `NonIndexed`)? What do CronJob `concurrencyPolicy` and `startingDeadlineSeconds` control?
* **Disruptions & Draining:** How do `kubectl cordon` and `drain` evict pods, and how do PodDisruptionBudgets (`minAvailable` vs `maxUnavailable`) protect availability during voluntary disruptions? Why can a PDB block a drain forever?
* **Requests, Limits & QoS:** How do requests and limits map to cgroups? Explain the QoS classes (Guaranteed, Burstable, BestEffort), and why exceeding a memory limit gets a container OOMKilled while exceeding a CPU limit only throttles it.
* **Autoscaling:** Compare HPA (replicas from CPU or custom metrics), VPA (right-sizing requests, restarting pods), and KEDA (event-driven). Why shouldn't HPA and VPA both act on CPU for the same workload?
* **Cluster Autoscaling:** How do Cluster Autoscaler and Karpenter add nodes when pods are pending and remove underused ones? What blocks scale-down?

## Networking

* **CNI Plugins:** How do CNI plugins (Calico, Cilium, Flannel) assign pod IPs and route between nodes (overlay with VXLAN/Geneve vs native routing with BGP)? What does the Kubernetes network model require?
* **Service Types:** Compare `ClusterIP`, `NodePort`, `LoadBalancer`, and `ExternalName`. Trace a packet from client to pod for each, including what `externalTrafficPolicy: Local` changes.
* **Headless Services:** What does `clusterIP: None` change in DNS (A records per pod), and why do StatefulSets need it?
* **EndpointSlices:** Why did EndpointSlices replace `Endpoints` for services with thousands of pods?
* **Ingress vs Gateway API:** How does an ingress controller implement host- and path-based routing and TLS termination? Why was the Gateway API (`GatewayClass`, `Gateway`, `HTTPRoute`) introduced, and how does it split responsibilities between platform and app teams?
* **NetworkPolicies:** What happens when no policy selects a pod? How do ingress and egress rules select pods, namespaces, and CIDRs, why start with default-deny, and why must you then allow DNS egress?
* **Service Mesh:** How do meshes (Istio, Linkerd) provide mTLS, retries, traffic splitting, and telemetry via sidecars? Compare the sidecar model with ambient (node-level) mesh regarding overhead and latency.

## Storage & Configuration

* **PV, PVC & StorageClass:** Explain how PersistentVolumes, PersistentVolumeClaims, and StorageClasses separate concerns, how dynamic provisioning works, and what `volumeBindingMode: WaitForFirstConsumer` and `allowVolumeExpansion` do.
* **Access Modes:** Compare `ReadWriteOnce`, `ReadOnlyMany`, `ReadWriteMany`, and `ReadWriteOncePod`. Why doesn't `RWO` stop two pods on the same node from mounting the volume?
* **CSI & Snapshots:** How do CSI drivers and their sidecars (`external-provisioner`, `external-attacher`, `node-driver-registrar`) work, and how do `VolumeSnapshot` objects enable backup and restore?
* **ConfigMaps & Secrets:** Contrast consuming ConfigMaps/Secrets as environment variables versus mounted files. Which one updates live, and why does a `subPath` mount never update?
* **Secrets Encryption at Rest:** Why are Secrets only base64-encoded by default, and how do encryption providers (`aescbc`, `aesgcm`, KMS v2) protect them in etcd? Who can still read them?
* **Ephemeral Storage:** How does Kubernetes account for and limit ephemeral storage (`emptyDir`, container logs, writable layers), and when does the kubelet evict pods for disk pressure?

## Security

* **Authentication:** Which authentication methods does the API server support (x509 client certs, bearer tokens, OIDC, ServiceAccount tokens), and why doesn't Kubernetes have a User object?
* **RBAC:** Differentiate `Role`, `ClusterRole`, `RoleBinding`, and `ClusterRoleBinding`. How do aggregated ClusterRoles work, and which permissions (`escalate`, `bind`, `impersonate`, `create pods`) are effectively privilege escalation?
* **ServiceAccount Tokens:** What did projected, time-bound, audience-scoped ServiceAccount tokens fix compared with legacy long-lived Secret tokens? How do cloud workload identity features build on them?
* **Pod Security Standards:** Compare `Privileged`, `Baseline`, and `Restricted`, and how Pod Security Admission enforces them per namespace (`enforce`, `audit`, `warn`).
* **Security Contexts:** What do `runAsNonRoot`, `runAsUser`, `readOnlyRootFilesystem`, `allowPrivilegeEscalation: false`, `capabilities.drop: ["ALL"]` (adding back only e.g. `NET_BIND_SERVICE`), and `seccompProfile: RuntimeDefault` each protect against?
* **Audit Logging:** How do audit policies choose what to log (`None`, `Metadata`, `Request`, `RequestResponse`) per resource, and why should Secrets only ever be logged at `Metadata`?

## Packaging

* **Helm vs Kustomize:** Compare Helm (templating, releases, rollbacks, chart dependencies) with Kustomize (template-free overlays and patches). When do teams combine them?

## Scenarios

* **Lab — CrashLoopBackOff After Reboot:**
  * *Setup:* A pod enters `CrashLoopBackOff` right after a node reboot. `kubectl describe pod` shows exit code 137.
  * *Challenge:* Determine whether it was OOMKilled or SIGKILLed for another reason (failed liveness probe, eviction), read logs from the previous container (`kubectl logs --previous`) and from the runtime (`crictl`), and explain the backoff timing.
* **Lab — Pods Can't Talk Across Nodes:**
  * *Setup:* Pods on Node A can't reach pods on Node B, even though both nodes are `Ready`. TCP connections time out.
  * *Challenge:* Walk through diagnosing CNI status, routes, overlay tunnels, `iptables`/IPVS rules, cloud security groups blocking VXLAN/BGP traffic, and MTU mismatches.
* **Lab — etcd Quorum Loss:**
  * *Setup:* After a power outage in a bare-metal cluster, the API server returns `connection refused`.
  * *Challenge:* Check etcd member health, decide between waiting for members and restoring from a snapshot, restore with `etcdctl snapshot restore`, and re-establish quorum.
* **Lab — Namespace Stuck Terminating:**
  * *Setup:* A namespace stays in `Terminating` for hours.
  * *Challenge:* Find the resources and finalizers blocking deletion (often an uninstalled controller or an unavailable aggregated API), explain why force-removing finalizers can orphan external resources, and do it safely.
* **Lab — 5-Second DNS Delays:**
  * *Setup:* Pods see intermittent 5-second delays resolving external hostnames.
  * *Challenge:* Explain how `ndots:5` makes every external name try the cluster search domains first, how the conntrack race between parallel A/AAAA UDP queries drops packets, and fix it with FQDNs (trailing dot), a lower `ndots`, NodeLocal DNSCache, and CoreDNS scaling.

## Study Guide

* **Books:**
  * *Kubernetes in Action* (Marko Lukša): the chapter on Kubernetes internals plus the chapters on pods, Services, volumes, Deployments and StatefulSets, for how controllers, the scheduler and the kubelet cooperate through the API server.
  * *Production Kubernetes* (Josh Rosso, Rich Lander, Alex Brand & John Harris): the chapters on pod networking, service routing, storage, admission control, identity and multitenancy, for the trade-offs behind each platform choice.
  * *Programming Kubernetes* (Michael Hausenblas & Stefan Schimanski): the chapters on controllers and operators, custom resources and custom API servers, for the CRD, operator and aggregated API cards.
  * *Hacking Kubernetes* (Andrew Martin & Michael Hausenblas): the chapters on pods, container isolation and policy, for RBAC escalation, Pod Security and container breakout.
* **Official docs:** the Kubernetes docs, especially "Cluster Architecture", "Pod Lifecycle", "Configure Liveness, Readiness and Startup Probes", "Taints and Tolerations", "Garbage Collection", "Using RBAC Authorization", "Pod Security Standards", "Encrypting Confidential Data at Rest", "Auditing" and "Debugging DNS Resolution"; the etcd docs on operating clusters and disaster recovery; the Gateway API docs; and Kubernetes Enhancement Proposals (KEPs) for the reasoning behind features such as native sidecars.
* **Papers:** "Large-scale cluster management at Google with Borg" (Verma et al., 2015); "Borg, Omega, and Kubernetes" (Burns et al., 2016); "In Search of an Understandable Consensus Algorithm" (Ongaro & Ousterhout, 2014), the Raft paper behind etcd.
* **Related technologies:** kind, k3s and minikube for local clusters; Cilium, Calico and Flannel for CNI; Istio and Linkerd for service mesh; Kyverno and OPA Gatekeeper for policy; Karpenter and KEDA for scaling; Helm and Kustomize; OpenShift and managed EKS, GKE and AKS for how vendors package all of this.
* **Search for:** `Kubernetes The Hard Way` (Kelsey Hightower), `level triggered reconciliation`, `preStop sleep 502`, `kube-proxy iptables vs ipvs vs nftables`, `CPU limits CFS throttling`, `ndots 5 conntrack race`, `etcdctl snapshot restore`, `namespace stuck terminating finalizers`.
* **Hands-on:** work through *Kubernetes The Hard Way* on local VMs, then break that cluster on purpose to reproduce the labs: set a memory limit too low to get exit code 137, leave a namespace stuck on a finalizer, and restore etcd from a snapshot.
