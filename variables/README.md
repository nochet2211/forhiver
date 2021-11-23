# Description
The following IaC deploys the follwing resources:
* Creates a Security Group (called prod-web-servers-sg) for
Default VPC that allows access to TCP port 80 and 443
from anywhere
* Creates 2 EC2 instances of type t3.large ( prod-web-server-1
and prod-web-server-2 )
* Places the above 2 EC2 instances in the Private Subnet of
your Default VPC
* Attaches an Internet-facing NLB load balancer to both of the
EC2
* All infrastructure should have a Security group created in first step


# Installation

Supply necessary variables using ***var.json*** in ****/variables**** folder.

Navigate to ****/templates**** folder and run the following
```bash
terraform init
```
Plan the execution and verify resources
```bash
terraform plan -var-file=../variables/var.json
```

Execute the once verified
```bash
terraform apply -var-file=../variables/var.json
```
