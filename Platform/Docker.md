# Docker

## Container Fundamentals

* **Containers vs VMs:** How do containers differ from VMs regarding kernel sharing and isolation strength? What follows from sharing the host kernel (no custom kernel modules, and the clock is the host's, so time sync must happen on the host)?
* **Linux Namespaces:** Which namespaces (pid, net, mnt, uts, ipc, user, cgroup) does a container use, and what does each one isolate?
* **cgroups v1 vs v2:** How do cgroups enforce CPU, memory, and I/O limits? What did cgroups v2 change (unified hierarchy, better memory accounting, PSI)?
* **chroot vs pivot_root:** Why is `chroot` a weak isolation boundary, and how do runtimes use mount namespaces plus `pivot_root` to give a container its own root filesystem?
* **OverlayFS & Copy-on-Write:** How does overlay2 combine lower (image), upper (container), and merged layers? What happens to performance when a container modifies a large file from a lower layer?
* **The PID 1 Problem:** Why does a process running as PID 1 ignore `SIGTERM` unless it installs a handler, and why do orphaned children become zombies if PID 1 doesn't reap them? How do `tini`/`--init` and exec-form `ENTRYPOINT` fix both?
* **OCI & Runtimes:** What do the OCI image and runtime specs standardize? How do `dockerd`, `containerd`, `runc`, and CRI-O relate to each other and to Kubernetes?

## Images & Dockerfiles

* **Multi-Stage Builds:** How do multi-stage builds keep compilers and build dependencies out of the runtime image?
* **COPY vs ADD:** Why is `COPY` preferred over `ADD` (remote URLs, automatic tar extraction)?
* **ENTRYPOINT vs CMD:** How do `ENTRYPOINT` and `CMD` combine, and how do exec form and shell form differ in signal handling?
* **Base Image Choice:** Compare `scratch`, Alpine (musl), distroless, and full distributions regarding attack surface, compatibility, and debuggability.
* **Build Context & .dockerignore:** Why does sending `.git`, `node_modules`, or build output in the build context slow builds and leak secrets?
* **Tags vs Digests:** Why are mutable tags like `latest` a reproducibility and security risk, and how do you pin by digest (`@sha256:...`) while still receiving updates?
* **BuildKit Cache Mounts:** How do `--mount=type=cache` mounts keep package manager caches (Maven, Gradle, pip) across builds without bloating layers?
* **Build Secrets:** Why are `ARG`/`ENV` secrets visible in image history and layers, and how do BuildKit secret mounts (`--mount=type=secret`) avoid that?
* **Lab — Slow Builds from Cache Invalidation:**
  * *Setup:* CI takes 15 minutes per build because `COPY . .` near the top of the Dockerfile invalidates every later layer on any change.
  * *Challenge:* Reorder the Dockerfile to copy dependency manifests and install dependencies before copying source, and explain how the layer cache key is computed for `RUN` and `COPY`.

## Networking & Storage

* **Network Drivers:** Contrast `bridge`, `host`, `none`, and `macvlan`. When do you need `host` networking, and what do you lose?
* **Port Publishing:** How does Docker use `iptables` NAT rules and `docker-proxy` to route host ports into containers? Why can published ports bypass a host firewall like `ufw`?
* **Lab — Service Name Resolution Fails:**
  * *Setup:* Two containers can't reach each other by name, though they can reach each other by IP.
  * *Challenge:* Explain why the default bridge network has no embedded DNS while user-defined networks do, and how custom `--dns` settings or `/etc/resolv.conf` changes can break resolution.
* **Volumes vs Bind Mounts:** Contrast named volumes, bind mounts, and tmpfs mounts. Which should a database use, and how do volume drivers attach external storage (NFS, EBS)?
* **Lab — Volume Permission Denied:**
  * *Setup:* A container running as a non-root user can't write to a mounted directory.
  * *Challenge:* Explain how UIDs/GIDs map between host and container, why new volumes and bind mounts can end up owned by root, and fix it safely (matching UIDs, `chown` in the image, init steps) without running as root.
* **Logging Drivers:** How do the `json-file`, `local`, `journald`, and `fluentd` drivers handle stdout/stderr? Why isn't log rotation enabled by default for `json-file`?
* **Disk Hygiene:** What's the difference between dangling and unused images? What fills `/var/lib/docker` (images, stopped containers, build cache, volumes, logs), and how do `docker system df` and `prune` help?
* **Lab — Disk Full:**
  * *Setup:* A host runs out of disk, and every service on it crashes. `df -h` shows the root partition at 100%.
  * *Challenge:* Find whether container logs, writes to containers' writable layers, volumes, or build cache filled the disk, and prevent it with log rotation, read-only root filesystems with explicit volumes, and storage quotas.
* **Lab — Corrupted overlay2 After Power Loss:**
  * *Setup:* The Docker daemon won't start after a power failure; logs point to corrupted overlay metadata under `/var/lib/docker/overlay2`.
  * *Challenge:* Describe how to inspect the damage, what is safe to delete, and when to wipe and re-pull. What does this say about keeping state inside containers?

## Compose

* **depends_on & Health Checks:** How do `HEALTHCHECK` and `depends_on` conditions (`service_started`, `service_healthy`, `service_completed_successfully`) control startup order? Why doesn't startup order remove the need for retries?
* **Environment Variable Precedence:** In which order does Compose resolve variables from the shell, `.env`, `env_file`, and `environment`? What's the difference between interpolation in the Compose file and variables passed into the container?
* **Profiles & Composition:** How do profiles start optional services, and how does `include` compare with `extends` and multiple `-f` files for sharing configuration?
* **Network Segmentation:** How do multiple user-defined networks in a Compose file keep the frontend from talking directly to the database?
* **Secrets & Configs:** How do Compose/Swarm secrets mount sensitive data as files instead of environment variables?

## Security

* **Rootless Mode & User Namespaces:** How do rootless Docker and user-namespace remapping map container root to an unprivileged host UID, and what breaks (low ports, some storage drivers)?
* **Capabilities & Hardening Flags:** How do you harden a container with `--cap-drop ALL` plus selective `--cap-add`, `--security-opt no-new-privileges`, `--read-only`, and a non-root `USER`?
* **Seccomp & AppArmor/SELinux:** How do seccomp syscall filters and mandatory access control profiles limit what a containerized process can do, even as root?
* **Container Escape Vectors:** What are the classic escape paths (a mounted `/var/run/docker.sock`, `--privileged`, dangerous capabilities like `CAP_SYS_ADMIN`, sensitive host path mounts, kernel exploits), and how do you spot them in a review?

## Study Guide

* **Books:**
  * *Container Security* (Liz Rice): the chapters on namespaces, cgroups, container root filesystems, capabilities, seccomp/AppArmor/SELinux and container escapes, which cover the Container Fundamentals and Security sections almost entirely.
  * *Docker Deep Dive* (Nigel Poulton): the chapters on the Docker engine, images, containerizing an app, networking, volumes and Compose, for how `dockerd`, `containerd` and `runc` fit together and for everyday Dockerfile practice.
  * *Docker: Up & Running* (Sean P. Kane & Karl Matthias): the chapters on building images and the advanced topics on storage, networking and security, for multi-stage builds, BuildKit and production tuning.
  * *The Linux Programming Interface* (Michael Kerrisk): the chapters on signals, process termination and monitoring child processes, for the PID 1 signal and zombie-reaping problem.
* **Official docs:** the Docker docs' Dockerfile reference and its pages on the build cache, build secrets, multi-stage builds, packet filtering and firewalls (iptables and `ufw`), the Compose file reference and environment variable precedence, rootless mode, seccomp profiles, and logging drivers; the OCI Image Format and Runtime specifications; the Linux man pages `namespaces(7)`, `cgroups(7)`, `capabilities(7)` and `pivot_root(2)`; the kernel docs "Control Group v2" and "Overlay Filesystem".
* **Related technologies:** Podman and Buildah (daemonless, rootless by default), containerd with `nerdctl`, `runc` vs `crun`, gVisor and Kata Containers for stronger isolation, kaniko for unprivileged builds, distroless and Chainguard images, `tini` and `dumb-init`.
* **Search for:** `containers from scratch` (Liz Rice's talk), `docker pid 1 zombie reaping`, `overlayfs copy up`, `docker embedded dns 127.0.0.11`, `docker ufw bypass DOCKER-USER`, `buildkit cache mount`, `docker.sock privilege escalation`, `CAP_SYS_ADMIN container escape`.
* **Hands-on:** build a container by hand: export an Alpine filesystem with `docker export`, then use `unshare` and `chroot` (later `pivot_root`) to give a shell its own PID, mount and UTS namespaces, and compare what it sees with a shell from `docker run`.
