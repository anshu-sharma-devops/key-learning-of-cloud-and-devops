<div align="center">

# 🛠️ Jenkins Phase 7 — Troubleshooting Guide

**Diagnosing parameter, Docker deployment, approval and environment-access issues**

Part of the [Jenkins Phase 7 Project](README.md)

![Jenkins](https://img.shields.io/badge/Jenkins-Troubleshooting-D24939?logo=jenkins&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Diagnostics-2496ED?logo=docker&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazonaws&logoColor=white)
![Status](https://img.shields.io/badge/Issues-Resolved-22C55E)

</div>

---

## 📌 Overview

This document records the problems encountered during Jenkins Phase 7 and explains how they were diagnosed and resolved.

Phase 7 introduced:

- Jenkins build parameters
- Development and production environments
- Docker image tag selection
- Conditional stages
- Manual production approval
- Environment-specific containers
- Application validation
- Container restart policies

The most important issue occurred during the first parameterized build because Jenkins had not yet initialized the build parameters.

---

## 📋 Troubleshooting Summary

| Issue | Cause | Resolution |
|---|---|---|
| First build failed | Parameters were not initialized | Run again using **Build with Parameters** |
| Production Approval skipped | Development was selected | Expected conditional behavior |
| Production Pipeline paused | Manual approval was required | Select **Deploy to Production** |
| Container name conflict | Old container still existed | Remove or replace the old container |
| Port already allocated | Another process used the port | Identify and remove the conflicting resource |
| Browser could not connect | Security group or public IP issue | Update the rule and use the current IP |
| EC2 instance would not start | Instance was not fully stopped | Check its current EC2 state |
| Public IP changed | EC2 was stopped and started | Use the new public IPv4 address |
| Image pull failed | Incorrect repository or tag | Verify the Docker Hub image |
| Jenkins Docker permission denied | Jenkins lacked Docker access | Add Jenkins to the Docker group |
| Deployment validation failed | Container or content problem | Inspect the container and response |
| Build was aborted | Approval rejected or timed out | Run and approve the build again |

---

## 1️⃣ First Build Failed During Parameter Validation

### Error

The first Pipeline execution reached the **Validate Parameters** stage and failed:

```text
+ set -e
+ test -n
```

Jenkins then reported:

```text
ERROR: script returned exit code 1
Finished: FAILURE
```

The remaining stages were skipped:

```text
Stage "Pull Docker Image" skipped due to earlier failure(s)
Stage "Production Approval" skipped due to earlier failure(s)
Stage "Deploy Container" skipped due to earlier failure(s)
Stage "Validate Deployment" skipped due to earlier failure(s)
Stage "Deployment Summary" skipped due to earlier failure(s)
```

### Cause

The Pipeline job was being executed for the first time after the parameters were declared in the Jenkinsfile.

Jenkins used the first execution to register:

```text
DEPLOY_ENV
IMAGE_TAG
KEEP_CONTAINER
```

During that execution, the raw `IMAGE_TAG` parameter was empty.

The validation command therefore behaved like:

```bash
test -n ""
```

This command returns exit code `1`, causing the Pipeline to stop.

### Resolution

After the first build, Jenkins displayed:

```text
Build with Parameters
```

The next build was started with:

```text
DEPLOY_ENV: development
IMAGE_TAG: latest
KEEP_CONTAINER: enabled
```

The validation stage passed and the Pipeline continued.

### Verification

The successful build displayed:

```text
Deployment environment: development
Docker image: anshu9103/jenkins-phase-6:latest
Container name: jenkins-phase-7-dev
Deployment port: 8083
Keep container: true
```

### Lesson Learned

A newly created parameterized Pipeline may require an initial execution before Jenkins displays and initializes its parameter form.

---

## 2️⃣ Production Approval Was Skipped

### Observation

The development Stage View displayed **Production Approval** as skipped.

### Cause

This was expected behavior.

The stage runs only when the selected parameter is:

```text
DEPLOY_ENV = production
```

The development build used:

```text
DEPLOY_ENV = development
```

Therefore, Jenkins correctly skipped the production approval gate.

### Resolution

No correction was required.

The correct development flow is:

```text
Pull Docker Image
        ↓
Production Approval — skipped
        ↓
Deploy Container
```

### Lesson Learned

A skipped stage is not always an error. Jenkins Declarative Pipeline conditions intentionally control when a stage should execute.

---

## 3️⃣ Production Pipeline Paused

### Observation

The production Pipeline stopped at:

```text
Production Approval
```

The deployment stages did not start immediately.

### Cause

The pause was intentional.

Production deployments use a Jenkins `input` step that requires explicit user authorization.

### Resolution

The running build was opened in Jenkins, and the following button was selected:

```text
Deploy to Production
```

The Pipeline then continued with:

```text
Deploy Container
Validate Deployment
Deployment Summary
Post Actions
```

### Successful Result

```text
Phase 7 production deployment completed successfully.
Deployment container will remain running.
Finished: SUCCESS
```

### Lesson Learned

Manual approval gates prevent an automated Pipeline from changing production without human authorization.

---

## 4️⃣ Docker Container Name Already Exists

### Possible Error

```text
docker: Error response from daemon:
Conflict. The container name is already in use.
```

### Cause

A previous deployment container may still use one of these names:

```text
jenkins-phase-7-dev
jenkins-phase-7-prod
```

Docker does not allow two containers to use the same name.

### Diagnosis

Check both running and stopped Phase 7 containers:

```bash
docker ps -a --filter "name=jenkins-phase-7"
```

### Resolution

Remove the existing development container:

```bash
docker rm -f jenkins-phase-7-dev
```

Remove the existing production container:

```bash
docker rm -f jenkins-phase-7-prod
```

Then run the Pipeline again.

### Pipeline Protection

The Jenkinsfile normally removes an older environment container before creating its replacement:

```bash
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
```

---

## 5️⃣ Deployment Port Already Allocated

### Possible Error

Development:

```text
Bind for 0.0.0.0:8083 failed: port is already allocated
```

Production:

```text
Bind for 0.0.0.0:8084 failed: port is already allocated
```

### Cause

Another container or process was already listening on the required host port.

### Diagnosis

Check Docker port mappings:

```bash
docker ps
```

Check port `8083`:

```bash
sudo ss -lntp | grep ':8083'
```

Check port `8084`:

```bash
sudo ss -lntp | grep ':8084'
```

### Resolution

Identify the container using the port:

```bash
docker ps --format "table {{.Names}}\t{{.Ports}}"
```

Remove the conflicting container if it is no longer required:

```bash
docker rm -f CONTAINER_NAME
```

Then rerun the deployment.

### Lesson Learned

Every container exposed on the same host requires a unique host port.

---

## 6️⃣ Application Could Not Be Opened in the Browser

### Symptom

The application did not open using:

```text
http://JENKINS_PUBLIC_IP:8083
```

or:

```text
http://JENKINS_PUBLIC_IP:8084
```

### Possible Causes

- The deployment container was not running.
- The EC2 security group did not allow the port.
- The browser used an old EC2 public IP.
- The local public IP changed.
- The security-group rule did not use the current client IP.
- HTTPS was used instead of HTTP.
- The wrong environment port was entered.

### Diagnosis

Check the containers:

```bash
docker ps --filter "name=jenkins-phase-7"
```

Test development from the EC2 server:

```bash
curl -I http://127.0.0.1:8083
```

Test production:

```bash
curl -I http://127.0.0.1:8084
```

Expected result:

```text
HTTP/1.1 200 OK
```

### Resolution

Temporarily add these EC2 security-group rules:

| Type | Port | Source |
|---|---:|---|
| Custom TCP | `8083` | My IP |
| Custom TCP | `8084` | My IP |

Open the application using the current EC2 public IPv4 address:

```text
http://CURRENT_PUBLIC_IP:8083
http://CURRENT_PUBLIC_IP:8084
```

Use HTTP rather than HTTPS.

### Security Cleanup

Remove both temporary inbound rules after capturing the application screenshots.

---

## 7️⃣ EC2 Public IP Changed

### Symptom

A previously working Jenkins or application URL stopped responding after the EC2 instance was restarted.

### Cause

A standard EC2 public IPv4 address can change after the instance is stopped and started.

This occurs when an Elastic IP is not assigned.

### Resolution

Open:

```text
AWS Console
→ EC2
→ Instances
→ Select the Jenkins instance
→ Public IPv4 address
```

Copy the current address and use it for:

```text
http://CURRENT_PUBLIC_IP:8080
http://CURRENT_PUBLIC_IP:8083
http://CURRENT_PUBLIC_IP:8084
```

### Additional Check

If a security-group rule uses **My IP**, confirm that the local public IP has not also changed.

### Lesson Learned

The EC2 private IP can remain the same while the public IPv4 address changes after a stop/start cycle.

---

## 8️⃣ EC2 Instance Could Not Be Started

### Error

```text
Failed to start the instance
The instance is not in a state from which it can be started.
```

### Cause

The EC2 instance was not in a valid `stopped` state.

It may have been:

```text
running
pending
stopping
shutting-down
terminated
```

### Diagnosis

Check the state in:

```text
AWS Console
→ EC2
→ Instances
→ Instance state
```

The state can also be checked with AWS CLI:

```bash
aws ec2 describe-instances \
  --instance-ids INSTANCE_ID \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text
```

### Resolution

| Instance state | Action |
|---|---|
| Running | The instance is already started |
| Pending | Wait until it becomes running |
| Stopping | Wait until it becomes stopped |
| Stopped | Start the instance |
| Shutting down | Wait and verify its final state |
| Terminated | The instance cannot be started again |

### Lesson Learned

An EC2 start operation is only valid when the instance has completely entered the `stopped` state.

---

## 9️⃣ Containers Restarted After EC2 Restart

### Observation

The Phase 7 containers appeared again after the EC2 instance was started.

### Cause

The containers were created with:

```text
--restart unless-stopped
```

This Docker restart policy automatically starts the containers when Docker starts again.

### Verification

Check Docker:

```bash
sudo systemctl is-active docker
```

Check Jenkins:

```bash
sudo systemctl is-active jenkins
```

Expected output:

```text
active
active
```

Check the containers:

```bash
docker ps --filter "name=jenkins-phase-7"
```

### Resolution

No action is required when the containers should remain deployed.

If they are no longer required, remove them:

```bash
docker rm -f jenkins-phase-7-dev jenkins-phase-7-prod
```

### Lesson Learned

`--restart unless-stopped` preserves a deployment across Docker service and EC2 restarts.

---

## 🔟 Docker Image Could Not Be Pulled

### Possible Errors

```text
pull access denied
```

```text
manifest unknown
```

```text
repository does not exist
```

### Possible Causes

- The repository name was incorrect.
- The selected tag did not exist.
- The Docker Hub repository was private.
- Docker Hub authentication was required.
- Network access to Docker Hub failed.

### Diagnosis

Test the latest tag manually:

```bash
docker pull anshu9103/jenkins-phase-6:latest
```

Test the versioned tag:

```bash
docker pull anshu9103/jenkins-phase-6:1
```

Review available images:

```bash
docker image ls anshu9103/jenkins-phase-6
```

### Resolution

Confirm that the selected repository is:

```text
anshu9103/jenkins-phase-6
```

Confirm that the selected tag exists on Docker Hub.

If the repository becomes private, authenticate using the Jenkins Docker Hub credential created during Phase 6.

---

## 1️⃣1️⃣ Jenkins Could Not Access Docker

### Possible Error

```text
permission denied while trying to connect to the Docker daemon socket
```

### Cause

The Jenkins service account did not have permission to communicate with Docker.

### Diagnosis

Run:

```bash
sudo -u jenkins docker version
```

Then:

```bash
sudo -u jenkins docker ps
```

### Resolution

Add Jenkins to the Docker group:

```bash
sudo usermod -aG docker jenkins
```

Restart Jenkins:

```bash
sudo systemctl restart jenkins
```

Verify the services:

```bash
sudo systemctl is-active docker
sudo systemctl is-active jenkins
```

Verify Jenkins Docker access:

```bash
sudo -u jenkins docker ps
```

### Lesson Learned

Restarting Jenkins is required so that the service process receives its updated group membership.

---

## 1️⃣2️⃣ Deployment Validation Failed

### Possible Symptoms

```text
curl: connection refused
```

```text
curl: (7) Failed to connect
```

```text
script returned exit code 1
```

A `grep` validation command may also fail.

### Possible Causes

- The container failed to start.
- The application was not ready.
- The wrong port was used.
- The wrong image tag was deployed.
- The expected HTML content was missing.
- The container exited after starting.

### Diagnosis

Check all Phase 7 containers:

```bash
docker ps -a --filter "name=jenkins-phase-7"
```

Check development logs:

```bash
docker logs jenkins-phase-7-dev
```

Check production logs:

```bash
docker logs jenkins-phase-7-prod
```

Inspect the image used by development:

```bash
docker inspect jenkins-phase-7-dev \
  --format '{{.Config.Image}}'
```

Inspect the production image:

```bash
docker inspect jenkins-phase-7-prod \
  --format '{{.Config.Image}}'
```

Test the complete responses:

```bash
curl http://127.0.0.1:8083
curl http://127.0.0.1:8084
```

### Resolution

Confirm that the expected image tag was selected.

Remove the failed container:

```bash
docker rm -f jenkins-phase-7-dev
```

or:

```bash
docker rm -f jenkins-phase-7-prod
```

Then rerun the Pipeline.

---

## 1️⃣3️⃣ Production Build Was Aborted

### Symptom

The production Pipeline ended with:

```text
ABORTED
```

### Possible Causes

- The approval request was rejected.
- The build was manually stopped.
- The input request reached a configured timeout.
- Jenkins restarted while waiting for approval.

### Resolution

Start another parameterized production build:

```text
DEPLOY_ENV: production
IMAGE_TAG: 1
KEEP_CONTAINER: true
```

Wait for:

```text
Production Approval
```

Then select:

```text
Deploy to Production
```

### Lesson Learned

An aborted approval is safer than allowing a production deployment to continue without authorization.

---

## 1️⃣4️⃣ Container Removed After Successful Build

### Observation

The Pipeline succeeded, but the deployment container was no longer running.

### Cause

The following parameter was disabled:

```text
KEEP_CONTAINER
```

When its value is `false`, Jenkins removes the container after validation.

### Resolution

To keep the deployment running, select:

```text
KEEP_CONTAINER: true
```

To test and automatically remove it, select:

```text
KEEP_CONTAINER: false
```

### Lesson Learned

Boolean parameters can control resource lifecycle behavior in Pipeline post actions.

---

## 1️⃣5️⃣ Jenkins Service Did Not Respond After EC2 Start

### Symptom

The EC2 instance was running, but Jenkins did not open on port `8080`.

### Diagnosis

Check Jenkins:

```bash
sudo systemctl status jenkins --no-pager
```

Check its active state:

```bash
sudo systemctl is-active jenkins
```

Check port `8080`:

```bash
sudo ss -lntp | grep ':8080'
```

### Resolution

Start Jenkins if necessary:

```bash
sudo systemctl start jenkins
```

Enable it during system startup:

```bash
sudo systemctl enable jenkins
```

Review recent logs:

```bash
sudo journalctl -u jenkins -n 100 --no-pager
```

Also verify that the EC2 security group allows Jenkins port `8080` only from the required source IP.

---

## 1️⃣6️⃣ Safe Phase 7 Cleanup

After taking all screenshots, remove both deployment containers:

```bash
docker rm -f jenkins-phase-7-dev jenkins-phase-7-prod
```

Verify that no Phase 7 containers remain:

```bash
docker ps --filter "name=jenkins-phase-7"
```

The expected result contains only the Docker headings with no matching containers.

Remove temporary security-group rules for:

```text
8083
8084
```

The Phase 6 Docker images can remain available for future Jenkins phases.

---

## 🔎 Diagnostic Command Reference

### Check services

```bash
sudo systemctl is-active jenkins
sudo systemctl is-active docker
```

### Check Jenkins Docker access

```bash
sudo -u jenkins docker version
sudo -u jenkins docker ps
```

### Check Phase 7 containers

```bash
docker ps -a --filter "name=jenkins-phase-7"
```

### Check development

```bash
docker logs jenkins-phase-7-dev
curl -I http://127.0.0.1:8083
```

### Check production

```bash
docker logs jenkins-phase-7-prod
curl -I http://127.0.0.1:8084
```

### Check listening ports

```bash
sudo ss -lntp | grep ':8083'
sudo ss -lntp | grep ':8084'
```

### Check deployed images

```bash
docker inspect jenkins-phase-7-dev \
  --format '{{.Config.Image}}'

docker inspect jenkins-phase-7-prod \
  --format '{{.Config.Image}}'
```

### Check Docker images

```bash
docker image ls anshu9103/jenkins-phase-6
```

---

## 📊 Resolved Issues

| Issue | Status |
|---|---|
| First-run parameter initialization | ✅ Resolved |
| Development approval-stage confusion | ✅ Explained |
| Production manual approval | ✅ Completed |
| Development container deployment | ✅ Verified |
| Production container deployment | ✅ Verified |
| Browser access on port `8083` | ✅ Verified |
| Browser access on port `8084` | ✅ Verified |
| EC2 instance start-state issue | ✅ Resolved |
| EC2 public IP change | ✅ Resolved |
| Container restart behavior | ✅ Verified |
| Application validation | ✅ Passed |
| Container cleanup | ✅ Completed |
| Security-group cleanup | ✅ Completed |

---

## 🧠 Key Troubleshooting Lessons

This phase demonstrated that:

- Jenkins may require an initial build to register parameters.
- A skipped conditional stage is not necessarily a failure.
- Production approval intentionally pauses a Pipeline.
- Jenkins Console Output identifies the exact failed command.
- Docker container names must be unique.
- Host ports cannot be shared by multiple running containers.
- EC2 public addresses can change after stop and start.
- Security-group rules control external browser access.
- Local `curl` tests separate application problems from network problems.
- Docker restart policies can restore containers automatically.
- `docker logs` and `docker inspect` provide deployment evidence.
- Cleanup should occur only after required screenshots are captured.

---

## ✅ Final Troubleshooting Result

All Phase 7 issues were identified and resolved.

The development and production deployments completed successfully:

```text
Phase 7 development deployment completed successfully.
Phase 7 production deployment completed successfully.
Finished: SUCCESS
```

The final environment cleanup was also completed.

---

<div align="center">

**Created by Anshu Sharma**

*Cloud and DevOps Learning Journey*

**Phase 7 Troubleshooting Status: ✅ Completed**

</div>