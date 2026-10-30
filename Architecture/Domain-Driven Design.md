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

## Study Guide

* **Books:**
  * *Domain-Driven Design: Tackling Complexity in the Heart of Software* (Eric Evans): the original source; the part on the building blocks (entities, value objects, aggregates, repositories, factories, services), the chapter on making implicit concepts explicit (specifications), and the part on strategic design (bounded contexts, context maps, anti-corruption layers).
  * *Implementing Domain-Driven Design* (Vaughn Vernon): the chapters on context maps, aggregates, domain events, and application services, with concrete code for each tactical pattern.
  * *Learning Domain-Driven Design* (Vlad Khononov): the most approachable modern overview; the chapters on subdomains, bounded contexts, and integrating bounded contexts cover the strategic half of this deck.
  * *Domain-Driven Design Distilled* (Vaughn Vernon): a short refresher on strategic design, context mapping, and aggregate rules when you only need the essentials.
* **Official docs:** Eric Evans's free *Domain-Driven Design Reference* (Domain Language), a pattern-by-pattern summary of the book; the DDD Crew's open-source Context Mapping and Bounded Context Canvas repositories on GitHub.
* **Papers:** "Effective Aggregate Design" (Vaughn Vernon's three-part essay), the standard reference for small aggregates and referencing other aggregates by ID.
* **Related technologies:** Event Storming (Alberto Brandolini's workshop format for finding boundaries), Axon Framework and EventStoreDB (aggregates and events), jMolecules (DDD building blocks for Java), and the specification support in Spring Data JPA.
* **Search for:** `bounded context vs subdomain`, `context mapping patterns`, `anti-corruption layer`, `domain events vs integration events`, `anemic domain model` (Martin Fowler's article), `specification pattern` (Evans & Fowler), `Event Storming`.
* **Hands-on:** pick a domain you know (e.g., a shop), run a solo Event Storming session on paper, then draw the bounded contexts, a context map, and one aggregate with its invariants.
