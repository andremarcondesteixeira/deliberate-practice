# Cryptography & TLS

## Primitives

* **Hashing vs Encryption vs Encoding:** Clarify the purpose and reversibility of hashing (one-way), encryption (reversible with a key), and encoding (representation, e.g., Base64). Where does a MAC fit?
* **Symmetric vs Asymmetric Crypto:** Contrast symmetric ciphers (AES for bulk data) with asymmetric cryptography (RSA/ECC for key exchange and signatures). Why do real protocols combine them?
* **Authenticated Encryption & Nonces:** Why are AEAD modes like AES-GCM or ChaCha20-Poly1305 preferred over CBC, and why is reusing a nonce with the same key catastrophic for GCM?
* **Padding Oracle Attacks:** How can differences in decryption errors for CBC ciphertext let attackers decrypt data byte by byte?
* **Digital Signatures:** How do signatures over a hash provide integrity, authenticity, and non-repudiation? How is that different from a MAC?
* **Secure Randomness:** Why are `Math.random()`/`java.util.Random` unsafe for tokens, and what does a CSPRNG (`SecureRandom`, `/dev/urandom`) guarantee?
* **Side-Channel Attacks:** How do timing and power side channels leak secrets, and why must secret comparisons be constant-time?
* **Post-Quantum Cryptography:** Why does Shor's algorithm threaten RSA and ECC far more than AES-256? What are ML-KEM (Kyber) and ML-DSA, why is "harvest now, decrypt later" a reason to adopt hybrid key exchange today, and how does Java's KEM API support it?

## TLS & PKI

* **TLS 1.3:** What did TLS 1.3 remove (RSA key exchange, static DH, CBC suites, renegotiation) and improve (1-RTT handshake, encrypted certificates)? What replay risk comes with 0-RTT data?
* **Perfect Forward Secrecy:** How does ephemeral (EC)DHE keep past sessions safe even if the server's long-term private key leaks later?
* **Certificate Chain Validation:** Walk through how a client validates a certificate: chain to a trusted root via intermediates, signatures, validity dates, hostname (SAN), key usage. What breaks when a server doesn't send its intermediate?
* **Certificate Revocation:** Compare CRLs, OCSP, OCSP stapling, and short-lived certificates. Why does revocation checking often "fail open"?
* **Mutual TLS:** How does mTLS authenticate both sides, and how do service meshes use it with automatically rotated certificates (SPIFFE IDs) as workload identity?

## Key & Data Protection

* **KMS, HSMs & Envelope Encryption:** Why should keys live in a KMS or HSM rather than in code or config? Explain envelope encryption (a key-encryption key in the KMS protecting data keys, as with AWS KMS `GenerateDataKey`) and why it scales.
* **Data at Rest, in Transit & in Use:** How do protections differ for data at rest (disk/storage encryption), in transit (TLS), and in use (enclaves, confidential computing)? Which threats does disk encryption not stop?
* **Column-Level Encryption:** When do you need application-level or column-level encryption on top of storage encryption, and what does it cost (querying, indexing, key management)?
* **Masking vs Tokenization:** Contrast data masking (hiding data for display or test copies) with tokenization (replacing data with surrogates mapped in a vault). Why does tokenization shrink PCI scope?

## Study Guide

* **Books:**
  * *Serious Cryptography* (Jean-Philippe Aumasson): the chapters on randomness, block ciphers, authenticated encryption, hash functions, RSA, elliptic curves and TLS (the second edition adds post-quantum cryptography), for the Primitives section.
  * *Real-World Cryptography* (David Wong): the chapters on authenticated encryption, key exchange, signatures, secure transport and post-quantum cryptography, for how primitives combine in real protocols and where they fail.
  * *Bulletproof TLS and PKI* (Ivan Ristić): the chapters on the TLS protocol, PKI, revocation and server configuration, for the TLS & PKI section.
  * *Cryptography Engineering* (Niels Ferguson, Bruce Schneier & Tadayoshi Kohno): the parts on implementation issues and key management, for side channels and keeping keys out of code.
* **Official docs:** RFC 8446 (TLS 1.3, including its 0-RTT replay discussion), RFC 5280 (X.509 certificate and CRL profile), RFC 6960 (OCSP), RFC 6066 (TLS extensions, including the certificate status request used for OCSP stapling), NIST SP 800-38D (GCM), FIPS 203 (ML-KEM) and FIPS 204 (ML-DSA), JEP 452 (Key Encapsulation Mechanism API) and JEP 496 (ML-KEM in the JDK), the SPIFFE specifications, the AWS KMS docs on envelope encryption, and OWASP Cheat Sheet Series: Cryptographic Storage, Transport Layer Security and Key Management.
* **Papers:** "Timing Attacks on Implementations of Diffie-Hellman, RSA, DSS, and Other Systems" (Paul Kocher, 1996); "Security Flaws Induced by CBC Padding: Applications to SSL, IPSEC, WTLS..." (Serge Vaudenay, 2002); "Nonce-Disrespecting Adversaries: Practical Forgery Attacks on GCM in TLS" (Böck et al., 2016).
* **Related technologies:** OpenSSL and `openssl s_client`, Google Tink and libsodium (misuse-resistant APIs), AWS KMS and CloudHSM, Vault's Transit secrets engine, Let's Encrypt and ACME, cert-manager, SPIRE, Certificate Transparency logs, and confidential computing platforms (AWS Nitro Enclaves, AMD SEV-SNP, Intel TDX).
* **Search for:** `Cryptopals challenges` (hands-on attacks, including CBC padding oracles), `AES-GCM nonce reuse forbidden attack`, `constant time comparison`, `harvest now decrypt later`, `X25519MLKEM768 hybrid key exchange`, `OCSP soft fail`, `missing intermediate certificate`, `envelope encryption data key`, `tokenization PCI scope`.
* **Hands-on:** use `openssl s_client -showcerts` against a few public sites, save the chain, verify it by hand with `openssl verify`, then drop the intermediate and watch verification fail; finally capture a TLS 1.3 handshake in Wireshark with `SSLKEYLOGFILE` set to see which parts are encrypted.
