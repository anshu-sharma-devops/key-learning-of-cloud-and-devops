<div align="center">

# ⚖️ Phase 5 — Load Balancer & Auto Scaling

### Building Highly Available Infrastructure with Terraform

[![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?style=flat-square&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?style=flat-square&logo=amazonaws&logoColor=white)](https://aws.amazon.com/)
[![Status](https://img.shields.io/badge/Phase-5%20of%208-blue?style=flat-square)]()
[![Free Tier](https://img.shields.io/badge/AWS-Free%20Tier-brightgreen?style=flat-square)]()

</div>

---

This project builds a highly available, self-healing application infrastructure using **Terraform**, an **Application Load Balancer (ALB)**, and an **Auto Scaling Group (ASG)**.

In earlier phases, the application ran on individual, manually-managed EC2 instances. In this phase, incoming traffic is distributed across multiple instances by a Load Balancer, while an Auto Scaling Group automatically launches, monitors, and replaces those instances as needed.

> 🏛️ This architecture is the foundation of production-grade cloud environments — it's the same pattern used to keep real-world applications online through traffic spikes and instance failures.

---

## 📑 Table of Contents

- [Objectives](#-objectives)
- [Tech Stack](#️-tech-stack)
- [Infrastructure Created](#️-infrastructure-created)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Terraform Commands](#-terraform-commands)
- [Screenshots](#-screenshots)
- [Errors & Fixes](#-errors--fixes)
- [Concepts Covered](#-concepts-covered)
- [Key Learnings](#-key-learnings)
- [Phase Summary](#-phase-summary)
- [Free Tier Considerations](#-free-tier-considerations)
- [Next Phase](#️-next-phase)
- [Author](#-author)

---

## 🎯 Objectives

- Learn how Application Load Balancers work
- Understand Auto Scaling concepts
- Distribute traffic across multiple application servers
- Improve application availability and fault tolerance
- Deploy scalable infrastructure using Terraform
- Build production-style cloud architecture

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| ☁️ Cloud Provider | AWS |
| 🧱 Infrastructure as Code | Terraform |
| 🖥️ Compute | EC2 |
| ⚖️ Load Balancing | Application Load Balancer |
| 📈 Scaling | Auto Scaling Group |
| 🌐 Networking | VPC, Subnets, Route Tables |
| 🔐 Security | Security Groups |
| 🔧 Version Control | Git & GitHub |
| 💻 Editor | VS Code |
| 🍎 Operating System | macOS |

---

## 🏗️ Infrastructure Created

| Resource | Purpose |
|---|---|
| VPC | Isolated network environment |
| 2× Public Subnets | Spread instances across Availability Zones |
| Internet Gateway | Allows internet-facing traffic |
| Route Table + Associations | Routes subnet traffic to the internet |
| Application Load Balancer | Distributes incoming traffic |
| Target Group | Tracks healthy application instances |
| Listener | Forwards ALB traffic to the Target Group |
| Launch Template | Standardized EC2 instance configuration |
| Auto Scaling Group | Manages instance count automatically |
| Security Groups | Controls ALB ↔ EC2 traffic flow |
| EC2 Instance(s) | Runs the application |

---

## 📐 Architecture

```text
                         🌐 Internet
                             │
                             ▼
              ┌──────────────────────────┐
              │  Application Load Balancer│
              └──────────────┬───────────┘
                             │
                             ▼
                     ┌───────────────┐
                     │  Target Group │
                     └───────┬───────┘
                             │
              ┌──────────────┴──────────────┐
              ▼                             ▼
     ┌──────────────────┐         ┌──────────────────┐
     │ App Server 1 (AZ-a)│       │ App Server 2 (AZ-b)│
     └──────────────────┘         └──────────────────┘
              │                             │
              └───────── Auto Scaling Group ┘
                    (min: 1 · desired: 1 · max: 2)
```

---

## 📂 Project Structure

```text
phase-5-load-balancer-autoscaling/
│
├── provider.tf        # AWS provider configuration
├── variables.tf       # Input variables
├── main.tf            # Core resource definitions
├── outputs.tf         # Output values (ALB DNS, ASG name, etc.)
├── README.md          # This file
└── screenshots/       # Deployment evidence
```

---

## 📋 Terraform Commands

| Step | Command | Description |
|---|---|---|
| 1️⃣ Initialize | `terraform init` | Downloads providers, initializes the working directory |
| 2️⃣ Validate | `terraform validate` | Checks configuration syntax & consistency |
| 3️⃣ Plan | `terraform plan` | Previews resources Terraform will create |
| 4️⃣ Apply | `terraform apply` | Creates all defined AWS resources |
| 5️⃣ Output | `terraform output` | Displays ALB DNS Name, URL, Target Group ARN, ASG Name |
| 6️⃣ Destroy | `terraform destroy` | Removes all managed resources |

---

## 📸 Screenshots

> 💡 Add screenshots to the `screenshots/` folder and link them below, e.g. `![Terraform Plan](screenshots/plan.png)`

<details>
<summary><b>🧾 Planning & Deployment</b></summary>
<br>

| Screenshot | Description |
|---|---|
| Terraform Plan | Execution plan generated before deployment |
| Terraform Apply | Infrastructure created successfully |
| Terraform Outputs | Output values displaying infrastructure info |
| Terraform Destroy | Infrastructure successfully removed after testing |

</details>

<details>
<summary><b>🌐 Networking</b></summary>
<br>

| Screenshot | Description |
|---|---|
| VPC Created | Custom VPC successfully provisioned |
| Public Subnets | Two public subnets created across different AZs |
| Internet Gateway Attached | Internet Gateway attached to the VPC |
| Route Table Configured | Public route configured through the Internet Gateway |

</details>

<details>
<summary><b>🔐 Security Groups</b></summary>
<br>

| Screenshot | Description |
|---|---|
| ALB Security Group | Allows HTTP traffic to the Load Balancer |
| Application Security Group | Allows traffic from the Load Balancer to EC2 instances |

</details>

<details>
<summary><b>⚖️ Load Balancer & Scaling</b></summary>
<br>

| Screenshot | Description |
|---|---|
| Launch Template Created | Configured for application instances |
| Target Group Created | Configured for application servers |
| Load Balancer Created | Application Load Balancer successfully created |
| Listener Created | HTTP listener forwarding traffic to the Target Group |
| Auto Scaling Group Created | Min: `1` · Desired: `1` · Max: `2` |

</details>

<details>
<summary><b>✅ Verification</b></summary>
<br>

| Screenshot | Description |
|---|---|
| EC2 Instance Running | Application instance launched by the ASG |
| Healthy Targets | Instance passed health checks |
| ALB URL Working | Application accessible via the Load Balancer DNS name |

</details>

---

## 🐞 Errors & Fixes

| Error | Root Cause | Fix |
|---|---|---|
| *No issues recorded yet* | — | — |

---

## 📚 Concepts Covered

<table>
<tr>
<td valign="top" width="33%">

**Infrastructure Concepts**
- Load Balancing
- High Availability
- Auto Scaling
- Fault Tolerance
- Horizontal Scaling

</td>
<td valign="top" width="33%">

**Terraform Concepts**
- Launch Templates
- Resource Dependencies
- Dynamic Infrastructure
- Multi-Resource Relationships

</td>
<td valign="top" width="34%">

**AWS Services**
- EC2
- Application Load Balancer
- Auto Scaling Group
- Launch Templates
- Target Groups

</td>
</tr>
</table>

---

## 🎓 Key Learnings

- Application Load Balancers distribute traffic across multiple servers.
- Auto Scaling Groups automatically manage application capacity.
- Health checks ensure traffic reaches only healthy instances.
- Launch Templates standardize EC2 deployments.
- Horizontal scaling improves availability and resilience.
- Terraform can automate complex, production-style architectures end to end.

---

## 📈 Phase Summary

In this phase, I learned how to:

- ✅ Build highly available application infrastructure
- ✅ Configure Application Load Balancers
- ✅ Create Target Groups and Listeners
- ✅ Configure Launch Templates
- ✅ Deploy Auto Scaling Groups
- ✅ Implement production-style scaling patterns

---

## 💰 Free Tier Considerations

To keep this project within the AWS Free Tier:

- EC2 instances limited to `t3.micro`
- Auto Scaling **minimum** and **desired** capacity set to `1`
- Load Balancer destroyed immediately after testing to avoid unnecessary charges

---

## ⏭️ Next Phase

### Phase 6 — Jenkins Infrastructure
- CI/CD Foundations
- Infrastructure Automation
- Build Pipelines
- Deployment Pipelines

```text
Load Balancing & Auto Scaling   ✅ (this phase)
        ↓
Jenkins Infrastructure           ← up next
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