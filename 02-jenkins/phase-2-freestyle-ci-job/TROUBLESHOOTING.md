<div align="center">

# 🛠️ Jenkins Phase 2 — Troubleshooting Guide

**Errors encountered and solutions applied while creating a Jenkins Freestyle CI job**

</div>

---

## 📌 Overview

This document records the problems encountered during Jenkins Phase 2 and explains how each problem was diagnosed and resolved.

Documenting these errors provides a practical reference for future Jenkins projects and demonstrates the troubleshooting process used during implementation.

---

## Issue 1 — Project Folder Created Outside the Git Repository

### Problem

The command used to enter the repository failed:

```bash
cd ~/Desktop/key-learning-of-cloud-and-devops
```

Error:

```text
cd: no such file or directory:
 /Users/anshusharma/Desktop/key-learning-of-cloud-and-devops
```

The Phase 2 folders were then accidentally created under the home directory:

```text
~/02-jenkins/phase-2-freestyle-ci-job
```

instead of inside the GitHub repository:

```text
~/key-learning-of-cloud-and-devops/02-jenkins/
```

### Root Cause

The repository was stored directly inside the home directory, not on the Desktop.

Correct repository location:

```text
/Users/anshusharma/key-learning-of-cloud-and-devops
```

### Diagnosis

The home directory contents were checked:

```bash
ls ~
```

This confirmed that both directories existed:

```text
02-jenkins
key-learning-of-cloud-and-devops
```

### Solution

The Phase 2 project was moved into the correct repository:

```bash
mv ~/02-jenkins/phase-2-freestyle-ci-job \
~/key-learning-of-cloud-and-devops/02-jenkins/
```

The remaining empty directory was removed:

```bash
rmdir ~/02-jenkins
```

The correct repository was then opened:

```bash
cd ~/key-learning-of-cloud-and-devops
code .
```

### Lesson Learned

Always verify the current directory before creating project files:

```bash
pwd
git rev-parse --show-toplevel
```

---

## Issue 2 — Unable to Type in `index.html`

### Problem

The `index.html` file appeared to be open in VS Code, but the HTML source code was not visible and the file could not be edited normally.

Instead, VS Code displayed the completed webpage:

```text
Jenkins Phase 2
Freestyle CI Job with GitHub
Build Successful
```

### Root Cause

VS Code opened `index.html` using a rendered HTML preview editor instead of the standard text editor.

The file was not read-only and its permissions were not the problem.

### Solution

The editor mode was changed:

```text
Right-click index.html tab
→ Reopen Editor With...
→ Text Editor
```

To avoid the same issue in the future:

```text
Text Editor
→ Configure as Default
```

### Lesson Learned

An HTML file may be opened using either:

- A text editor, which displays and edits source code.
- A preview editor, which renders the webpage.

Use **Text Editor** when modifying HTML source code.

---

## Issue 3 — Jenkins Service Not Found

### Problem

The EC2 instance was running and accessible through SSH, but Jenkins was unavailable.

Command:

```bash
sudo systemctl status jenkins --no-pager
```

Error:

```text
Unit jenkins.service could not be found.
```

### Root Cause

The EC2 server was running Ubuntu 24.04, but the Jenkins package had not been installed on that instance.

The operating system was confirmed with:

```bash
cat /etc/os-release
```

Output:

```text
PRETTY_NAME="Ubuntu 24.04 LTS"
```

### Solution

Java 21 was installed first:

```bash
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre
java -version
```

The Jenkins LTS signing key was added:

```bash
sudo mkdir -p /etc/apt/keyrings

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
```

The Jenkins LTS repository was configured:

```bash
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
| sudo tee /etc/apt/sources.list.d/jenkins.list
```

Jenkins was installed and started:

```bash
sudo apt update
sudo apt install -y jenkins
sudo systemctl enable --now jenkins
```

The service was verified:

```bash
sudo systemctl is-active jenkins
```

Expected output:

```text
active
```

### Lesson Learned

Jenkins requires a compatible Java installation. On Ubuntu 24.04, Java 21 should be installed before installing the current Jenkins release.

---

## Issue 4 — Intentional Build Failure

### Problem

The first Jenkins build passed successfully. To confirm that Jenkins was actually validating the HTML content, the status text was changed from:

```html
<div class="status">Build Successful</div>
```

to:

```html
<div class="status">Deployment Successful</div>
```

Jenkins then reported:

```text
Build step 'Execute shell' marked build as failure
Finished: FAILURE
```

### Root Cause

The Jenkins validation script expected this exact text:

```bash
grep -q "Build Successful" "$APP_DIR/index.html"
```

The updated HTML no longer contained that phrase.

The script also contained:

```bash
set -e
```

Therefore, it stopped immediately after the failed `grep` command.

