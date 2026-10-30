# SLOs, Alerting & Incident Response

## SRE Foundations

* **SRE Principles & Toil:** What are the core SRE tenets (embracing risk, SLOs, eliminating toil, automation, simplicity)? How do you tell toil (manual, repetitive, automatable, no lasting value) from engineering work, and why cap it?
* **SLIs, SLOs & SLAs:** Contrast SLIs (measurements), SLOs (internal targets), and SLAs (contracts with penalties). Why should the SLO be stricter than the SLA?
* **Choosing SLIs:** How do you define good SLIs for request-driven services (availability and latency as "good events / valid events") versus pipelines (freshness, correctness, coverage)? Where should you measure them?
* **Error Budgets:** Calculate the error budget for 99.9% over 30 days (~43 minutes). What should an error budget policy say happens when the budget is spent (feature freeze, reliability work), and who has to agree to it?
* **Chaos Engineering & GameDays:** What is the scientific method of chaos engineering (steady state, hypothesis, minimal blast radius, abort conditions)? How do GameDays test both systems (killing nodes, injecting latency) and people (alerting, runbooks)?

## Alerting

* **Burn-Rate Alerts:** How do multi-window, multi-burn-rate alerts (e.g., 2% of the budget in 1 hour, 5% in 6 hours) catch both fast outages and slow burns while avoiding noise?
* **Alertmanager Routing:** How do routing trees, grouping, inhibition, and silences work? When do you silence (maintenance) versus inhibit (suppress symptoms of a known cause)?
* **Runbooks:** Why should every page link to a runbook, and what makes a runbook useful at 3 AM?
* **Business Metric Alerts:** How do you alert on sudden drops in business metrics (orders per minute, conversion rate) without drowning in false positives from normal seasonality?
* **Dead Man's Switch:** How do heartbeat checks catch scheduled jobs that silently stop running, and how do you make sure the alerting pipeline itself is alive?
* **Lab — Noisy Page Storm:**
  * *Setup:* A short network blip fires 45 separate alerts, one per pod, and wakes the on-call engineer at 3 AM.
  * *Challenge:* Alert on service-level symptoms (`sum by (service)`, SLO burn) instead of per-pod causes, group and inhibit in Alertmanager, and audit which alerts are actually actionable.

## Incident Response

* **Incident Roles & Severity:** What do the incident commander, operations lead, and communications lead do? How do severity levels (SEV1–SEV4) map to customer impact and response expectations?
* **On-Call Design:** How do rotations, escalation policies, and handovers keep pages reaching the right person without burning people out?
* **Blameless Postmortems:** How do blameless postmortems find systemic causes instead of blaming people? How do you reconstruct the timeline from metrics, logs, and traces, and make sure action items actually get done?
