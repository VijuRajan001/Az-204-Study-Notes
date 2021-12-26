#Virtual Machine Notes

- Choose a VM when you need more control over the computing environment than the other choices offer.
- You still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it.
- To get 99.95% availability deploy VM in 2 or more Vm in availability set
- The size that you choose then determines factors such as processing power, memory, and storage capacity
	1. A-Series Entry-level VMs for dev/test
	2. Bs-Series Economical burstable VMs
	3. D-Series General purpose compute (Most Production workloads, web apps ,ecommerce etc)
	4. E-Series Optimised for in-memory hyper-threaded applications (SAP hana)
	5. G-Series Memory and storage optimised virtual machines (SQL and NoSQL databases)
	6. H-Series High Performance Computing virtual machines (electronic design automation, rendering, Spark, weather modelling, quantum simulation, computational chemistry,)
	7. Ls-Series Storage optimised virtual machines NoSQL databases such as Cassandra, MongoDB, Cloudera and Redis
	8. M-Series Memory optimised virtual machines (SAP HANA, SAP S/4 HANA, SQL Hekaton and other large in-memory business critical workloads)
	9. N-Series GPU enabled virtual machines

- Azure Policy lets you control which VM sizes are allowed to de deployed in your environment, and by omission, which sizes are not allowed. The instance sizes are referred to as SKUs 
- The current limit on a per subscription basis is 20 VMs per region. Limits can be raised by filing a support ticket requesting an increase
- Azure Dedicated Host is a service that provides physical servers - able to host one or more virtual machines - dedicated to one Azure subscription.
- Azure Spot Virtual Machines allows you to take advantage of our unused capacity at a significant cost savings. At any point in time when Azure needs the capacity back, the Azure infrastructure will evict Azure Spot Virtual Machines. 
- For customers with Software Assurance, Azure Hybrid Benefit for Windows Server allows you to use your on-premises Windows Server licenses and run Windows virtual machines on Azure at a reduced cost
- Azure Reservations help you save money by committing to one-year or three-year plans for multiple products. Committing allows you to get a discount on the resources you use. Reservations can significantly reduce your resource costs by up to 72% from pay-as-you-go prices.
- If your Windows VM supports Accelerated Networking, enabling that feature would be the optimal configuration for throughput. 
- Windows VMs, using Receive Side Scaling (RSS) can reach higher maximal throughput than a VM without RSS. RSS may be disabled by default in a Windows VM. 
- A proximity placement group is a logical grouping used to make sure that Azure compute resources are physically located close to each other. Proximity placement groups are useful for workloads where low latency is a requirement
- We can configure an Availability Set ONLY when we deploy a New Virtual Machine, we can't add an existing Virtual Machine to an Availability Set.
