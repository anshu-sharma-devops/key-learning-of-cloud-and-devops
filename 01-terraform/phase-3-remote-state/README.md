# 🗄️ Phase 3 - Remote State Management using Terraform

This project demonstrates how to configure **Remote State Management** in Terraform using AWS S3 and DynamoDB.

In previous phases, Terraform state files were stored locally on the developer machine. In this phase, the state is moved to AWS so that multiple team members can safely collaborate on the same infrastructure.

This is a standard practice in production Terraform environments.

---

## 🎯 Objectives

- Understand Terraform State Management
- Learn why local state files are problematic for teams
- Store Terraform state remotely in S3
- Enable state locking using DynamoDB
- Prevent concurrent infrastructure modifications
- Simulate real-world Terraform workflows

---

## 🛠️ Technologies Used

| Category | Technology |
|----------|------------|
| Cloud Provider | AWS |
| Infrastructure as Code | Terraform |
| State Storage | Amazon S3 |
| State Locking | DynamoDB |
| Version Control | Git & GitHub |
| Editor | VS Code |
| Operating System | macOS |

---

## 🏗️ Infrastructure Created

The following AWS resources were provisioned:

- S3 Bucket for Terraform State Storage
- S3 Bucket Versioning
- DynamoDB Table for State Locking

---

## 📐 Architecture

```text
Developer Machine
        │
        ▼
Terraform CLI
        │
        ▼
S3 Bucket
(terraform.tfstate)
        │
        ▼
DynamoDB Table
(State Lock)
```

---

## 📂 Project Structure

```text
phase-3-remote-state/
│
├── backend.tf
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

Shows what Terraform will create before any changes are made.

---

### Create Infrastructure

```bash
terraform apply
```

Creates the S3 bucket and DynamoDB table.

---

### Configure Remote Backend

```bash
terraform init -reconfigure
```

Reconfigures Terraform to use the remote backend.

---

### Destroy Infrastructure

```bash
terraform destroy
```

Deletes infrastructure managed by Terraform.

---

## 🗂️ Backend Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "anshu-devops-terraform-state"
    key            = "01-terraform/phase-3-remote-state/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

---

## 📸 Screenshots

### Terraform Plan
Terraform generated an execution plan for remote state infrastructure.

### Terraform Apply
Terraform successfully provisioned AWS resources.

### S3 Bucket Created
S3 bucket created for storing Terraform state.

### Bucket Versioning Enabled
Versioning enabled to protect state history.

### DynamoDB Table Created
State locking table created successfully.

### Backend Configuration
Terraform configured to use remote state.

### State Migration
Terraform state successfully migrated to S3.

### Terraform Destroy
Infrastructure successfully destroyed after testing.

---

## 🐞 Errors and Fixes

| Error | Root Cause | Fix |
|-------|------------|-----|
| BucketNotEmpty: The bucket you tried to delete is not empty | Versioned S3 buckets retain object versions and delete markers | Deleted object versions and delete markers before running destroy |
| Error acquiring the state lock | DynamoDB lock table had already been removed while Terraform still expected it | Used `terraform destroy -lock=false` after verifying no active operations existed |

---

## 📚 Terraform Concepts Covered

### State Management

- Local State
- Remote State
- State Migration
- Backend Configuration

### AWS Services

- S3
- S3 Versioning
- DynamoDB

### Collaboration Concepts

- Shared State
- State Locking
- Team Workflows
- Infrastructure Consistency

---

## 🎓 Key Learnings

- Local state files are not suitable for team environments.
- S3 provides centralized and durable state storage.
- DynamoDB prevents multiple users from modifying infrastructure simultaneously.
- Backend migration moves state from local storage to remote storage.
- Remote state is a standard practice in production Terraform environments.
- State locking prevents corruption caused by concurrent Terraform operations.

---

## 📈 Phase Summary

In this phase I learned how to:

- Create a remote backend using S3
- Configure state locking using DynamoDB
- Migrate local state to remote storage
- Work with backend configuration files
- Handle common state management issues

---

## ⏭️ Next Phase

The next phase focuses on:

- Multiple EC2 Instances
- Shared Security Groups
- Resource References
- `count`
- `for_each`
- Production Infrastructure Patterns

---

## 👨‍💻 Author

**Anshu Sharma**  
Cloud & DevOps Learning Journey

GitHub: https://github.com/anshu-sharma-devops