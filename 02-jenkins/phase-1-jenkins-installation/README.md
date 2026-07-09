# ☕ Phase 1 – Jenkins Installation & Initial Setup

## 📌 Project Overview

This phase marks the beginning of my Jenkins learning journey as part of the **Key Learning of Cloud and DevOps** repository.

The objective of this project was to install and configure **Jenkins** on an **AWS EC2 Ubuntu Server** that was provisioned during my Terraform learning journey. Instead of manually creating cloud infrastructure, I reused my existing Terraform-created environment to focus entirely on Jenkins installation, configuration, and understanding its architecture.

By the end of this phase, I successfully deployed Jenkins, configured the initial setup, created an administrator account, and prepared the server for upcoming CI/CD pipeline projects.

---

# 🎯 Objectives

- Install Java (OpenJDK)
- Install Git
- Install Jenkins on Ubuntu
- Configure the Jenkins repository
- Enable and start the Jenkins service
- Unlock Jenkins
- Install recommended plugins
- Create an administrator account
- Verify the Jenkins installation
- Prepare the environment for future CI/CD projects

---

# 🏗️ Project Architecture

```text
                     Internet
                         │
                         │
                Public IP :8080
                         │
                ┌─────────────────┐
                │ Security Group  │
                │                 │
                │ SSH → 22        │
                │ Jenkins → 8080  │
                └─────────────────┘
                         │
                  Ubuntu EC2 Instance
                         │
          ┌────────────────────────────┐
          │                            │
          │ OpenJDK                    │
          │ Git                        │
          │ Jenkins                    │
          │ Systemd Service            │
          └────────────────────────────┘
                         │
                   Jenkins Dashboard
```

---

# 🏛 Jenkins Architecture

Jenkins follows a Controller-Agent architecture.

### Jenkins Controller

The Controller is responsible for:

- Managing Jenkins configuration
- Scheduling build jobs
- Managing plugins
- Assigning work to agents
- Displaying build history
- Managing credentials

---

### Jenkins Agents

Agents execute build jobs assigned by the Controller.

In this phase, only the Controller was installed.

Agent configuration will be covered in a future phase.

---

# 🛠 Infrastructure Used

| Resource | Details |
|----------|---------|
| Cloud Provider | AWS |
| Operating System | Ubuntu 24.04 LTS |
| Instance Type | t3.micro |
| Infrastructure | Terraform |
| Java | OpenJDK 21 |
| Git | Latest Stable Version |
| Jenkins | Latest LTS |

---

# 📋 Prerequisites

Before starting this phase:

- AWS Account
- Existing EC2 Instance
- SSH Access
- Internet Connection
- Port 8080 Open
- Java Installed
- Git Installed

---

# 🚀 Installation Process

## Step 1

Connected to the EC2 instance using SSH.

---

## Step 2

Updated the Ubuntu packages.

---

## Step 3

Installed Java (OpenJDK 21).

---

## Step 4

Installed Git.

---

## Step 5

Added the official Jenkins repository.

---

## Step 6

Installed Jenkins.

---

## Step 7

Started and enabled the Jenkins service.

---

## Step 8

Verified the Jenkins service was running successfully.

---

## Step 9

Retrieved the Initial Administrator Password.

---

## Step 10

Opened the Jenkins Dashboard in a web browser.

```
http://<EC2-Public-IP>:8080
```

---

## Step 11

Installed the Suggested Plugins.

---

## Step 12

Created the Administrator User.

---

## Step 13

Successfully logged into the Jenkins Dashboard.

---

# ✅ Verification

The following verifications were completed successfully.

### Java Version

```bash
java --version
```

Verified Java installation.

---

### Git Version

```bash
git --version
```

Verified Git installation.

---

### Jenkins Service

```bash
sudo systemctl status jenkins
```

Confirmed Jenkins was running.

---

### Jenkins Port

```bash
sudo ss -tlnp | grep 8080
```

Verified Jenkins was listening on Port 8080.

---

# 📸 Screenshots

The following screenshots have been included.

- EC2 Instance Running
- Security Group Configuration
- SSH Connection
- Java Version
- Jenkins Service Running
- Jenkins Unlock Page
- Jenkins Dashboard
- Manage Jenkins Page

---

# 📚 Key Concepts Learned

During this phase I learned:

- What Jenkins is
- Why Jenkins is used
- Continuous Integration basics
- Jenkins Controller
- Jenkins Agents
- Jenkins Dashboard
- Plugin Management
- Jenkins Service Management
- Jenkins Initial Configuration
- Administrator Setup

---

# 💡 Why Jenkins?

Jenkins automates software delivery by continuously building, testing, and deploying applications.

Benefits include:

- Automation
- Continuous Integration
- Continuous Delivery
- Faster Feedback
- Build History
- Plugin Ecosystem
- Easy Integration with GitHub, Docker, Kubernetes, Terraform, and AWS

---

# 📈 Skills Gained

After completing this phase, I can:

- Deploy Jenkins on AWS
- Configure Jenkins
- Manage Jenkins Services
- Install Plugins
- Create Administrator Accounts
- Access Jenkins Dashboard
- Verify Jenkins Installation
- Prepare Jenkins for CI/CD Pipelines

---

# 🚀 Next Phase

In the next phase, I will:

- Create my first Freestyle Job
- Execute Shell Commands
- Understand Jenkins Build Process
- Explore Console Output
- Learn Build History
- Build my first automation task

---

# 🧹 Cleanup

No cleanup was performed in this phase because the Jenkins server will be reused throughout the remaining Jenkins learning journey.

---

# 📝 Conclusion

Successfully installed and configured Jenkins on an AWS EC2 Ubuntu server using infrastructure previously created with Terraform.

This phase established a fully functional Jenkins environment that will serve as the foundation for upcoming CI/CD projects involving GitHub integration, Jenkins Pipelines, Docker, Kubernetes, and complete DevOps automation workflows.