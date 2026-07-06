<div align="center">

# ☁️ Terraform Learning Journey

**Infrastructure as Code (IaC) on AWS — from a single EC2 instance to production-grade environments**

Part of the **Key Learning of Cloud and DevOps** repository

[![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Status](https://img.shields.io/badge/Status-Actively%20Updated-brightgreen)]()

</div>

---

## 📖 About This Journey

This repository documents my hands-on path to learning **Infrastructure as Code** with Terraform on AWS — replacing manual, click-through console setups with version-controlled, repeatable, and scalable infrastructure defined entirely in code.

Each phase builds on the last: starting with a single EC2 instance, then adding networking, remote state, multi-server architecture, and eventually scaling into highly available, production-ready deployments.

> 🔄 **This is a living repository** — new phases are added as I progress. Check back for updates.

---

## 🎯 Learning Objectives

- Learn Infrastructure as Code (IaC) principles and practice
- Provision AWS infrastructure using Terraform
- Understand and manage Terraform state
- Build reusable, scalable infrastructure patterns
- Follow production-grade infrastructure practices
- Progress from single-resource deployments to complete cloud environments

---

## 🛠️ Technologies Used

| Category | Technology |
|---|---|
| ☁️ Cloud Provider | AWS |
| 🧱 Infrastructure as Code | Terraform |
| 🔧 Version Control | Git |
| 📦 Repository | GitHub |
| 💻 Code Editor | VS Code |
| 🖥️ Operating System | macOS |
| ⌨️ Terminal | zsh |

---

## 🗺️ Terraform Learning Roadmap

| Phase | Topic | Status |
|---|---|:---:|
| 1 | Basic EC2 Deployment | ✅ Completed |
| 2 | VPC and Networking | ✅ Completed |
| 3 | Remote State Management | ✅ Completed |
| 4 | Multi-EC2 Infrastructure | ✅ Completed |
| 5 | Load Balancer and Auto Scaling | 🚧 In Progress |
| 6 | Jenkins Infrastructure | 🔜 Planned |
| 7 | Terraform Modules | 🔜 Planned |
| 8 | Production Infrastructure | 🔜 Planned |

---

## 📂 Repository Structure

```text
01-terraform/
│
├── README.md
│
├── phase-1-basic-ec2/
│   ├── Terraform Fundamentals
│   ├── EC2 Deployment
│   ├── Security Groups
│   └── Variables and Outputs
│
├── phase-2-vpc-networking/
│   ├── VPC
│   ├── Public Subnet
│   ├── Internet Gateway
│   ├── Route Tables
│   ├── Route Table Associations
│   ├── Security Groups
│   └── EC2 Deployment in Custom Network
│
├── phase-3-remote-state/
│   ├── S3 Backend
│   ├── S3 Versioning
│   ├── DynamoDB State Locking
│   ├── Backend Configuration
│   └── Remote State Migration
│
├── phase-4-multi-ec2/
│   ├── Multiple EC2 Instances
│   ├── Shared Security Groups
│   ├── Resource Dependencies
│   ├── Terraform Outputs
│   └── Multi-Server Architecture
│
├── phase-5-load-balancer-autoscaling/   🚧 in progress
│   ├── Application Load Balancer
│   ├── Target Groups
│   ├── Launch Templates
│   └── Auto Scaling Groups
│
├── phase-6-jenkins-infrastructure/
├── phase-7-terraform-modules/
└── phase-8-production-infrastructure/
```

---

## 🧠 Terraform Concepts Covered

<details open>
<summary><strong>✅ Completed</strong></summary>

<br>

**Core Terraform Concepts**
- Providers · Resources · Variables · Outputs
- Terraform State · Remote State · Backend Configuration
- State Migration · State Locking
- Resource Dependencies · Multi-Resource Deployments

**AWS Networking Concepts**
- VPC · Subnets · Internet Gateway
- Route Tables · Route Table Associations · Security Groups

**AWS Services Used**
- EC2 · S3 · DynamoDB

**Infrastructure Concepts**
- Multi-EC2 Infrastructure · Shared Security Groups
- Server Role Separation · Multi-Server Architecture

**Terraform Commands**

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform output
terraform destroy
terraform init -reconfigure
terraform init -migrate-state
```

</details>

<details open>
<summary><strong>🚧 Currently Learning — Phase 5</strong></summary>

<br>

- Application Load Balancer (ALB)
- Target Groups
- Launch Templates
- Auto Scaling Groups
- Dynamic Scaling Policies
- High Availability Design

</details>

<details>
<summary><strong>🔜 Upcoming Concepts</strong></summary>

<br>

- Modules · Workspaces
- `count` · `for_each` · Dynamic Blocks
- Data Sources
- Multi-Environment Deployments
- Production Folder Structure
- Reusable Infrastructure Patterns

</details>

---

## 🚀 Terraform Workflow

```text
Write Terraform Code
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
Infrastructure Created
        ↓
terraform output
        ↓
terraform destroy
```

---

## 📈 Progress Log

### ✅ Phase 1 — Basic EC2 Deployment
Created and managed:
- EC2 Instance
- Security Group
- Variables and Outputs
- Terraform Lifecycle Commands

### ✅ Phase 2 — VPC and Networking
Created and managed:
- Custom VPC · Public Subnet
- Internet Gateway · Route Table · Route Table Association
- Security Group
- EC2 Instance inside Custom VPC

### ✅ Phase 3 — Remote State Management
Created and managed:
- S3 Backend Bucket + Versioning
- DynamoDB Lock Table
- Backend Configuration
- Remote State Migration & Locking

### ✅ Phase 4 — Multi-EC2 Infrastructure
Created and managed:
- Jenkins Server EC2
- Application Server EC2
- Shared Security Group
- Multiple Outputs
- Multi-Server Architecture & Role Separation

### 🚧 Phase 5 — Load Balancer and Auto Scaling *(in progress)*
Working on:
- Application Load Balancer (ALB) setup
- Target Groups for routing traffic across instances
- Launch Templates for standardized instance configuration
- Auto Scaling Groups for elastic, high-availability infrastructure

> 📝 This section will be updated with details and code as the phase progresses.

---

## 🎓 Learning Goal

```text
Single EC2 Instance
        ↓
Custom Networking
        ↓
Remote State Management
        ↓
Multi-Server Infrastructure
        ↓
Load Balancing & Scaling   ← currently here
        ↓
Production-Grade Deployments
```

---

## 📌 Key Learnings So Far

- Infrastructure can be fully defined using code.
- Terraform provides repeatable and predictable deployments.
- Networking resources can be provisioned without touching the AWS Console.
- Local state files are not suitable for team environments.
- S3 provides centralized, durable Terraform state storage.
- DynamoDB prevents concurrent infrastructure modifications.
- Remote state management is a production standard in Terraform environments.
- Infrastructure can be separated into dedicated server roles.
- Security Groups can be shared across multiple EC2 instances.
- Terraform can provision multiple resources in a single deployment.
- Outputs simplify access to infrastructure details after deployment.
- Load balancing and auto scaling are key to building highly available systems *(new, Phase 5)*.

---

## 🔜 What's Next

### Phase 6 — Jenkins Infrastructure
- Dedicated CI/CD server provisioning
- Jenkins-specific networking and security rules

### Phase 7 — Terraform Modules
- Refactoring existing phases into reusable modules
- Building a modular, DRY infrastructure codebase

### Phase 8 — Production Infrastructure
- Multi-environment setups (dev / staging / prod)
- Production-grade folder structure and best practices

---

<div align="center">

## 👨‍💻 Author

**Anshu Sharma**
Cloud & DevOps Learning Journey

[![GitHub](https://img.shields.io/badge/GitHub-anshu--sharma--devops-181717?logo=github&logoColor=white)](https://github.com/anshu-sharma-devops)

*⭐ This repo is updated as new phases are completed — feel free to follow along.*

</div>