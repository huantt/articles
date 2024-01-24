## EBS (a.k.a. Elastic Block Store)
- They are bound to a specific AZ (in specific region)
- You can attach an EBS Volume to your EC2 instances while they run
- It allows your instances to persist data, even after their termination
- They can only be mounted to one instance at a time (at the CCP level)
  - An EC2 instance can attach more than one EBS
- It's a network drive (i.e. not a physical drive)
  - It uses the network to communicate the instance, which means there might be a bit of latency
  - It can be detached from an EC2 instance and attached to another one quickly
- It's locked to an Availability Zone
  - To move a volume across, you first need to snapshot it
- Have a specified capacity (size in GBs and IOPS)
  - You get billed for all provisioned capacity
  - You can increase the capacity of the drive over time
- Types
  - gp2/gp3 (SSD): General purpose SSD that balances price and performance for a wide variety of workloads
  - io 1/io 2 (SSD): Highest-performance SSD for mission-critical low-latency or high-throughput workloads
  - st I (HDD): Low cost HDD volume designed for frequently accessed, throughput-intensive workloads
  - sc I (HDD): Lowest cost HDD volume designed for less frequently accessed workloads
  - Only gp2/gp3/io 1/io 2 can be used  as boot volumes
-  Amazon EBS Multi-Attach enables you to attach a single Provisioned IOPS SSD (io1 or io2) volume to multiple instances that are in the same Availability Zone
  - Multi-Attach enabled volumes can be attached to up to 16 Linux instances built on the Nitro System that are in the same Availability Zone.
  - The maximum number of Amazon EBS volumes that you can attach to an instance depends on the instance type and instance size
  - Multi-Attach for io1 volumes is available in the following Regions only: US East (N. Virginia), US West (Oregon), and Asia Pacific (Seoul)
  - Multi-Attach for io2 is available in all Regions that support io2
- By default, the Root volume type will be deleted as its "Delete On Termination" attribute checked by default. Any other EBS volume types will not be deleted as its "Delete On Termination" attribute disabled by default.
- To encrypt an unencrypted EBS volume:
  - Create an EBS snapshot of your EBS volume
  - Copy the snapshot and tick the option to encrypt the copied snapshot 
  - Then, use the encrypted snapshot to create a new EBS volume
- With Elastic Volumes, you can dynamically increase the size, increase or decrease the performance, and change the volume type of your Amazon EBS volumes without detaching them. You can not scale down after increasing volume size.
- All current volume types support Elastic Volume

## EFS
- Can be attached up-to 100 EC2 instances across AZ (not regions)
- Scales automatically, pay-per-use

## EC2 instance store
- If you need a high-performance hardware disk that does not require persistence, you should use EC2 Instance Store instead of EBS
- Note:
  - Instance store volumes are attached only at instance launch. You can't attach instance store volumes after launch. You can’t detach an instance store volume from one instance and attach it to a different instance.
  - An instance store volume exists only during the lifetime of the instance to which it is attached
  - The data on an instance store volume persists even if the instance is rebooted. However, the data does not persist if the instance is stopped, hibernated, or terminated
  - Instance store is ideal for temporary storage of information that changes frequently, such as buffers, caches, scratch data, and other temporary content
  - It can also be used to store temporary data that you replicate across a fleet of instances, such as a load-balanced pool of web servers
