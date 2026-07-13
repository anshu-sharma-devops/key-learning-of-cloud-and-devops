<div align="center">

# 🛠️ Jenkins Phase 3 — Troubleshooting Guide

**Validation checks and troubleshooting reference for a Declarative Pipeline loaded from GitHub**

</div>

---

## 📌 Overview

This document records the validation performed during Jenkins Phase 3 and provides troubleshooting steps for common Declarative Pipeline problems.

The Phase 3 pipeline completed successfully on its first execution. No major runtime error occurred during implementation.

The successful result confirmed that:

- Jenkins could connect to GitHub.
- Jenkins found the correct `Jenkinsfile`.
- The Declarative Pipeline syntax was valid.
- The repository was checked out successfully.
- The application directory and HTML file existed.
- All required HTML content was present.
- Every pipeline stage completed successfully.
- The `post` actions executed correctly.

---

## ✅ Final Pipeline Status

Jenkins successfully loaded the pipeline definition from:

```text
02-jenkins/phase-3-declarative-pipeline/Jenkinsfile
```

Console output:

```text
Obtained 02-jenkins/phase-3-declarative-pipeline/Jenkinsfile from git
https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git
```

Final result:

```text
Jenkins Phase 3 pipeline completed successfully.
Pipeline execution finished.
Finished: SUCCESS
```

---

## Validation 1 — Jenkinsfile Retrieved from GitHub

### Verification

The Jenkins console displayed:

```text
Obtained 02-jenkins/phase-3-declarative-pipeline/Jenkinsfile from git
```

### Meaning

This confirmed that:

- The GitHub repository URL was correct.
- The configured branch existed.
- The Script Path was correct.
- Jenkins could access the public repository.
- The `Jenkinsfile` had already been pushed to GitHub.

### Jenkins Configuration

```text
Definition: Pipeline script from SCM
SCM: Git
Branch Specifier: */main
Script Path: 02-jenkins/phase-3-declarative-pipeline/Jenkinsfile
```

---

## Validation 2 — Repository Checkout Completed

### Verification

Jenkins successfully cloned the repository and checked out the latest revision:

```text
Cloning repository https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git
Checking out Revision be0a76764fb5b4af073f6b1d94fecc32a7eecb7e
Commit message: "Add Jenkins Phase 3 declarative pipeline"
```

### Meaning

This confirmed that:

- Git was installed on the Jenkins server.
- Jenkins could communicate with GitHub.
- The `main` branch was available.
- No credentials were required because the repository was public.
- Jenkins retrieved the expected Git commit.

The Git version used by Jenkins was:

```text
git version 2.43.0
```

---

## Validation 3 — Application Structure Passed

### Verification

The pipeline executed:

```bash
test -d "$APP_DIR"
test -f "$APP_FILE"
```

Console output:

```text
Application structure validation passed.
```

### Meaning

This confirmed that both paths existed inside the Jenkins workspace:

```text
02-jenkins/phase-3-declarative-pipeline/app
02-jenkins/phase-3-declarative-pipeline/app/index.html
```

---

## Validation 4 — HTML Content Tests Passed

### Verification

The pipeline searched for three required values:

```bash
grep -q "Jenkins Phase 3" "$APP_FILE"
grep -q "Declarative Pipeline with Jenkinsfile" "$APP_FILE"
grep -q "Pipeline Successful" "$APP_FILE"
```

Console output:

```text
HTML content tests passed.
```

### Meaning

The HTML application contained all required text with the correct spelling and capitalization.

---

## Validation 5 — Post Actions Executed

### Verification

The pipeline completed with:

```text
Pipeline execution finished.
Jenkins Phase 3 pipeline completed successfully.
```

### Meaning

The following post actions executed:

```groovy
post {
    success {
        echo 'Jenkins Phase 3 pipeline completed successfully.'
    }

    failure {
        echo 'Jenkins Phase 3 pipeline failed. Review the console output.'
    }

    always {
        echo 'Pipeline execution finished.'
    }
}
```

The `success` block ran because every stage passed.

The `always` block also ran because it executes after every build, regardless of the result.

---

# Common Problems and Solutions

The following errors were not encountered during the successful build, but these checks can be used if the pipeline fails in the future.

