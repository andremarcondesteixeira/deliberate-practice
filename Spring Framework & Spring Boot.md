# Spring Framework & Spring Boot Engineering Practice (100 Challenges)

## Phase 1: Core Spring Framework & IoC Container

* **Card 1 (Inversion of Control & DI):** How does Inversion of Control (IoC) shift dependency management, and what are the three primary forms of Dependency Injection in Spring?
* **Card 2 (BeanFactory vs ApplicationContext):** What are the structural and feature differences between the lightweight `BeanFactory` and the enterprise-ready `ApplicationContext` container?
* **Card 3 (Bean Scopes):** Contrast `singleton`, `prototype`, `request`, `session`, and `application` bean scopes regarding lifecycle management and thread safety.
* **Card 4 (Bean Lifecycle Methods):** Trace the complete lifecycle of a Spring bean from instantiation, property population, `BeanNameAware`, `BeanFactoryAware`, `InitializingBean` (`afterPropertiesSet`), custom init methods, to destruction.
* **Card 5 (BeanPostProcessor Interface):** How do `BeanPostProcessor` implementations execute custom logic before and after bean initialization (e.g., wrapper proxy generation)?
* **Card 6 (BeanFactoryPostProcessor):** What is the role of `BeanFactoryPostProcessor`, and how does it modify bean definition metadata before bean instantiation occurs?
* **Card 7 (Spring Event Propagation):** How do `ApplicationEvent`, `ApplicationEventPublisher`, and `@EventListener` facilitate decoupled intra-application messaging?
* **Card 8 (Profiles and Environment Abstraction):** How do Spring profiles (`@Profile`, `spring.profiles.active`) segregate environment-specific bean configurations?
* **Card 9 (Resource Loader Abstraction):** How does Spring’s `ResourceLoader` abstract file access across classpath, URL, and filesystem locations using prefixes like `classpath:` and `file:`?
* **Card 10 (Spring Expression Language - SpEL):** What is SpEL, and how do expressions embedded in `@Value` annotations evaluate dynamic properties and bean attributes?
* **Card 11 (Aware Interfaces):** What is the architectural purpose of Spring Aware interfaces (e.g., `ApplicationContextAware`, `EnvironmentAware`), and why are they generally considered an anti-pattern when overused?
* **Card 12 (Circular Dependencies):** How does Spring resolve circular dependencies between singleton beans using constructor injection versus setter/field injection (via property resolution and early bean references)?
* **Card 13 (Lazy Initialization):** What are the performance trade-offs of enabling global lazy bean initialization (`spring.main.lazy-initialization=true`) in Spring applications?
* **Card 14 (Bean Aliases and Primary Beans):** How do `@Primary` and `@Qualifier` annotations resolve ambiguity when multiple beans match a single injection target type?
* **Card 15 (SmartInitializingSingleton):** When does the `SmartInitializingSingleton` callback execute during container startup compared to `InitializingBean`?

## Phase 2: Aspect-Oriented Programming (AOP) & Configuration

* **Card 16 (AOP Core Terminology):** Define the core concepts of Spring AOP: Aspect, Advice, JoinPoint, Pointcut, and Weaving.
* **Card 17 (JDK Dynamic Proxies vs CGLIB):** Contrast JDK Dynamic Proxies (interface-based) with CGLIB proxies (subclass-based) regarding proxy generation and performance constraints.
* **Card 18 (Advice Types):** Differentiate between `@Before`, `@AfterReturning`, `@AfterThrowing`, `@After`, and `@Around` advice annotations.
* **Card 19 (Pointcut Expressions):** How do AspectJ pointcut designators like `execution`, `within`, `@annotation`, and `bean` target specific method execution joins?
* **Card 20 (Configuration Metadata):** How do `@Configuration` and `@Bean` annotations differ from standard component scanning (`@Component`) regarding bean definition generation and lite vs full configuration modes?
* **Card 21 (Conditional Configuration):** How do `@Conditional` and custom condition implementations (`Condition` interface) enable dynamic bean registration based on environment checks?
* **Card 22 (Property Sources and Resolution):** How does `@PropertySource` integrate external property files into Spring’s `Environment` abstraction property resolvers?
* **Card 23 (Type-Safe Configuration Binding):** Contrast `@Value("${...}")` injection with `@ConfigurationProperties` classes regarding type safety, nested structures, and validation.
* **Card 24 (Import and Component Scanning):** How do `@Import` and `@ComponentScan` allow modular aggregation of configuration classes across multi-module projects?
* **Card 25 (Aspect Ordering):** How does the `@Order` annotation or `Ordered` interface govern execution precedence when multiple aspects apply to the same join point?

