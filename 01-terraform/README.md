# ☁️ Terraform Learning Journey

Part of my **Key Learning of Cloud and DevOps** repository, this section documents my journey of learning **Infrastructure as Code (IaC)** using Terraform on AWS.

Terraform allows infrastructure to be defined, version controlled, and deployed using code instead of manually creating resources through the AWS Console.

---

## 🎯 Learning Objectives

- Learn Infrastructure as Code (IaC)
- Provision AWS infrastructure using Terraform
- Understand Terraform state management
- Build reusable and scalable infrastructure
- Follow production-grade infrastructure practices
- Move from single EC2 deployments to complete cloud environments

---

## 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| Cloud Provider | AWS |
| Infrastructure as Code | Terraform |
| Version Control | Git |
| Repository | GitHub |
| Code Editor | VS Code |
| Operating System | macOS |
| Terminal | zsh |

---

## 📚 Terraform Learning Roadmap

| Phase | Topic | Status |
|-------|-------|--------|
| Phase 1 | Basic EC2 Deployment | ✅ Completed |
| Phase 2 | VPC and Networking | ✅ Completed |
| Phase 3 | Remote State Management | ✅ Completed |
| Phase 4 | Multi-EC2 Infrastructure | 🔜 Planned |
| Phase 5 | Load Balancer and Auto Scaling | 🔜 Planned |
| Phase 6 | Jenkins Infrastructure | 🔜 Planned |
| Phase 7 | Terraform Modules | 🔜 Planned |
| Phase 8 | Production Infrastructure | 🔜 Planned |

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
│
├── phase-5-load-balancer-autoscaling/
│
├── phase-6-jenkins-infrastructure/
│
├── phase-7-terraform-modules/
│
└── phase-8-production-infrastructure/
```

---

## 🧠 Terraform Concepts Covered

### ✅ Completed

#### Core Terraform Concepts
- Providers
- Resources
- Variables
- Outputs
- Terraform State
- Remote State
- Backend Configuration
- State Migration
- State Locking

#### AWS Networking Concepts
- VPC
- Subnets
- Internet Gateway
- Route Tables
- Route Table Associations
- Security Groups

#### AWS Services Used
- EC2
- S3
- DynamoDB

#### Terraform Commands
- `terraform init`
- `terraform validate`
- `terraform fmt`
- `terraform plan`
- `terraform apply`
- `terraform output`s
- `terraform destroy`
- `terraform init -reconfigure`
- `terraform init -migrate-state`

---

### 🔄 Currently Learning

- Multi-EC2 Infrastructure
- Resource Dependencies
- Infrastructure Scaling Patterns

---

### 🔜 Upcoming Concepts

- Modules
- Workspaces
- `count`
- `for_each`
- Dynamic Blocks
- Data Sources
- Multi-Environment Deployments
- Production Folder Structure
- Reusable Infrastructure Patterns

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
terraform destroy
```

---

## 📈 Current Progress

### ✅ Phase 1 — Basic EC2 Deployment

Created and managed:

- EC2 Instance
- Security Group
- Variables
- Outputs
- Terraform Lifecycle Commands

---

### ✅ Phase 2 — VPC and Networking

Created and managed:

- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association
- Security Group
- EC2 Instance inside Custom VPC

---

### ✅ Phase 3 — Remote State Management

Created and managed:

- S3 Backend Bucket
- Bucket Versioning
- DynamoDB Lock Table
- Backend Configuration
- Remote State Migration
- State Locking
- Remote State Storage

---

## 🎓 Learning Goal

The goal of this Terraform journey is to progress from:

```text
Single EC2 Instance
        ↓
Custom Networking
        ↓
Remote State Management
        ↓
Multi-Server Infrastructure
        ↓
Load Balancing
        ↓
Production-Grade Deployments
```

---

## 📌 Key Learnings So Far

- Infrastructure can be fully defined using code.
- Terraform provides repeatable and predictable deployments.
- Networking resources can be provisioned without using the AWS Console.
- Local state files are not suitable for team environments.
- S3 provides centralized and durable Terraform state storage.
- DynamoDB prevents concurrent infrastructure modifications.
- Remote state management is a production standard in Terraform environments.

---

## 🔜 Next Phase

### Phase 4 — Multi-EC2 Infrastructure

Upcoming topics:

- Multiple EC2 Instances
- Shared Security Groups
- Resource Dependencies
- `count`
- `for_each`
- Reusable Infrastructure Patterns

---

## 👨‍💻 Author

**Anshu Sharma**  
Cloud & DevOps Learning Journey

GitHub: https://github.com/anshu-sharma-devops