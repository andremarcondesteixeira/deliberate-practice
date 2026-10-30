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
  * *Challenge:* Enforce context-aware auto-escaping everywhere, and use an HTML sanitizer (such as the OWASP Java HTML Sanitizer) only where rich text is required.
* **CSRF:** How does CSRF abuse a logged-in user's cookies to perform state-changing requests? Compare synchronizer tokens, double-submit cookies, `SameSite=Lax`/`Strict`, and origin checks. When is it safe to disable CSRF protection?
* **CORS:** What is the same-origin policy, which requests trigger an `OPTIONS` preflight, and which response headers control access (`Access-Control-Allow-Origin`, `-Credentials`, `-Methods`, `-Headers`)? Why isn't CORS a server-side security control?
* **Lab — CORS Origin Reflection:**
  * *Setup:* A sensitive internal API's gateway reflects any `Origin` header back in `Access-Control-Allow-Origin` together with `Access-Control-Allow-Credentials: true`.
  * *Challenge:* Explain why browsers reject `*` with credentials but happily accept a reflected origin, how an attacker's site can read authenticated responses, and fix it with a strict origin allowlist.
* **Security Headers:** Explain what HSTS (`max-age`, preload, SSL stripping), `X-Content-Type-Options: nosniff`, `frame-ancestors`/`X-Frame-Options` (clickjacking), and `Referrer-Policy` each prevent.

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
  * *Setup:* An email validation regex pins a Java service's request threads at 100% CPU for 30 seconds when given a crafted string of repeating characters.
  * *Challenge:* Explain catastrophic backtracking (nested quantifiers), rewrite the regex, set input length limits, or use a linear-time engine (RE2).

## Access Control & APIs

* **Lab — IDOR/BOLA:**
  * *Setup:* `/api/orders/{id}` returns any customer's order when you change the ID.
  * *Challenge:* Add object-level authorization (ownership checks in the data access layer, scoped queries), and explain why unguessable IDs alone are not a fix.
* **Lab — Mass Assignment:**
  * *Setup:* A profile update endpoint binds JSON straight onto the `User` entity, so attackers send `"isAdmin": true`.
  * *Challenge:* Use explicit request DTOs with allowlisted fields, and explain how ORMs and frameworks make this easy to get wrong.
* **API Input Validation:** How do schema validation (OpenAPI/JSON Schema), strict `Content-Type` enforcement, and size limits stop malformed, oversized, or unexpected payloads before they reach business logic?
* **WebSocket Security:** How do you prevent cross-site WebSocket hijacking (checking `Origin`, authenticating on connect) and message flooding?
* **Shadow & Zombie APIs:** What risks do undocumented (shadow) and forgotten old (zombie) API versions pose, and how do you find and retire them?
* **Web Application Firewalls:** What can a WAF realistically block, how is it bypassed, and why is it a supplement to fixing code rather than a replacement?

## Study Guide

* **Books:**
  * *The Web Application Hacker's Handbook* (Dafydd Stuttard & Marcus Pinto): the chapters on injection, attacking users (XSS, CSRF), access controls and back-end components, for how each attack really works; it is old, but the fundamentals hold.
  * *The Tangled Web* (Michal Zalewski): the chapters on the same-origin policy, content sniffing and frame security, for why CORS, CSP and the security headers exist.
  * *Hacking APIs* (Corey Ball): the chapters on exploiting authorization and mass assignment, for the Access Control & APIs section.
  * *Web Application Security* (Andrew Hoffman): the defense part on XSS, CSRF, XXE and injection, plus secure architecture, for modern mitigations.
* **Official docs:** the OWASP Top 10 and OWASP API Security Top 10; OWASP Cheat Sheet Series: SQL Injection Prevention, OS Command Injection Defense, XML External Entity Prevention, Deserialization, Cross Site Scripting Prevention, DOM based XSS Prevention, Content Security Policy, Cross-Site Request Forgery Prevention, Server Side Request Forgery Prevention, File Upload, Mass Assignment and HTTP Headers; the OWASP ASVS; the Fetch Standard's CORS section and MDN's CORS and CSP guides; JEP 290 and JEP 415 for Java deserialization filters; the AWS EC2 docs on IMDSv2.
* **Papers:** "CSP Is Dead, Long Live CSP! On the Insecurity of Whitelists and the Future of Content Security Policy" (Weichselbaum et al., 2016); "HTTP Desync Attacks: Request Smuggling Reborn" (James Kettle, PortSwigger research, 2019).
* **Related technologies:** Burp Suite and OWASP ZAP, sqlmap, ysoserial, the OWASP Java HTML Sanitizer, RE2 and its Java port RE2/J, Semgrep and CodeQL, and ModSecurity or Coraza with the OWASP Core Rule Set.
* **Search for:** `PortSwigger Web Security Academy` (free labs for nearly every card here), `blind SQL injection time based`, `SSTI payloads`, `billion laughs`, `java deserialization gadget chain`, `strict-dynamic CSP`, `CORS origin reflection`, `DNS rebinding SSRF`, `catastrophic backtracking`.
* **Hands-on:** run OWASP Juice Shop locally and attack it through Burp Suite or ZAP until you have exploited SQL injection, stored XSS and an IDOR yourself, then look for the same patterns in code you own.