### Solution

This failure was intentional and confirmed that the CI validation was working correctly.

The required status text was restored:

```html
<div class="status">Build Successful</div>
```

The corrected application was committed and pushed:

```bash
git add 02-jenkins/phase-2-freestyle-ci-job/app/index.html
git commit -m "Restore successful Jenkins validation"
git push origin main
```

### Lesson Learned

A failed Jenkins build does not always indicate a Jenkins configuration problem. It can correctly indicate that application code does not meet the defined validation requirements.

---

## Issue 5 — First Recovery Build Still Failed

### Problem

After restoring the status message, the recovery build still failed.

Console output:

```text
Checking expected webpage content...
grep -q Jenkins Phase 2 02-jenkins/phase-2-freestyle-ci-job/app/index.html
Build step 'Execute shell' marked build as failure
Finished: FAILURE
```

The build stopped before reaching the second content check.

### Root Cause

The latest committed version of `index.html` did not contain the exact required heading:

```text
Jenkins Phase 2
```

The Jenkins script used exact, case-sensitive text validation:

```bash
grep -q "Jenkins Phase 2" "$APP_DIR/index.html"
```

Restoring only `Build Successful` was not enough. Both required phrases had to exist.

### Diagnosis

The file was checked locally:

```bash
grep -n "Jenkins Phase 2" \
02-jenkins/phase-2-freestyle-ci-job/app/index.html

grep -n "Build Successful" \
02-jenkins/phase-2-freestyle-ci-job/app/index.html
```

The committed version was also checked:

```bash
git show HEAD:02-jenkins/phase-2-freestyle-ci-job/app/index.html \
| grep -E "Jenkins Phase 2|Build Successful"
```

### Solution

Both exact values were restored:

```html
<h1>Jenkins Phase 2</h1>
<div class="status">Build Successful</div>
```

The fix was committed and pushed:

```bash
git add 02-jenkins/phase-2-freestyle-ci-job/app/index.html
git commit -m "Fix required Jenkins validation text"
git push origin main
```

The next Jenkins build completed successfully:

```text
HTML application validation completed successfully.
Finished: SUCCESS
```

### Lesson Learned

Content-validation commands are sensitive to exact spelling, capitalization and spacing. Every condition in the validation script must pass before Jenkins marks the build as successful.

---

## Issue 6 — Public EC2 IP Address Changes

### Problem

The same Jenkins EC2 instance is reused across all Jenkins learning phases. When the instance is stopped and restarted, its public IPv4 address may change.

The previous Jenkins URL then stops working:

```text
http://OLD_PUBLIC_IP:8080
```

### Root Cause

A standard EC2 public IPv4 address is dynamic and is normally released when the instance is stopped.

### Solution

After starting the instance, retrieve its current public IP:

```bash
aws ec2 describe-instances \
  --instance-ids YOUR_INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```

Open Jenkins using the new address:

```text
http://NEW_PUBLIC_IP:8080
```

The security group must allow inbound TCP port `8080` from the current trusted IP address.

### Lesson Learned

Stopping an EC2 instance preserves Jenkins data on the EBS volume, but the public IPv4 address may change after restart.

---

## ✅ Final Validation

The final Jenkins build performed the following checks successfully:

```bash
test -d "$APP_DIR"
test -f "$APP_DIR/index.html"
grep -q "Jenkins Phase 2" "$APP_DIR/index.html"
grep -q "Build Successful" "$APP_DIR/index.html"
```

Final console output:

```text
HTML application validation completed successfully.
Finished: SUCCESS
```

---

## 🧠 Troubleshooting Summary

| Problem | Root cause | Resolution |
|---|---|---|
| Repository path not found | Repository was not stored on Desktop | Located the repository under the home directory |
| Phase 2 folder created in the wrong place | Commands ran from `~` | Moved the folder into `02-jenkins` |
| HTML source could not be edited | File opened in preview mode | Reopened it with Text Editor |
| Jenkins service not found | Jenkins was not installed | Installed Java 21 and Jenkins LTS |
| Intentional build failed | Required status text was removed | Restored `Build Successful` |
| Recovery build still failed | Required heading was missing or mismatched | Restored both exact validation phrases |
| Jenkins URL changed | EC2 public IP was dynamic | Retrieved the new public IPv4 address |

---

## ✅ Final Status

All Phase 2 problems were successfully resolved.

The Jenkins Freestyle project can now:

- Retrieve the latest source code from GitHub.
- Validate the application directory and HTML file.
- Detect incorrect application content.
- Mark invalid builds as failed.
- Return to a successful state after the code is corrected.

---

<div align="center">

**Jenkins Phase 2 Troubleshooting Completed**

*Documented by Anshu Sharma*

</div>