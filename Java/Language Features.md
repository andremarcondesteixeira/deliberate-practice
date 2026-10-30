# Java Language Features

## Functional Programming & Streams

* **Lambdas & Functional Interfaces:** How are lambdas compiled with `invokedynamic` and `LambdaMetafactory` instead of anonymous inner classes? What makes an interface functional, and what does `@FunctionalInterface` add?
* **Method References:** Differentiate the four kinds of method references: static, bound instance, unbound instance (arbitrary object of a type), and constructor.
* **Default Methods:** How do default methods let interfaces evolve without breaking implementations, and how is the diamond problem resolved when two interfaces provide the same default?
* **Intermediate vs Terminal Operations:** Contrast lazy intermediate operations (stateless vs stateful, like `sorted` and `distinct`) with terminal operations. Why does nothing run until a terminal operation, and how do short-circuiting operations like `limit()` make infinite streams (`Stream.iterate`, `Stream.generate`) usable?
* **reduce vs collect:** Contrast `reduce()` (immutable reduction) with `collect()` (mutable reduction). Why is using `reduce` to build a list a bug in parallel streams?
* **Custom Collectors:** How do you build a collector with `Collector.of()` (supplier, accumulator, combiner, finisher, characteristics)?
* **Primitive Streams:** Why use `IntStream`/`LongStream`/`DoubleStream` instead of `Stream<Integer>`, and what do `boxed()` and `mapToObj()` cost?
* **Parallel Streams:** When do parallel streams hurt (small data, sources that split poorly like `LinkedList`, blocking I/O, shared mutable state, ordering constraints)? Why is relying on the common `ForkJoinPool` risky in servers?
* **Lab — Sliding Windows with Gatherers:**
  * *Setup:* You need to turn a stream of sensor readings into sliding windows of 10 readings with a step of 2.
  * *Challenge:* Explain why this was awkward before Stream Gatherers (final in Java 24), then implement it with a custom `Gatherer` (`Gatherer.ofSequential` with state, an integrator, and a finisher) and compare it with the built-in `Gatherers.windowSliding`.
* **Stream.toList() vs Collectors.toList():** How do `stream.toList()` (Java 16), `Collectors.toList()`, and `Collectors.toUnmodifiableList()` differ in mutability and null handling?
* **Files.lines & Resource Handling:** How does `Files.lines()` stream a file lazily, and why must you close it (try-with-resources) unlike most streams?
* **Optional:** What is `Optional` designed for (return types), why is it discouraged for fields, parameters, and collections, and why is `get()` without a check a smell?
* **Comparator Composition:** How do `Comparator.comparing()`, `thenComparing()`, `reversed()`, and `nullsFirst()` build multi-key sorts? Why does `comparing(p -> p.name()).reversed()` sometimes fail to compile?
* **Map Compute & Merge:** How do `putIfAbsent`, `computeIfAbsent`, `compute`, and `merge` remove boilerplate? Why must you never modify the map inside the mapping function?
* **java.time:** Why did `java.time` replace `Date` and `Calendar` (immutability, distinct types)? When do you use `Instant`, `LocalDateTime`, `ZonedDateTime`, `OffsetDateTime`, `Duration`, and `Period`?

## Modern Language Features

* **Local Variable Type Inference:** Where can `var` be used (locals, loops, lambda parameters since Java 11 so you can annotate them) and where can't it? Which readability guidelines apply?
* **Text Blocks:** How do text blocks handle indentation stripping, trailing spaces, line continuations (`\`), and escapes?
* **Switch Expressions:** How do switch expressions (arrow labels, multiple labels per case, `yield`, exhaustiveness) differ from the old switch statement?
* **Records:** What do records generate (canonical constructor, accessors, `equals`/`hashCode`/`toString`)? Why are they only shallowly immutable, how do compact constructors validate and normalize, and why does record deserialization always go through the canonical constructor?
* **Sealed Classes:** How do `sealed` and `permits` restrict a hierarchy, what must subclasses declare (`final`, `sealed`, `non-sealed`), and how does that enable exhaustive `switch` without `default`?
* **Pattern Matching for instanceof & switch:** How do type patterns in `instanceof` and `switch` (Java 21) work, including guards (`case String s when s.length() > 5`), `case null`, and dominance rules?
* **Record Patterns:** How do record patterns deconstruct nested records in `instanceof` and `switch`, and how is generic type inference handled?
* **Unnamed Variables & Patterns:** How do `_` unnamed variables and patterns (final in Java 22) clean up unused catch parameters, lambda parameters, and pattern components?
* **Primitive Types in Patterns:** What does the Java 25 preview of primitive types in patterns, `instanceof`, and `switch` add (e.g., a safe narrowing check with `instanceof byte b`)?
* **Data-Oriented Programming:** How do records, sealed interfaces, and pattern matching combine into data-oriented programming (algebraic data types plus exhaustive switches) as an alternative to visitor-heavy OOP?
* **Flexible Constructor Bodies:** What do flexible constructor bodies (final in Java 25) allow before `super(...)`/`this(...)`, such as argument validation, and what is still forbidden there?
* **Compact Source Files & Instance Main:** How do compact source files, instance `main` methods, and module import declarations (final in Java 25, JEPs 512 and 511) simplify small programs? How does the `java` launcher run source files directly (multi-file programs since Java 22)?

## Study Guide

* **Books:**
  * *Modern Java in Action* (Raoul-Gabriel Urma, Mario Fusco & Alan Mycroft): the parts on lambdas, streams, collectors, parallel streams, default methods, `Optional` and the date and time API. This is the best single source for the first half of this deck.
  * *Effective Java* (Joshua Bloch): the chapter on lambdas and streams (method references, side-effect-free stream functions, parallel streams) and the item on returning optionals judiciously.
  * *Core Java, Volume I: Fundamentals* (Cay S. Horstmann): a recent edition covers records, sealed classes, switch expressions, pattern matching and text blocks alongside the classics.
  * *Cruising Along with Java* (Venkat Subramaniam): a short, example-driven tour of the features added since Java 8, from `var` and text blocks to records, sealed classes and pattern matching.
* **Official docs:** the `java.util.stream` package summary in the JDK API docs (non-interference, statelessness, reduction and mutable reduction) and the `Gatherer` javadoc; the Java Language Specification sections on lambda expressions, records, sealed classes, `switch` and patterns; Brian Goetz's "Translation of Lambda Expressions" (OpenJDK) for `invokedynamic`; and the JEP for each feature, e.g. JEP 395 (Records), JEP 409 (Sealed Classes), JEP 441 (Pattern Matching for switch), JEP 440 (Record Patterns), JEP 456 (Unnamed Variables & Patterns), JEP 485 (Stream Gatherers), JEP 507 (Primitive Types in Patterns, third preview), JEP 513 (Flexible Constructor Bodies), and JEPs 511 and 512.
* **Related technologies:** compare Scala case classes and pattern matching, Kotlin data classes, sealed classes and `when`, algebraic data types in Haskell or OCaml, and functional libraries like Vavr.
* **Search for:** `Data-Oriented Programming in Java` (Brian Goetz's InfoQ article), `LambdaMetafactory invokedynamic`, `stream non-interference stateless`, `reduce vs collect mutable reduction`, `pattern dominance switch`, `Gatherers.windowSliding`, `Instant vs LocalDateTime vs ZonedDateTime`, and Stuart Marks's talk "Optional: The Mother of All Bikesheds".
* **Hands-on:** model a small expression language as a sealed interface of records, write an evaluator as one exhaustive `switch` with record patterns, then add a new record type and watch the compiler flag every switch you must update.