## Phase 3: Spring Boot Fundamentals & Auto-Configuration

* **Card 26 (Spring Boot Philosophy):** What are the core pillars of Spring Boot (opinionated defaults, stand-alone apps, embedded servers, zero XML)?
* **Card 27 (Auto-Configuration Mechanics):** How does `@EnableAutoConfiguration` leverage `META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports` (formerly `spring.factories`) to load conditional configurations?
* **Card 28 (Starter Dependencies):** How do Spring Boot Starter POMs aggregate transitive dependencies to simplify dependency management for specific tech stacks?
* **Card 29 (SpringBootApplication Anatomy):** What three annotations are meta-annotated inside `@SpringBootApplication` (`@Configuration`, `@EnableAutoConfiguration`, `@ComponentScan`)?
* **Card 30 (Spring Boot Actuator Endpoints):** What operational insights do Actuator endpoints (`/health`, `/metrics`, `/env`, `/loggers`) provide for production monitoring?
* **Card 31 (Custom Health Indicators):** How do you implement a custom `HealthIndicator` to report external database or third-party service connectivity in `/actuator/health`?
* **Card 32 (Application Startup Failure Analysis):** How do Spring Boot `FailureAnalyzer` implementations translate complex stack traces into actionable startup error messages?
* **Card 33 (Externalized Configuration Precedence):** Walk through Spring Boot's property override order (command-line args, JVM system properties, OS environment variables, `application.properties`).
* **Card 34 (Spring Boot DevTools):** How do DevTools accelerate local development using automatic restarts, live reload, and classpath caching?
* **Card 35 (Banner Customization):** How can developers customize or disable the ASCII Spring Boot startup banner using `banner.txt`?
* **Card 36 (SpringApplication API Customization):** How do you programmatically configure a SpringApplication instance (e.g., setting headless mode, adding initializers) before running?
* **Card 37 (Spring Boot Test Slices):** Contrast full `@SpringBootTest` integration tests with lightweight test slices like `@WebMvcTest`, `@DataJpaTest`, and `@JsonTest`.
* **Card 38 (Application Listeners and Run Listeners):** How do `SpringApplicationRunListener` and Application Events hook into the early phases of the Spring Boot startup lifecycle?
* **Card 39 (Profile-Specific Configuration Files):** How do files named `application-{profile}.properties` override or merge with base `application.properties` settings?
* **Card 40 (Embedded Servlet Containers):** How does Spring Boot configure and embed Tomcat, Jetty, or Undertow containers without requiring external application server deployment?
* **Card 41 (Spring Boot CLI):** What is the purpose of the Spring Boot CLI for rapid prototyping with Groovy scripts?
* **Card 42 (Graceful Shutdown in Boot):** How does `server.shutdown=graceful` coordinate active request draining during application termination?
* **Card 43 (Startup Tracking):** How does `ApplicationStartup` track startup phase durations and identify boot performance bottlenecks?
* **Card 44 (Configuration Processor Metadata):** How does `spring-boot-configuration-processor` generate metadata JSON for auto-completion in IDE properties editors?
* **Card 45 (Properties Validation):** How do JSR-380 validation annotations (`@NotNull`, `@Min`) validate `@ConfigurationProperties` classes at startup?

## Phase 4: Data Access, Transactions & Spring Data

