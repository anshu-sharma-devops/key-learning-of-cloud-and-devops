<div align="center">

# ☁️ Phase 8 – Production Infrastructure with Terraform

### Building a Production-Ready Infrastructure using Reusable Modules and Environment-Based Configuration

Part of the **Key Learning of Cloud and DevOps** Repository

![Terraform](https://img.shields.io/badge/Terraform-v1.5+-623CE4?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Free%20Tier-FF9900?logo=amazon-aws&logoColor=white)
![Environment](https://img.shields.io/badge/Environment-Dev%20%7C%20Prod-blue)
![Status](https://img.shields.io/badge/Status-Completed-success)

</div>

---

## 📖 Project Overview

Phase 8 focuses on organizing Terraform infrastructure using a production-style project structure. Instead of placing all infrastructure resources in a single Terraform configuration, the infrastructure is divided into reusable modules and separate environments.

The project demonstrates how Terraform can be structured to support multiple environments such as Development and Production while keeping the code modular, reusable, and easy to maintain.

This phase simulates how infrastructure is commonly organized in enterprise environments where the same infrastructure modules are reused across multiple environments.

---

## 🎯 Objectives

- Build a production-ready Terraform project structure
- Learn reusable Terraform modules
- Separate Development and Production environments
- Improve infrastructure organization
- Reduce code duplication
- Follow Infrastructure as Code (IaC) best practices
- Deploy AWS infrastructure using modular design
- Prepare infrastructure for future scalability

---

## 🏗 Architecture

```
                    Internet
                        │
                Internet Gateway
                        │
                Public Route Table
                        │
                  Public Subnet
                        │
              Security Group
               (22, 80 Open)
                        │
                EC2 Web Server
               Apache Installed
```

**Traffic flow:** Internet → Internet Gateway → VPC → Public Subnet → Security Group (22, 80) → EC2 Web Server (Apache)

![Phase 8 architecture diagram](./architecture-diagram.svg)

Terraform Project Structure

```
Terraform
│
├── environments
│   ├── dev
│   └── prod
│
├── modules
│   ├── vpc
│   ├── security-group
│   └── ec2
│
├── README.md
└── TROUBLESHOOTING.md
```

---

## 📂 Project Structure

```
phase-8-production-infrastructure/
│
├── environments
│   ├── dev
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   │
│   └── prod
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
│
├── modules
│   ├── vpc
│   ├── security-group
│   └── ec2
│
├── screenshots
│
├── README.md
└── TROUBLESHOOTING.md
```

---

## 📦 Terraform Modules

### VPC Module

Responsible for creating:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association

This module handles the complete networking layer of the infrastructure.

---

### Security Group Module

Responsible for creating:

- SSH Rule (22)
- HTTP Rule (80)
- Outbound Rules

This module secures the EC2 instance while allowing remote administration and web traffic.

---

### EC2 Module

Responsible for creating:

- EC2 Instance
- Apache Installation
- Website Deployment
- Resource Tags

The EC2 instance automatically installs Apache using User Data during instance launch.

---

## 🌍 Environment Structure

### Development Environment

The Dev environment is used for testing infrastructure changes.

**Characteristics**

- Safe for experimentation
- Small instance size
- Free Tier friendly
- Fully deployed and verified

---

### Production Environment

The Production environment demonstrates how the same modules can be reused with different configurations.

**Characteristics**

- Separate configuration
- Separate variables
- Ready for deployment
- Not deployed to avoid unnecessary AWS costs

---

## ☁ AWS Resources Created

| Resource | Purpose |
|-----------|----------|
| VPC | Private Network |
| Public Subnet | Host EC2 Instance |
| Internet Gateway | Internet Access |
| Route Table | Route Traffic |
| Security Group | Firewall Rules |
| EC2 Instance | Apache Web Server |

---

## 🏷 Resource Tagging

Every AWS resource is tagged using:

- Project
- Environment
- Name

Example:

```
Project     = phase-8-production-infra
Environment = dev
Name        = phase-8-production-infra-dev-web-server
```

This makes AWS resources easier to identify and manage.

---

## ⚙ Terraform Workflow

```
terraform init
      ↓
terraform fmt
      ↓
terraform validate
      ↓
terraform plan
      ↓
terraform apply
      ↓
terraform output
      ↓
terraform destroy
```

---

## 🚀 Deployment Process

**Initialize Terraform**
```bash
terraform init
```

**Format Code**
```bash
terraform fmt -recursive
```

**Validate Configuration**
```bash
terraform validate
```

**Preview Infrastructure**
```bash
terraform plan
```

**Deploy Infrastructure**
```bash
terraform apply
```

**View Outputs**
```bash
terraform output
```

**Destroy Infrastructure**
```bash
terraform destroy
```

---

## 🌐 Website Verification

After deployment, Terraform outputs:

```
website_url
```

Opening the URL displays:

```
Phase 8 Production Infrastructure
Dev Environment
Deployed using Terraform Modules
```

---

## 📊 Terraform Outputs

The project provides:

- VPC ID
- Public Subnet ID
- Security Group ID
- EC2 Public IP
- Website URL

---

## 📸 Screenshots

```
01-folder-structure.png
02-files-created.png
03-environment-structure.png
04-terraform-init.png
05-terraform-fmt-validate.png
06-terraform-plan.png
07-terraform-apply-success.png
08-vpc-created.png
09-public-subnet-created.png
10-route-table-and-igw.png
11-security-group-created.png
12-apache-webpage.png
13-terraform-output.png
14-ssh-connected.png
15-ec2-instance-running.png
16-prod-environment-plan.png
17-terraform-destroy.png
```

---

## 🎓 Learning Outcomes

After completing this phase, I learned:

- How enterprise Terraform projects are organized
- How reusable modules reduce code duplication
- How to separate Development and Production environments
- How to structure Infrastructure as Code projects
- How Terraform modules communicate using variables and outputs
- How to organize Terraform repositories for long-term maintenance
- How environment-specific configuration improves infrastructure management
- How User Data automates server provisioning
- How to tag AWS resources consistently
- How to safely deploy and destroy infrastructure in the AWS Free Tier

---

## 🚀 Future Improvements

Possible enhancements include:

- Remote Backend (S3 + DynamoDB)
- Multiple Availability Zones
- Private Subnets
- NAT Gateway
- Application Load Balancer
- Auto Scaling Group
- Terraform Workspaces
- CI/CD Pipeline Integration
- Terraform Cloud
- Kubernetes Deployment
- Monitoring with Prometheus & Grafana

---

## 🧹 Cleanup

To avoid AWS charges:

```bash
terraform destroy
```

Verify:

- EC2 deleted
- VPC deleted
- Security Groups deleted
- Internet Gateway deleted
- Route Table deleted

---

## ✅ Conclusion

Phase 8 represents the transition from writing simple Terraform configurations to designing production-style Infrastructure as Code projects.

Instead of deploying infrastructure from a single configuration file, this phase introduces reusable Terraform modules, separate environment configurations, and an organized repository structure similar to those used in enterprise DevOps teams.

By completing this phase, I gained practical experience in building maintainable, scalable, and reusable cloud infrastructure on AWS while following Infrastructure as Code best practices.

The project provides a strong foundation for future work involving CI/CD pipelines, Kubernetes, monitoring, and enterprise cloud architecture.