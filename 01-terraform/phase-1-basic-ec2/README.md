# 🚀 Phase 1 — Basic EC2 Deployment

Part of the [Terraform Learning Journey](../README.md) — *Key Learning of Cloud and DevOps*

---

## 🎯 Objective

The goal of this phase was to take the very first step into Infrastructure as Code: replace a manual, console-driven EC2 launch with a fully Terraform-defined deployment, and get comfortable with the core Terraform workflow.

## 🏗️ What Was Built

- A single **EC2 instance** provisioned entirely through Terraform
- A **Security Group** controlling inbound/outbound access to the instance
- **Input variables** to parameterize instance type, AMI, and region instead of hardcoding values
- **Output values** to surface useful information (e.g. public IP) after `apply`

## 🧠 Concepts Covered

- Terraform providers and the AWS provider block
- Resource blocks and resource addressing
- Variables (`variable` blocks) and `.tfvars` usage
- Outputs (`output` blocks)
- The core Terraform lifecycle

## 🔧 Commands Used

```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform output
terraform destroy
```

## 📂 Structure

```text
phase-1-basic-ec2/
├── main.tf          # Provider + EC2 + Security Group resources
├── variables.tf      # Input variable definitions
├── outputs.tf         # Output values (e.g. public IP)
└── terraform.tfvars   # Variable values for this environment
```

## 📌 Key Learnings

- Infrastructure can be fully defined using code instead of manual console clicks.
- Terraform's plan/apply workflow gives a predictable, reviewable path to changes.
- Variables and outputs make configurations reusable instead of hardcoded.
- Local state was used here — its limitations become the motivation for **Phase 3: Remote State Management**.

## ➡️ Next

Continue to [Phase 2 — VPC and Networking](../phase-2-vpc-networking/README.md), where the EC2 instance moves out of the default VPC and into a custom-built network.

---

⬅ [Back to main Terraform Learning Journey README](../README.md)
