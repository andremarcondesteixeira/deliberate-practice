# Configuration & Secrets

* **Externalized Configuration:** Why does the Twelve-Factor App require config to live outside the build artifact, and why should config be read once at startup (immutable at runtime) unless you deliberately support reloading?
* **Environment Variables vs Files for Secrets:** What are the risks of passing secrets as environment variables (inherited by child processes, crash dumps, `/proc`, accidental logging), and why are mounted files or direct secret-manager fetches safer?
* **HashiCorp Vault:** How does Vault work: auth methods, policies, leases, and dynamic secrets? How does the database secrets engine issue short-lived credentials per application instance?
* **Secret Rotation:** How do you rotate database passwords, API keys, and certificates without downtime (dual credentials, overlap windows, client reload)?
* **External Secrets Operator:** How does ESO sync secrets from AWS Secrets Manager or Vault into Kubernetes Secrets, and what are the trade-offs versus CSI secret store mounts?
* **Sealed Secrets:** How do Sealed Secrets let you store encrypted secrets in Git safely, and what happens if you lose the controller's private key?
* **Least Privilege & Auditing:** How do you scope secret access per workload identity, and how do you audit who read which secret and when?
* **Lab — Config Drift Breaks Consumers:**
  * *Setup:* A configuration change to an upstream service breaks downstream services because environment variables had drifted between environments.
  * *Challenge:* Centralize configuration (Git-backed config, Spring Cloud Config, Consul, ConfigMaps), validate it against a schema at startup, and promote config through environments like code.

## Study Guide

* **Books:**
  * *Kubernetes Secrets Management* (Alex Soto Bueno & Andrew Block): the chapters on Vault on Kubernetes, Sealed Secrets and the Secrets Store CSI driver, which map almost card for card to this deck.
  * *Kubernetes Patterns* (Bilgin Ibryam & Roland Huß): the configuration patterns (EnvVar Configuration, Configuration Resource, Immutable Configuration), for how config should reach a container and when it should change.
  * *Beyond the Twelve-Factor App* (Kevin Hoffman, free from O'Reilly): the sections on configuration, credentials and code, for externalized config in cloud-native services.
* **Official docs:** the Twelve-Factor App's "Config" factor; the HashiCorp Vault docs on auth methods, policies, leases and renewal, and the database secrets engine; the External Secrets Operator docs (SecretStore, ExternalSecret, refresh interval) and the Secrets Store CSI Driver docs; the Sealed Secrets README sections on key renewal and backing up the sealing key; the Kubernetes page "Good practices for Kubernetes Secrets"; the AWS Secrets Manager docs on rotation strategies (single user vs alternating users); OWASP Cheat Sheet Series: Secrets Management.
* **Related technologies:** OpenBao (the open-source Vault fork), AWS Secrets Manager and SSM Parameter Store, SOPS, cert-manager for certificate rotation, Spring Cloud Config and Consul KV for centralized config, and JSON Schema or CUE for validating config at startup.
* **Search for:** `twelve-factor config`, `secrets in environment variables /proc/environ`, `vault dynamic database credentials`, `vault lease revocation`, `alternating users rotation`, `external secrets operator vs secrets store csi`, `sealed secrets key backup`, `fail fast config validation`.
* **Hands-on:** run Vault in dev mode next to a PostgreSQL container, enable the database secrets engine, read a credential, then revoke its lease and confirm the database role is gone.
