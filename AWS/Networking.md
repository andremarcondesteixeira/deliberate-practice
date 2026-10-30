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

## Study Guide

* **Books:**
  * *Amazon Web Services in Action* (Andreas Wittig & Michael Wittig): the security chapter on IAM, security groups and VPCs, and the chapters on load balancing, for building a VPC by hand.
  * *Computer Networking: A Top-Down Approach* (James Kurose & Keith Ross): the network layer chapters (IP addressing, CIDR, NAT, routing) and the application layer chapter (DNS), the fundamentals under every VPC card.
  * *HTTP: The Definitive Guide* (David Gourley & Brian Totty): the chapter on caching, for `Cache-Control`, cache keys and why a CDN keeps serving stale content.
* **Official docs:** the Amazon VPC User Guide (CIDR blocks and subnets, route tables, security groups vs network ACLs, NAT gateways, gateway endpoints, flow logs), the Transit Gateway guide (appliance mode), the AWS PrivateLink guide, the Elastic Load Balancing guides for each load balancer type, the Route 53 Developer Guide (routing policies, health checks, alias records, Resolver), the CloudFront Developer Guide (cache policies, invalidation, CloudFront Functions vs Lambda@Edge), the Global Accelerator and API Gateway guides, and the whitepapers "Building a Scalable and Secure Multi-VPC AWS Network Infrastructure" and "Hybrid Connectivity". The re:Invent talk "Another Day, Another Billion Flows" explains how the VPC network works underneath.
* **Related technologies:** compare Azure Virtual Network (NSGs, Virtual WAN, ExpressRoute, Front Door), Google Cloud VPC (Cloud Interconnect, Cloud CDN), Kubernetes topology-aware routing, Cloudflare or Akamai as CDNs, and Envoy or NGINX as L7 proxies.
* **Search for:** `VPC reserved IP addresses`, `NACL ephemeral ports`, `VPC peering transitive`, `NAT gateway data processing cost`, `gateway endpoint vs interface endpoint`, `Transit Gateway appliance mode`, `Gateway Load Balancer GENEVE`, `Route 53 alias vs CNAME`, `CloudFront cache key`, `Global Accelerator anycast`, `Direct Connect VPN backup`.
* **Hands-on:** build a VPC by hand with public and private subnets in two AZs, launch two free-tier instances in different subnets, add a NACL that blocks ephemeral ports and watch HTTP fail, then enable flow logs and find the `REJECT` records with CloudWatch Logs Insights.
