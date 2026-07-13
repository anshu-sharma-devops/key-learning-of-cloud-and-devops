# Jenkins Phase 7 — Parameterized Environment Deployment

## Overview

This phase demonstrates how a Jenkins Declarative Pipeline can deploy a Docker image to different environments using build parameters.

The pipeline deploys the Docker image created and published during Jenkins Phase 6:

```text
anshu9103/jenkins-phase-6
```

Two deployment environments are supported:

| Environment | Container name | Host port | Container port |
|---|---|---:|---:|
| Development | `jenkins-phase-7-dev` | `8083` | `80` |
| Production | `jenkins-phase-7-prod` | `8084` | `80` |

Production deployments require manual approval before Jenkins starts the container.

## Learning objectives

This phase covers:

- Creating a parameterized Jenkins pipeline
- Using choice, string, and boolean parameters
- Selecting a Docker image tag during a build
- Deploying the same image to multiple environments
- Assigning different container names and ports
- Adding manual approval before production
- Testing a deployed application with `curl`
- Keeping or removing a container after deployment
- Using Docker restart policies
- Cleaning up deployment resources

## Deployment workflow

```text
User selects parameters
        ↓
Jenkins checks out the repository
        ↓
Jenkins validates the parameters
        ↓
Jenkins pulls the selected Docker image
        ↓
Production deployment requires approval
        ↓
Jenkins creates the environment container
        ↓
Jenkins tests the deployed application
        ↓
Jenkins displays the deployment summary
```

## Project structure

```text
phase-7-parameterized-deployment
├── Jenkinsfile
├── README.md
├── screenshots
│   ├── 01-first-build-parameters-not-initialized.png
│   ├── 02-development-build-parameters.png
│   ├── 03-development-pipeline-success.png
│   ├── 04-development-container-running.png
│   ├── 05-development-application-preview.png
│   ├── 06-production-build-parameters.png
│   ├── 07-production-approval-required.png
│   ├── 08-production-pipeline-success.png
│   ├── 09-both-environment-containers-running.png
│   ├── 10-production-application-preview.png
│   ├── 11-deployment-console-success.png
│   └── 12-container-cleanup.png
└── TROUBLESHOOTING.md
```

Phase 7 does not contain another `Dockerfile` or application directory. It deploys the image already published to Docker Hub during Phase 6.

## Prerequisites

The following components were prepared before running this phase:

- Jenkins server running on an Ubuntu EC2 instance
- Docker installed and active on the Jenkins server
- Jenkins user permitted to run Docker
- Git installed on the Jenkins server
- Phase 6 image available on Docker Hub
- EC2 security group under my control
- Jenkins Pipeline plugin installed

The Jenkins and Docker services can be checked with:

```bash
sudo systemctl is-active jenkins
sudo systemctl is-active docker
```

Expected output:

```text
active
active
```

Docker access for Jenkins can be tested with:

```bash
sudo -u jenkins docker version
```

## Pipeline parameters

The pipeline provides three parameters.

### DEPLOY_ENV

Selects the target environment:

```text
development
production
```

### IMAGE_TAG

Selects the Docker image version to deploy.

Examples:

```text
latest
1
```

The complete selected image could therefore be:

```text
anshu9103/jenkins-phase-6:latest
```

or:

```text
anshu9103/jenkins-phase-6:1
```

### KEEP_CONTAINER

Controls whether the deployed container remains running after a successful pipeline.

```text
true  = keep the container running
false = remove the container after validation
```

## Jenkins job configuration

A Jenkins Pipeline job was created with the following configuration:

```text
Job name: phase-7-parameterized-deployment
Definition: Pipeline script from SCM
SCM: Git
Repository URL:
https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git

Branch:
*/main

Script Path:
02-jenkins/phase-7-parameterized-deployment/Jenkinsfile
```

Because the repository is public, no Git credentials were required.

## First pipeline execution

The first execution was used by Jenkins to load and register the parameters declared in the `Jenkinsfile`.

The initial execution failed during parameter validation because `IMAGE_TAG` had not been initialized:

```text
+ test -n
ERROR: script returned exit code 1
Finished: FAILURE
```

After the parameters were registered, the job displayed the **Build with Parameters** option.

The next builds were started with explicit parameter values.

## Development deployment

The development deployment used:

```text
DEPLOY_ENV: development
IMAGE_TAG: latest
KEEP_CONTAINER: true
```

Jenkins selected:

```text
Image: anshu9103/jenkins-phase-6:latest
Container: jenkins-phase-7-dev
Port: 8083
```

The development environment does not require manual approval. Jenkins skips the production approval stage and deploys the container directly.

The running container was checked with:

```bash
docker ps --filter "name=jenkins-phase-7-dev"
```

The application was tested locally on the server:

```bash
curl -I http://127.0.0.1:8083
```

Expected response:

```text
HTTP/1.1 200 OK
```

The application could temporarily be viewed from a browser at:

```text
http://EC2_PUBLIC_IP:8083
```

## Production deployment

