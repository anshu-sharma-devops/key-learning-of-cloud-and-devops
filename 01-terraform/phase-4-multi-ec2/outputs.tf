output "jenkins_server_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "app_server_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "jenkins_ssh_command" {
  value = "ssh -i ~/Downloads/jenkins-key.pem ubuntu@${aws_instance.jenkins_server.public_ip}"
}

output "app_server_ssh_command" {
  value = "ssh -i ~/Downloads/jenkins-key.pem ubuntu@${aws_instance.app_server.public_ip}"
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}