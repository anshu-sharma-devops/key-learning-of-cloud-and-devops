# Terraform Learning Project

Part of my **Key Learning of Cloud and DevOps** repository, this section focuses on learning and demonstrating **Infrastructure as Code (IaC)** using Terraform on AWS.

Terraform lets you define infrastructure in code so it can be created, modified, and destroyed in a repeatable, version-controlled way — instead of clicking through the AWS Console by hand.

---

## Objectives

- Understand Terraform fundamentals
- Create and manage AWS resources using code
- Learn the core principles of Infrastructure as Code (IaC)
- Manage infrastructure using Terraform state
- Practice real-world Terraform workflows
- Build reusable and scalable infrastructure patterns

---

## Technologies Used

| Category   | Tools                  |
|------------|-------------------------|
| Cloud      | AWS                     |
| IaC        | Terraform               |
| Editor     | VS Code                 |
| Versioning | Git & GitHub            |
| OS / Shell | macOS Terminal          |

---

## Project Structure

```text
01-terraform/
├── provider.tf      # AWS provider configuration
├── variables.tf     # Input variables
├── main.tf           # Core resource definitions
├── outputs.tf        # Output values
├── README.md
└── screenshots/      # Plan/apply evidence
```

---

## Resources Created

### ✅ Current

- EC2 Instance
- Security Group

### 🔜 Upcoming

- VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables
- S3 Backend (remote state)
- DynamoDB Table (state locking)
- Terraform Modules

---

## Terraform Concepts Covered

| Status         | Concepts                                                                 |
|----------------|---------------------------------------------------------------------------|
| ✅ Completed    | Provider, Resource, `terraform init`, `terraform validate`, `terraform plan` |
| 🔄 In Progress  | `terraform apply`, Variables, Outputs                                     |
| 🔜 Upcoming     | Terraform State, Remote Backend, Modules, `count`, `for_each`, Workspaces, Production Folder Structure |

---

## Commands Reference

```bash
terraform init        # Initialize working directory and download providers
terraform fmt          # Auto-format configuration files
terraform validate     # Check configuration syntax and internal consistency
terraform plan         # Preview changes before applying
terraform apply        # Create or update infrastructure
terraform output       # Display output values
terraform destroy      # Tear down managed infrastructure
```

---

## Screenshots

### Terraform Plan
Terraform analyzed the configuration and generated an execution plan before creating any resources.

> *Add screenshot here.*

### Terraform Apply
Terraform created the AWS resources successfully.

> *Add screenshot here.*

### EC2 Instance Created
AWS EC2 instance provisioned via Terraform, visible in the AWS Console.

> *Add screenshot here.*

---

## Errors and Fixes

This section will be updated with real issues encountered during the learning process, along with how they were resolved.

| Error | Root Cause | Fix |
|-------|------------|-----|
| *No errors recorded yet* | — | — |

---

## Key Learnings

- Terraform uses declarative configuration files to define and manage infrastructure.
- `terraform plan` previews exactly what will change before anything is touched.
- `terraform apply` provisions the resources defined in the configuration.
- Terraform state keeps track of what infrastructure it manages and its current status.
- Infrastructure defined as code can be destroyed and recreated consistently and predictably.

---

## Next Steps

- [ ] Complete `terraform apply` workflow
- [ ] Learn and implement Outputs
- [ ] Learn State Management
- [ ] Configure S3 Backend for remote state
- [ ] Implement DynamoDB state locking
- [ ] Build reusable Terraform Modules
- [ ] Practice Terraform Workspaces

---

## Author

**Anshu Sharma**
Cloud & DevOps Learning Journey