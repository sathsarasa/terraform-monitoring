
variable "access_key" {}
variable "secret_key" {}

variable "project_name" {
	default = "SathsaraMCX"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc" {
	default = "vpc-ccfa32aa"
}

variable "subnet_1" {
	default = "subnet-1396ed5a"
}

variable "subnet_2" {
	default = "subnet-cfa42994"
}

variable "bastion_key_pair_name" {
	default = "sathsara-k8s"
}

variable "key_pair_name" {
	default = "sathsara-k8s"
}

variable "bastion_instance_type" {
	default = "t2.micro"
}

variable "monitoring_instance_type" {
	default = "t2.micro"
}

variable "nginx_instance_type" {
	default = "t2.micro"
}

variable "instance_ami" {
	default = "ami-41e0b93b"
}
