# Configuration & Secrets

* **Externalized Configuration:** Why does the Twelve-Factor App require config to live outside the build artifact, and why should config be read once at startup (immutable at runtime) unless you deliberately support reloading?
* **Environment Variables vs Files for Secrets:** What are the risks of passing secrets as environment variables (inherited by child processes, crash dumps, `/proc`, accidental logging), and why are mounted files or direct secret-manager fetches safer?
* **HashiCorp Vault:** How does Vault work: auth methods, policies, leases, and dynamic secrets? How does the database secrets engine issue short-lived credentials per application instance?
* **Secret Rotation:** How do you rotate database passwords, API keys, and certificates without downtime (dual credentials, overlap windows, client reload)?
* **External Secrets Operator:** How does ESO sync secrets from AWS Secrets Manager, Vault, or GCP Secret Manager into Kubernetes Secrets, and what are the trade-offs versus CSI secret store mounts?
* **Sealed Secrets:** How do Sealed Secrets let you store encrypted secrets in Git safely, and what happens if you lose the controller's private key?
* **Least Privilege & Auditing:** How do you scope secret access per workload identity, and how do you audit who read which secret and when?
* **Lab — Config Drift Breaks Consumers:**
  * *Setup:* A configuration change to an upstream service breaks downstream services because environment variables had drifted between environments.
  * *Challenge:* Centralize configuration (Git-backed config, Spring Cloud Config, Consul, ConfigMaps), validate it against a schema at startup, and promote config through environments like code.
