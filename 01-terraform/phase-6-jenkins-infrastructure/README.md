<div align="center">

# 🛠️ Phase 6 — Jenkins Server Infrastructure using Terraform

**Provisioning the foundation for CI/CD on AWS with Terraform**

[![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![Status](https://img.shields.io/badge/Status-Completed-brightgreen)]()

</div>

---

## 📖 Overview

This project demonstrates how to provision **Jenkins infrastructure** on AWS using Terraform.

Unlike previous phases that focused on networking, remote state management, and scaling, this phase focuses on preparing the infrastructure required for **Continuous Integration and Continuous Deployment (CI/CD)** workflows.

The objective here is to build the infrastructure *foundation* for Jenkins. Jenkins installation, configuration, jobs, pipelines, and agent setup are covered separately in the `02-jenkins` section of this repository.

> 🧩 **Design principle:** infrastructure provisioning and software configuration are kept separate — Terraform builds the server, Jenkins setup happens on top of it.

---

## 🎯 Objectives

- Provision Jenkins infrastructure using Terraform
- Create a dedicated EC2 instance for Jenkins
- Configure Security Groups for Jenkins access
- Generate outputs for SSH and Jenkins access
- Prepare the foundation for future CI/CD pipelines
- Separate infrastructure provisioning from application configuration

---

## 🛠️ Technologies Used

| Category | Technology |
|---|---|
| ☁️ Cloud Provider | AWS |
| 🧱 Infrastructure as Code | Terraform |
| 🖥️ Compute | EC2 |
| 🔒 Security | Security Groups |
| 🔁 CI/CD | Jenkins |
| 🔧 Version Control | Git & GitHub |
| 💻 Editor | VS Code |
| 🖱️ Operating System | macOS |
| ⌨️ Terminal | zsh |

---

## 🏗️ Infrastructure Created

| Resource | Purpose |
|---|---|
| Jenkins EC2 Instance | Hosts the Jenkins server |
| Jenkins Security Group | Controls inbound access (SSH + Jenkins UI) |
| Terraform Outputs | Exposes IP, URL, and SSH command |

---

## 📐 Architecture

```text
                    Internet
                       │
                       ▼
             Jenkins Security Group
               (22 SSH, 8080 UI)
                       │
                       ▼
                Jenkins Server
                 (EC2 Instance)
```

---

## 📂 Project Structure

```text
phase-6-jenkins-infrastructure/
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

| Command | Purpose |
|---|---|
| `terraform init` | Downloads required providers and initializes the working directory |
| `terraform validate` | Checks configuration for syntax errors and consistency |
| `terraform plan` | Previews resources Terraform will create before deployment |
| `terraform apply` | Creates the Jenkins EC2 instance and Security Group |
| `terraform output` | Displays Jenkins Public IP, URL, and SSH command |
| `terraform destroy` | Deletes all resources managed by Terraform |

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```

---

## 📸 Screenshots

| Screenshot | Description |
|---|---|
| **Terraform Plan** | Execution plan generated before deployment |
| **Terraform Apply** | AWS resources successfully provisioned |
| **Security Group Created** | Inbound rules configured for SSH (22) and Jenkins UI (8080) |
| **Jenkins Server Running** | EC2 instance successfully created and running |
| **Terraform Outputs** | Public IP address and access information displayed |
| **SSH Connection** | Successful SSH connection to the Jenkins server |
| **Jenkins Security Group Rules** | Inbound access configured for Jenkins UI and SSH |
| **Terraform Destroy** | Infrastructure successfully removed after testing |

> 📷 *Add screenshots to the `screenshots/` folder and reference them here.*

---

## 🐞 Errors and Fixes

| Error | Root Cause | Fix |
|---|---|---|
| *No issues recorded yet* | — | — |

---

## 📚 Terraform Concepts Covered

**Infrastructure Concepts**
- CI/CD Infrastructure
- Infrastructure Provisioning
- Dedicated Server Architecture

**Terraform Concepts**
- Variables · Outputs
- Resource Definitions
- Infrastructure Lifecycle Management

**AWS Services**
- EC2 · Security Groups

---

## 🎓 Key Learnings

- Terraform can provision infrastructure required for CI/CD platforms.
- Security Groups can be configured specifically for Jenkins access requirements.
- Infrastructure provisioning and software installation should be kept separate.
- Outputs simplify infrastructure access after deployment.
- Terraform enables repeatable and predictable infrastructure deployments.

---

## 📈 Phase Summary

In this phase I learned how to:

- Provision Jenkins infrastructure using Terraform
- Create dedicated CI/CD infrastructure
- Configure Jenkins networking requirements
- Generate useful deployment outputs
- Prepare the foundation for future Jenkins automation

---

## 🔗 Connection to Future Sections

This phase only provisions Jenkins **infrastructure**. Software setup is covered separately:

### `02-jenkins`
- Jenkins Installation
- Initial Setup Wizard
- Plugin Installation
- Pipeline Jobs
- Declarative Pipelines
- Jenkins Agents

### `03-ansible`
- Automated Jenkins Installation
- Automated Docker Installation
- Server Configuration Management

---

## 💰 Free Tier Considerations

- Instance type used: `t3.micro`
- Infrastructure was destroyed after testing to avoid unnecessary charges.
- Only the required resources were provisioned.

---

## ⏭️ Next Phase

### Phase 7 — Terraform Modules
- Reusable Infrastructure
- Production Folder Structure
- Modular Architecture
- Infrastructure Reusability

---

<div align="center">

## 👨‍💻 Author

**Anshu Sharma**
Cloud & DevOps Learning Journey

[![GitHub](https://img.shields.io/badge/GitHub-anshu--sharma--devops-181717?logo=github&logoColor=white)](https://github.com/anshu-sharma-devops)

</div>