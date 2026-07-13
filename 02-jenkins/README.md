<div align="center">

# ⚙️ Jenkins Learning Journey

**From Jenkins installation to complete automated CI/CD pipelines**

Part of the **Key Learning of Cloud and DevOps** repository

![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?logo=jenkins&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazonaws&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Source%20Control-181717?logo=github&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker&logoColor=white)
![Groovy](https://img.shields.io/badge/Groovy-Jenkinsfile-4298B8?logo=apachegroovy&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?logo=ubuntu&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Progress-F59E0B)

</div>

---

## 📌 Overview

This directory documents my practical Jenkins learning journey.

The journey begins with installing Jenkins on an AWS EC2 instance and gradually progresses through Freestyle jobs, Declarative Pipelines, GitHub webhook automation, Docker image builds, container testing and registry publishing.

Each phase introduces a new Jenkins concept through a practical project.

Every phase includes:

- Source code
- Jenkins job or Pipeline configuration
- A version-controlled `Jenkinsfile` when applicable
- Screenshots
- A detailed `README.md`
- A separate `TROUBLESHOOTING.md`
- Errors, root causes and fixes
- Cleanup and cost-management steps

---

## 🎯 Learning Objectives

The objectives of this Jenkins journey are to:

- Understand Jenkins architecture.
- Install and configure Jenkins.
- Create Freestyle and Pipeline jobs.
- Connect Jenkins with GitHub.
- Implement Pipeline as Code.
- Automate builds with GitHub webhooks.
- Integrate Docker with Jenkins.
- Build and test Docker containers.
- Publish images to a container registry.
- Store credentials securely.
- Understand Jenkins controller and agent architecture.
- Create Multibranch Pipelines.
- Integrate Jenkins with Ansible.
- Build a complete CI/CD workflow.
- Learn Jenkins backup and security practices.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Jenkins | Continuous Integration and Continuous Delivery |
| AWS EC2 | Jenkins controller infrastructure |
| Terraform | Provisioning the Jenkins server |
| Ubuntu Linux | Jenkins server operating system |
| GitHub | Source-code repository |
| Git | Version control and source checkout |
| Jenkinsfile | Pipeline as Code |
| Groovy | Declarative Pipeline syntax |
| Shell | Validation and automation commands |
| Docker | Image building and container execution |
| Nginx | Lightweight web application server |
| HTML5 | Static applications for Pipeline testing |
| curl | HTTP and container validation |

---

## 🏗️ Learning Architecture

```text
Developer
    ↓
Git and GitHub
    ↓
GitHub Push or Manual Build
    ↓
Jenkins Controller on AWS EC2
    ↓
Jenkinsfile
    ↓
Pipeline Stages
    ↓
Build, Test and Validation
    ↓
Docker Image and Container
    ↓
Container Registry
    ↓
Future Deployment Environment
```

---

## 📁 Directory Structure

```text
02-jenkins/
├── phase-1-jenkins-installation/
├── phase-2-freestyle-ci-job/
├── phase-3-declarative-pipeline/
├── phase-4-github-webhook/
├── phase-5-docker-build-pipeline/
├── phase-6-dockerhub-registry-pipeline/
└── README.md
```

---

# 🗺️ Jenkins Phase Roadmap

| Phase | Project | Main Learning | Status |
|---:|---|---|---|
| 1 | Jenkins Installation | Install and configure Jenkins on AWS EC2 | ✅ Completed |
| 2 | Freestyle CI Job | Connect GitHub and execute shell validation | ✅ Completed |
| 3 | Declarative Pipeline | Store the CI workflow in a `Jenkinsfile` | ✅ Completed |
| 4 | GitHub Webhook Automation | Trigger Jenkins automatically after Git push | ✅ Completed |
| 5 | Docker Build Pipeline | Build, run and test a Docker container | ✅ Completed |
| 6 | Docker Hub Registry Pipeline | Publish versioned images to Docker Hub | 🚧 In Progress |
| 7 | Credentials and Deployment | Manage credentials and deployment environments | ⏳ Planned |
| 8 | Controller–Agent Architecture | Run builds on a separate Jenkins agent | ⏳ Planned |
| 9 | Multibranch Pipeline | Automatically build multiple Git branches | ⏳ Planned |
| 10 | Jenkins with Ansible | Deploy applications through Ansible | ⏳ Planned |
| 11 | Complete CI/CD Pipeline | Combine GitHub, Jenkins, Docker and deployment | ⏳ Planned |
| 12 | Backup and Security | Protect, back up and finalize Jenkins | ⏳ Planned |

---

# ✅ Completed Phases

## Phase 1 — Jenkins Installation on AWS EC2

📁 [View Phase 1](phase-1-jenkins-installation/)

### Overview

The first phase established the Jenkins learning environment on AWS.

A reusable Jenkins controller was configured on an Ubuntu EC2 instance.

### Key Work

- Provisioned an EC2 instance with Terraform.
- Configured security-group access for SSH and Jenkins.
- Installed Java 21.
- Installed Jenkins.
- Started and enabled the Jenkins service.
- Retrieved the initial administrator password.
- Completed the setup wizard.
- Installed the suggested plugins.
- Created the administrator account.
- Accessed the Jenkins dashboard.

### Main Learning

```text
AWS EC2 → Ubuntu → Java → Jenkins → Dashboard
```

### Status

```text
✅ Completed
```

---

## Phase 2 — Freestyle CI Job with GitHub

📁 [View Phase 2](phase-2-freestyle-ci-job/)

### Overview

This phase introduced Jenkins Freestyle jobs and basic Continuous Integration.

Jenkins cloned the GitHub repository and executed shell commands to validate a static HTML application.

### Validation

The job checked:

```bash
test -d "$APP_DIR"
test -f "$APP_DIR/index.html"
grep -q "Jenkins Phase 2" "$APP_DIR/index.html"
grep -q "Build Successful" "$APP_DIR/index.html"
```

### Failure and Recovery Test

The required HTML content was intentionally changed.

The build failed because Jenkins could not find the expected value:

```text
Build Successful
```

After restoring the required content, the build returned to:

```text
Finished: SUCCESS
```

### Main Learning

```text
GitHub → Jenkins Freestyle Job → Shell Validation
```

### Status

```text
✅ Completed
```

---

## Phase 3 — Declarative Pipeline with Jenkinsfile

📁 [View Phase 3](phase-3-declarative-pipeline/)

### Overview

This phase replaced manual Freestyle build steps with a version-controlled Declarative Pipeline.

The complete CI workflow was stored in:

```text
Jenkinsfile
```

### Pipeline Stages

```text
Declarative: Checkout SCM
Checkout Information
Validate Structure
Test HTML Content
Build Summary
Post Actions
```

### Key Concepts

- Pipeline as Code
- Declarative Pipeline syntax
- `agent any`
- Environment variables
- Pipeline stages
- Shell steps
- Success and failure post actions
- Automatic SCM checkout

### Main Learning

```text
GitHub → Jenkinsfile → Declarative Pipeline → Validation
```

### Status

```text
✅ Completed
```

---

## Phase 4 — GitHub Webhook Automation

📁 [View Phase 4](phase-4-github-webhook/)

### Overview

This phase automated the Declarative Pipeline using a GitHub webhook.

A push to the `main` branch automatically notified Jenkins and started the Pipeline.

### Webhook Endpoint

```text
http://JENKINS_PUBLIC_IP:8080/github-webhook/
```

### Automation Proof

The Jenkins build displayed:

```text
Started by GitHub push by anshu-sharma-devops
```

### Pipeline Workflow

```text
Git Push
    ↓
GitHub Webhook
    ↓
Jenkins Pipeline
    ↓
Application Validation
    ↓
Finished: SUCCESS
```

### Security Practice

Port `8080` was made publicly reachable only for the temporary webhook test.

After testing:

- Public access was removed.
- Port `8080` was restricted back to **My IP**.
- The Jenkins interface was not left publicly exposed.

### Main Learning

```text
GitHub Push → Webhook → Automatic Jenkins Pipeline
```

### Status

```text
✅ Completed
```

---

## Phase 5 — Docker Build and Container Test Pipeline

📁 [View Phase 5](phase-5-docker-build-pipeline/)

### Overview

This phase integrated Docker with Jenkins.

Jenkins built an Nginx Docker image, started a temporary container, tested the running application and removed the container automatically.

### Pipeline Stages

```text
Checkout SCM
Checkout Information
Validate Project Files
Docker Environment
Build Docker Image
Run Test Container
Test Container Application
Image Information
Post Actions
```

### Docker Image

```text
jenkins-phase-5:1
```

### Pipeline Workflow

```text
GitHub
    ↓
Jenkins
    ↓
Docker Build
    ↓
Container
    ↓
HTTP Test
    ↓
Container Cleanup
```

### Key Work

- Verified Docker Engine.
- Added the Jenkins user to the Docker group.
- Created an Nginx Alpine Dockerfile.
- Built a versioned Docker image.
- Started a temporary test container.
- Tested the application with `curl`.
- Validated required HTML content.
- Displayed the Docker image ID.
- Removed the temporary container.
- Verified the application in a browser.

### Errors Resolved

- Docker socket permission denied.
- Group membership not applying in the current session.
- Incorrect `curl config` command.
- Container port unavailable in the browser.
- Missing AWS security-group rule for port `8081`.

### Main Learning

```text
Jenkins → Docker Image → Container → Automated Test → Cleanup
```

### Status

```text
✅ Completed
```

---

# 🚧 Current Phase

## Phase 6 — Docker Hub Registry Pipeline

📁 [View Phase 6](phase-6-dockerhub-registry-pipeline/)

### Overview

This phase extends the Docker Pipeline by publishing the Jenkins-built image to Docker Hub.

### Planned Workflow

```text
GitHub
    ↓
Jenkins Checkout
    ↓
Docker Image Build
    ↓
Container Test
    ↓
Secure Docker Hub Login
    ↓
Versioned Image Tag
    ↓
Push to Docker Hub
    ↓
Published Image Verification
```

### Planned Image

```text
anshu9103/jenkins-phase-6
```

### Planned Topics

- Creating a Docker Hub repository.
- Creating a Docker Hub access token.
- Storing credentials securely in Jenkins.
- Using `withCredentials`.
- Logging in with `docker login --password-stdin`.
- Tagging images with the Jenkins build number.
- Publishing `BUILD_NUMBER` and `latest` tags.
- Verifying the public image.
- Preventing credentials from appearing in Console Output.

### Status

```text
🚧 In Progress
```

---

# ⏳ Future Phases

## Phase 7 — Credentials and Environment Deployment

Planned topics:

- Jenkins credential types
- Secret text and username/password credentials
- Environment variables
- Development and production environments
- Parameterized builds
- Deployment approval concepts

---

## Phase 8 — Jenkins Controller–Agent Architecture

Planned topics:

- Jenkins controller responsibilities
- Dedicated build agent
- SSH agent connection
- Agent labels
- Running Docker builds on an agent
- Separating orchestration from workloads

---

## Phase 9 — Multibranch Pipeline

Planned topics:

- Branch discovery
- `develop`, feature and `main` branches
- Automatic Pipeline creation
- Branch-specific stages
- Pull request concepts
- GitHub branch workflow

---

## Phase 10 — Jenkins with Ansible

Planned topics:

- Jenkins-to-Ansible integration
- Ansible inventory
- SSH credentials
- Application-server configuration
- Automated deployment
- Deployment verification

---

## Phase 11 — Complete CI/CD Pipeline

Planned workflow:

```text
Developer
    ↓
GitHub
    ↓
Webhook
    ↓
Jenkins
    ↓
Validation and Tests
    ↓
Docker Image Build
    ↓
Container Registry
    ↓
Ansible Deployment
    ↓
Running Application
```

---

## Phase 12 — Backup, Security and Final Documentation

Planned topics:

- Jenkins home directory
- Job and plugin backup
- Credentials protection
- User and permission management
- Build retention
- Workspace cleanup
- Plugin updates
- Final architecture documentation

---

## ☁️ Reusable Jenkins Server Strategy

The same Jenkins EC2 instance is reused across the entire journey.

This preserves:

- Jenkins jobs
- Plugins
- Build history
- Pipeline configuration
- Credentials
- Docker images
- Future agent settings

The instance is stopped after practice instead of being destroyed.

### Starting the Instance

```bash
aws ec2 start-instances \
  --instance-ids YOUR_INSTANCE_ID
```

### Stopping the Instance

```bash
aws ec2 stop-instances \
  --instance-ids YOUR_INSTANCE_ID
```

### Retrieve the Current Public IP

```bash
aws ec2 describe-instances \
  --instance-ids YOUR_INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```

> The public IP can change after restarting the instance.

---

## 🔐 Security Practices

The following security practices are followed:

- Jenkins access is restricted to trusted IP addresses.
- Temporary application ports are removed after testing.
- Docker Hub tokens are stored in Jenkins Credentials.
- Passwords and tokens are never committed to GitHub.
- Secrets are not written directly inside the `Jenkinsfile`.
- Temporary containers are removed after builds.
- The EC2 instance is stopped when not in use.

For a production environment, additional improvements would include:

- HTTPS
- Domain name
- Reverse proxy
- GitHub webhook secret
- Dedicated Jenkins agents
- Role-based access control
- Automated backups
- Private networking

---

## 💰 Cost Management

This learning journey reuses a single EC2 instance to reduce unnecessary infrastructure costs.

After each session:

- Temporary containers are removed.
- Temporary security-group rules are removed.
- The Jenkins EC2 instance is stopped.
- The instance is not destroyed.
- Unused Docker images can be cleaned when storage becomes limited.

Check Docker disk usage:

```bash
docker system df
```

Remove unused images carefully:

```bash
docker image prune
```

> Attached EBS storage may still generate a small charge depending on AWS Free Tier eligibility and account usage.

---

## 🧠 Skills Developed

Through the completed phases, I have practised:

- Jenkins installation and administration
- AWS EC2 server management
- Freestyle CI jobs
- Declarative Pipelines
- Pipeline as Code
- GitHub integration
- Webhook automation
- Shell validation
- Git commit tracking
- Docker image creation
- Container execution
- HTTP application testing
- Pipeline cleanup
- Linux user and group permissions
- CI/CD troubleshooting
- Technical documentation

---

## 📈 Journey Progress

```text
Phase 1  Jenkins Installation           ✅
Phase 2  Freestyle CI Job               ✅
Phase 3  Declarative Pipeline           ✅
Phase 4  GitHub Webhook                 ✅
Phase 5  Docker Build Pipeline          ✅
Phase 6  Docker Hub Registry            🚧
Phase 7  Credentials and Deployment     ⏳
Phase 8  Controller and Agent           ⏳
Phase 9  Multibranch Pipeline           ⏳
Phase 10 Jenkins with Ansible           ⏳
Phase 11 Complete CI/CD                 ⏳
Phase 12 Backup and Security            ⏳
```

---

## ✅ Current Achievement

The Jenkins learning environment can currently:

- Retrieve code from GitHub.
- Execute Freestyle jobs.
- Load Pipelines from a `Jenkinsfile`.
- Trigger builds through GitHub webhooks.
- Validate application files and content.
- Build Docker images.
- Run Docker containers.
- Test applications automatically.
- Clean temporary build resources.

The next milestone is publishing Jenkins-built images securely to Docker Hub.

---

<div align="center">

**Created by Anshu Sharma**

*Cloud and DevOps Learning Journey*

**Completed Phases: 5 / 12**

</div>