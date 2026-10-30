# Spring Core & Spring Boot

## IoC Container

* **Inversion of Control & DI:** How does IoC move dependency wiring out of your code? Compare constructor, setter, and field injection, and explain why constructor injection is recommended.
* **BeanFactory vs ApplicationContext:** What does `ApplicationContext` add on top of `BeanFactory` (events, i18n, eager singleton creation, automatic BeanPostProcessor registration, the environment)?
* **Bean Scopes:** Contrast `singleton`, `prototype`, `request`, `session`, and `application`. What happens when you inject a prototype or request-scoped bean into a singleton, and how do scoped proxies or `ObjectProvider` fix it?
* **Bean Lifecycle:** Trace a bean's lifecycle: instantiation, property population, `*Aware` callbacks, `BeanPostProcessor` before-init, `@PostConstruct`/`afterPropertiesSet`/init methods, after-init (proxying), `SmartInitializingSingleton`, and destruction. Why is overusing `*Aware` interfaces an anti-pattern?
* **BeanPostProcessor vs BeanFactoryPostProcessor:** Contrast processors that modify bean *instances* (e.g., wrapping them in proxies) with those that modify bean *definitions* before instantiation (e.g., resolving property placeholders).
* **@Primary & @Qualifier:** How do `@Primary`, `@Qualifier`, and injecting `List<T>`/`Map<String, T>` resolve multiple candidate beans?
* **@Configuration Full vs Lite Mode:** Why do `@Bean` methods in a `@Configuration` class return the same singleton when they call each other (CGLIB proxy), but not in a `@Component` class? What does `proxyBeanMethods = false` do, and how do `@Import` and `@ComponentScan` assemble configuration?
* **Conditional Beans:** How do `@Conditional` and custom `Condition` implementations register beans based on the environment?
* **Application Events:** How do `ApplicationEventPublisher` and `@EventListener` decouple components, and are listeners synchronous? How do `@TransactionalEventListener` phases (e.g., `AFTER_COMMIT`) and `TransactionSynchronizationManager` callbacks tie side effects to the transaction outcome?
* **Lazy Initialization:** What are the trade-offs of `spring.main.lazy-initialization=true` (faster startup vs late failures and slow first requests)?
* **Lab — Circular Dependency:**
  * *Setup:* After an upgrade, startup fails with `BeanCurrentlyInCreationException`: Service A and Service B inject each other through constructors.
  * *Challenge:* Explain why constructor cycles can't be resolved, why Spring Boot 2.6+ forbids circular references by default even with field injection, and fix it by redesigning responsibilities (extract a third bean, use events) rather than reaching for `@Lazy` or re-enabling cycles.

## AOP

* **AOP Concepts & Advice Types:** Define aspect, advice, join point, pointcut, and weaving. Differentiate `@Before`, `@AfterReturning`, `@AfterThrowing`, `@After`, and `@Around`.
* **Pointcut Expressions:** How do designators like `execution`, `within`, `@annotation`, `@within`, and `bean` select join points?
* **JDK Proxies vs CGLIB & Self-Invocation:** Contrast interface-based JDK dynamic proxies with subclass-based CGLIB proxies. Why does calling an `@Transactional` or `@Async` method from the same class bypass the proxy, and what are the fixes?
* **Aspect Ordering:** How do `@Order`/`Ordered` decide aspect precedence, and why does the order of transaction, retry, and caching advice matter?

## Configuration

* **Externalized Configuration Precedence:** Walk through Spring Boot's property source order (command-line arguments, system properties, environment variables, profile-specific files, `application.properties`, `@PropertySource`). How do relaxed binding and `spring.config.import` work?
* **Profiles:** How do `@Profile`, `spring.profiles.active`, `application-{profile}.yml`, and profile groups select configuration? Why is business logic that depends on profiles a smell?
* **@Value vs @ConfigurationProperties:** Contrast `@Value("${...}")` (and SpEL) with type-safe `@ConfigurationProperties` regarding nesting, relaxed binding, immutability (constructor binding), and validation with `@Validated`.

## Spring Boot

* **Auto-Configuration:** How does `@SpringBootApplication` (= `@SpringBootConfiguration` + `@EnableAutoConfiguration` + `@ComponentScan`) load auto-configurations from `META-INF/spring/...AutoConfiguration.imports`? How do `@ConditionalOnClass`/`@ConditionalOnMissingBean` let your own beans override defaults, and how do you find out why something was or wasn't configured?
* **Starters:** What does a starter contain, and how does the Spring Boot BOM manage dependency versions?
* **Startup Lifecycle:** Walk through what `SpringApplication.run()` does: environment preparation, context creation, refresh, runners. Where do `SpringApplicationRunListener`, `ApplicationContextInitializer`, and lifecycle events fit, and how does `ApplicationStartup` help profile slow startups?
* **Embedded Servers:** How does Boot create and configure an embedded Tomcat, Jetty, or Undertow, and how do you tune its threads and connection limits? What does `spring.threads.virtual.enabled` change?
* **Graceful Shutdown:** How does `server.shutdown=graceful` with `spring.lifecycle.timeout-per-shutdown-phase` drain requests, and how does it interact with Kubernetes pod termination?
* **Actuator & Health:** What do the main Actuator endpoints expose (`health`, `metrics` via Micrometer, `env`, `loggers`, `prometheus`)? How do you write a custom `HealthIndicator`, and why should liveness and readiness health groups check different things?
* **Lab — Duplicate Bean Definitions:**
  * *Setup:* After a dependency upgrade, startup fails because two bean definitions share the same name.
  * *Challenge:* Explain why Boot disables bean definition overriding by default, and fix it by renaming or conditionalizing a bean instead of setting `spring.main.allow-bean-definition-overriding=true`.
