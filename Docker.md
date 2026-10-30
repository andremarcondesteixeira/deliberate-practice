# Docker Architecture & Engineering Practice

## Phase 1: Container Fundamentals, Namespaces & Cgroups

* **Card 1 (Containers vs Virtual Machines):** How do Docker containers differ architecturally from traditional Virtual Machines regarding kernel sharing and hypervisor virtualization?
* **Card 2 (Linux Namespaces):** What are the six primary Linux kernel namespaces leveraged by Docker to achieve process, network, and filesystem isolation?
* **Card 3 (Control Groups - cgroups):** Contrast cgroups v1 and cgroups v2. How do they enforce strict limits on CPU, memory, and I/O usage for containerized processes?
* **Card 4 (Copy-on-Write Storage Drivers):** Explain how the Overlay2 storage driver uses lower, upper, and merge layers to implement Copy-on-Write (CoW) efficiency.
* **Card 5 (PID 1 & Signal Forwarding):** Why does running a Node.js or Java application as PID 1 inside a container cause signal propagation issues (e.g., ignoring `SIGTERM`), and how do tools like `tini` fix it?
* **Card 6 (Container Lifecycle States):** Trace the lifecycle states of a container from `created`, `running`, and `paused`, to `exited` and `dead`.
* **Card 7 (Pivot Root Mechanics):** How does the container runtime use `pivot_root` to isolate the container's root filesystem from the host system?
* **Card 8 (Chroot vs Containers):** Why is `chroot` a weak security boundary compared to modern containerization namespaces and seccomp profiles?

## Phase 2: Images, Layers & Dockerfile Best Practices

* **Card 9 (Layer Caching Optimization):** How does Docker's build cache mechanism work, and why does ordering Dockerfile instructions by change frequency drastically speed up builds?
* **Card 10 (Multi-Stage Builds):** How do multi-stage Dockerfiles allow developers to separate compile-time toolchains from runtime execution environments to minimize image size?
* **Card 11 (COPY vs ADD):** Contrast the `COPY` and `ADD` instructions in a Dockerfile. Why is `COPY` preferred for standard file additions?
* **Card 12 (ENTRYPOINT vs CMD):** Differentiate between `ENTRYPOINT` and `CMD`. When should you combine an executable entrypoint with default arguments (`CMD`)?
* **Card 13 (Base Image Selection Trade-offs):** Compare `scratch`, `Alpine Linux`, `Distroless`, and standard `Ubuntu` base images regarding security surface area and debugging capability.
* **Card 14 (Build Context & .dockerignore):** Why is an unoptimized build context (e.g., building in a directory containing `node_modules` or `.git`) detrimental to build performance?
* **Card 15 (Image Digests vs Tags):** What are the security and reproducibility risks of using mutable image tags (like `latest`) versus immutable content digests (`@sha256:...`)?
* **Card 16 (BuildKit Cache Mounts):** How do BuildKit cache mounts (`--mount=type=cache`) persist package manager caches (like npm or pip) across successive builds?
* **Card 17 (Secret Leakage in Build Layers):** Why is passing database credentials or API keys as `ENV` or `ARG` build arguments dangerous, and how do BuildKit secret mounts solve this?
* **Card 18 (Image Vulnerability Scanning & SBOM):** What is a Software Bill of Materials (SBOM), and how does container image vulnerability scanning integrate into CI/CD pipelines?

## Phase 3: Networking & Storage Management

* **Card 19 (Docker Network Drivers):** Contrast `bridge`, `host`, `none`, and `macvlan` network drivers. When would an architecture require `host` networking?
* **Card 20 (Port Publishing & iptables):** How does Docker use host `iptables` and port forwarding rules to route traffic from host interfaces into container network namespaces?
* **Card 21 (Container DNS Resolution):** How does Docker's internal embedded DNS server facilitate service discovery between containers on custom bridge networks?
* **Card 22 (Volumes vs Bind Mounts):** Contrast Docker managed volumes with host bind mounts. Which is recommended for persistent database storage and why?
* **Card 23 (Volume Lifecycle & Drivers):** How do volume plugins enable external persistent storage (like AWS EBS or NFS) to mount dynamically into containers?
* **Card 24 (System Pruning & Disk Hygiene):** What is the difference between dangling images and unused images, and how does `docker system prune -a --volumes` reclaim disk space?
* **Card 25 (Container Logging Drivers):** How do logging drivers (like `json-file`, `journald`, or `fluentd`) handle stdout/stderr redirection and log rotation?
* **Card 26 (Overlay2 Disk Bloat):** What causes unexpected disk consumption in `/var/lib/docker/overlay2`, and how do you track down orphaned container layers?
* **Card 27 (Read-Only Root Filesystems):** How does running containers with `--read-only` root filesystems enhance security against runtime file tampering?
* **Card 28 (File Permission Gotchas):** Why do host bind mounts frequently result in permission denied errors when container processes run as non-root users?

## Phase 4: Docker Compose & Multi-Container Workflows

