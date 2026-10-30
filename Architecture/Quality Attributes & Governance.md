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
