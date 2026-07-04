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
| Phase 3 | Remote State Management | 🔜 Planned |
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
│   ├── Security Groups
│   └── EC2 Deployment in Custom Network
│
├── phase-3-remote-state/
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

- Providers
- Resources
- Variables
- Outputs
- VPC
- Subnets
- Internet Gateway
- Route Tables
- Security Groups
- `terraform init`
- `terraform validate`
- `terraform plan`
- `terraform apply`
- `terraform output`
- `terraform destroy`

### 🔄 Currently Learning

- Terraform State
- Remote Backends
- State Locking

### 🔜 Upcoming

- S3 Backend
- DynamoDB State Locking
- Modules
- Workspaces
- `count`
- `for_each`
- Dynamic Blocks
- Multi-Environment Deployments
- Production Folder Structure

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
Production-Grade Deployments
```

---

## 🔜 Next Phase

### Phase 3 — Remote State Management

Upcoming topics:

- S3 Backend
- DynamoDB Locking
- Team Collaboration Workflow
- Shared Terraform State

---

## 👨‍💻 Author

**Anshu Sharma**  
Cloud & DevOps Learning Journey

GitHub: https://github.com/anshu-sharma-devops
