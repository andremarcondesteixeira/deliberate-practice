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

## Study Guide

* **Books:**
  * *Threat Modeling: Designing for Security* (Adam Shostack): the parts on modeling software with data flow diagrams and on STRIDE, for running a structured design review.
  * *Zero Trust Networks* (Evan Gilman & Doug Barth): the chapters on trusting devices, identities and applications, and the BeyondCorp case study, for zero-trust principles and identity-aware proxies.
  * *Software Supply Chain Security* (Cassie Crossley): the chapters on supply chain frameworks and standards and on securing software development and builds, for SBOMs, SLSA and provenance.
  * *Hacking Kubernetes* (Andrew Martin & Michael Hausenblas): the chapters on container isolation, the application supply chain and policy, for the privileged-container lab and verifying images at admission.
* **Official docs:** NIST SP 800-207 (Zero Trust Architecture); NIST SP 800-218 (Secure Software Development Framework); the SLSA specification (build track levels and the provenance format); the Sigstore docs for Cosign, Fulcio and Rekor; the SPDX and CycloneDX specifications; OWASP Cheat Sheet Series: Threat Modeling; the Kubernetes docs on Pod Security Standards and Node Authorization; GitHub's docs on removing sensitive data from a repository and on push protection.
* **Papers:** "Reflections on Trusting Trust" (Ken Thompson, 1984); "BeyondCorp: A New Approach to Enterprise Security" (Rory Ward & Betsy Beyer, 2014); "Sigstore: Software Signing for Everybody" (Newman, Meyers & Torres-Arias, 2022).
* **Related technologies:** OWASP Threat Dragon and the Microsoft Threat Modeling Tool; Semgrep, CodeQL and SonarQube for SAST; OWASP ZAP for DAST; Trivy, Grype, Syft and Dependency-Track for SCA and SBOMs; in-toto and GitHub artifact attestations; Kyverno or the Sigstore policy-controller for image verification; Gitleaks, TruffleHog and `git filter-repo`.
* **Search for:** `STRIDE data flow diagram`, `dependency confusion Alex Birsan`, `SLSA build levels`, `cosign keyless signing`, `SBOM VEX`, `Log4Shell SBOM triage`, `secret scanning push protection`, `privileged pod escape nsenter`.
* **Hands-on:** generate an SBOM for one of your images with Syft, scan it with Grype, sign the image keylessly with Cosign, and add an admission policy to a `kind` cluster that rejects unsigned images.
