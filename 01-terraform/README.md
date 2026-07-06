<div align="center">

# ☁️ Terraform Learning Journey

### Infrastructure as Code (IaC) on AWS

*Part of the **Key Learning of Cloud & DevOps** repository*

[![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?style=flat-square&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?style=flat-square&logo=amazonaws&logoColor=white)](https://aws.amazon.com/)
[![Status](https://img.shields.io/badge/Status-In%20Progress-yellow?style=flat-square)]()
[![Last Updated](https://img.shields.io/badge/Last%20Updated-July%202026-blue?style=flat-square)]()

</div>

---

Terraform lets infrastructure be defined, version-controlled, and deployed as code — instead of clicking through the AWS Console. This repo documents that journey, phase by phase, from a single EC2 instance to production-grade, auto-scaling infrastructure.

> 📝 **This is a living document.** It's updated as each new phase is completed, so check back for progress.

---

## 📑 Table of Contents

- [Learning Objectives](#-learning-objectives)
- [Tech Stack](#️-tech-stack)
- [Roadmap](#-roadmap)
- [Repository Structure](#-repository-structure)
- [Terraform Workflow](#-terraform-workflow)
- [Concepts Covered](#-concepts-covered)
- [Progress Log](#-progress-log)
- [Key Learnings](#-key-learnings)
- [What's Next](#-whats-next)
- [Author](#-author)

---

## 🎯 Learning Objectives

- Learn Infrastructure as Code (IaC) principles and practice
- Provision real AWS infrastructure using Terraform
- Understand and manage Terraform state (local → remote)
- Build reusable, scalable, and production-grade infrastructure
- Progress from single-instance deployments to full cloud environments

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| ☁️ Cloud Provider | AWS |
| 🧱 Infrastructure as Code | Terraform |
| 🔧 Version Control | Git |
| 📦 Repository Hosting | GitHub |
| 💻 Code Editor | VS Code |
| 🖥️ Operating System | macOS |
| ⌨️ Terminal | zsh |

---

## 🗺️ Roadmap

| Phase | Topic | Status |
|:---:|---|:---:|
| 1 | Basic EC2 Deployment | ✅ Completed |
| 2 | VPC & Networking | ✅ Completed |
| 3 | Remote State Management | ✅ Completed |
| 4 | Multi-EC2 Infrastructure | ✅ Completed |
| 5 | Load Balancer & Auto Scaling | 🔄 In Progress |
| 6 | Jenkins Infrastructure | 🔜 Planned |
| 7 | Terraform Modules | 🔜 Planned |
| 8 | Production Infrastructure | 🔜 Planned |

**Progress: 4 / 8 phases complete**
`████████████████░░░░░░░░░░░░░░` **50%**

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
│   └── Variables & Outputs
│
├── phase-2-vpc-networking/
│   ├── VPC
│   ├── Public Subnet
│   ├── Internet Gateway
│   ├── Route Tables & Associations
│   ├── Security Groups
│   └── EC2 in Custom Network
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
├── phase-5-load-balancer-autoscaling/   🔄
├── phase-6-jenkins-infrastructure/      🔜
├── phase-7-terraform-modules/           🔜
└── phase-8-production-infrastructure/   🔜
```

---

## 🚀 Terraform Workflow

```text
Write Terraform Code
        ↓
terraform init          → initialize backend & providers
        ↓
terraform validate       → check syntax & config
        ↓
terraform fmt            → format code consistently
        ↓
terraform plan            → preview changes
        ↓
terraform apply            → create infrastructure
        ↓
terraform output             → retrieve resource details
        ↓
terraform destroy              → tear down when done
```

---

## 🧠 Concepts Covered

<details>
<summary><b>✅ Core Terraform Concepts</b></summary>
<br>

- Providers, Resources, Variables, Outputs
- Terraform State & Remote State
- Backend Configuration & State Migration
- State Locking
- Resource Dependencies
- Multi-Resource Deployments

</details>

<details>
<summary><b>✅ AWS Networking Concepts</b></summary>
<br>

- VPC & Subnets
- Internet Gateway
- Route Tables & Route Table Associations
- Security Groups

</details>

<details>
<summary><b>✅ AWS Services Used</b></summary>
<br>

- EC2
- S3
- DynamoDB

</details>

<details>
<summary><b>✅ Infrastructure Concepts</b></summary>
<br>

- Multi-EC2 Infrastructure
- Shared Security Groups
- Server Role Separation
- Multi-Server Architecture

</details>

<details>
<summary><b>✅ Terraform Commands</b></summary>
<br>

`terraform init` · `terraform validate` · `terraform fmt` · `terraform plan` · `terraform apply` · `terraform output` · `terraform destroy` · `terraform init -reconfigure` · `terraform init -migrate-state`

</details>

<details>
<summary><b>🔄 Currently Learning</b></summary>
<br>

- Load Balancing
- Auto Scaling
- High Availability Design

</details>

<details>
<summary><b>🔜 Upcoming Concepts</b></summary>
<br>

- Modules & Workspaces
- `count` & `for_each`
- Dynamic Blocks
- Data Sources
- Launch Templates & Auto Scaling Groups
- Application Load Balancer
- Multi-Environment Deployments
- Production Folder Structure & Reusable Patterns

</details>

---

## 📈 Progress Log

### ✅ Phase 1 — Basic EC2 Deployment
Created and managed: EC2 Instance · Security Group · Variables · Outputs · Terraform Lifecycle Commands

### ✅ Phase 2 — VPC & Networking
Created and managed: Custom VPC · Public Subnet · Internet Gateway · Route Table & Association · Security Group · EC2 Instance inside Custom VPC

### ✅ Phase 3 — Remote State Management
Created and managed: S3 Backend Bucket · Bucket Versioning · DynamoDB Lock Table · Backend Configuration · Remote State Migration · State Locking

### ✅ Phase 4 — Multi-EC2 Infrastructure
Created and managed: Jenkins Server EC2 · Application Server EC2 · Shared Security Group · Multiple Outputs · Server Role Separation

### 🔄 Phase 5 — Load Balancer & Auto Scaling *(in progress)*
Working on: Application Load Balancer · Target Groups · Auto Scaling Groups · Launch Templates · High Availability Design

---

## 💡 Key Learnings

> Insights collected along the way — updated as new phases are completed.

- Infrastructure can be fully defined, versioned, and repeated using code.
- Networking resources can be provisioned entirely without the AWS Console.
- Local state files don't scale to team environments — remote state is the production standard.
- S3 gives centralized, durable state storage; DynamoDB prevents concurrent modifications via locking.
- Infrastructure can be cleanly separated into dedicated server roles.
- Security Groups can be shared across multiple EC2 instances to reduce duplication.
- Terraform can provision multiple, interdependent resources in a single deployment.
- Outputs make it easy to retrieve infrastructure details after `apply`.

---

## 🔜 What's Next

### Phase 5 — Load Balancer & Auto Scaling
- Application Load Balancer (ALB)
- Target Groups
- Auto Scaling Groups & Launch Templates
- High Availability Architecture
- Dynamic Scaling Policies

### Looking further ahead
```text
Multi-Server Infrastructure
        ↓
Load Balancing & Auto Scaling   ← you are here
        ↓
Terraform Modules
        ↓
Production-Grade Deployments
```

---

## 👨‍💻 Author

**Anshu Sharma**
Cloud & DevOps Learning Journey

[![GitHub](https://img.shields.io/badge/GitHub-anshu--sharma--devops-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/anshu-sharma-devops)

<sub>⭐ If you're following a similar learning path, feel free to fork this structure for your own journey.</sub>