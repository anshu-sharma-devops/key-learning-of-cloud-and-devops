output "vpc_id" {
  value = aws_vpc.devops_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "route_table_id" {
  value = aws_route_table.public_rt.id
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}

output "instance_id" {
  value = aws_instance.web_server.id
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/Downloads/jenkins-key.pem ubuntu@${aws_instance.web_server.public_ip}"
}