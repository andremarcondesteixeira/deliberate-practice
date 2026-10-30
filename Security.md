# Software Security & Application Defense Practice (100 Challenges)

## Phase 1: OWASP Top 10 & Injection Vulnerabilities

* **Card 1 (SQL Injection Mechanics):** Explain how SQL injection occurs when user input is concatenated directly into database queries, and contrast it with parameterized queries (prepared statements).
* **Card 2 (Blind SQL Injection):** How do attackers extract data using Boolean-based and Time-based blind SQL injection when error messages are disabled?
* **Card 3 (Stored vs Reflected XSS):** Contrast Stored XSS (persisted in a database and served to users) with Reflected XSS (immediate execution via HTTP request parameters).
* **Card 4 (DOM-Based XSS):** How does DOM-based Cross-Site Scripting occur entirely within client-side JavaScript execution without hitting the server backend?
* **Card 5 (Content Security Policy - CSP):** How does a strong Content Security Policy header mitigate XSS by restricting script execution sources and object loading?
* **Card 6 (Cross-Site Request Forgery - CSRF):** Explain how CSRF exploits an authenticated user's browser session to perform unintended state-changing actions.
* **Card 7 (CSRF Defense Mechanisms):** Compare anti-CSRF synchronizer tokens with `SameSite=Strict` and `SameSite=Lax` cookie attributes for stopping CSRF.
* **Card 8 (Server-Side Request Forgery - SSRF):** How do SSRF vulnerabilities allow attackers to trick backend servers into issuing requests to internal metadata services or private networks?
* **Card 9 (XML External Entity - XXE):** How do improperly configured XML parsers process malicious external entity references to read local system files or cause Denial of Service?
* **Card 10 (Insecure Deserialization):** What makes deserializing untrusted data streams in languages like Java, Python, or PHP dangerous, and how does it lead to Remote Code Execution (RCE)?
* **Card 11 (Path Traversal / LFI):** How do directory traversal attacks (`../../etc/passwd`) bypass inadequate input sanitization to access restricted filesystem resources?
* **Card 12 (Command Injection):** Explain how improper sanitization of inputs passed to operating system shell execution functions (`system`, `exec`) leads to arbitrary command execution.
* **Card 13 (Broken Object Level Authorization - BOLA/IDOR):** How do Insecure Direct Object References allow attackers to manipulate resource IDs in API paths to access unauthorized records?
* **Card 14 (Mass Assignment / Over-Posting):** What is mass assignment vulnerability in ORM frameworks, and how can binding raw HTTP request parameters directly to domain models expose sensitive fields?
* **Card 15 (Prototype Pollution in JavaScript):** How do recursive object merging operations in Node.js exploit prototype pollution to inject properties into the `Object.prototype`?
* **Card 16 (Server-Side Template Injection - SSTI):** How do malicious inputs evaluated by template engines (Jinja2, Thymeleaf, Freemarker) achieve remote code execution?
* **Card 17 (Regular Expression Denial of Service - ReDoS):** Why do poorly crafted regular expressions vulnerable to catastrophic backtracking cause thread starvation and Denial of Service?
* **Card 18 (HTTP Request Smuggling):** How do discrepancies in how front-end proxies and back-end servers parse `Content-Length` and `Transfer-Encoding` headers lead to request smuggling?
* **Card 19 (Clickjacking / UI Redressing):** How do transparent iframe overlays trick users into clicking hidden malicious buttons behind legitimate interfaces?
* **Card 20 (File Upload Vulnerabilities):** What security controls (content-type validation, magic number checks, isolated storage) are required to safely accept user-uploaded files?

## Phase 2: Authentication, Session Management & Identity

