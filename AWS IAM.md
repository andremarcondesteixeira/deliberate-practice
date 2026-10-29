# AWS IAM Deliberate Practice Cards

## Phase 1: Core Fundamentals & Policy Syntax

* **Card 1 (JSON Anatomy):** Deconstruct a standard IAM policy document. Define the exact functional roles and differences between `Effect`, `Principal`, `Action`, `Resource`, and `Condition`.
* **Card 2 (Identity vs. Resource):** Contrast Identity-Based Policies (attached to users, groups, or roles) with Resource-Based Policies (attached directly to resources like S3 buckets, KMS keys, or SQS queues). Who evaluates the Principal element in each?
* **Card 3 (Inline vs. Managed):** When should you choose an AWS-Managed Policy, a Customer-Managed Policy, or an Inline Policy? Which one strictly violates the "separation of concerns and resource reuse" principle by tying its lifecycle to a single user or role?
* **Card 4 (The Root User):** What are the privileges and operational risks surrounding the AWS Account Root User, and what is the single absolute best practice for handling it daily?

## Phase 2: Evaluation Logic & Resolution Math

* **Card 5 (The Evaluation Algorithm):** Walk through the exact multi-step evaluation logic AWS uses when an API request arrives. In what order are *Explicit Deny*, *Explicit Allow*, and *Implicit Deny* computed? Does an allow override a deny anywhere in the chain?
* **Card 6 (Cross-Account Math):** Principal A in Account 123 tries to access a Lambda function in Account 456. Account 456 has a resource-based policy allowing Principal A, but Principal A’s identity-based policy in Account 123 has *no* mention of that Lambda function (implicit deny). Does the call succeed? Why?
* **Card 7 (NotAction Pitfall):** You write an IAM policy with `Effect: Allow`, `NotAction: s3:DeleteBucket`, and `Resource: *`. Explain the security implications of combining `NotAction` with wildcard resources. Why is this considered an extreme anti-pattern?

## Phase 3: Advanced Architecture & Delegation

* **Card 8 (The PassRole Trap):** A senior developer with `AdministratorAccess` attempts to launch an EC2 instance with an IAM instance profile attached, but AWS throws an `AccessDenied` error on `iam:PassRole`. Explain why `AdministratorAccess` didn't automatically cover this and what `PassRole` protects against.
* **Card 9 (Trust Policies vs. Permission Policies):** An IAM Role requires *two* distinct policies to function. Name them, explain where each is stored (attached to the role vs. defining who can assume it), and describe what happens if the Trust Policy lacks an `ExternalId`.
* **Card 10 (The Confused Deputy Problem):** Define the Confused Deputy problem in multi-tenant SaaS environments. How do AWS Service Principals use `aws:SourceArn` and `aws:SourceAccount` condition keys to mitigate it?

## Phase 4: Guardrails, Boundaries & Scopes

* **Card 11 (Permissions Boundary Math):** You attach a Permissions Boundary to a developer user that restricts them strictly to creating S3 buckets. However, you attach an administrative policy (`AdministratorAccess`) directly to their user identity. Can they create an EC2 instance? Walk through the intersection logic.
* **Card 12 (SCP Inheritance & Overriding):** Service Control Policies (SCPs) are applied at the AWS Organizations level. If an SCP at the Root/Parent Organizational Unit (OU) explicitly allows `s3:*`, but an SCP attached directly to a child Account explicitly denies `s3:DeleteBucket`, does the child account have deletion powers? Explain how SCP evaluation works across OUs.
* **Card 13 (Session Policies & Dynamic Scoping):** When calling `AssumeRole` via AWS STS, you can pass an optional `Policy` parameter. What is a Session Policy, and how does it dynamically constrain the maximum permissions of the resulting temporary credentials?

## Phase 5: Hands-On Labs & Scenario Troubleshooting

* **Lab Scenario A (The Cross-Account AssumeRole Block):** 
  * *The Setup:* User `Alice` in Account A needs to read data from an S3 bucket in Account B by assuming Role `DataFetcher` in Account B.
  * *The Symptom:* Alice gets `AccessDenied` when calling `sts:AssumeRole`. 
  * *The Challenge:* List the three places you must check for misconfigurations (Identity policy in Account A, Trust Policy in Account B, and KMS Key Policy if the bucket is encrypted). Which one is most frequently missed?
* **Lab Scenario B (The Rogue Lambda Role):** 
  * *The Setup:* A Lambda function in your account needs to read from a DynamoDB table. You write an execution role, but the Lambda logs show `User: ... is not authorized to perform: dynamodb:GetItem on resource: ...`. 
  * *The Challenge:* Is this an identity-based policy issue, a resource-based policy issue, or a network boundary issue? How would you verify it using IAM Access Analyzer or `aws iam simulate-principal-policy`?