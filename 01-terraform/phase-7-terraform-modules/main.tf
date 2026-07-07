module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  public_subnet_name = var.public_subnet_name
  availability_zone  = var.availability_zone
  igw_name           = var.igw_name
  route_table_name   = var.route_table_name
}

module "security_group" {
  source = "./modules/security-group"

  security_group_name  = var.security_group_name
  vpc_id               = module.vpc.vpc_id
  allowed_ssh_cidr     = var.allowed_ssh_cidr
  allowed_http_cidr    = var.allowed_http_cidr
  allowed_jenkins_cidr = var.allowed_jenkins_cidr
}

module "jenkins_server" {
  source = "./modules/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
  instance_name     = var.instance_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y openjdk-17-jdk wget gnupg

              wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list

              apt update -y
              apt install -y jenkins

              systemctl enable jenkins
              systemctl start jenkins
              EOF
}