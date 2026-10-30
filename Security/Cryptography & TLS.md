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
