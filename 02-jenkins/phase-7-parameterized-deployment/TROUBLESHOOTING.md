# Jenkins Phase 7 — Troubleshooting

This document records the issues encountered while creating the parameterized environment deployment pipeline and explains how they were resolved.

## 1. First build failed during parameter validation

### Error

The initial pipeline stopped in the **Validate Parameters** stage:

```text
+ set -e
+ test -n
ERROR: script returned exit code 1
Finished: FAILURE
```

Later stages were skipped:

```text
Stage "Pull Docker Image" skipped due to earlier failure(s)
Stage "Deploy Container" skipped due to earlier failure(s)
Stage "Validate Deployment" skipped due to earlier failure(s)
```

### Cause

The job was being executed for the first time after the parameter declarations were loaded from the Jenkinsfile.

Jenkins needed the initial build to register the parameters. During that first execution, `IMAGE_TAG` was empty.

### Resolution

After the first build, Jenkins displayed **Build with Parameters**.

The pipeline was started again with:

```text
DEPLOY_ENV: development
IMAGE_TAG: latest
KEEP_CONTAINER: enabled
```

The validation stage then passed successfully.

### Lesson learned

A newly created parameterized Pipeline job may require one initial execution before the parameter form becomes available.

## 2. Production approval was skipped during development

### Observation

The development Stage View showed the **Production Approval** stage as skipped.

### Cause

This is expected behavior.

The production approval stage contains a condition that runs it only when:

```text
DEPLOY_ENV = production
```

### Resolution

No change was necessary.

For development, the pipeline should continue directly from pulling the image to deploying the container.

### Lesson learned

Declarative Pipeline `when` conditions allow stages to run only for selected environments.

## 3. Pipeline paused during production deployment

### Observation

The production build stopped at:

```text
Production Approval
```

The remaining stages did not begin immediately.

### Cause

The pause was intentional. Production deployments require manual approval.

### Resolution

The running Jenkins build was opened and **Deploy to Production** was selected.

After approval, Jenkins continued with:

```text
Deploy Container
Validate Deployment
Deployment Summary
```

### Lesson learned

The Jenkins `input` step provides a manual gate before sensitive operations such as production deployment.

## 4. Docker container name already existed

### Possible error

```text
docker: Error response from daemon:
Conflict. The container name is already in use.
```

### Cause

A container from an earlier deployment was still using the selected environment name.

The expected names are:

```text
jenkins-phase-7-dev
jenkins-phase-7-prod
```

### Resolution

Remove the old environment container:

```bash
docker rm -f jenkins-phase-7-dev
```

or:

```bash
docker rm -f jenkins-phase-7-prod
```

Then run the pipeline again.

The Jenkinsfile normally removes an older container with the same name before starting a replacement.

## 5. Deployment port was already allocated

### Possible error

```text
Bind for 0.0.0.0:8083 failed: port is already allocated
```

or:

```text
Bind for 0.0.0.0:8084 failed: port is already allocated
```

### Cause

Another process or container was already using the deployment port.

### Diagnosis

Check running containers:

```bash
docker ps
```

Check the specific ports:

```bash
sudo ss -lntp | grep ':8083'
sudo ss -lntp | grep ':8084'
```

### Resolution

Stop or remove the old container using the required port:

```bash
docker rm -f CONTAINER_NAME
```

Then rerun the Jenkins deployment.

## 6. Application could not be opened in the browser

### Symptoms

The container was running, but the browser could not open:

```text
http://EC2_PUBLIC_IP:8083
```

or:

```text
http://EC2_PUBLIC_IP:8084
```

### Possible causes

- The EC2 security group did not allow the port.
- The old EC2 public IP was being used.
- The container was not running.
- The source IP in the security-group rule had changed.
- HTTPS was used instead of HTTP.

### Diagnosis

Confirm the container:

```bash
docker ps --filter "name=jenkins-phase-7"
```

Test it from the Jenkins server:

```bash
curl -I http://127.0.0.1:8083
curl -I http://127.0.0.1:8084
```

Check the current public IP in the EC2 console.

### Resolution

Temporarily add these inbound security-group rules:

```text
Custom TCP | 8083 | My IP
Custom TCP | 8084 | My IP
```

Use:

```text
http://CURRENT_PUBLIC_IP:8083
http://CURRENT_PUBLIC_IP:8084
```

Remove the temporary rules after testing.

## 7. EC2 instance public IP changed

### Symptom

A previously working Jenkins or application URL stopped opening after the instance was stopped and started.

### Cause

A normal EC2 public IPv4 address can change after a stop/start operation unless an Elastic IP is assigned.

### Resolution

Open the EC2 console and copy the current **Public IPv4 address**.

