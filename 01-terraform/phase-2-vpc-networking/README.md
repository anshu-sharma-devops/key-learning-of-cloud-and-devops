# 🌐 Phase 2 - Custom VPC and Networking using Terraform

This project demonstrates how to build a custom AWS networking environment using Terraform instead of relying on AWS default networking resources.

This is the second phase of my Terraform learning journey and focuses on creating the foundational networking components required for real-world cloud infrastructure deployments.

---

## 🎯 Objectives

- Learn AWS networking fundamentals
- Create a custom VPC using Terraform
- Configure public networking resources
- Understand routing and internet connectivity
- Deploy an EC2 instance inside a custom VPC
- Learn resource dependencies in Terraform

---

## 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| Cloud Provider | AWS |
| Infrastructure as Code | Terraform |
| Networking | VPC, Subnet, Route Table, Internet Gateway |
| Compute | EC2 |
| Security | Security Groups |
| Version Control | Git & GitHub |
| Editor | VS Code |
| Operating System | macOS |

---

## 🏗️ Infrastructure Created

The following AWS resources were provisioned:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association
- Security Group
- EC2 Instance

---

## 📐 Architecture

```text
Internet
   │
   ▼
Internet Gateway
   │
   ▼
VPC (10.0.0.0/16)
   │
   ▼
Public Subnet (10.0.1.0/24)
   │
   ▼
Security Group
   │
   ▼
EC2 Instance
```

---

## 📂 Project Structure

```text
phase-2-vpc-networking/
│
├── provider.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── README.md
├── terraform.tfstate
├── terraform.tfstate.backup
└── screenshots/
```

---

## 📋 Terraform Commands Used

### Initialize Terraform

```bash
terraform init
```

Downloads the required Terraform providers and initializes the working directory.

---

### Validate Configuration

```bash
terraform validate
```

Checks the Terraform configuration for syntax errors and consistency.

---

### Preview Infrastructure Changes

```bash
terraform plan
```

Displays the resources Terraform will create before making any changes.

---

### Create Infrastructure

```bash
terraform apply
```

Creates all networking resources and provisions the EC2 instance.

---

### View Outputs

```bash
terraform output
```

Displays useful deployment information such as:

- VPC ID
- Subnet ID
- Security Group ID
- Instance ID
- Public IP Address
- SSH Command

---

### Destroy Infrastructure

```bash
terraform destroy
```

Deletes all resources managed by Terraform.

---

## 📸 Screenshots

### Terraform Plan
Preview of the infrastructure that Terraform planned to create.

### Terraform Apply
Successful creation of AWS infrastructure.

### VPC Created in AWS
Custom VPC successfully created.

### Public Subnet
Public subnet created inside the VPC.

### Internet Gateway Attached
Internet Gateway attached to the VPC for internet access.

### Route Table Configuration
Route table configured with:

```text
0.0.0.0/0 → Internet Gateway
```

### Security Group Rules
Inbound rules configured for:

- SSH (22)
- HTTP (80)

### EC2 Instance Running
EC2 instance deployed inside the custom VPC.

### SSH Connection
Successful SSH access to the EC2 instance.

### Terraform Destroy
All infrastructure successfully removed.

---

## 🐞 Errors and Fixes

| Error | Root Cause | Fix |
|-------|------------|-----|
| No issues recorded yet | - | - |

---

## 📚 Terraform Concepts Covered

### Networking Concepts

- VPC
- CIDR Blocks
- Public Subnets
- Internet Gateway
- Route Tables
- Route Table Associations
- Security Groups

### Terraform Concepts

- Resource Dependencies
- Variables
- Outputs
- Resource References
- Terraform State

---

## 🎓 Key Learnings

- AWS networking can be fully defined using code.
- Public subnets require an Internet Gateway and proper routing.
- Security Groups control inbound and outbound traffic.
- Terraform automatically manages resource dependencies.
- Infrastructure can be consistently recreated from code.

---

## 📈 Phase Summary

In this phase I learned how to:

- Build a custom VPC from scratch
- Configure internet connectivity
- Create and associate route tables
- Deploy EC2 instances into custom networks
- Manage infrastructure dependencies using Terraform

---

## ⏭️ Next Phase

The next phase focuses on:

- Remote State Management
- S3 Backend Configuration
- DynamoDB State Locking
- Team Collaboration Workflows

---

## 👨‍💻 Author

**Anshu Sharma**  
Cloud & DevOps Learning Journey

GitHub: https://github.com/anshu-sharma-devops