---

## Potential Issue 1 — Jenkinsfile Not Found

### Possible Error

```text
Unable to find Jenkinsfile
```

or:

```text
Jenkinsfile not found
```

### Possible Causes

- Incorrect Script Path.
- Incorrect filename capitalization.
- The `Jenkinsfile` was not committed or pushed.
- Jenkins was configured to use the wrong branch.

### Solution

Confirm that the file exists locally:

```bash
cd ~/key-learning-of-cloud-and-devops

ls -l 02-jenkins/phase-3-declarative-pipeline/Jenkinsfile
```

Confirm that Git tracks it:

```bash
git ls-files \
02-jenkins/phase-3-declarative-pipeline/Jenkinsfile
```

Use this exact Script Path in Jenkins:

```text
02-jenkins/phase-3-declarative-pipeline/Jenkinsfile
```

The filename must be:

```text
Jenkinsfile
```

not:

```text
jenkinsfile
JenkinsFile
Jenkinsfile.txt
```

---

## Potential Issue 2 — Jenkinsfile Changes Not Used

### Problem

The local `Jenkinsfile` is updated, but Jenkins continues executing the old pipeline.

### Possible Cause

The changes were saved locally but were not committed and pushed to GitHub.

### Solution

Check Git status:

```bash
git status
```

Push the changes:

```bash
git add 02-jenkins/phase-3-declarative-pipeline/Jenkinsfile

git commit -m "Update Jenkins Phase 3 pipeline"

git push origin main
```

Confirm the latest commit:

```bash
git log -1 --oneline
```

Run the Jenkins job again and compare the commit displayed in the Console Output.

---

## Potential Issue 3 — Declarative Pipeline Syntax Error

### Possible Error

```text
WorkflowScript: expected a step
```

or:

```text
MultipleCompilationErrorsException
```

### Possible Causes

- Missing braces.
- A stage placed outside the `stages` block.
- A command placed outside the `steps` block.
- Incorrect Groovy syntax.
- Incorrect quotation marks.

### Correct Structure

```groovy
pipeline {
    agent any

    stages {
        stage('Example') {
            steps {
                echo 'Pipeline syntax is valid.'
            }
        }
    }
}
```

### Solution

Review the braces carefully and use Jenkins Pipeline Syntax tools when required:

```text
Jenkins Dashboard
→ Manage Jenkins
→ Tools and Actions
→ Pipeline Syntax
```

---

## Potential Issue 4 — Application Directory Not Found

### Possible Failure Point

```bash
test -d "$APP_DIR"
```

### Possible Causes

- Incorrect `APP_DIR` value.
- Project folder renamed.
- Application folder not committed.
- Jenkins checked out a different branch.

### Solution

Check the directory locally:

```bash
ls -ld \
02-jenkins/phase-3-declarative-pipeline/app
```

Confirm the environment variable inside the `Jenkinsfile`:

```groovy
environment {
    APP_DIR = '02-jenkins/phase-3-declarative-pipeline/app'
}
```

---

## Potential Issue 5 — `index.html` Not Found

### Possible Failure Point

```bash
test -f "$APP_FILE"
```

### Possible Causes

- `index.html` was deleted or renamed.
- Incorrect `APP_FILE` path.
- The file was not committed to Git.
- Filename capitalization did not match.

### Solution

Check the file:

```bash
ls -l \
02-jenkins/phase-3-declarative-pipeline/app/index.html
```

Confirm Git tracks it:

```bash
git ls-files \
02-jenkins/phase-3-declarative-pipeline/app/index.html
```

The environment variables should be:

```groovy
environment {
    APP_DIR = '02-jenkins/phase-3-declarative-pipeline/app'
    APP_FILE = "${APP_DIR}/index.html"
}
```

---

## Potential Issue 6 — HTML Content Validation Failed

### Possible Failure Point

```bash
grep -q "Jenkins Phase 3" "$APP_FILE"
grep -q "Declarative Pipeline with Jenkinsfile" "$APP_FILE"
grep -q "Pipeline Successful" "$APP_FILE"
```

### Root Cause

One or more required values are missing or do not exactly match the validation script.

The checks are case-sensitive. For example:

```text
Pipeline Successful
```

