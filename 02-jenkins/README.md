<div align="center">

# ☕ Jenkins Learning Journey

**Continuous Integration & Continuous Delivery (CI/CD) on AWS — from Jenkins installation to production-ready automation**

Part of the **Key Learning of Cloud and DevOps** repository.

[![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?logo=jenkins&logoColor=white)](https://www.jenkins.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-E95420?logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![Git](https://img.shields.io/badge/Git-Version_Control-F05032?logo=git&logoColor=white)](https://git-scm.com/)
[![Status](https://img.shields.io/badge/Status-In_Progress-success)]()

</div>

---

# 📖 About This Journey

This section documents my complete **Jenkins learning journey** as part of my Cloud & DevOps roadmap.

Rather than simply installing Jenkins, this journey focuses on understanding how Jenkins is used in real-world DevOps environments to automate software delivery through **Continuous Integration (CI)** and **Continuous Delivery (CD)**.

Throughout these phases, I will build practical projects by integrating Jenkins with technologies such as:

- AWS
- Terraform
- Git & GitHub
- Docker
- Ansible
- Kubernetes

The goal is to progress from basic Jenkins installation to building complete production-style CI/CD pipelines.

---

# 🎯 Learning Objectives

Throughout this journey, I aim to:

- Understand Jenkins architecture
- Install and configure Jenkins on AWS
- Create Freestyle Jobs
- Build Declarative Pipelines
- Write Jenkinsfiles
- Configure Jenkins Agents
- Integrate GitHub repositories
- Automate Docker image builds
- Deploy applications automatically
- Integrate Jenkins with Kubernetes
- Build complete CI/CD workflows

---

# 🏗 Jenkins Learning Roadmap

| Phase | Project | Status |
|--------|---------|--------|
| Phase 1 | Jenkins Installation & Initial Setup | ✅ Completed |
| Phase 2 | Freestyle Jobs | ⏳ Coming Soon |
| Phase 3 | GitHub Integration | ⏳ Coming Soon |
| Phase 4 | Jenkins Pipeline | ⏳ Coming Soon |
| Phase 5 | Jenkinsfile | ⏳ Coming Soon |
| Phase 6 | Jenkins Agents | ⏳ Coming Soon |
| Phase 7 | Docker Integration | ⏳ Coming Soon |
| Phase 8 | Complete CI/CD Project | ⏳ Coming Soon |

---

# 🏛 Jenkins Architecture

```text
                    Developer
                        │
                        │ Git Push
                        ▼
                  GitHub Repository
                        │
                        ▼
                 Jenkins Controller
                        │
          ┌─────────────┴─────────────┐
          │                           │
     Build Jobs                 Jenkins Agents
          │                           │
          └─────────────┬─────────────┘
                        ▼
                 Build / Test / Deploy
                        │
                        ▼
               Production Environment
```

---

# 📂 Repository Structure

```text
02-jenkins/
│
├── README.md
│
├── phase-1-jenkins-installation/
│   ├── README.md
│   ├── commands.md
│   ├── TROUBLESHOOTING.md
│   └── screenshots/
│
├── phase-2-freestyle-job/
│
├── phase-3-github-integration/
│
├── phase-4-jenkins-pipeline/
│
├── phase-5-jenkinsfile/
│
├── phase-6-jenkins-agents/
│
├── phase-7-docker-integration/
│
└── phase-8-complete-cicd-project/
```

---

# 🧰 Technologies Used

- Jenkins
- AWS EC2
- Ubuntu Linux
- Git
- GitHub
- Java (OpenJDK)
- Terraform
- Docker
- Kubernetes
- Ansible

---

# 📚 Skills Covered

During this learning journey I will gain hands-on experience with:

- Continuous Integration (CI)
- Continuous Delivery (CD)
- Jenkins Dashboard
- Plugin Management
- Jenkins Security
- Freestyle Jobs
- Declarative Pipelines
- Jenkinsfile
- Build Automation
- Pipeline Stages
- Docker Builds
- Automated Deployments
- GitHub Webhooks
- Distributed Builds using Agents
- Infrastructure Automation

---

# 📁 Phase Documentation

Each phase contains:

- 📖 README.md
- 💻 commands.md
- 🛠 TROUBLESHOOTING.md
- 📸 Screenshots

This documentation records not only the successful implementation but also the troubleshooting process, making the repository useful as both a portfolio and a learning reference.

---

# 🚀 Project Goal

The ultimate objective of this Jenkins journey is to build a complete production-style CI/CD pipeline capable of:

- Pulling source code from GitHub
- Building applications automatically
- Running automated tests
- Building Docker images
- Pushing images to a container registry
- Deploying applications to Kubernetes
- Automating software delivery with minimal manual intervention

---

# 🔗 Related Learning Journeys

- ☁️ Terraform Learning Journey
- 🐳 Docker Learning Journey
- ⚙️ Ansible Learning Journey
- ☸️ Kubernetes Learning Journey
- 🚀 Final DevOps Capstone Projects

---

# 📝 Progress

Current Progress:

```text
█████░░░░░░░░░░░░░░░░░░░ 12%
```

✅ Current Phase:

**Phase 1 – Jenkins Installation & Initial Setup**

---

# 🎯 Next Step

➡️ **Phase 2 – Creating Freestyle Jobs**

In the next phase, I will create my first Jenkins Freestyle Job, execute shell commands, understand the build lifecycle, and explore Jenkins console output.

---

<div align="center">

### ⭐ Thank you for visiting my Jenkins Learning Journey!

This repository will continue to grow as I progress through real-world CI/CD and DevOps projects.

</div>