Use the new address for Jenkins and application URLs.

If a security-group rule uses **My IP**, verify that the local public IP has not changed as well.

## 8. EC2 instance could not be started

### Error

```text
Failed to start the instance
The instance is not in a state from which it can be started.
```

### Cause

The instance was not fully in the `stopped` state. It may already have been:

- Running
- Pending
- Stopping
- Shutting down
- Terminated

### Resolution

Check the instance state in:

```text
AWS Console → EC2 → Instances
```

Actions depend on the state:

- `running`: the instance is already started.
- `pending`: wait until it becomes running.
- `stopping`: wait until it becomes stopped.
- `stopped`: start the instance.
- `terminated`: the instance cannot be started again.

The instance state can also be checked with AWS CLI:

```bash
aws ec2 describe-instances \
  --instance-ids INSTANCE_ID \
  --query 'Reservations[0].Instances[0].State.Name' \
  --output text
```

## 9. Containers after EC2 restart

### Observation

After restarting the EC2 instance, the Phase 7 containers may start automatically.

### Cause

The containers were created with:

```text
--restart unless-stopped
```

### Verification

```bash
docker ps --filter "name=jenkins-phase-7"
```

Check the applications:

```bash
curl -I http://127.0.0.1:8083
curl -I http://127.0.0.1:8084
```

### Resolution

No action is required if the containers are healthy.

If they should no longer run:

```bash
docker rm -f jenkins-phase-7-dev jenkins-phase-7-prod
```

## 10. Docker image could not be pulled

### Possible error

```text
pull access denied
```

or:

```text
manifest unknown
```

### Possible causes

- The repository name was incorrect.
- The selected image tag did not exist.
- The Docker Hub repository was private.
- Docker Hub authentication was required.

### Diagnosis

Check the image manually:

```bash
docker pull anshu9103/jenkins-phase-6:latest
```

For the versioned image:

```bash
docker pull anshu9103/jenkins-phase-6:1
```

### Resolution

Confirm that the selected tag exists in Docker Hub.

For this phase, the expected repository is:

```text
anshu9103/jenkins-phase-6
```

If the repository becomes private, Jenkins must authenticate using the Docker Hub credential created during Phase 6.

## 11. Jenkins could not access Docker

### Possible error

```text
permission denied while trying to connect to the Docker daemon socket
```

### Cause

The Jenkins service account did not have permission to access Docker.

### Resolution

Add Jenkins to the Docker group:

```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

Verify access:

```bash
sudo -u jenkins docker version
sudo -u jenkins docker ps
```

## 12. Deployment validation failed

### Possible symptoms

```text
curl: connection refused
```

or a `grep` validation command returned exit code `1`.

### Possible causes

- The container had not finished starting.
- The container exited.
- The wrong port was selected.
- The expected webpage content was not present.
- The wrong Docker image tag was deployed.

### Diagnosis

Check container state:

```bash
docker ps -a --filter "name=jenkins-phase-7"
```

Check logs:

```bash
docker logs jenkins-phase-7-dev
```

or:

```bash
docker logs jenkins-phase-7-prod
```

Test the environment directly:

```bash
curl http://127.0.0.1:8083
curl http://127.0.0.1:8084
```

Inspect the deployed image:

```bash
docker inspect jenkins-phase-7-dev --format '{{.Config.Image}}'
docker inspect jenkins-phase-7-prod --format '{{.Config.Image}}'
```

### Resolution

Confirm that the correct image and tag were selected, remove the failed container, and rerun the pipeline.

## 13. Build aborted at production approval

### Symptom

The production build ended with:

```text
ABORTED
```

### Cause

The approval request was rejected, timed out, or the build was manually stopped.

### Resolution

Start another production build and approve it when the pipeline reaches **Production Approval**.

An aborted production deployment is safer than continuing without explicit authorization.

## 14. KEEP_CONTAINER behavior

### Observation

The container disappeared after a successful validation.

### Cause

`KEEP_CONTAINER` was not enabled.

### Resolution

To retain the deployment, run the pipeline with:

```text
KEEP_CONTAINER: true
```

To test and automatically clean up, use:

```text
KEEP_CONTAINER: false
```

### Lesson learned

Boolean pipeline parameters can control post-build resource lifecycle behavior.

## 15. Cleaning up Phase 7

After capturing all evidence, remove both containers:

```bash
docker rm -f jenkins-phase-7-dev jenkins-phase-7-prod
```

Confirm cleanup:

```bash
docker ps --filter "name=jenkins-phase-7"
```

Also remove temporary EC2 inbound rules for:

```text
8083
8084
```

The Phase 6 Docker images may remain on the server for later Jenkins phases.