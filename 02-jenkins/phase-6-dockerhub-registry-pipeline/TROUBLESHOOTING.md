<div align="center">

# 🛠️ Jenkins Phase 6 — Troubleshooting Guide

**Docker Hub authentication, image publication and registry Pipeline troubleshooting**

</div>

---

## 📌 Overview

The Phase 6 Pipeline completed successfully without a major build failure.

Two warnings appeared during execution:

- Docker legacy builder deprecation.
- Docker login configuration stored temporarily in the Jenkins home directory.

Neither warning caused the Pipeline to fail.

This document explains those warnings and provides solutions for common registry Pipeline problems.

---

## Warning 1 — Legacy Docker Builder Deprecated

### Console Warning

```text
DEPRECATED: The legacy builder is deprecated and will be removed
in a future release.

Install the buildx component to build images with BuildKit.
```

### Meaning

Docker successfully built the image using the legacy builder, but recommends migrating to BuildKit and Buildx.

### Impact

The warning did not affect the Phase 6 result:

```text
Successfully built 7c7007815313
Successfully tagged anshu9103/jenkins-phase-6:1
```

### Future Improvement

Check Buildx:

```bash
docker buildx version
```

If available, enable BuildKit:

```bash
DOCKER_BUILDKIT=1 docker build \
  -t anshu9103/jenkins-phase-6:1 .
```

### Status

```text
⚠️ Warning only — build succeeded
```

---

## Warning 2 — Docker Login Configuration Stored Unencrypted

### Console Warning

```text
WARNING! Your credentials are stored unencrypted in
'/var/lib/jenkins/.docker/config.json'.
```

### Meaning

Docker created a temporary authentication configuration for the Jenkins user.

### Security Controls Used

The Pipeline protected the token with:

```groovy
withCredentials(...)
```

The shell used:

```bash
set +x
```

Login used:

```bash
docker login --password-stdin
```

The token was masked:

```text
Masking supported pattern matches of $DOCKERHUB_TOKEN
```

Finally, Jenkins ran:

```bash
docker logout
```

Output:

```text
Removing login credentials for https://index.docker.io/v1/
```

### Status

```text
⚠️ Warning handled through automatic logout
```

A production system can additionally configure a Docker credential helper.

---

## Potential Issue 1 — Jenkins Credential Not Found

### Possible Error

```text
Could not find credentials entry with ID
'dockerhub-credentials'
```

### Cause

The Jenkins credential ID does not match the Jenkinsfile.

### Required ID

```text
dockerhub-credentials
```

### Solution

Open:

```text
Manage Jenkins
→ Credentials
→ System
→ Global credentials
```

Confirm:

| Field | Value |
|---|---|
| Kind | Username with password |
| Username | `anshu9103` |
| Password | Docker Hub access token |
| ID | `dockerhub-credentials` |

---

## Potential Issue 2 — Docker Hub Login Failed

### Possible Error

```text
unauthorized: incorrect username or password
```

### Possible Causes

- Docker Hub username is incorrect.
- Normal password was entered instead of the token.
- Token was copied incorrectly.
- Token expired.
- Token was deactivated.
- Token lacks required permissions.

### Solution

Create a new Docker Hub personal access token with:

```text
Read and Write
```

Update the Jenkins credential password field with the new token.

Do not update the Jenkinsfile if the credential ID remains:

```text
dockerhub-credentials
```

---

## Potential Issue 3 — Image Push Denied

### Possible Error

```text
denied: requested access to the resource is denied
```

### Possible Causes

- Repository does not exist.
- Repository belongs to another namespace.
- Image repository is misspelled.
- Token lacks write permission.
- Docker Hub username does not match the namespace.

### Required Repository

```text
anshu9103/jenkins-phase-6
```

### Jenkinsfile Value

```groovy
IMAGE_REPOSITORY = 'anshu9103/jenkins-phase-6'
```

Confirm the Docker Hub repository exists and the token has write permission.

---

## Potential Issue 4 — Repository Name Rejected

### Error

Docker Hub may report:

```text
Repository name must contain alphanumeric characters and may
contain ., _, or -. Letters must be lowercase.
```

### Cause

The full image path may have been entered in the repository-name field:

```text
anshu9103/jenkins-phase-6
```

The `/` is not valid in the repository-name field.

### Solution

Use:

```text
Namespace: anshu9103
Repository name: jenkins-phase-6
```

Docker Hub automatically creates:

```text
anshu9103/jenkins-phase-6
```

---

## Potential Issue 5 — Container Test Failed

### Possible Failure Point

```bash
curl --fail --silent http://127.0.0.1:8082
```

### Possible Causes

- Container did not start.
- Port `8082` is already in use.
- Nginx has not started.
- Image build failed.
- Application file was not copied.