* **Card 46 (JdbcTemplate vs ORM):** When should an architecture choose lightweight `JdbcTemplate` over heavy JPA/Hibernate ORM mappings?
* **Card 47 (Declarative Transaction Management):** How does `@Transactional` leverage Spring AOP proxies to manage transaction boundaries transparently?
* **Card 48 (Transaction Propagation Behaviors):** Contrast the seven transaction propagation behaviors (`REQUIRED`, `REQUIRES_NEW`, `NESTED`, `SUPPORTS`, `NOT_SUPPORTED`, `MANDATORY`, `NEVER`).
* **Card 49 (Transaction Isolation Levels):** Explain the four isolation levels (`DEFAULT`, `READ_UNCOMMITTED`, `READ_COMMITTED`, `REPEATABLE_READ`, `SERIALIZABLE`) and concurrency anomalies they prevent.
* **Card 50 (Checked vs Unchecked Exceptions in TX):** By default, what types of exceptions trigger automatic rollback in `@Transactional` methods, and how does `rollbackFor` alter this?
* **Card 51 (Spring Data JPA Repository Pattern):** How does Spring Data JPA dynamically generate repository implementations at runtime using interface proxy definitions?
* **Card 52 (Derived Query Methods):** How do method name conventions (`findByLastNameAndAgeGreaterThan`) automatically construct JPQL queries in Spring Data?
* **Card 53 (Specifications and Criteria API):** How do `JpaSpecificationExecutor` and Criteria API construct dynamic, type-safe queries programmatically?
* **Card 54 (Auditing with Spring Data):** How do `@CreatedDate`, `@LastModifiedDate`, and `@EntityListeners(AuditingEntityListener.class)` automate audit column tracking?
* **Card 55 (Hibernate Dirty Checking):** Explain how Hibernate's persistence context tracks entity modifications during flush cycles to generate SQL UPDATE statements automatically.
* **Card 56 (Lazy Loading & N+1 Query Problem):** What causes the N+1 query problem with `LAZY` fetch associations, and how do `JOIN FETCH` or EntityGraphs resolve it?
* **Card 57 (Optimistic vs Pessimistic Locking):** Contrast `@Version` optimistic locking (detecting concurrent updates via version checks) with pessimistic locking (`PESSIMISTIC_WRITE`).
* **Card 58 (Spring Data Reactive Repositories):** How do reactive repositories (`R2DBC`, Reactive MongoDB) provide non-blocking database access using Project Reactor?
* **Card 59 (Database Migration Tools):** How do Flyway and Liquibase manage version-controlled database schema migrations during Spring Boot startup?
* **Card 60 (EntityManager and Persistence Context):** What is the difference between an EntityManager and the underlying JDBC connection pool regarding transaction lifecycles?
* **Card 61 (Second-Level Caching):** How does Hibernate's second-level cache (e.g., Ehcache, Redis) reduce database read load across multiple sessions?
* **Card 62 (Modifying Queries):** Why must update or delete queries in Spring Data JPA repositories be annotated with `@Modifying` and run within a transaction?
* **Card 63 (Pagination and Sorting):** How do `Pageable`, `Page`, and `Slice` objects handle paginated database query results efficiently?
* **Card 64 (Open Session in View Anti-Pattern):** What are the performance and connection pool risks of enabling Open Session in View (`spring.jpa.open-in-view=true`) in web applications?
* **Card 65 (Transaction Synchronization Manager):** How does `TransactionSynchronizationManager` register callbacks to execute code after transaction commit or rollback?

## Phase 5: Spring MVC & Web Development

* **Card 66 (DispatcherServlet Lifecycle):** Walk through the lifecycle of a request entering Spring MVC via the central `DispatcherServlet`.
* **Card 67 (Controller vs RestController):** Contrast `@Controller` (view resolution and HTML rendering) with `@RestController` (JSON/XML serialization via `HttpMessageConverter`).
* **Card 68 (Request Mapping Annotations):** How do `@GetMapping`, `@PostMapping`, and path variables (`@PathVariable`, `@RequestParam`, `@RequestBody`) bind request inputs?
* **Card 69 (Handler Interceptors):** How do `HandlerInterceptor` implementations (`preHandle`, `postHandle`, `afterCompletion`) differ from Servlet Filters?
* **Card 70 (Global Exception Handling):** How do `@ControllerAdvice` and `@ExceptionHandler` centralize exception mapping across all controllers into standardized error responses?
* **Card 71 (Content Negotiation):** How does Spring MVC negotiate response media types (`application/json` vs `application/xml`) using `Accept` headers or URL extensions?
* **Card 72 (Bean Validation Integration):** How do `@Valid` and Bean Validation annotations (`@NotNull`, `@Size`, `@Email`) validate incoming DTO payloads automatically?
* **Card 73 (Message Converters):** What is the role of `HttpMessageConverter` implementations (like `MappingJackson2HttpMessageConverter`) in serializing object graphs?
* **Card 74 (Multipart File Uploads):** How does `MultipartResolver` handle file uploads in Spring MVC, and how are files injected via `MultipartFile`?
* **Card 75 (CORS Configuration):** How do `@CrossOrigin` and global `CorsRegistry` configurations permit cross-origin resource sharing safely?
* **Card 76 (Servlet Filters vs Interceptors):** Contrast Servlet Filters (operating at the servlet container container level) with Spring Interceptors (operating within the DispatcherServlet context).
* **Card 77 (View Resolvers):** How do `ViewResolver` beans map logical view names to concrete rendering templates (Thymeleaf, JSP)?
* **Card 78 (Async Request Processing):** How do `Callable` and `DeferredResult` enable asynchronous request processing to free up servlet container worker threads?
* **Card 79 (Matrix Variables):** How do matrix variables (`@MatrixVariable`) extract parameters embedded within URI path segments?
* **Card 80 (Handler Methods Argument Resolvers):** How do custom `HandlerMethodArgumentResolver` implementations inject custom objects into controller method signatures?

