Issue:
Jenkins service was not found after Terraform deployment.

Error:
Unit jenkins.service could not be found.

Root Cause:
The Jenkins APT repository signing key used in the user_data script was outdated. During EC2 initialization, apt refused to install Jenkins because the repository signature could not be verified.

Resolution:
- Removed the old Jenkins repository configuration.
- Downloaded the current Jenkins signing key.
- Reconfigured the Jenkins repository.
- Ran apt update.
- Installed Jenkins successfully.
- Started and enabled the Jenkins service.