### Diagnosis

```bash
docker ps -a \
  --filter "name=jenkins-phase-6-test"

docker logs jenkins-phase-6-test

sudo ss -tulpn | grep :8082
```

### Solution

Remove an old container:

```bash
docker rm -f jenkins-phase-6-test
```

Check for another service using port `8082`.

---

## Potential Issue 6 — Required Content Missing

The Pipeline expects:

```text
Jenkins Phase 6
Docker Hub Registry Pipeline
Registry Pipeline Successful
```

Check locally:

```bash
grep -nE \
"Jenkins Phase 6|Docker Hub Registry Pipeline|Registry Pipeline Successful" \
02-jenkins/phase-6-dockerhub-registry-pipeline/app/index.html
```

Restore the exact values if required.

---

## Potential Issue 7 — `latest` Tag Missing

### Cause

The versioned image may have been built without creating `latest`.

### Required Tag Command

```bash
docker tag \
  anshu9103/jenkins-phase-6:1 \
  anshu9103/jenkins-phase-6:latest
```

### Push

```bash
docker push anshu9103/jenkins-phase-6:latest
```

Check Docker Hub’s Tags page afterward.

---

## Potential Issue 8 — Token Appears in Console Output

### Risk

A token must never appear in Jenkins Console Output.

### Protection

Use:

```groovy
withCredentials([
    usernamePassword(
        credentialsId: 'dockerhub-credentials',
        usernameVariable: 'DOCKERHUB_USERNAME',
        passwordVariable: 'DOCKERHUB_TOKEN'
    )
])
```

Use single-quoted shell blocks and:

```bash
set +x
```

Authenticate with:

```bash
echo "$DOCKERHUB_TOKEN" |
docker login \
  --username "$DOCKERHUB_USERNAME" \
  --password-stdin
```

If a real token is ever exposed:

1. Deactivate it immediately in Docker Hub.
2. Generate a replacement.
3. Update Jenkins Credentials.
4. Remove the exposed value from logs and repository history when applicable.

---

## Potential Issue 9 — Application Preview Does Not Open

### Cause

The preview container may work locally while AWS blocks port `8082`.

### Local Verification

```bash
curl -I http://127.0.0.1:8082
```

### AWS Rule

Temporarily allow:

```text
Custom TCP
Port: 8082
Source: My IP
```

Open:

```text
http://CURRENT_PUBLIC_IP:8082
```

After capturing the screenshot:

```bash
docker rm -f jenkins-phase-6-preview
```

Remove the temporary security-group rule.

---

## Potential Issue 10 — Public IP Changed

If Jenkins EC2 was stopped and restarted, retrieve the current public IP:

```bash
aws ec2 describe-instances \
  --instance-ids YOUR_INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```

Use the new IP for Jenkins and temporary application previews.

---

## ✅ Final Successful Evidence

Credential masking:

```text
Masking supported pattern matches of $DOCKERHUB_TOKEN
```

Login:

```text
Login Succeeded
```

Versioned push:

```text
1: digest: sha256:7c7007815313...
Versioned Docker image pushed successfully.
```

Latest push:

```text
latest: digest: sha256:7c7007815313...
Latest Docker image pushed successfully.
```

Cleanup:

```text
Removing login credentials
Phase 6 Pipeline cleanup completed.
```

Final status:

```text
Finished: SUCCESS
```

---

## 🔍 Useful Diagnostic Commands

### Check local images

```bash
docker images anshu9103/jenkins-phase-6
```

### Check containers

```bash
docker ps -a --filter "name=jenkins-phase-6"
```

### Pull published images

```bash
docker pull anshu9103/jenkins-phase-6:1
docker pull anshu9103/jenkins-phase-6:latest
```

### Test the application

```bash
curl -I http://127.0.0.1:8082
```

### Log out

```bash
docker logout
```

### Check Docker disk usage

```bash
docker system df
```

---

## 🧠 Troubleshooting Summary

| Item | Result |
|---|---|
| Legacy builder warning | Build still succeeded |
| Temporary Docker config warning | Handled through logout |
| Jenkins credential masking | ✅ Working |
| Docker Hub login | ✅ Successful |
| Version tag push | ✅ Successful |
| Latest tag push | ✅ Successful |
| Published image pull | ✅ Successful |
| Temporary container cleanup | ✅ Completed |
| Final Pipeline | ✅ SUCCESS |

---

## ✅ Conclusion

Phase 6 completed without a major build failure.

The warnings were understood and handled appropriately. Jenkins protected the Docker Hub token, published both required tags, logged out and removed temporary resources.

Final result:

```text
Finished: SUCCESS
```

---

<div align="center">

**Jenkins Phase 6 Troubleshooting Completed**

*Documented by Anshu Sharma*

</div>