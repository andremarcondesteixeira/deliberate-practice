# Domain-Driven Design

## Strategic Design

* **Strategic vs Tactical DDD:** Differentiate strategic DDD (subdomains, bounded contexts, context maps) from tactical DDD (aggregates, entities, value objects, repositories). Why does strategic design matter more?
* **Ubiquitous Language:** Why must domain experts and engineers share one language inside a bounded context, and how do you spot translation bugs when they don't?
* **Bounded Contexts:** How do you find bounded context boundaries, and why should microservice boundaries follow bounded contexts rather than technical layers? Why can the same word ("Customer") mean different things in different contexts?
* **Context Map Patterns:** Explain upstream/downstream relationships and the Customer-Supplier, Conformist, Open Host Service, Published Language, Shared Kernel, and Separate Ways patterns. Why is a Shared Kernel risky in large organizations?
* **Anti-Corruption Layer:** How does an ACL protect your model from a legacy or external system's concepts, and where does it live in the code?

## Tactical Design

* **Entities vs Value Objects:** Contrast entities (identity and lifecycle) with value objects (defined by attributes, immutable). Why should you model more value objects than you think?
* **Aggregates:** Which rules govern aggregate design: a single root as the entry point, invariants enforced within one transaction, references to other aggregates by ID only? Why keep aggregates small, and what goes wrong with large ones (contention, loading cost)?
* **Domain Events vs Integration Events:** Distinguish domain events (inside a bounded context) from integration events (published contracts across contexts). Why shouldn't you publish domain events directly?
* **Repositories & Factories:** What is the split between repositories (collection-like persistence per aggregate) and factories (complex creation)? Why one repository per aggregate root, not per table?
* **Domain Services vs Application Services:** Where does logic go when it spans aggregates: a domain service (pure domain logic) or an application service (orchestration, transactions, security)?
* **Anemic Domain Model:** Why is an anemic model (data-only classes with logic in services) considered an anti-pattern, and when is it actually fine?
* **Specification Pattern:** How does the specification pattern turn business rules into reusable, composable predicate objects, and how can specifications be translated into queries?
