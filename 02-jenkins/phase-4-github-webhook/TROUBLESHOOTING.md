<div align="center">

# 🛠️ Jenkins Phase 4 — Troubleshooting Guide

**Troubleshooting GitHub webhook delivery and automated Jenkins Pipeline execution**

</div>

---

## 📌 Overview

This document records the validation performed during Jenkins Phase 4 and provides solutions for common GitHub webhook integration problems.

The final webhook-triggered Pipeline completed successfully without a major execution error.

The key Console Output was:

```text
Started by GitHub push by anshu-sharma-devops
Finished: SUCCESS
```

---

## ✅ Final Validation

| Check | Result |
|---|---|
| Manual Pipeline test | ✅ Passed |
| GitHub webhook created | ✅ Completed |
| Push event enabled | ✅ Completed |
| Jenkins webhook endpoint reached | ✅ Passed |
| Pipeline triggered automatically | ✅ Passed |
| Correct Git commit retrieved | ✅ Passed |
| Application directory validated | ✅ Passed |
| `index.html` validated | ✅ Passed |
| Required content validated | ✅ Passed |
| Final Pipeline result | ✅ SUCCESS |

---

## Validation 1 — Manual Pipeline Passed

Before configuring the webhook, the Pipeline was run manually.

This verified:

- The GitHub repository URL.
- The Script Path.
- The Jenkinsfile syntax.
- The repository checkout.
- The application files.
- The validation commands.

This is an important troubleshooting method:

```text
Manual build fails
→ Fix the Pipeline first

Manual build passes but automatic build does not start
→ Investigate the webhook
```

---

## Validation 2 — Webhook Trigger Was Enabled

The Jenkins job used:

```text
GitHub hook trigger for GITScm polling
```

This setting allowed Jenkins to process the incoming GitHub push notification.

---

## Validation 3 — Webhook Started the Build

The automatic Jenkins build displayed:

```text
Started by GitHub push by anshu-sharma-devops
```

This confirmed that the build was not started through **Build Now**.

---

## Validation 4 — Correct Commit Was Retrieved

Jenkins retrieved:

```text
Commit message: "Trigger Jenkins Phase 4 through GitHub webhook"
```

The Pipeline displayed:

```text
c11e681 Trigger Jenkins Phase 4 through GitHub webhook
```

This confirmed that Jenkins processed the commit that triggered the webhook.

---

## Validation 5 — Application Tests Passed

The Pipeline executed:

```bash
test -d "$APP_DIR"
test -f "$APP_FILE"

grep -q "Jenkins Phase 4" "$APP_FILE"
grep -q "GitHub Webhook Automation" "$APP_FILE"
grep -q "Webhook Pipeline Successful" "$APP_FILE"
```

Successful output:

```text
Application structure validation passed.
Webhook application tests passed.
Finished: SUCCESS
```

---

# Common Problems and Solutions

The following are reference checks for future webhook failures.

---

## Potential Issue 1 — GitHub Trigger Option Missing

### Problem

This option is unavailable:

```text
GitHub hook trigger for GITScm polling
```

### Cause

The Jenkins GitHub plugin may be missing or disabled.

### Solution

Open:

```text
Manage Jenkins
→ Plugins
→ Available Plugins
```

Search for and install:

```text
GitHub
```

Restart Jenkins if requested.

---

## Potential Issue 2 — GitHub Cannot Reach Jenkins

### Symptoms

- Webhook delivery times out.
- The Jenkins job does not start.
- GitHub displays a failed delivery.

### Possible Causes

- EC2 is stopped.
- Jenkins service is stopped.
- The webhook uses an old public IP.
- Port `8080` is blocked.
- The Payload URL is incorrect.

### Diagnosis

```bash
sudo systemctl is-active jenkins
sudo ss -tulpn | grep :8080
```

Expected:

```text
active
```

Confirm Jenkins opens:

```text
http://CURRENT_PUBLIC_IP:8080
```

---

## Potential Issue 3 — Incorrect Payload URL

### Correct Format

```text
http://PUBLIC_IP:8080/github-webhook/
```

Check that:

- The public IP is used.
- Port `8080` is included.
- The path is `/github-webhook/`.
- The final slash is present.

Do not use the private `172.31.x.x` address.

---

## Potential Issue 4 — Push Event Not Selected

Open:

```text
GitHub Repository
→ Settings
→ Webhooks
→ Edit
```

Confirm:

```text
Just the push event
Active
```

---

## Potential Issue 5 — Webhook Arrives but Job Does Not Start

Confirm the Jenkins job uses:

```text
GitHub hook trigger for GITScm polling
```

Confirm the repository URL:

```text
https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git
```

Confirm the branch:

```text
*/main
```

---

## Potential Issue 6 — Jenkinsfile Not Found

### Correct Script Path

```text
02-jenkins/phase-4-github-webhook/Jenkinsfile
```

Check locally:

```bash
ls -l \
02-jenkins/phase-4-github-webhook/Jenkinsfile
```

Check that Git tracks it:

```bash
git ls-files \
02-jenkins/phase-4-github-webhook/Jenkinsfile
```

---

## Potential Issue 7 — HTML Validation Failed

The Pipeline expects:

```text
Jenkins Phase 4
GitHub Webhook Automation
Webhook Pipeline Successful
```

Check locally:

```bash
grep -nE \
"Jenkins Phase 4|GitHub Webhook Automation|Webhook Pipeline Successful" \
02-jenkins/phase-4-github-webhook/app/index.html
```

Correct values:

```html
<h1>Jenkins Phase 4</h1>

<h2>GitHub Webhook Automation</h2>

<div class="status">Webhook Pipeline Successful</div>
```

Commit and push the correction.

---

## Potential Issue 8 — Public IP Changed

A stopped and restarted EC2 instance may receive a new public IP.

Retrieve it:

```bash
aws ec2 describe-instances \
  --instance-ids YOUR_INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```

Update the GitHub webhook:

```text
http://NEW_PUBLIC_IP:8080/github-webhook/
```

---

## Potential Issue 9 — Push Occurred While Jenkins Was Stopped

If GitHub attempted delivery while the EC2 instance was stopped:

1. Start the EC2 instance.
2. Check the new public IP.
3. Start or verify Jenkins.
4. Update the webhook URL if needed.
5. Open GitHub webhook deliveries.
6. Select the failed request.
7. Choose **Redeliver**.

---

## Potential Issue 10 — Jenkins Was Left Publicly Accessible

### Risk

This security-group rule exposes Jenkins publicly:

```text
TCP 8080
Source: 0.0.0.0/0
```

### Resolution

After testing, public access was removed and restored to:

```text
TCP 8080
Source: My IP
```

A production setup should use HTTPS, a webhook secret, IP allowlisting and a reverse proxy.

---

## Potential Issue 11 — Local Change Was Not Pushed

Check:

```bash
git status
git log -1 --oneline
```

If changes remain local:

```bash
git add 02-jenkins/phase-4-github-webhook

git commit -m "Update Jenkins Phase 4"

git push origin main
```

Compare the Jenkins commit with:

```bash
git log -1 --oneline
```

---

## 🔍 Useful Diagnostic Commands

### Jenkins service

```bash
sudo systemctl status jenkins --no-pager
```

### Jenkins port

```bash
sudo ss -tulpn | grep :8080
```

### Latest commit

```bash
git log -1 --oneline
```

### Repository access

```bash
git ls-remote \
https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git
```

### Project structure

```bash
tree 02-jenkins/phase-4-github-webhook
```

### Git status

```bash
git status
```

---

## 🧠 Troubleshooting Summary

| Component | Result |
|---|---|
| Manual Pipeline | ✅ Passed |
| GitHub webhook configuration | ✅ Completed |
| Automatic trigger | ✅ Passed |
| Correct Git revision | ✅ Retrieved |
| Pipeline stages | ✅ Passed |
| Application validation | ✅ Passed |
| Security group restored | ✅ Completed |
| Final result | ✅ SUCCESS |

---

## ✅ Conclusion

No major execution error occurred during the final Phase 4 implementation.

The validation confirmed that GitHub could trigger Jenkins automatically, Jenkins could retrieve the correct commit, and every Pipeline stage completed successfully.

The main evidence was:

```text
Started by GitHub push by anshu-sharma-devops
Finished: SUCCESS
```

This document also provides reusable checks for future webhook, network, Pipeline and application-validation problems.

---

<div align="center">

**Jenkins Phase 4 Troubleshooting Completed**

*Documented by Anshu Sharma*

</div>