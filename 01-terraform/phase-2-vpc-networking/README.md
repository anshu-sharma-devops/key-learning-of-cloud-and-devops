# 🌐 Phase 2 — VPC and Networking

Part of the [Terraform Learning Journey](../README.md) — *Key Learning of Cloud and DevOps*

---

## 🎯 Objective

Move beyond the AWS default VPC and learn to design and provision a custom network from scratch — the foundation every real-world AWS deployment is built on.

## 🏗️ What Was Built

- A **custom VPC** with a defined CIDR block
- A **public subnet** inside the VPC
- An **Internet Gateway** attached to the VPC for outbound/inbound internet access
- A **Route Table** with a route to the Internet Gateway
- A **Route Table Association** linking the subnet to the route table
- A **Security Group** scoped to the custom network
- An **EC2 instance** deployed inside the custom VPC/subnet (instead of the default VPC from Phase 1)

## 🧠 Concepts Covered

- VPC and subnet design
- Internet Gateways and public connectivity
- Route tables and route table associations
- Deploying compute resources inside custom networking

## 🔧 Commands Used

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform output
terraform destroy
```

## 📂 Structure

```text
phase-2-vpc-networking/
├── main.tf          # VPC, subnet, IGW, route table, EC2, security group
├── variables.tf      # CIDR blocks, region, instance settings
└── outputs.tf         # VPC ID, subnet ID, instance public IP
```

## 📌 Key Learnings

- Networking resources can be fully provisioned without touching the AWS Console.
- A route table + Internet Gateway is what actually makes a subnet "public" — the subnet itself has no inherent internet access.
- Explicit route table associations are required; Terraform (like AWS) doesn't auto-attach subnets to route tables.
- Building the network first makes every later phase (multi-EC2, load balancing, Jenkins) more predictable and secure.

## ➡️ Next

Continue to [Phase 3 — Remote State Management](../phase-3-remote-state/README.md), where local `.tfstate` files are replaced with a shared, locked, S3-backed backend.

---

⬅ [Back to main Terraform Learning Journey README](../README.md)
