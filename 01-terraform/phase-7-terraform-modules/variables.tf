variable "aws_region" {}

variable "vpc_cidr" {}
variable "vpc_name" {}

variable "public_subnet_cidr" {}
variable "public_subnet_name" {}
variable "availability_zone" {}

variable "igw_name" {}
variable "route_table_name" {}

variable "security_group_name" {}

variable "allowed_ssh_cidr" {}
variable "allowed_http_cidr" {}
variable "allowed_jenkins_cidr" {}

variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "instance_name" {}