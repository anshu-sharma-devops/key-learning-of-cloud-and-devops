# 🖥️ Phase 4 - Multi EC2 Infrastructure using Terraform

This project demonstrates how to provision and manage multiple EC2 instances using Terraform.

Unlike previous phases where a single server was deployed, this phase introduces infrastructure patterns commonly used in real-world DevOps environments where different servers are responsible for different tasks.

This is the fourth phase of my Terraform learning journey.

---

## 🎯 Objectives

- Learn how to provision multiple EC2 instances using Terraform
- Understand infrastructure separation and server roles
- Use shared Security Groups across multiple servers
- Learn resource references and dependencies
- Generate outputs for multiple resources
- Simulate production-style infrastructure deployment

---

## 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| Cloud Provider | AWS |
| Infrastructure as Code | Terraform |
| Compute | EC2 |
| Security | Security Groups |
| Version Control | Git & GitHub |
| Code Editor | VS Code |
| Operating System | macOS |
| Terminal | zsh |

---

## 🏗️ Infrastructure Created

The following AWS resources were provisioned:

- Security Group
- Jenkins Server EC2 Instance
- Application Server EC2 Instance

---

## 📐 Architecture

```text
                    Internet
                        │
                        ▼
                Security Group
            (22, 80, 8080 Allowed)
                        │
        ┌───────────────┴───────────────┐
        ▼                               ▼
 Jenkins Server                  Application Server
    Port 8080                         Port 80
```

---

## 📂 Project Structure

```text
phase-4-multi-ec2/
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

Downloads required providers and initializes the working directory.

---

### Validate Configuration

```bash
terraform validate
```

Checks Terraform configuration for syntax errors and consistency.

---

### Preview Infrastructure Changes

```bash
terraform plan
```

Displays the resources Terraform will create before any changes are applied.

---

### Create Infrastructure

```bash
terraform apply
```

Creates the Security Group and both EC2 instances.

---

### View Outputs

```bash
terraform output
```

Displays useful information including:

- Jenkins Server Public IP
- Application Server Public IP
- SSH Commands
- Jenkins URL

---

### Destroy Infrastructure

```bash
terraform destroy
```

Deletes all infrastructure managed by Terraform.

---

## 📸 Screenshots

### Terraform Plan
Terraform generated an execution plan before infrastructure creation.

### Terraform Apply
Terraform successfully provisioned AWS resources.

### Security Group Created
Security Group created with inbound rules for:

- SSH (22)
- HTTP (80)
- Jenkins (8080)

### Jenkins Server Running
Jenkins server instance successfully created.

### Application Server Running
Application server instance successfully created.

### EC2 Instances List
AWS Console displaying both EC2 instances.

### Terraform Outputs
Terraform outputs displaying public IP addresses and connection details.

### SSH Connection - Jenkins Server
Successful SSH connection to Jenkins server.

### SSH Connection - Application Server
Successful SSH connection to application server.

### Terraform Destroy
Infrastructure successfully removed after testing.

---

## 🐞 Errors and Fixes

| Error | Root Cause | Fix |
|-------|------------|-----|
| No issues recorded yet | - | - |

---

## 📚 Terraform Concepts Covered

### Infrastructure Concepts

- Multi-Server Architecture
- Infrastructure Separation
- Server Roles
- Shared Security Groups

### Terraform Concepts

- Multiple Resources
- Resource References
- Outputs
- Variables
- Dependencies

### AWS Concepts

- EC2
- Security Groups
- Public Networking

---

## 🎓 Key Learnings

- Infrastructure can be organized into separate server roles.
- Terraform can manage multiple resources in a single deployment.
- Security Groups can be shared across multiple EC2 instances.
- Outputs make it easier to retrieve deployment information.
- Infrastructure can be scaled by adding additional resources to the configuration.

---

## 📈 Phase Summary

In this phase I learned how to:

- Deploy multiple EC2 instances simultaneously
- Separate infrastructure responsibilities across servers
- Manage shared Security Groups
- Generate outputs for multiple resources
- Simulate production-style infrastructure design

---

## ⏭️ Next Phase

The next phase focuses on:

- Load Balancers
- Auto Scaling Groups
- Dynamic Infrastructure
- Production Availability Patterns
- Infrastructure Scaling

---

## 👨‍💻 Author

**Anshu Sharma**  
Cloud & DevOps Learning Journey

GitHub: https://github.com/anshu-sharma-devops