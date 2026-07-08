resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Phase 8 Production Infrastructure - Dev Environment</h1>" > /var/www/html/index.html
              echo "<p>Deployed using Terraform Modules and Environment-Based Structure</p>" >> /var/www/html/index.html
              EOF

  tags = {
    Name        = "${var.project_name}-${var.environment}-web-server"
    Project     = var.project_name
    Environment = var.environment
  }
}