* **Card 21 (Secure Password Hashing):** Why are fast hashing algorithms like MD5, SHA-1, or SHA-256 insecure for passwords, and why must slow, memory-hard algorithms like Argon2id or bcrypt be used?
* **Card 22 (Salting and Peppering Passwords):** Contrast the role of a unique per-user salt (stored in the database) with a secret global pepper (stored in a secure environment variable) in password hashing.
* **Card 23 (JWT Architecture & Claims):** Deconstruct a JSON Web Token (JWT) into its three parts (Header, Payload, Signature) and explain what claims standard attributes represent.
* **Card 24 (JWT Cryptographic Algorithm Confusion):** How do attackers exploit the `none` algorithm vulnerability or force asymmetric-to-symmetric key confusion (`RS256` to `HS256`) in JWT verification?
* **Card 25 (JWT Expiration and Revocation):** Why is revoking stateless JWTs difficult before expiration, and what architectural patterns (short TTL + refresh tokens, token blacklists) solve this?
* **Card 26 (OAuth2 Authorization Code Flow with PKCE):** Why is the Authorization Code Flow with PKCE (Proof Key for Code Exchange) mandatory for securing public clients like Single Page Apps and mobile apps?
* **Card 27 (OpenID Connect - OIDC):** How does OpenID Connect build upon OAuth2 to provide standardized user authentication and identity claims via the ID Token?
* **Card 28 (Session Fixation Attacks):** How do session fixation attacks work, and why must applications regenerate session identifiers immediately upon successful authentication?
* **Card 29 (Session Hijacking via Stolen Cookies):** How do `HttpOnly`, `Secure`, and `SameSite` flags protect session cookies against XSS theft and cleartext transmission?
* **Card 30 (Multi-Factor Authentication & TOTP):** How do Time-based One-Time Passwords (TOTP based on HMAC-SHA1) generate synchronized secondary verification codes?
* **Card 31 (FIDO2 / WebAuthn / Passkeys):** How do public-key cryptography and hardware authenticators in WebAuthn eliminate phishing vulnerabilities inherent in passwords and SMS OTPs?
* **Card 32 (Role-Based Access Control - RBAC):** How does RBAC assign permissions to roles rather than individual users to streamline enterprise identity authorization?
* **Card 33 (Attribute-Based Access Control - ABAC):** How does ABAC evaluate dynamic context attributes (user department, resource classification, time of day, IP location) for fine-grained authorization?
* **Card 34 (API Key Leakage Vectors):** Why are API keys passed in URL query parameters or committed to source control hazardous, and how do scoped bearer tokens mitigate risk?
* **Card 35 (Credential Stuffing & Brute-Force Defense):** How do rate limiting, IP reputation checks, CAPTCHAs, and credential blacklists mitigate automated stuffing attacks?
* **Card 36 (Account Enumeration Vulnerabilities):** Why do verbose login or password reset error messages ("Email not found" vs "Invalid credentials") enable user enumeration, and how do you fix them?
* **Card 37 (Single Sign-On - SAML vs OIDC):** Compare SAML (XML-based enterprise federation) with OIDC (JSON/OAuth2-based modern identity) regarding complexity and modern web support.
* **Card 38 (Session Timeout Policies):** Contrast idle timeout (inactivity threshold) with absolute timeout (maximum session lifetime) in high-security applications.
* **Card 39 (Impersonation and Delegation Tokens):** How do delegation tokens and service accounts allow background worker processes to act safely on behalf of authenticated users?
* **Card 40 (Passwordless Authentication Flows):** What are the architectural trade-offs of magic link authentication versus WebAuthn passkeys?

## Phase 3: Cryptography & Data Protection

