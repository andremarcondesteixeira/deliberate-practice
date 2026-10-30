# AWS Storage

## S3

* **S3 Consistency:** What does S3's strong read-after-write consistency guarantee for PUTs, overwrites, deletes, and LIST operations? What still isn't coordinated (e.g., concurrent writers to the same key)?
* **Storage Classes:** Compare Standard, Intelligent-Tiering, Standard-IA, One Zone-IA, Glacier Instant Retrieval, Glacier Flexible Retrieval, and Glacier Deep Archive. Which hidden costs (minimum storage duration, minimum object size, retrieval fees) matter?
* **Lifecycle Rules:** How do lifecycle rules transition and expire objects, clean up noncurrent versions, and abort incomplete multipart uploads?
* **Data Protection:** How do versioning, MFA Delete, and Object Lock (Governance vs Compliance mode, legal holds) protect against accidental or malicious deletion and ransomware?
* **Bucket Policies vs ACLs:** Why are ACLs disabled by default now (Object Ownership: bucket owner enforced), and how do bucket policies and Block Public Access govern access?
* **Presigned URLs vs CloudFront Signed URLs:** How do S3 presigned URLs grant temporary access with the signer's permissions, and when do you use CloudFront signed URLs or signed cookies instead?
* **S3 Performance:** How does S3 scale request rates per prefix (3,500 writes and 5,500 reads per second), and how do multipart uploads, byte-range fetches, and parallelism maximize throughput?
* **Replication:** What are the prerequisites for Cross-Region and Same-Region Replication (versioning, an IAM role, KMS permissions)? What isn't replicated by default, and what does Replication Time Control add?
* **Access Points:** How do S3 access points give each application its own policy and network controls on a shared bucket?
* **Lab — AccessDenied on an Encrypted Bucket:**
  * *Setup:* An application role with `s3:GetObject` gets `AccessDenied` reading objects from a bucket encrypted with a customer managed KMS key.
  * *Challenge:* Explain why the role also needs `kms:Decrypt` (and the key policy must allow it), how to tell S3 and KMS denials apart in CloudTrail, and what S3 Bucket Keys change.

## Block & File Storage

* **EBS Volume Types:** Compare gp2, gp3, io1/io2, st1, and sc1. Why does gp3 decouple IOPS and throughput from size, and how can you change type or size on a live volume (Elastic Volumes)?
* **Lab — gp2 Burst Credit Exhaustion:**
  * *Setup:* A database on a 100GB gp2 volume slows to a crawl with high I/O wait after a busy morning.
  * *Challenge:* Explain the gp2 burst bucket (3 IOPS/GB baseline, bursting to 3,000), how to confirm it with `BurstBalance`, and why gp3 with provisioned IOPS fixes it.
* **EBS Snapshots:** How are EBS snapshots incremental yet each restorable on its own? What is lazy loading from S3 after a restore, and how do Fast Snapshot Restore or pre-warming help?
* **EFS vs EBS:** When do you choose EFS (multi-AZ shared NFS) over EBS (single-AZ block storage)? Explain EFS performance modes and throughput modes (elastic, bursting, provisioned).
* **FSx Family:** When do you pick FSx for Windows File Server (SMB, Active Directory), FSx for Lustre (HPC/ML, S3 integration), FSx for NetApp ONTAP, or FSx for OpenZFS?
* **Storage Gateway:** Contrast File Gateway, Volume Gateway, and Tape Gateway for hybrid storage.
