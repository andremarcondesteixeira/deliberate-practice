# AWS Networking

## VPC

* **CIDR Planning:** What are the VPC CIDR limits (`/16` to `/28`), the five reserved IPs per subnet, and the rules for adding secondary CIDRs? Why does avoiding overlapping ranges matter for future peering?
* **Public vs Private Subnets:** What makes a subnet public (a route to an Internet Gateway)? Contrast the bidirectional IGW with outbound-only NAT gateways, and explain why NAT gateways should be deployed per AZ.
* **Lab — Security Groups vs NACLs:**
  * *Setup:* Instances in two different subnets can't talk over HTTP, even though their security groups reference each other's group ID.
  * *Challenge:* Contrast stateful security groups (ENI level) with stateless NACLs (subnet level, ordered rules), and find the NACL rule missing for return traffic on ephemeral ports. Why would the same instances talk fine if they were in the same subnet?
* **Peering vs Transit Gateway:** When do you use VPC peering (non-transitive, point-to-point) versus a Transit Gateway hub (transitive, route tables, inter-region peering)? When is PrivateLink the better way to expose a single service?
* **Lab — NAT Gateway Bill Shock:**
  * *Setup:* The monthly bill spikes because of NAT gateway data processing charges: terabytes of traffic from private subnets to S3 and DynamoDB.
  * *Challenge:* Explain why that traffic goes through NAT, how gateway endpoints (S3 and DynamoDB, free, via route tables) differ from interface endpoints (PrivateLink ENIs, hourly + per-GB), and fix it.
* **Lab — Cross-AZ Data Transfer:**
  * *Setup:* A chatty microservice architecture spread across three AZs has high latency and a large cross-AZ data transfer bill.
  * *Challenge:* Keep traffic in-zone with AZ-aware routing (Kubernetes topology-aware routing, cross-zone load balancing settings) while preserving availability.
* **Lab — Asymmetric Routing Through an Inspection VPC:**
  * *Setup:* Traffic through a centralized firewall VPC attached to a Transit Gateway drops intermittently because return traffic reaches a different firewall instance.
  * *Challenge:* Explain why stateful appliances need symmetric flows, and fix it with Transit Gateway appliance mode and correct route table associations, or with a Gateway Load Balancer.
* **VPC Flow Logs:** What do flow logs record and not record (payloads, traffic to the Route 53 Resolver and instance metadata), and how do you query them with Athena or CloudWatch Logs Insights?

## Load Balancing & Edge

* **ALB vs NLB vs GWLB:** Compare Application (L7: host/path routing, weighted target groups, built-in auth), Network (L4: static IPs, extreme throughput, TLS passthrough), and Gateway Load Balancers (inline appliances via GENEVE). Which one do you use when clients must allowlist IPs?
* **Route 53 Routing & Health Checks:** Compare simple, weighted, latency, failover, geolocation, geoproximity, and multivalue routing. How do health checks drive DNS failover, and what does an alias record change compared with a CNAME?
* **Route 53 Resolver:** How do inbound and outbound Resolver endpoints and forwarding rules provide hybrid DNS between AWS and on-premises networks?
* **CloudFront vs Global Accelerator:** How does CloudFront cache at edge locations and regional edge caches, and how does Global Accelerator use anycast IPs to route TCP/UDP over the AWS backbone without caching? When do you use each?
* **Lab — CloudFront Serving Stale Content:**
  * *Setup:* After a hotfix, users keep seeing the broken version for hours despite invalidations.
  * *Challenge:* Check cache policies and cache keys, origin `Cache-Control` headers, invalidation paths and wildcards, browser caching, and any other caching layers. Why are versioned asset names better than invalidations?
* **CloudFront Functions vs Lambda@Edge:** Contrast lightweight CloudFront Functions (viewer events, sub-millisecond JavaScript) with Lambda@Edge (viewer and origin events, network access, longer runtimes).
* **API Gateway REST vs HTTP APIs:** Compare REST APIs (usage plans and API keys, request validation, caching, WAF) with HTTP APIs (cheaper, faster, native JWT authorizers). What are usage plans actually good for?
* **Lambda Authorizers:** How do token- and request-based Lambda authorizers work, and how does caching authorizer results affect security and cost?

## Hybrid Connectivity

* **Direct Connect vs Site-to-Site VPN:** Contrast dedicated Direct Connect links with IPsec VPN over the internet regarding bandwidth, latency, cost, setup time, and encryption. Why do teams use a VPN as a Direct Connect backup?
