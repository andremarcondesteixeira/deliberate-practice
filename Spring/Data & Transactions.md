# Spring Data & Transactions

## Transactions

* **@Transactional Mechanics:** How does `@Transactional` use AOP proxies and a `PlatformTransactionManager` to bind a connection to the current thread? Why don't private methods or self-calls get transactions?
* **Propagation:** Contrast `REQUIRED`, `REQUIRES_NEW`, `NESTED`, `SUPPORTS`, `NOT_SUPPORTED`, `MANDATORY`, and `NEVER`. What does `REQUIRES_NEW` cost in connections, and how does `NESTED` differ (savepoints)?
* **Lab — UnexpectedRollbackException:**
  * *Setup:* An inner `@Transactional` method throws, the outer method catches and swallows the exception, and the commit fails with `UnexpectedRollbackException`.
  * *Challenge:* Explain the default rollback rules (unchecked exceptions and errors roll back, checked exceptions don't), how the inner call marked the shared transaction rollback-only, and fix it with `REQUIRES_NEW`, `noRollbackFor`, or by not catching.
* **Read-Only Transactions:** What does `@Transactional(readOnly = true)` actually do in Hibernate and the JDBC driver (flush mode, replica routing), and what doesn't it do?

## JPA & Hibernate

* **JdbcTemplate/JdbcClient vs JPA:** When is plain SQL through `JdbcTemplate` or `JdbcClient` a better fit than JPA/Hibernate?
* **Persistence Context & Dirty Checking:** What is the persistence context, and how does Hibernate's dirty checking generate `UPDATE`s at flush time? How do the `EntityManager`, the transaction, and the pooled JDBC connection relate to each other?
* **Lab — The N+1 Problem:**
  * *Setup:* Listing 100 orders fires 101 queries because each order's `LAZY` items collection loads separately.
  * *Challenge:* Detect it (SQL logs, Hibernate statistics, tests that assert query counts), then fix it with `JOIN FETCH`, `@EntityGraph`, or batch fetching. Why does `JOIN FETCH` combined with pagination trigger in-memory paging warnings?
* **Lab — LazyInitializationException & Open Session in View:**
  * *Setup:* A REST endpoint throws `LazyInitializationException: could not initialize proxy - no Session` while serializing an entity.
  * *Challenge:* Explain why the session closed before serialization, why `spring.jpa.open-in-view=true` hides the problem while holding a connection for the whole request, and fix it with DTO projections, fetch plans, or proper transactional service boundaries.
* **Optimistic vs Pessimistic Locking:** How does `@Version` detect concurrent updates, and what should the application do with an `OptimisticLockException`? When do you use `PESSIMISTIC_WRITE` lock modes instead?
* **Second-Level Cache:** How does Hibernate's second-level cache work (entity, collection, and query caches), and what are its consistency risks in a multi-instance deployment?

## Spring Data

* **Repository Proxies & Derived Queries:** How does Spring Data generate repository implementations at runtime, and how are method names such as `findByLastNameAndAgeGreaterThan` parsed into queries? When should you switch to `@Query`?
* **Specifications & Criteria:** How do `JpaSpecificationExecutor` and the Criteria API build dynamic, type-safe queries for optional filters?
* **@Modifying Queries:** Why do bulk update/delete queries need `@Modifying` and a transaction, and why can they leave stale entities in the persistence context (`clearAutomatically`)?
* **Page vs Slice:** How do `Pageable`, `Page`, and `Slice` differ, and why can the extra count query behind `Page` be expensive?
* **Auditing:** How do `@CreatedDate`, `@LastModifiedDate`, `@CreatedBy`, and `AuditorAware` fill audit columns automatically?
* **Reactive Data Access:** How do R2DBC and reactive MongoDB repositories provide non-blocking database access with Project Reactor, and how do transactions work without a thread-bound connection?
