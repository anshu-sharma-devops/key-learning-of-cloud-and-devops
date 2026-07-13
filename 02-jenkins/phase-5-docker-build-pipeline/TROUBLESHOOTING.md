<div align="center">

# 🛠️ Jenkins Phase 5 — Troubleshooting Guide

**Errors and fixes encountered while integrating Jenkins with Docker**

</div>

---

## 📌 Overview

This document records the problems encountered during Jenkins Phase 5.

The final Pipeline completed successfully, but several Docker permission, shell-session and network-access issues were diagnosed and resolved.

---

## Issue 1 — Ubuntu User Could Not Access Docker

### Problem

The Jenkins user could access Docker:

```bash
sudo -u jenkins docker ps
```

But the Ubuntu user received:

```text
permission denied while trying to connect to the docker API
at unix:///var/run/docker.sock
```

Command:

```bash
docker ps
```

### Root Cause

The `jenkins` user was a member of the Docker group, but the `ubuntu` user was not.

The Docker socket is normally controlled by:

```text
root:docker
```

Users outside the Docker group cannot access Docker without `sudo`.

### Solution

The Ubuntu user was added to the Docker group:

```bash
sudo usermod -aG docker ubuntu
```

---

## Issue 2 — Docker Permission Still Failed After `usermod`

### Problem

After running:

```bash
sudo usermod -aG docker ubuntu
```

the current terminal still showed:

```text
permission denied while trying to connect to the docker API
```

### Root Cause

Linux group changes do not automatically update an already-running login session.

Running `usermod` repeatedly does not refresh the current shell.

### Solution

The SSH session was closed and reconnected:

```bash
exit
```

After reconnecting:

```bash
groups
```

Output included:

```text
ubuntu adm cdrom sudo dip lxd docker
```

Docker then worked without `sudo`:

```bash
docker ps
docker images jenkins-phase-5
```

### Alternative

A temporary new shell can be started with:

```bash
newgrp docker
```

### Lesson Learned

After changing Linux group membership, reconnect the user session or use `newgrp`.

---

## Issue 3 — Incorrect `curl` Command

### Problem

The following command was run:

```bash
curl config
```

Error:

```text
curl: (6) Could not resolve host: config
```

Running it with `sudo` produced the same result.

### Root Cause

`curl` interpreted `config` as a hostname and attempted DNS resolution.

`config` was not a valid server name or URL.

This was not a permission problem, so `sudo` could not fix it.

### Solution

The correct container address was used:

```bash
curl http://127.0.0.1:8081
```

Headers could be checked with:

```bash
curl -I http://127.0.0.1:8081
```

Expected:

```text
HTTP/1.1 200 OK
Server: nginx
```

Content validation:

```bash
curl -s http://127.0.0.1:8081 | grep -E \
"Jenkins Phase 5|Docker Pipeline Successful"
```

### Lesson Learned

`curl` requires a valid URL or hostname. Adding `sudo` does not fix DNS or URL mistakes.

---

## Issue 4 — Container Worked Locally but Not in Browser

### Problem

The container was healthy:

```text
Up 3 minutes (healthy)
0.0.0.0:8081->80/tcp
```

The application worked through local `curl`, but it did not initially open from the Mac browser.

### Root Cause

Port `8081` was not allowed in the EC2 security group.

The Docker port was correctly published, but AWS still blocked inbound traffic.

### Solution

A temporary inbound rule was added:

| Setting | Value |
|---|---|
| Type | Custom TCP |
| Port | `8081` |
| Source | My IP |
| Description | Phase 5 Docker preview |

The application was opened using:

```text
http://CURRENT_PUBLIC_IP:8081
```

The private IP was not used:

```text
172.31.41.33
```

### Cleanup

After the screenshot was captured:

- The preview container was removed.
- The temporary port `8081` rule was removed.

### Lesson Learned

Docker port publishing and AWS security-group rules are separate controls. Both must permit the connection.

---

## Issue 5 — Temporary Container No Longer Appeared

### Observation

The command returned an empty result:

```bash
docker ps -a --filter "name=jenkins-phase-5-test"
```

### Explanation

This was expected, not an error.

The Jenkinsfile contains:

```groovy
post {
    always {
        sh '''
            docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
        '''
    }
}
```

The container was automatically removed after the Pipeline.

### Lesson Learned

The `post { always { ... } }` block runs after both successful and failed builds, making it suitable for cleanup.

---

## Issue 6 — `sudo groups` Displayed Only Root

### Observation

Command:

```bash
sudo groups
```

Output:

```text
root
```

### Explanation

`sudo groups` runs the command as the root user, so it displays root’s groups.

To check the current Ubuntu user:

```bash
groups
```

or:

```bash
groups ubuntu
```

Expected to include:

```text
docker
```

---

## ✅ Final Validation

Docker access:

```bash
sudo -u jenkins docker version
sudo -u jenkins docker ps
```

Image:

```bash
docker images jenkins-phase-5
```

Result:

```text
jenkins-phase-5:1
```

Container cleanup:

```bash
docker ps -a --filter "name=jenkins-phase-5"
```

Pipeline result:

```text
Jenkins Phase 5 Docker Pipeline completed successfully.
Phase 5 Pipeline cleanup completed.
Finished: SUCCESS
```

---

## 🔍 Useful Commands

### Check Docker

```bash
docker --version
sudo systemctl is-active docker
```

### Check Jenkins

```bash
sudo systemctl is-active jenkins
```

### Check user groups

```bash
groups
groups jenkins
groups ubuntu
```

### Test Docker as Jenkins

```bash
sudo -u jenkins docker version
sudo -u jenkins docker ps
```

### List Phase 5 images

```bash
docker images jenkins-phase-5
```

### List Phase 5 containers

```bash
docker ps -a --filter "name=jenkins-phase-5"
```

### Test the application

```bash
curl -I http://127.0.0.1:8081
```

### Remove Phase 5 containers

```bash
docker rm -f jenkins-phase-5-test 2>/dev/null || true
docker rm -f jenkins-phase-5-preview 2>/dev/null || true
```

---

## 🧠 Troubleshooting Summary

| Problem | Root cause | Fix |
|---|---|---|
| Ubuntu Docker permission denied | User not in Docker group | Added `ubuntu` to Docker group |
| Permission remained after `usermod` | Existing session had old groups | Reconnected SSH session |
| `curl config` failed | `config` treated as hostname | Used `http://127.0.0.1:8081` |
| Browser could not open container | Port `8081` blocked by AWS | Temporarily allowed `8081` from My IP |
| Test container missing afterward | Jenkins cleanup removed it | Confirmed expected `post` behaviour |
| `sudo groups` showed root | Command ran as root | Used `groups` without `sudo` |

---

## ✅ Conclusion

All Phase 5 issues were resolved.

Jenkins can communicate with Docker, build the application image, run and test a container, retain image evidence and remove temporary containers automatically.

Final status:

```text
Finished: SUCCESS
```

---

<div align="center">

**Jenkins Phase 5 Troubleshooting Completed**

*Documented by Anshu Sharma*

</div>