* **Card 41 (Symmetric vs Asymmetric Encryption):** Contrast symmetric ciphers (AES-256 for bulk data speed) with asymmetric cryptography (RSA/ECC for key exchange and digital signatures).
* **Card 42 (Authenticated Encryption - AES-GCM):** Why are modern authenticated encryption modes like AES-GCM superior to older CBC modes by providing both confidentiality and integrity protection?
* **Card 43 (Cryptographic Nonces and IVs):** Why must Initialization Vectors (IVs) or nonces in symmetric encryption never be reused with the same secret key?
* **Card 44 (Public Key Infrastructure - PKI):** How do Certificate Authorities (CAs), root certificates, intermediate certificates, and trust chains establish secure SSL/TLS connections?
* **Card 45 (Digital Signatures and Non-Repudiation):** How do digital signatures use private keys to sign message hashes, ensuring data integrity and non-repudiation?
* **Card 46 (Key Management Services - KMS):** Why should application secrets and encryption keys be offloaded to dedicated KMS or hardware security modules (HSMs) rather than hardcoded?
* **Card 47 (Envelope Encryption):** Explain the envelope encryption pattern (using a Master Key to encrypt a Data Key, which in turn encrypts the payload) and its scalability benefits.
* **Card 48 (Padding Oracle Attacks):** How do cryptographic padding oracle vulnerabilities allow attackers to decrypt ciphertext by observing server-side error responses?
* **Card 49 (Hashing vs Encryption vs Encoding):** Clarify the distinct purposes and reversibility of hashing (one-way), encryption (reversible with key), and encoding (representation formatting like Base64).
* **Card 50 (Perfect Forward Secrecy - PFS):** How do ephemeral Diffie-Hellman key exchanges guarantee PFS so that past recorded sessions remain secure even if long-term private keys are later compromised?
* **Card 51 (Secure Random Number Generation):** Why is standard pseudo-random number generation (`Math.random()`) insecure for security tokens, and why must cryptographically secure PRNGs (`SecureRandom`) be used?
* **Card 52 (Data Masking and Tokenization):** Contrast data masking (obfuscating PII for display) with tokenization (replacing sensitive tokens with non-sensitive surrogate values stored in a secure vault).
* **Card 53 (Homomorphic Encryption):** What is homomorphic encryption, and how does it allow computations to be performed on encrypted data without decrypting it first?
* **Card 54 (Quantum Computing Threats to Cryptography):** Which standard cryptographic algorithms (RSA, ECC) are vulnerable to Shor's algorithm on quantum computers, and what post-quantum algorithms are emerging?
* **Card 55 (Certificate Revocation Checking):** How do Online Certificate Status Protocol (OCSP) stapling and Certificate Revocation Lists (CRLs) verify whether a TLS certificate has been revoked?
* **Card 56 (Transport Layer Security - TLS 1.3):** What architectural improvements in TLS 1.3 eliminate vulnerable legacy ciphers and reduce handshake latency to 1-RTT?
* **Card 57 (Data at Rest vs Data in Transit):** How do security architectures differentiate protection mechanisms for data at rest (storage encryption) versus data in transit (TLS) and data in use (secure enclaves)?
* **Card 58 (Secrets Rotation Lifecycles):** What automated processes govern zero-downtime rotation of database credentials, API keys, and TLS certificates?
* **Card 59 (Side-Channel Attacks):** How do timing attacks or power-analysis side-channel vulnerabilities leak secret cryptographic keys from hardware implementations?
* **Card 60 (Database Column-Level Encryption):** When is application-level column encryption required over standard storage-level filesystem encryption?

## Phase 4: API Security & Web Defenses

* **Card 61 (CORS Misconfigurations):** How do wildcard Access-Control-Allow-Origin headers combined with `Access-Control-Allow-Credentials: true` lead to cross-origin data theft?
* **Card 62 (API Rate Limiting & Throttling):** Contrast IP-based rate limiting with token-bucket and sliding-window user-based rate limiting for mitigating abuse.
* **Card 63 (Web Application Firewalls - WAF):** What are the strengths and limitations of WAF signature inspection in filtering malicious Layer 7 HTTP traffic?
* **Card 64 (Essential Security Headers):** Explain the exact security purpose of HSTS, X-Content-Type-Options, X-Frame-Options, and Referrer-Policy headers.
* **Card 65 (API Versioning & Deprecation Security):** How do unmaintained legacy API versions expose deprecated endpoints and unpatched vulnerabilities to attackers?
* **Card 66 (GraphQL Security - Depth and Complexity Limiting):** Why are deeply nested queries in GraphQL vulnerable to Denial of Service, and how do query depth and complexity analysis prevent it?
* **Card 67 (GraphQL Batching Attacks):** How do attackers exploit GraphQL batching endpoints to bypass standard IP rate limits during credential stuffing attacks?
* **Card 68 (API Schema Validation):** How do OpenAPI / Swagger schema validations prevent malformed or oversized payloads from reaching backend controllers?
* **Card 69 (WebSockets Security):** How do you secure WebSocket connections against cross-site WebSocket hijacking (CSWSH) and unauthenticated message flooding?
* **Card 70 (API Gateway Security Interceptors):** What security enforcement responsibilities belong at the API Gateway layer versus internal microservices?
* **Card 71 (JSON Web Encryption - JWE):** How does JWE provide payload confidentiality for JWTs in addition to signature integrity?
* **Card 72 (Subresource Integrity - SRI):** How does Subresource Integrity use cryptographic hashes to ensure browsers only execute trusted third-party CDN scripts?
* **Card 73 (HTTP Strict Transport Security - HSTS):** How does HSTS preload and max-age configuration prevent SSL stripping Man-in-the-Middle attacks?
* **Card 74 (API Shadow and Zombie Endpoints):** What security risks do undocumented shadow APIs and forgotten zombie endpoints pose to enterprise perimeters?
* **Card 75 (Content-Type Enforcement):** Why must APIs strictly validate `Content-Type` headers (e.g., rejecting unexpected form-urlencoded payloads on JSON endpoints) to prevent injection?

