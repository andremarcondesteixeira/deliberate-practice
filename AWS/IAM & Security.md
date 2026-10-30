# AWS IAM & Security

## IAM Fundamentals

* **Policy Anatomy:** Deconstruct an IAM policy document: `Effect`, `Principal`, `Action`, `Resource`, `Condition`. Which element appears only in resource-based policies?
* **Identity-Based vs Resource-Based Policies:** Contrast policies attached to users, groups, and roles with policies attached to resources (S3 buckets, KMS keys, SQS queues). Who is the principal in each, and which services support resource-based policies?
* **Managed vs Inline Policies:** When do you use AWS managed, customer managed, or inline policies? Why are inline policies usually avoided?
* **Root User & Long-Lived Credentials:** What can only the root user do, and how should it be protected? Why are IAM roles with temporary STS credentials preferred over IAM users with access keys for both people and applications?
* **Policy Evaluation Logic:** Walk through how AWS evaluates a request: an explicit deny anywhere wins; otherwise Organizations SCPs (and RCPs), resource-based policies, identity-based policies, permissions boundaries, and session policies must each allow it. Can an allow ever override an explicit deny?
* **Cross-Account Evaluation:** A principal in account 111 calls a Lambda function in account 222. The function's resource policy allows the principal, but the principal's identity policy says nothing about the function. Does the call succeed? How would the answer differ within a single account?
* **NotAction Pitfall:** What does `Effect: Allow`, `NotAction: s3:DeleteBucket`, `Resource: *` actually grant? Why is `NotAction` with `Allow` an anti-pattern, and where is `NotAction` with `Deny` useful?
* **ABAC with Tags:** How do condition keys such as `aws:PrincipalTag`, `aws:ResourceTag`, and `aws:RequestTag` enable attribute-based access control that scales without writing new policies per project?

## Roles & Delegation

* **Trust Policies & Cross-Account Roles:** A role needs a trust policy (who can assume it) and permission policies (what it can do). How does cross-account `AssumeRole` work, and why do third parties require an `ExternalId`?
* **Confused Deputy:** What is the confused deputy problem, and how do `aws:SourceArn`, `aws:SourceAccount`, and `ExternalId` mitigate it for AWS services and SaaS vendors?
* **iam:PassRole:** Why does a user with broad EC2 permissions get `AccessDenied` on `iam:PassRole` when launching an instance with an instance profile? Which escalation does `PassRole` prevent?
* **Session Policies:** How do session policies passed to `AssumeRole` (or federation) restrict the resulting temporary credentials, and why can they never expand them?
* **IAM Identity Center:** How does IAM Identity Center provide SSO across many accounts with permission sets and an external identity provider?

## Guardrails

* **Permissions Boundaries:** A user has `AdministratorAccess` attached but a permissions boundary that allows only S3. Can they launch an EC2 instance? How do boundaries let you safely delegate role creation to developers?
* **SCPs & Organizations:** How are SCPs inherited through OUs, and why must an action be allowed at every level from the root down to the account? An SCP at the root allows `s3:*`, and the account's SCP denies `s3:DeleteBucket`: can the account delete buckets? Do SCPs apply to the management account?
* **Resource Access Manager:** How does RAM share resources such as subnets, Transit Gateways, and Route 53 Resolver rules across accounts?
* **Lab — Privilege Escalation Paths:**
  * *Setup:* An audit shows that a low-privilege user can attach admin policies to their own role through overly permissive policies.
  * *Challenge:* Identify escalation permissions (`iam:PutUserPolicy`, `iam:AttachRolePolicy`, `iam:CreatePolicyVersion`, `iam:PassRole` plus a compute service, `iam:CreateAccessKey` on other users), and block them with permissions boundaries and SCPs.
* **Lab — Cross-Account AssumeRole Denied:**
  * *Setup:* Alice in account A must read an S3 bucket in account B by assuming the role `DataFetcher` in B, but `sts:AssumeRole` returns `AccessDenied`.
  * *Challenge:* List everything that must line up: Alice's identity policy allowing `sts:AssumeRole` on the role ARN, the role's trust policy trusting Alice (or account A) with any required conditions (MFA, `ExternalId`), and, once assumed, the bucket policy and KMS key policy. Which one is most often missed?
