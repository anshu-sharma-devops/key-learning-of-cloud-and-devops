## Issue 1: Jenkins repository GPG key error

### Error

E: The repository 'https://pkg.jenkins.io/debian-stable binary/ Release' is not signed.

### Cause

The Jenkins signing key was not installed correctly.

### Solution

Re-imported the official Jenkins GPG key:

```bash
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null



Issue 2: Unable to access Jenkins on port 8080
Cause
Security Group did not allow inbound traffic on port 8080.

Solution
Added a Custom TCP rule for port 8080 in the EC2 Security Group.

￼
