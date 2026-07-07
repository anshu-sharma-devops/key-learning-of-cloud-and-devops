output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "route_table_id" {
  value = module.vpc.route_table_id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "jenkins_instance_id" {
  value = module.jenkins_server.instance_id
}

output "jenkins_public_ip" {
  value = module.jenkins_server.public_ip
}

output "jenkins_url" {
  value = "http://${module.jenkins_server.public_ip}:8080"
}