* **Lab — Lambda Can't Read DynamoDB:**
  * *Setup:* A Lambda function logs `User: ... is not authorized to perform: dynamodb:GetItem on resource: ...`.
  * *Challenge:* Decide whether it's the execution role's identity policy, a resource-policy or SCP denial, or a network problem (it isn't, and explain why). Verify with the IAM policy simulator, IAM Access Analyzer policy validation, and CloudTrail.

## Encryption & Secrets

* **KMS Keys:** Contrast AWS owned keys, AWS managed keys, and customer managed keys regarding control, key policies, rotation, auditing, and cost. How does automatic rotation keep the same key ID and still decrypt old data?
* **Secrets Manager vs Parameter Store:** Compare Secrets Manager (rotation via Lambda, cross-region replication, cost per secret) with SSM Parameter Store (hierarchies, `SecureString`, free standard tier).
* **ACM:** How does ACM provision and auto-renew public and private TLS certificates for load balancers, CloudFront, and API Gateway? Why must certificates for CloudFront live in `us-east-1`?

## Threat Detection & Compliance

* **Security Services Map:** What does each service do: GuardDuty (threat detection from CloudTrail, VPC Flow Logs, DNS logs), Inspector (vulnerability scanning of EC2, ECR images, Lambda), Macie (sensitive data in S3), Security Hub (aggregated findings and standards), Detective (investigation)? Which would you enable first?
* **AWS Config:** How do Config rules and conformance packs continuously evaluate resource configurations, and how does that differ from CloudTrail?
* **CloudTrail:** What's the difference between management events and data events? Why send an organization trail to a central, locked-down log archive account, and when do you use CloudTrail Lake?
* **Shield & WAF:** Contrast Shield Standard (automatic L3/L4 DDoS protection) with Shield Advanced (L7 support, response team, cost protection). How do WAF web ACLs, managed rule groups, and rate-based rules fit in?
* **Lab — WAF False Positives:**
  * *Setup:* A WAF managed rule blocks legitimate checkout form submissions that contain special characters.
  * *Challenge:* Find the matching rule in WAF logs, switch that rule to count mode, add a scoped exclusion or label-based rule, and test new rules in count mode before enforcing them.
* **Lab — GuardDuty Alert Fatigue:**
  * *Setup:* A security team running 200 accounts drowns in low-priority GuardDuty findings.
  * *Challenge:* Set up a delegated administrator, aggregate findings centrally (Security Hub), add suppression rules for known benign patterns, and route only high-severity findings to people.

## Study Guide

* **Books:**
  * *AWS Security* (Dylan Shields): the chapters on IAM policies, multi-account management, data protection, logging and audit trails, and continuous monitoring and incident response map onto almost every section of this deck.
  * *Practical Cloud Security* (Chris Dotson): the chapters on identity and access management, encryption and key management, and incident response, for the provider-neutral principles behind AWS's services.
  * *Amazon Web Services in Action* (Andreas Wittig & Michael Wittig): the security chapter on IAM, security groups and VPCs, for a hands-on start.
* **Official docs:** the IAM User Guide, especially "Policy evaluation logic" (including cross-account evaluation), the IAM JSON policy elements reference, permissions boundaries, the confused deputy problem, and passing roles to services; the AWS Organizations User Guide on SCPs and RCPs; the IAM Identity Center User Guide; the AWS KMS Developer Guide (key policies, rotation) and the "AWS Key Management Service Cryptographic Details" whitepaper; the GuardDuty, Security Hub, Config, CloudTrail and WAF guides; the "Organizing Your AWS Environment Using Multiple Accounts" whitepaper; and the Security pillar of the Well-Architected Framework. The re:Invent talks on becoming an IAM policy master are classics.
* **Papers:** "Semantic-based Automated Reasoning for AWS Access Policies using SMT" (Backes et al., 2018), the Zelkova work behind IAM Access Analyzer.
* **Related technologies:** compare Azure RBAC with Microsoft Entra ID and Azure Policy, Google Cloud IAM with Organization Policies, HashiCorp Vault (secrets), Open Policy Agent and Cedar (policy as code), and Okta or Entra ID as Identity Center's external identity provider.
* **Search for:** `IAM policy evaluation logic`, `cross-account policy evaluation`, `confused deputy aws:SourceArn`, `iam:PassRole privilege escalation`, `permissions boundary delegation`, `SCP inheritance`, `ABAC aws:PrincipalTag`, `KMS key policy vs IAM policy`, Rhino Security Labs' research on AWS IAM privilege escalation, and the open-source tools Pacu and PMapper.
* **Hands-on:** set up a cross-account role with a trust policy and `ExternalId` between two accounts in a free AWS Organization, then break each piece in turn (identity policy, trust policy, bucket policy, KMS key policy) and read the resulting `AccessDenied` messages and CloudTrail events.