is different from:

```text
Pipeline successful
```

### Diagnosis

Run these checks locally:

```bash
grep -n "Jenkins Phase 3" \
02-jenkins/phase-3-declarative-pipeline/app/index.html

grep -n "Declarative Pipeline with Jenkinsfile" \
02-jenkins/phase-3-declarative-pipeline/app/index.html

grep -n "Pipeline Successful" \
02-jenkins/phase-3-declarative-pipeline/app/index.html
```

### Solution

Restore the exact required values:

```html
<h1>Jenkins Phase 3</h1>

<h2>Declarative Pipeline with Jenkinsfile</h2>

<div class="status">Pipeline Successful</div>
```

Commit and push the correction before rebuilding.

---

## Potential Issue 7 — GitHub Repository Access Failed

### Possible Error

```text
Failed to connect to repository
```

or:

```text
Could not read from remote repository
```

### Possible Causes

- Incorrect repository URL.
- Jenkins server has no internet access.
- GitHub is temporarily unreachable.
- Private repository credentials are missing.

### Solution

Confirm the repository URL:

```text
https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git
```

Test GitHub connectivity from the Jenkins EC2 server:

```bash
git ls-remote \
https://github.com/anshu-sharma-devops/key-learning-of-cloud-and-devops.git
```

Because this repository is public, Jenkins credentials can remain:

```text
- none -
```

---

## Potential Issue 8 — Jenkins URL Does Not Open After Restart

### Problem

The same Jenkins EC2 instance is reused across all learning phases. Its previous URL may stop working after the instance is restarted.

### Root Cause

The EC2 public IPv4 address normally changes after a stop/start cycle.

### Solution

Check the current public IP from the AWS Console or AWS CLI:

```bash
aws ec2 describe-instances \
  --instance-ids YOUR_INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text
```

Open Jenkins using:

```text
http://NEW_PUBLIC_IP:8080
```

Confirm that the EC2 security group allows inbound TCP port `8080` from the trusted source IP.

---

## Potential Issue 9 — Jenkins Service Is Not Running

### Diagnosis

Connect to the EC2 instance and run:

```bash
sudo systemctl is-active jenkins
```

Expected:

```text
active
```

For detailed information:

```bash
sudo systemctl status jenkins --no-pager
```

### Solution

If Jenkins is installed but stopped:

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

Check again:

```bash
sudo systemctl is-active jenkins
```

---

## 🔍 Useful Diagnostic Commands

### Check Jenkins

```bash
sudo systemctl status jenkins --no-pager
```

### Check port 8080

```bash
sudo ss -tulpn | grep :8080
```

### Check the latest Git commit

```bash
git log -1 --oneline
```

### Check the project files

```bash
tree 02-jenkins/phase-3-declarative-pipeline
```

### Check uncommitted changes

```bash
git status
```

### Check required HTML content

```bash
grep -nE \
"Jenkins Phase 3|Declarative Pipeline with Jenkinsfile|Pipeline Successful" \
02-jenkins/phase-3-declarative-pipeline/app/index.html
```

---

## 🧠 Troubleshooting Summary

| Check | Result |
|---|---|
| Jenkinsfile retrieved from GitHub | ✅ Passed |
| Git repository checkout | ✅ Passed |
| Latest commit displayed | ✅ Passed |
| Application directory validation | ✅ Passed |
| `index.html` validation | ✅ Passed |
| Required HTML content tests | ✅ Passed |
| Build summary stage | ✅ Passed |
| Success post action | ✅ Passed |
| Always post action | ✅ Passed |
| Final pipeline result | ✅ SUCCESS |

---

## ✅ Conclusion

Jenkins Phase 3 completed without a major implementation error.

The troubleshooting process focused on verifying each important connection and pipeline component:

```text
GitHub access
    ↓
Jenkinsfile retrieval
    ↓
Repository checkout
    ↓
Pipeline syntax
    ↓
Application structure
    ↓
HTML content
    ↓
Post actions
    ↓
Successful result
```

These checks provide a reusable troubleshooting reference for future Jenkins Declarative Pipelines.

---

<div align="center">

**Jenkins Phase 3 Troubleshooting Completed**

*Documented by Anshu Sharma*

</div>