provider "aws" {
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region     = "${var.region}"
}




## Create EC2 Instances

resource "aws_instance" "bastion" {
	instance_type = "${var.bastion_instance_type}"
	ami = "${var.instance_ami}"
	tags {
		Name = "${var.project_name}-Bastion-01"
	}

	key_name = "${var.bastion_key_pair_name}"
	vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]
	subnet_id = "${var.subnet_1}"
#	disable_api_termination = "true"
}

resource "aws_instance" "monitoring1" {
	instance_type = "${var.monitoring_instance_type}"
	ami = "${var.instance_ami}"
	tags {
		Name = "${var.project_name}-Monitoring-01"
	}

	key_name = "${var.key_pair_name}"
	vpc_security_group_ids = ["${aws_security_group.monitoring_sg.id}"]
	subnet_id = "${var.subnet_1}"
#	disable_api_termination = "true"
}	


## Create Security Group

resource "aws_security_group" "bastion_sg" {
	name = "${var.project_name}-Bastion-SG"
	description = "Security group for Baston server"
	vpc_id = "${var.vpc}"
	
	#SSH 
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "SSH"
	}
}


resource "aws_security_group" "monitoring_sg" {
	name = "${var.project_name}-Monitoring-SG"
	description = "Security group for monitoring servers"
	vpc_id = "${var.vpc}"
	
	# SSH 
	ingress {
		from_port 	= 22
		to_port		= 22
		protocol	= "tcp"
		cidr_blocks = "${aws_security_group.bastion_sg.id}"
	}
	
	# HTTP for Nagios
	ingress {
		from_port 	= 80
		to_port		= 80
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	# Elasticsearch 
	ingress {
		from_port 	= 9200
		to_port		= 9200
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	# Logstash 
	ingress {
		from_port 	= 5043
		to_port		= 5043
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	# Kibana 
	ingress {
		from_port 	= 5601
		to_port		= 5601
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	# Nagios NRPE  
	ingress {
		from_port 	= 5666
		to_port		= 5666
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

}