## Phase 5: Secure Architecture, Supply Chain & Advanced Scenarios

* **Card 76 (Software Bill of Materials - SBOM):** What is an SBOM, and how does component transparency assist in rapid vulnerability triage during zero-day disclosures?
* **Card 77 (Supply Chain Dependency Confusion):** How do dependency confusion attacks exploit package manager resolution orders to inject malicious packages into internal builds?
* **Card 78 (Container Security - Rootless & Least Privilege):** Why should containers avoid running as root, and how do read-only root filesystems and dropped capabilities harden them?
* **Card 79 (Threat Modeling - STRIDE Methodology):** How does the STRIDE framework (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) guide architectural design reviews?
* **Card 80 (SAST vs DAST vs IAST):** Contrast Static Application Security Testing (code analysis), Dynamic Application Security Testing (black-box fuzzing), and Interactive AST.
* **Card 81 (Zero Trust Network Architecture):** What are the core tenets of Zero Trust ("Never trust, always verify"), and how does micro-segmentation replace perimeter security?
* **Card 82 (Mutual TLS - mTLS in Service Meshes):** How does mTLS provide both encryption and cryptographic workload identity authentication between internal microservices?
* **Card 83 (Infrastructure as Code Security Scanning):** How do tools like Checkov or tfsec scan Terraform and Kubernetes manifests for security misconfigurations before deployment?
* **Card 84 (Immutable Infrastructure Security):** How does replacing servers entirely rather than in-place patching eliminate persistence mechanisms for attackers?
* **Card 85 (Incident Response and Forensics Readiness):** What logging and telemetry best practices ensure forensic investigators can reconstruct attack timelines after a breach?

## Phase 6: Practical Security Scenarios & Troubleshooting

* **Card 86 (Lab Scenario A - The IDOR Privilege Escalation):**
  * *The Setup:* An e-commerce API allows users to view order details by requesting `/api/orders/{id}`. Changing the numeric ID allows viewing any other customer's order.
  * *The Challenge:* Implement object-level authorization checks that validate whether the authenticated user principal owns the requested resource ID.

* **Card 87 (Lab Scenario B - SSRF Cloud Metadata Exfiltration):**
  * *The Setup:* A web scraper service accepts a target URL parameter from users. Attackers supply `http://169.254.169.254/latest/meta-data/iam/security-credentials/` to steal IAM instance role tokens.
  * *The Challenge:* Implement strict URL parsing allowlists, block private IP ranges, and enforce IMDSv2 session token requirements.

* **Card 88 (Lab Scenario C - JWT Algorithm Confusion Exploit):**
  * *The Setup:* A backend service verifies RS256-signed JWTs using a public key. An attacker replaces the algorithm header with HS256 and signs the token using the public key as an HMAC secret.
  * *The Challenge:* Explicitly enforce expected cryptographic algorithms during JWT parsing (`Jwts.parser().verifyWith(expectedKey).build()`) to prevent algorithm substitution attacks.

* **Card 89 (Lab Scenario D - Deserialization RCE Outbreak):**
  * *The Setup:* A Java backend accepts serialized objects via RMI/HTTP. An attacker sends a crafted gadget chain payload that executes arbitrary OS commands upon deserialization.
  * *The Challenge:* Replace insecure native Java serialization with safe JSON/Protobuf formats or implement strict `ObjectInputFilter` class whitelisting.

