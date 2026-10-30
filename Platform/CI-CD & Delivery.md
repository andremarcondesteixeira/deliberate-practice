# CI/CD & Delivery

## Continuous Integration

* **Trunk-Based Development vs GitFlow:** Contrast trunk-based development with GitFlow regarding integration pain, release cadence, and the practices trunk-based development needs (feature flags, small PRs, fast CI).
* **Pipeline Anatomy:** Which stages does a mature pipeline run (lint, unit tests, build, integration tests, security scans, publish), and why define pipelines as code in the repository? How should stages be ordered for fast feedback?
* **Pipeline Speed:** How do dependency caches, layer caches, test sharding, and matrix builds cut pipeline time? What makes a cache key correct?
* **Branch Protection:** How do required status checks, code owners, required reviews, and merge queues enforce quality gates?
* **Reproducible Builds:** What makes a build reproducible (pinned dependencies, lockfiles, pinned base images, hermetic build environments), and why does that matter for security?
* **Artifacts & Versioning:** Why build once and promote the same immutable artifact through environments? How do semantic versioning and Conventional Commits automate version bumps and changelogs?
* **Flaky Tests:** How do you detect, quarantine, and fix flaky tests without losing trust in the pipeline or quietly dropping coverage?
* **Webhook Security:** How do CI systems verify that a webhook really came from the Git host (HMAC signatures, shared secrets), and why are pipelines triggered by pull requests from forks a security risk?
* **Ephemeral Preview Environments:** How do per-pull-request environments work, and how do you keep them cheap and isolated for multi-service changes?

## Delivery

* **Blue-Green vs Canary:** Contrast blue-green deployments (instant switch, instant rollback, double capacity) with canary releases (gradual traffic shift). What does each require from the database layer?
* **Progressive Delivery & Automated Rollback:** How do tools like Argo Rollouts or Flagger promote a canary step by step based on metric analysis (error rate, latency, SLO burn) and roll back automatically?
* **Feature Flags:** How do feature flags decouple deployment from release? What are the types of flags (release, experiment, ops kill switch, permission), and why does flag debt need active cleanup?
* **DORA Metrics:** Define deployment frequency, lead time for changes, change failure rate, and time to restore service. Why measure them together?

## GitOps

* **GitOps:** What makes a system GitOps (declarative desired state in Git, pulled and continuously reconciled by an agent)? How do Argo CD or Flux compare live state with Git, and what are the security benefits of pull-based deployment?
* **Lab — GitOps Overwrites the Hotfix:**
  * *Setup:* An engineer hotfixes a crashing deployment with `kubectl edit`. Ten minutes later, the GitOps controller syncs and puts the broken manifest back.
  * *Challenge:* Explain drift detection and self-healing, why the controller did the right thing, and the correct incident workflow (revert or fix in Git, or explicitly pause sync and record it).

## Study Guide

* **Books:**
  * *Continuous Delivery* (Jez Humble & David Farley): the chapters on the deployment pipeline, version control and continuous integration, for pipeline stages, ordering for fast feedback, and building once and promoting the same artifact.
  * *Accelerate* (Nicole Forsgren, Jez Humble & Gene Kim): the chapters on measuring software delivery performance, for the four DORA metrics and the research showing why they belong together.
  * *Software Engineering at Google* (Titus Winters, Tom Manshreck & Hyrum Wright): the chapters on continuous integration, continuous delivery and testing, for flaky tests, presubmit gates and trunk-based development at scale.
  * *GitOps and Kubernetes* (Billy Yuen, Alexander Matyushentsev, Todd Ekenstam & Jesse Suen): the chapters on Argo CD and on deployment strategies, for reconciliation, drift detection, and blue-green and canary rollouts.
* **Official docs:** the Argo CD docs on automated sync and self-heal, the Argo Rollouts docs on canary steps and analysis (Flagger's docs cover the same ideas), the OpenGitOps principles (CNCF), your CI system's docs on caching and security hardening (for GitHub Actions: "Security hardening for GitHub Actions", the `pull_request_target` warnings, and "Validating webhook deliveries"), the Semantic Versioning and Conventional Commits specifications, and the annual DORA *State of DevOps* reports.
* **Related technologies:** GitHub Actions, GitLab CI, Jenkins and Buildkite for pipelines; Bazel for hermetic, cached builds; merge queues in GitHub and GitLab; LaunchDarkly, Unleash and the OpenFeature standard for flags; semantic-release and Release Please for automated versioning; Argo CD vs Flux for GitOps.
* **Search for:** `trunk based development` (Paul Hammant's site of that name), `feature toggles Pete Hodgson`, `build once deploy many`, `pwn request pull_request_target`, `flaky test quarantine`, `cache key lockfile hash`, `expand and contract migration` (for blue-green with a shared database), `Argo CD self-heal drift`.
* **Hands-on:** manage a small app in a `kind` cluster with Argo CD and self-heal enabled, `kubectl edit` the deployment and watch the controller revert it; then add an Argo Rollouts canary whose analysis step fails and rolls back on its own.