* **Card 29 (Compose Service Dependencies):** How do `depends_on` conditions (`service_healthy`, `service_completed_successfully`) control startup ordering in Docker Compose?
* **Card 30 (Environment Variable Precedence):** Walk through the resolution order for environment variables in Docker Compose (.env files, shell environment, environment section).
* **Card 31 (Compose Scaling & Port Conflicts):** What architectural challenges occur when scaling a Compose service that binds to a static host port?
* **Card 32 (Container Health Checks):** How do `HEALTHCHECK` instructions in Dockerfiles or Compose files dictate container readiness and orchestration recovery?
* **Card 33 (Compose Profiles):** How do you use Compose profiles to conditionally start optional services (like debugging tools or mock servers) in development?
* **Card 34 (Extending Compose Files):** Contrast the legacy `extends` keyword with modern Compose file composition (`include`) for managing shared microservice configurations.
* **Card 35 (Isolated Network Segmentation):** How do multiple custom networks in a Compose file restrict cross-service communication (e.g., separating frontend-backend from backend-database)?
* **Card 36 (Secrets & Configs Management):** How do Docker Swarm or Compose handle externalized configuration and secret injection securely without embedding plaintext?

## Phase 5: Security, Rootless Mode & Isolation

* **Card 37 (Rootless Docker Architecture):** How does Rootless Docker allow unprivileged users to run the daemon using user namespaces without root privileges?
* **Card 38 (Dropping Kernel Capabilities):** How do you harden a container by dropping default Linux capabilities (`--cap-drop ALL`) and selectively adding back only required ones?
* **Card 39 (Seccomp & AppArmor Profiles):** How do Seccomp system call filters and AppArmor mandatory access control restrict what system calls a containerized process can execute?
* **Card 40 (User Namespace Mapping):** How does mapping container UID 0 to an unprivileged host UID protect the host system in case of a container escape?
* **Card 41 (Common Container Escape Vectors):** What are primary container escape mechanisms (e.g., mounted Docker socket `/var/run/docker.sock`, privileged mode, insecure kernel capabilities)?

## Phase 6: Advanced Troubleshooting & Edge Cases

* **Card 42 (Lab Scenario A - OOMKilled vs Host Memory):**
  * *The Setup:* A containerized Java service terminates abruptly with exit code 137. `dmesg` on the host shows `Memory cgroup out of memory`.
  * *The Challenge:* Explain why JVM heap settings combined with off-heap memory pushed the container past its cgroup limit, and how to configure correct container memory boundaries.

* **Card 43 (Lab Scenario B - Zombie Process Accumulation):**
  * *The Setup:* A Python container running background worker subprocesses accumulates thousands of defunct processes, eventually exhausting the process table.
  * *The Challenge:* Diagnose why PID 1 failed to reap orphaned child processes, and explain how proper init-system signal handling resolves it.

* **Card 44 (Lab Scenario C - Slow Build Cache Invalidation):**
  * *The Setup:* A CI/CD pipeline takes 15 minutes to build a Docker image because a minor file modification at the top of the Dockerfile invalidates all subsequent layer caches.
  * *The Challenge:* Restructure the Dockerfile to optimize layer caching by moving high-change files (source code) below low-change files (dependency manifests).

* **Card 45 (Lab Scenario D - Corrupted Overlay2 State):**
  * *The Setup:* Docker daemon fails to start after an abrupt power loss. Logs indicate corrupted overlay filesystem metadata under `/var/lib/docker/overlay2`.
  * *The Challenge:* Outline the recovery steps to inspect corrupted mount points, clean up dangling locking files, or safely prune broken container layers.

* **Card 46 (Lab Scenario E - Custom Network DNS Failures):**
  * *The Setup:* Two containers on a custom user-defined bridge network cannot resolve each other by service name, even though default bridge communication worked.
  * *The Challenge:* Diagnose why the embedded DNS resolver daemon failed or how custom `--dns` flags interfered with internal Docker DNS forwarding.

* **Card 47 (Lab Scenario F - Volume Permission Denied):**
  * *The Setup:* A secure container configured to run as a non-root user fails to write logs or data into a mounted volume directory created automatically by Docker.
  * *The Challenge:* Explain why Docker initializes new volumes with root ownership and how to use initialization scripts or entrypoints to adjust directory permissions securely.

* **Card 48 (Lab Scenario G - Ephemeral Storage Exhaustion):**
  * *The Setup:* A node running multiple containers runs out of disk space completely, crashing all local services. `df -h` shows root partition is 100% full.
  * *The Challenge:* Trace how unbounded container log generation or temporary file writes inside the container writable layer consume host root disk space, and how to enforce storage quotas.

* **Card 49 (Lab Scenario H - Time Synchronization Drift):**
  * *The Setup:* Distributed microservices running in containers across different worker nodes log timestamps that drift out of sync, breaking request tracing and JWT expiration validation.
  * *The Challenge:* Explain how containers inherit host system time and why time synchronization (NTP/chrony) on the host kernel is critical for containerized workloads.

* **Card 50 (Lab Scenario I - Socket Leak / File Descriptor Exhaustion):**
  * *The Setup:* A high-throughput API gateway container throws `EMFILE: too many open files` and stops accepting incoming socket connections.
  * *The Challenge:* Diagnose how unclosed database connections or slow upstream responses leak file descriptors inside the container, and how to tune system-wide vs container-level `ulimit` settings.