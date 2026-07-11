sudo apt update
sudo apt install git -y
sudo apt install fontconfig openjdk-21-jre -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | ...

sudo apt install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword