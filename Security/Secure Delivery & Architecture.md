# Secure Delivery & Architecture

## Secure Design

* **Threat Modeling with STRIDE:** How does STRIDE (spoofing, tampering, repudiation, information disclosure, denial of service, elevation of privilege) structure a design review? Walk through one data flow.
* **Zero Trust:** What are the core principles of zero trust ("never trust, always verify", least privilege, assume breach)? How do identity-aware proxies and micro-segmentation replace perimeter trust?

## Security Testing

* **SAST vs DAST vs IAST:** Contrast static analysis of code, dynamic black-box testing of a running app, and interactive (instrumented) testing. What does each one miss, and where does each run in the pipeline?
* **SCA, SBOMs & Image Scanning:** How do software composition analysis and container scanners (Trivy, Grype) find vulnerable dependencies and OS packages? What is an SBOM (SPDX, CycloneDX), and how does it speed up triage when a zero-day like Log4Shell lands?

## Supply Chain

* **Dependency Confusion:** How do attackers exploit package managers that prefer a public package over a private one with the same name, and how do scoped registries and pinned sources prevent it?
* **SLSA & Build Provenance:** What do the SLSA levels require, and how does signed build provenance prove where and how an artifact was built?
* **Artifact Signing:** How do Sigstore/Cosign signatures (keyless with OIDC and transparency logs) let a cluster verify images at admission time?
* **Lab — Secret Committed to Git:**
  * *Setup:* A developer pushes a production database password to a public repository and deletes it in the next commit. It's still in the history.
  * *Challenge:* Rotate the credential first, then purge history (`git filter-repo`/BFG), and prevent repeats with pre-commit hooks and server-side secret scanning (Gitleaks, push protection). Why is rotation non-negotiable even after the purge?
* **Lab — Privileged Container Escape:**
  * *Setup:* A pod running with `securityContext.privileged: true` is compromised, and the attacker mounts the host filesystem and takes over the node.
  * *Challenge:* Remove privileged mode and dangerous capabilities, enforce the `Restricted` Pod Security Standard via admission control, and limit what a compromised node can reach (node authorization, network policies).
