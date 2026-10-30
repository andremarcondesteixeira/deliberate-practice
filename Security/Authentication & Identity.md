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