* **Card 90 (Lab Scenario E - CORS Wildcard Data Leak):**
  * *The Setup:* A sensitive internal API endpoint sets `Access-Control-Allow-Origin: *` and `Access-Control-Allow-Credentials: true`. Browsers reject this combination, but misconfigured gateway proxies strip headers or reflect arbitrary origin inputs.
  * *The Challenge:* Fix the gateway proxy policy to dynamically validate incoming `Origin` headers against a strict whitelist instead of blindly reflecting them.

* **Card 91 (Lab Scenario F - SQL Injection in Dynamic Sort Parameters):**
  * *The Setup:* An application allows sorting database search results by accepting column names directly from user input (`ORDER BY ${sortColumn}`), leading to SQL injection.
  * *The Challenge:* Refactor the query builder to validate requested sort columns against a strict whitelist array rather than string interpolation.

* **Card 92 (Lab Scenario G - Path Traversal in File Viewer):**
  * *The Setup:* A document management service loads files using `new File(baseDir, userInputFilename)`. Attackers supply `../../etc/passwd`, which escapes the base directory.
  * *The Challenge:* Canonicalize file paths using `file.toPath().normalize()` and verify that the resulting path strictly starts with the designated base directory prefix.

* **Card 93 (Lab Scenario H - ReDoS in User Input Validation):**
  * *The Setup:* A registration form validating complex email formats uses a vulnerable regular expression that locks the Node.js event loop for 30 seconds when fed malicious repeating characters.
  * *The Challenge:* Rewrite the regular expression to eliminate catastrophic backtracking or switch to safe parsing libraries.

* **Card 94 (Lab Scenario I - Mass Assignment Vulnerability in User Profile):**
  * *The Setup:* An endpoint updating user profiles accepts an untrusted JSON payload and binds it directly to the User entity, allowing attackers to inject `isAdmin: true`.
  * *The Challenge:* Introduce explicit Data Transfer Objects (DTOs) with field-level mapping to restrict updateable attributes strictly to safe fields (e.g., bio, avatar).

* **Card 95 (Lab Scenario J - Hardcoded Secrets in Git History):**
  * *The Setup:* A developer accidentally commits a production database password into a public Git repository. Even after deleting it in the latest commit, it remains in git history.
  * *The Challenge:* Purge the secret from history using `git-filter-repo` or BFG Repo-Cleaner, invalidate the compromised credential immediately, and rotate secrets.

* **Card 96 (Lab Scenario K - XSS via Unescaped Template Rendering):**
  * *The Setup:* A server-side rendering template engine outputs user-submitted comments using unescaped raw HTML tags (`{{{comment}}}`), enabling persistent XSS in the browser.
  * *The Challenge:* Enforce auto-escaping by default across all template contexts and sanitize inputs with DOMPurify if rich text rendering is required.

* **Card 97 (Lab Scenario L - Session Fixation During Login):**
  * *The Setup:* A user visits a site anonymously, receiving session ID `A`. They log in as an administrator, but the application keeps session ID `A`. An attacker who pre-seeded session `A` now controls the admin session.
  * *The Challenge:* Call session invalidation and session regeneration (`session.invalidate()` / `request.changeSessionId()`) immediately upon authentication success.

* **Card 98 (Lab Scenario M - Unencrypted PII in Database Logs):**
  * *The Setup:* An application logging framework captures incoming HTTP request bodies for debugging, inadvertently writing unencrypted credit card numbers and SSNs to plain text log files.
  * *The Challenge:* Implement automated redaction filters in the logging pipeline to mask sensitive PII fields before log output serialization.

* **Card 99 (Lab Scenario N - Broken Rate Limiting on Password Reset):**
  * *The Setup:* A password reset endpoint allows unlimited requests per IP address, enabling attackers to flood user inboxes with spam reset tokens or brute-force OTP tokens.
  * *The Challenge:* Implement tiered rate limiting per account identifier and per IP address, backed by distributed Redis token buckets.

* **Card 100 (Lab Scenario O - Kubernetes Privileged Container Escape):**
  * *The Setup:* A Kubernetes pod deployed with `securityContext.privileged: true` suffers a container breakout, allowing attackers to mount the host filesystem and compromise the entire cluster node.
  * *The Challenge:* Remove privileged container configurations, drop unnecessary Linux capabilities, and enforce Pod Security Standards (Restricted profile) via admission controllers.