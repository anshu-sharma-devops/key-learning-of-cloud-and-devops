output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "instance_id" {
  value = aws_instance.web_server.id
}

output "ssh_command" {
  value = "ssh -i ~/Downloads/jenkins-key.pem ubuntu@${aws_instance.web_server.public_ip}"
}