## Phase 6: Spring Security

* **Card 81 (Security Filter Chain):** Explain how Spring Security intercepts requests using a chain of servlet filters (`SecurityFilterChain`).
* **Card 82 (Authentication vs Authorization):** Contrast Authentication (verifying who the user is via `AuthenticationManager`) with Authorization (verifying what the user can do via `AccessDecisionManager`).
* **Card 83 (Password Encoding):** Why is storing plaintext passwords forbidden, and how does `PasswordEncoder` (using BCrypt or Argon2) enforce secure hashing?
* **Card 84 (Method-Level Security):** How do `@PreAuthorize`, `@PostAuthorize`, `@Secured`, and `@EnableMethodSecurity` secure service-layer method executions?
* **Card 85 (OAuth2 Resource Server):** How does an OAuth2 Resource Server validate incoming JWT bearer tokens against a remote authorization server's JWK set?
* **Card 86 (CSRF Protection):** What is Cross-Site Request Forgery, and why does Spring Security enable CSRF token validation by default for state-changing HTTP methods?
* **Card 87 (Session Management Policies):** Contrast session creation policies (`ALWAYS`, `NEVER`, `IF_REQUIRED`, `STATELESS`) for stateless REST APIs vs stateful web apps.
* **Card 88 (Custom Authentication Providers):** How do you implement a custom `AuthenticationProvider` to integrate proprietary user directories or legacy authentication systems?
* **Card 89 (Remember-Me Authentication):** How does Spring Security implement token-based and persistent remember-me cookie authentication?
* **Card 90 (Security Context Holder Strategies):** How do `SecurityContextHolder` strategies (`MODE_THREADLOCAL`, `MODE_INHERITABLETHREADLOCAL`, `MODE_GLOBAL`) store security context across thread boundaries?

## Phase 7: Spring Cloud, Testing & Troubleshooting Scenarios

* **Card 91 (Spring Cloud Config Architecture):** How does Spring Cloud Config Server externalize configuration management across distributed microservices using Git backends?
* **Card 92 (Service Discovery with Eureka):** How do Eureka clients register with a discovery server and perform client-side load balancing?
* **Card 93 (API Gateway Routing):** How does Spring Cloud Gateway route traffic, apply filters, and handle predicate matching at the edge of a microservice architecture?
* **Card 94 (Circuit Breaker with Resilience4j):** How do Resilience4j circuit breakers, rate limiters, and retry mechanisms integrate into Spring Cloud applications?
* **Card 95 (Spring Boot Test Slices & Mockito):** How do `@WebMvcTest` combined with `@MockBean` isolate web controllers for unit testing without loading external dependencies?
* **Card 96 (Testcontainers Integration):** How does Testcontainers empower integration tests by spinning up real Docker containers (PostgreSQL, Redis, Kafka) during test execution?
* **Card 97 (Lab Scenario A - The Circular Dependency Failure):**
  * *The Setup:* A Spring Boot application fails to start with `BeanCurrentlyInCreationError` because Service A and Service B inject each other via constructors.
  * *The Challenge:* Diagnose why constructor injection circular dependencies cannot be auto-resolved, and explain how refactoring domain boundaries or switching to `@Lazy` fixes it.
* **Card 98 (Lab Scenario B - LazyInitializationException in Views):**
  * *The Setup:* A REST endpoint throws `org.hibernate.LazyInitializationException: could not initialize proxy - no Session` when serializing an entity outside a transaction.
  * *The Challenge:* Explain how closing the Hibernate session prematurely causes lazy proxy failures, and resolve it using `JOIN FETCH`, EntityGraphs, or transactional service boundaries.
* **Card 99 (Lab Scenario C - Transaction Rollback Exception Suppression):**
  * *The Setup:* An exception thrown inside a transactional method is caught and swallowed by a `try-catch` block, yet Spring still marks the transaction for rollback, throwing `UnexpectedRollbackException`.
  * *The Challenge:* Explain how marking transactions as rollback-only when an exception occurs leads to `UnexpectedRollbackException`, and how to handle or specify `noRollbackFor` correctly.
* **Card 100 (Lab Scenario D - Bean Overriding Conflict):**
  * *The Setup:* Upgrading a Spring Boot dependency causes startup failure due to duplicate bean definitions with the same name.
  * *The Challenge:* Explain how Spring Boot disables bean overriding by default (`spring.main.allow-bean-definition-overriding=false`), and how to properly configure or rename competing bean definitions.