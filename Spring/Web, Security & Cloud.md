# Spring Web, Security & Cloud

## Spring MVC

* **DispatcherServlet:** Walk through a request in Spring MVC: filters, `DispatcherServlet`, handler mapping, interceptors, handler adapter, argument resolution, return value handling, and exception resolution.
* **Filters vs Interceptors:** Contrast servlet filters (container level, before Spring MVC) with `HandlerInterceptor` (`preHandle`, `postHandle`, `afterCompletion`, inside MVC). Which one do you use for auth, logging, and timing?
* **Argument Resolvers:** How are `@PathVariable`, `@RequestParam`, `@RequestBody`, and `@RequestHeader` resolved by `HandlerMethodArgumentResolver`s, and how do you write a custom resolver (e.g., to inject the current tenant)?
* **Message Converters & Content Negotiation:** How does `@RestController` (`@Controller` + `@ResponseBody`) use `HttpMessageConverter`s such as the Jackson converter, and how is the response media type chosen from the `Accept` header?
* **Validation:** How do `@Valid` and `@Validated` trigger Bean Validation on request bodies and method parameters, and how do they differ (groups, method-level validation)?
* **Global Exception Handling:** How do `@RestControllerAdvice` and `@ExceptionHandler` centralize error mapping, and how does `ProblemDetail` (RFC 9457, formerly RFC 7807) standardize error responses?
* **Async Request Processing:** How do `Callable`, `DeferredResult`, and `SseEmitter` free servlet threads, and how does that compare with WebFlux or virtual threads?

## Spring Security

* **Security Filter Chain:** How does Spring Security plug into the servlet container (`DelegatingFilterProxy`, `FilterChainProxy`, one or more `SecurityFilterChain`s)? How do you see which filters run?
* **Authentication vs Authorization:** How do `AuthenticationManager`/`AuthenticationProvider` authenticate, and how does `AuthorizationManager` (which replaced `AccessDecisionManager` in Spring Security 6) authorize requests?
* **Custom Authentication Providers:** How do you implement an `AuthenticationProvider` for a legacy user directory, and where do `UserDetailsService` and `PasswordEncoder` (`DelegatingPasswordEncoder`) fit?
* **Method Security:** How do `@EnableMethodSecurity`, `@PreAuthorize`, `@PostAuthorize`, and `@PostFilter` secure service methods, and why does self-invocation bypass them?
* **OAuth2 Resource Server:** How does a resource server validate JWT bearer tokens against the issuer's JWK set (signature, `exp`, `iss`, `aud`), and how do you map claims and scopes to authorities?
* **Stateless APIs & CSRF:** What do the `SessionCreationPolicy` values (`ALWAYS`, `IF_REQUIRED`, `NEVER`, `STATELESS`) do? When is disabling CSRF safe (bearer tokens in headers), and when is it a vulnerability (cookie-based auth)?
* **SecurityContext Propagation:** How does `SecurityContextHolder` store the context (`MODE_THREADLOCAL`, `MODE_INHERITABLETHREADLOCAL`, `MODE_GLOBAL`), and how do you propagate it to `@Async` tasks, executors, and reactive code?

## Spring Cloud & Testing

* **Spring Cloud Config:** How does a Config Server serve Git-backed configuration to services, and how do clients refresh it (`@RefreshScope`, Spring Cloud Bus)? What do you gain or lose compared with Kubernetes ConfigMaps?
* **Eureka:** How do Eureka clients register, renew leases, and fetch the registry for client-side load balancing? What is Eureka's self-preservation mode?
* **Spring Cloud Gateway:** How do routes, predicates, and filters work, and why is the gateway built on a reactive stack?
* **Resilience4j:** How do Resilience4j's circuit breaker, retry, rate limiter, bulkhead, and time limiter integrate with Spring Boot, and in which order are they applied when combined?
* **Test Slices & Mocks:** Contrast `@SpringBootTest` with slices like `@WebMvcTest`, `@DataJpaTest`, and `@JsonTest`. How do `@MockitoBean` (which replaced the deprecated `@MockBean` in Boot 3.4) and context caching affect test speed?
* **Testcontainers:** How does Testcontainers run real dependencies (PostgreSQL, Kafka, Redis) in tests, and how do `@ServiceConnection` and reusable containers simplify setup?