The production deployment used:

```text
DEPLOY_ENV: production
IMAGE_TAG: 1
KEEP_CONTAINER: true
```

Jenkins selected:

```text
Image: anshu9103/jenkins-phase-6:1
Container: jenkins-phase-7-prod
Port: 8084
```

Unlike development, the production pipeline paused at:

```text
Production Approval
```

The deployment continued only after the **Deploy to Production** approval button was selected.

This demonstrates how a manual control can be placed between automated testing and a production deployment.

The production container was checked with:

```bash
docker ps --filter "name=jenkins-phase-7-prod"
```

The application was tested locally with:

```bash
curl -I http://127.0.0.1:8084
```

The production application could temporarily be viewed at:

```text
http://EC2_PUBLIC_IP:8084
```

## Pipeline stages

The Jenkinsfile contains the following stages:

### 1. Declarative: Checkout SCM

Jenkins retrieves the repository and the Phase 7 Jenkinsfile from GitHub.

### 2. Checkout Information

Displays the Git commit used by the deployment.

```bash
git log -1 --oneline
```

### 3. Initialize Deployment

Sets the image, container name, and port according to the selected environment.

Development:

```text
jenkins-phase-7-dev
8083
```

Production:

```text
jenkins-phase-7-prod
8084
```

### 4. Validate Parameters

Ensures that an image tag was provided and that its format is allowed.

Invalid or empty tags stop the pipeline before deployment.

### 5. Pull Docker Image

Downloads the selected image from Docker Hub:

```bash
docker pull anshu9103/jenkins-phase-6:IMAGE_TAG
```

### 6. Production Approval

Runs only when the selected environment is `production`.

Jenkins pauses and waits for a user to approve the deployment.

### 7. Deploy Container

Removes an older container with the same environment name and starts the new deployment.

The containers use:

```text
--restart unless-stopped
```

This allows them to start again after the EC2 instance or Docker service restarts.

### 8. Validate Deployment

Jenkins accesses the application through the selected local port and verifies expected HTML content.

Development uses:

```text
127.0.0.1:8083
```

Production uses:

```text
127.0.0.1:8084
```

### 9. Deployment Summary

Displays information about the completed deployment, including:

- Environment
- Docker image
- Container name
- Deployment port
- Container status

### 10. Post Actions

Reports whether the deployment succeeded, failed, or was aborted.

When `KEEP_CONTAINER` is enabled, the container remains running. Otherwise, Jenkins removes it after validation.

Temporary response files are also removed.

## Verifying both environments

Both deployment containers can be displayed with:

```bash
docker ps --filter "name=jenkins-phase-7"
```

Expected names:

```text
jenkins-phase-7-dev
jenkins-phase-7-prod
```

The applications can be tested locally with:

```bash
curl -I http://127.0.0.1:8083
curl -I http://127.0.0.1:8084
```

Both should return a successful HTTP response.

## Security-group configuration

For temporary browser testing, the following inbound rules were added:

| Port | Purpose | Source |
|---:|---|---|
| 8083 | Development preview | My IP |
| 8084 | Production preview | My IP |

These ports should not be opened to `0.0.0.0/0` for this learning exercise.

The temporary inbound rules were removed after the screenshots were captured.

## Cleanup

After completing the screenshots, both environment containers can be removed:

```bash
docker rm -f jenkins-phase-7-dev jenkins-phase-7-prod
```

Confirm that no Phase 7 containers remain:

```bash
docker ps --filter "name=jenkins-phase-7"
```

The command should display only the headings and no matching containers.

The Docker images do not have to be removed because they may be reused in later Jenkins phases.

## Screenshots

### First build parameter issue

![First build parameters not initialized](screenshots/01-first-build-parameters-not-initialized.png)

### Development parameters

![Development build parameters](screenshots/02-development-build-parameters.png)

### Development pipeline success

![Development pipeline success](screenshots/03-development-pipeline-success.png)

### Development container

![Development container running](screenshots/04-development-container-running.png)

### Development application

![Development application preview](screenshots/05-development-application-preview.png)

### Production parameters

![Production build parameters](screenshots/06-production-build-parameters.png)

### Production approval

![Production approval required](screenshots/07-production-approval-required.png)

### Production pipeline success

![Production pipeline success](screenshots/08-production-pipeline-success.png)

### Both environments

![Both environment containers running](screenshots/09-both-environment-containers-running.png)

### Production application

![Production application preview](screenshots/10-production-application-preview.png)

### Console output

![Deployment console success](screenshots/11-deployment-console-success.png)

### Cleanup

![Container cleanup](screenshots/12-container-cleanup.png)

## Result

Jenkins successfully:

1. Accepted environment and image parameters.
2. Pulled the requested Phase 6 image from Docker Hub.
3. Deployed separate development and production containers.
4. skipped approval for development.
5. Required approval for production.
6. Validated both deployed applications.
7. Preserved or removed containers according to the selected option.

This phase introduced controlled, repeatable, environment-specific deployments while reusing the same tested Docker image.