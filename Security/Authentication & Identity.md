# Authentication & Identity

## Passwords & Credentials

* **Password Storage:** Why are fast hashes (MD5, SHA-256) unsafe for passwords, and why use slow, memory-hard functions (Argon2id, scrypt, bcrypt)? Contrast a per-user salt with a secret pepper, and explain how you upgrade hashes over time.
* **Lab — Credential Stuffing & Reset Abuse:**
  * *Setup:* Attackers replay leaked credentials against the login endpoint and flood the password-reset endpoint, which has no rate limit, to spam users and brute-force reset codes.
  * *Challenge:* Layer defenses: rate limits per account and per IP (e.g., Redis token buckets), breached-password checks, bot detection/CAPTCHA, MFA, short-lived single-use reset tokens, and alerting.
* **Account Enumeration:** How do different login and reset messages or response times ("email not found" vs "wrong password") reveal which accounts exist, and how do you fix both the messages and the timing?
* **MFA & TOTP:** How does TOTP derive codes from a shared secret and the time (HMAC over 30-second steps)? Why are SMS codes and TOTP still phishable?
* **WebAuthn & Passkeys:** How does WebAuthn's origin-bound public-key challenge-response make phishing ineffective? How do passkeys compare with magic links?
* **API Keys:** Why are API keys in URLs dangerous (logs, browser history, referrers), and how do scoped, short-lived bearer tokens reduce the blast radius?

## Sessions

* **Session Cookies:** How do `HttpOnly`, `Secure`, `SameSite`, and the `__Host-` prefix protect session cookies? Contrast idle timeouts with absolute timeouts.
* **Lab — Session Fixation:**
  * *Setup:* A user gets session ID `A` as a guest, logs in as an admin, and the app keeps using `A`. An attacker who planted `A` now has an admin session.
  * *Challenge:* Regenerate the session ID on login and on privilege change (`request.changeSessionId()`), and explain how frameworks such as Spring Security do it by default.

## Tokens

* **JWT Structure:** Deconstruct a JWT (header, payload, signature) and its registered claims (`iss`, `sub`, `aud`, `exp`, `nbf`, `iat`, `jti`). What does a JWS protect, and when do you need JWE for confidentiality?
* **JWT vs Opaque Tokens & Revocation:** Compare self-contained JWTs with opaque tokens checked via introspection. Why are JWTs hard to revoke, and how do short lifetimes, refresh token rotation, and deny lists help?
* **Lab — JWT Algorithm Confusion:**
  * *Setup:* A service verifies RS256 tokens with a public key. An attacker switches the header to HS256 and signs the token with the public key as the HMAC secret. Another attacker sends `alg: none`.
  * *Challenge:* Explain why both attacks work against naive libraries, and fix verification by pinning the expected algorithm and key type.

## Delegated Auth & Federation

* **OAuth 2.0 Authorization Code + PKCE:** Walk through the authorization code flow with PKCE. Why is PKCE required for SPAs and mobile apps (and now recommended for all clients), and why was the implicit flow deprecated?
* **OpenID Connect vs SAML:** How does OIDC add authentication on top of OAuth 2.0 (ID token, `nonce`, UserInfo)? Compare it with SAML for enterprise SSO.
* **Delegation & Token Exchange:** How can a background job or downstream service act on behalf of a user safely (OAuth token exchange, on-behalf-of flows, narrowly scoped service accounts) instead of forwarding the user's token everywhere?

## Authorization

* **RBAC vs ABAC:** Contrast role-based access control with attribute-based access control (department, resource classification, time, location). When does RBAC "role explosion" push you toward ABAC or relationship-based access control (Zanzibar-style)?

## Study Guide

* **Books:**
  * *API Security in Action* (Neil Madden): the chapters on session cookie authentication, token-based authentication, self-contained tokens and JWTs, OAuth2 and OpenID Connect, and identity-based access control, covering most of this deck in one place.
  * *OAuth 2 in Action* (Justin Richer & Antonio Sanso): the chapters on the authorization code flow, client types, common vulnerabilities and OpenID Connect, for PKCE and why the implicit flow was deprecated.
  * *Solving Identity Management in Modern Applications* (Yvonne Wilson & Abhishek Hingnikar): the chapters on OIDC, SAML, sessions and MFA, for the federation and enterprise SSO picture.
  * *Spring Security in Action* (Laurențiu Spilcă): the chapters on authentication, CSRF and OAuth 2 resource servers, for how a framework applies these defenses by default.
* **Official docs:** NIST SP 800-63B (Digital Identity Guidelines: authentication, passwords, MFA); OWASP Cheat Sheet Series: Password Storage, Authentication, Session Management, Forgot Password, Credential Stuffing Prevention and JSON Web Token; RFC 9106 (Argon2) and RFC 6238 (TOTP); the W3C Web Authentication specification; RFC 6749 (OAuth 2.0), RFC 7636 (PKCE), RFC 9700 (OAuth 2.0 Security Best Current Practice), RFC 8693 (Token Exchange) and RFC 7662 (Token Introspection); RFC 7519 (JWT), RFC 7515 (JWS), RFC 7516 (JWE) and RFC 8725 (JWT Best Current Practices); OpenID Connect Core 1.0; the OASIS SAML 2.0 standard; NIST SP 800-162 (ABAC).
* **Papers:** "Zanzibar: Google's Consistent, Global Authorization System" (Pang et al., 2019).
* **Related technologies:** Keycloak, Auth0/Okta, Microsoft Entra ID and Spring Authorization Server as identity providers; OpenFGA, SpiceDB, Cedar and OPA for authorization; Have I Been Pwned's Pwned Passwords range API for breached-password checks.
* **Search for:** `argon2id parameters`, `rehash password on login`, `account enumeration timing`, `TOTP HMAC time step`, `passkeys phishing resistance`, `__Host- cookie prefix`, `session fixation`, `JWT algorithm confusion`, `refresh token rotation`, `OAuth PKCE`, `RBAC role explosion`.
* **Hands-on:** run Keycloak in Docker, register a public client, walk the authorization code + PKCE flow by hand with `curl`, then decode the ID and access tokens and list every claim your API should validate.
