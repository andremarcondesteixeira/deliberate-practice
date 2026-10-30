# Quality Attributes & Governance

## Quality Attributes

* **Reliability, Faults & Failures:** How does Kleppmann define reliability, and what's the difference between a fault and a failure? Contrast hardware faults, systematic software bugs, and human errors, and how each is mitigated.
* **Scalability & Load Parameters:** How do load parameters (requests/sec, read/write ratio, fan-out, cache hit rate) describe the load that matters? Use the Twitter home-timeline example (fan-out on write vs on read).
* **Percentiles & Tail Latency:** Why are response-time percentiles (p50, p95, p99, p999) better than averages? How do head-of-line blocking and fan-out to many backends amplify tail latency, and what's the difference between latency, response time, and throughput?
* **Maintainability:** Explain operability, simplicity, and evolvability. How do good abstractions remove accidental complexity without hiding essential complexity?
* **Non-Functional Requirements:** How do NFRs (scalability, availability, security, testability, cost) drive structural decisions? Why must they be stated as measurable scenarios ("p99 < 200ms at 5k rps")?

## Decisions & Documentation

* **Architecture Decision Records:** What goes into an ADR (context, decision, consequences, status), and why keep ADRs lightweight and in the repository?
* **C4 Model:** How does the C4 model describe architecture at four levels (Context, Containers, Components, Code), and which levels are worth maintaining?
* **Technology Radar:** How do teams use a technology radar (Adopt, Trial, Assess, Hold) to govern technology choices without central bureaucracy?

## Evolution

* **Technical Debt:** How does Fowler's technical debt quadrant (deliberate/inadvertent × prudent/reckless) help categorize debt, and how do you make debt visible and pay it down?
* **Coupling & Cohesion Metrics:** How do afferent/efferent coupling, instability, abstractness, and distance from the main sequence assess modularity? How do you use them without gaming them?
* **Fitness Functions & Evolutionary Architecture:** What is an architectural fitness function, and how do automated checks (dependency rules, latency budgets, security scans) protect architecture characteristics during incremental change?
* **API Versioning:** Compare URI versioning, header/media-type versioning, and evolving without versions (additive changes, tolerant readers). How do REST and gRPC APIs let clients and servers evolve independently, and how do you deprecate old versions?

## Study Guide

* **Books:**
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the opening chapter on reliable, scalable, and maintainable applications, which this deck's first section follows closely (faults vs failures, load parameters, the Twitter timeline, percentiles).
  * *Software Architecture in Practice* (Len Bass, Paul Clements & Rick Kazman): the chapters on quality attributes and quality attribute scenarios, for turning NFRs into measurable requirements.
  * *Building Evolutionary Architectures* (Neal Ford, Rebecca Parsons & Patrick Kua): the chapters on fitness functions and incremental change.
  * *Clean Architecture* (Robert C. Martin): the chapters on component coupling (stable dependencies, stable abstractions, and the main sequence).
* **Official docs:** Simon Brown's C4 model website (the diagram levels and notation); the Thoughtworks Technology Radar and its "Build Your Own Radar" tool; the adr-tools project and Michael Nygard's "Documenting Architecture Decisions" post; Google's API Improvement Proposals (AIPs) on versioning and compatibility; the Protocol Buffers documentation on updating message types.
* **Papers:** "The Tail at Scale" (Jeffrey Dean & Luiz André Barroso, 2013); "No Silver Bullet: Essence and Accident in Software Engineering" (Fred Brooks, 1986), for essential vs accidental complexity.
* **Related technologies:** ArchUnit (fitness functions as tests), Structurizr (C4 diagrams as code), adr-tools or Log4brains (ADRs), and SonarQube or NDepend (coupling metrics and debt tracking).
* **Search for:** `quality attribute scenario`, `tail latency amplification`, `architecture decision record template`, `C4 model container diagram`, `technical debt quadrant` (Martin Fowler), `distance from the main sequence`, `architectural fitness function`, `tolerant reader`, `API deprecation Sunset header`.
* **Hands-on:** write three ADRs and a C4 container diagram for a system you work on, then turn one architectural rule into an automated test that runs in CI.
