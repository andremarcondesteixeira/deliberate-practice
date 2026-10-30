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

## Study Guide

* **Books:**
  * *Amazon Web Services in Action* (Andreas Wittig & Michael Wittig): the chapters on object storage with S3, block storage with EBS and instance store, and shared file systems with EFS.
  * *Systems Performance* (Brendan Gregg): the Disks and File Systems chapters, for IOPS, throughput, latency and I/O wait, so you can read EBS metrics and diagnose the gp2 lab.
  * *Designing Data-Intensive Applications* (Martin Kleppmann): the Replication and Consistency and Consensus chapters, for what read-after-write consistency guarantees and what it leaves open for concurrent writers.
* **Official docs:** the Amazon S3 User Guide (data consistency model, storage classes, lifecycle, Object Lock, Object Ownership and Block Public Access, presigned URLs, performance design patterns, replication, access points, Bucket Keys), the CloudFront Developer Guide on signed URLs and cookies, the Amazon EBS User Guide (volume types, I/O credits and burst performance, Elastic Volumes, snapshots, Fast Snapshot Restore), the Amazon EFS and FSx user guides, the Storage Gateway User Guide, and the Cost Optimization pillar of the Well-Architected Framework. The re:Invent deep dives on S3 and EBS are worth watching.
* **Papers:** "Using Lightweight Formal Methods to Validate a Key-Value Storage Node in Amazon S3" (Bornholt et al., 2021); "Millions of Tiny Databases" (Brooker et al., 2020), on how EBS manages replication configuration.
* **Related technologies:** compare Azure Blob Storage, Managed Disks and Azure Files; Google Cloud Storage, Persistent Disk and Filestore; MinIO and Ceph (S3-compatible object and block storage); and NetApp ONTAP, Lustre and OpenZFS themselves.
* **Search for:** `S3 strong consistency`, `S3 storage class minimum duration`, `S3 Object Lock compliance mode`, `S3 Object Ownership bucket owner enforced`, `S3 request rate per prefix`, `S3 replication what is not replicated`, `S3 KMS AccessDenied kms:Decrypt`, `gp2 burst balance`, `gp3 vs gp2`, `EBS snapshot lazy loading`, `EFS throughput modes`.
* **Hands-on:** create a versioned bucket encrypted with a customer managed KMS key (about a dollar a month), give a role `s3:GetObject` but not `kms:Decrypt`, reproduce the `AccessDenied`, find the KMS denial in CloudTrail, then fix it and add a lifecycle rule for noncurrent versions.
