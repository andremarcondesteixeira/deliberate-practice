# Application Security

## Injection

* **SQL Injection:** How does SQL injection happen when input is concatenated into queries? How do parameterized queries stop it, and how do boolean-based and time-based blind injection extract data when errors are hidden?
* **Lab — SQL Injection via Sort Parameter:**
  * *Setup:* An endpoint builds `ORDER BY ${sortColumn}` from a query parameter.
  * *Challenge:* Explain why bind parameters can't be used for identifiers, and fix it with an allowlist that maps user-facing names to column names.
* **Command Injection:** How does passing unsanitized input to shell execution (`system`, `exec`, `Runtime.exec` via a shell) lead to arbitrary command execution? Why is avoiding the shell (argument arrays) better than escaping?
* **Server-Side Template Injection:** How does evaluating user input as a template (Jinja2, Thymeleaf, FreeMarker) lead to remote code execution?
* **XXE:** How do XML parsers with external entities enabled leak local files, perform SSRF, or cause denial of service (billion laughs)? How do you configure parsers safely?
* **Lab — Deserialization RCE:**
  * *Setup:* A Java backend accepts native serialized objects over HTTP. An attacker sends a gadget chain that runs OS commands during deserialization.
  * *Challenge:* Explain why deserializing untrusted data is dangerous in Java, Python (pickle), and PHP, then replace native serialization with JSON/Protobuf or enforce strict `ObjectInputFilter` allowlists (JEP 290/415).

## Cross-Site Attacks

* **XSS Types:** Contrast stored, reflected, and DOM-based XSS. Why doesn't server-side escaping alone stop DOM-based XSS?
* **Content Security Policy:** How does a strict CSP (nonces or hashes, `strict-dynamic`, no `unsafe-inline`) limit the damage of XSS? Why are allowlist-based CSPs often bypassable?
* **Lab — XSS via Unescaped Templates:**
  * *Setup:* A server-side template renders user comments as raw HTML (`{{{comment}}}`), allowing persistent XSS.
  * *Challenge:* Enforce context-aware auto-escaping everywhere, and use an HTML sanitizer (DOMPurify, OWASP Java HTML Sanitizer) only where rich text is required.
* **CSRF:** How does CSRF abuse a logged-in user's cookies to perform state-changing requests? Compare synchronizer tokens, double-submit cookies, `SameSite=Lax`/`Strict`, and origin checks. When is it safe to disable CSRF protection?
* **CORS:** What is the same-origin policy, which requests trigger an `OPTIONS` preflight, and which response headers control access (`Access-Control-Allow-Origin`, `-Credentials`, `-Methods`, `-Headers`)? Why isn't CORS a server-side security control?
* **Lab — CORS Origin Reflection:**
  * *Setup:* A sensitive internal API's gateway reflects any `Origin` header back in `Access-Control-Allow-Origin` together with `Access-Control-Allow-Credentials: true`.
  * *Challenge:* Explain why browsers reject `*` with credentials but happily accept a reflected origin, how an attacker's site can read authenticated responses, and fix it with a strict origin allowlist.
* **Security Headers:** Explain what HSTS (`max-age`, preload, SSL stripping), `X-Content-Type-Options: nosniff`, `frame-ancestors`/`X-Frame-Options` (clickjacking), and `Referrer-Policy` each prevent.
* **Subresource Integrity:** How does SRI make sure the browser only runs third-party CDN scripts that match a known hash?

## Server-Side Vulnerabilities

* **Lab — SSRF to Cloud Credentials:**
  * *Setup:* A URL-preview service fetches any user-supplied URL. Attackers request `http://169.254.169.254/latest/meta-data/iam/security-credentials/` and steal the instance role's credentials.
  * *Challenge:* Explain SSRF and why blocklists are bypassable (redirects, DNS rebinding, alternate IP encodings), then fix it with allowlists, resolving and checking IPs before connecting, egress controls, and IMDSv2 (session tokens, hop limit 1).
* **Lab — Path Traversal:**
  * *Setup:* A document viewer opens `new File(baseDir, userInputFilename)`. Attackers request `../../etc/passwd`.
  * *Challenge:* Canonicalize with `toPath().normalize()` (or `toRealPath()` to resolve symlinks) and verify that the result still starts with the base directory. Why is stripping `../` not enough?
* **File Uploads:** Which controls make file uploads safe (size limits, checking magic bytes instead of trusting `Content-Type`, random file names, storage outside the web root or in object storage, malware scanning, serving from a separate domain)?
* **HTTP Request Smuggling:** How do disagreements between a front-end proxy and a back-end server about `Content-Length` and `Transfer-Encoding` let attackers smuggle requests? How does end-to-end HTTP/2 help?
* **Lab — ReDoS:**
  * *Setup:* An email validation regex locks a Node.js event loop for 30 seconds when given a crafted string of repeating characters.
  * *Challenge:* Explain catastrophic backtracking (nested quantifiers), rewrite the regex, set input length limits, or use a linear-time engine (RE2).
* **Prototype Pollution:** How do unsafe recursive merges in JavaScript let attackers set properties on `Object.prototype`, and how can that escalate to privilege bypass or RCE?

## Access Control & APIs

* **Lab — IDOR/BOLA:**
  * *Setup:* `/api/orders/{id}` returns any customer's order when you change the ID.
  * *Challenge:* Add object-level authorization (ownership checks in the data access layer, scoped queries), and explain why unguessable IDs alone are not a fix.
* **Lab — Mass Assignment:**
  * *Setup:* A profile update endpoint binds JSON straight onto the `User` entity, so attackers send `"isAdmin": true`.
  * *Challenge:* Use explicit request DTOs with allowlisted fields, and explain how ORMs and frameworks make this easy to get wrong.
* **API Input Validation:** How do schema validation (OpenAPI/JSON Schema), strict `Content-Type` enforcement, and size limits stop malformed, oversized, or unexpected payloads before they reach business logic?
* **GraphQL Abuse:** How do deeply nested queries and batching/aliases enable denial of service and rate-limit bypass (e.g., thousands of login attempts in one request)? How do depth limits, complexity analysis, and persisted queries help?
* **WebSocket Security:** How do you prevent cross-site WebSocket hijacking (checking `Origin`, authenticating on connect) and message flooding?
* **Shadow & Zombie APIs:** What risks do undocumented (shadow) and forgotten old (zombie) API versions pose, and how do you find and retire them?
* **Web Application Firewalls:** What can a WAF realistically block, how is it bypassed, and why is it a supplement to fixing code rather than a replacement?
