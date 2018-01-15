provider "aws" {
	access_key = "${var.access_key}"
	secret_key = "${var.secret_key}"
	region     = "${var.region}"
}



## Create EC2 Instances

resource "aws_instance" "monitoring1" {
	instance_type = "${var.instance_type}"
	ami = "${var.instance_ami}"
	tags {
		Name = "Monitoring-01"
	}

	key_name = "${var.key_pair_name}"
	vpc_security_group_ids = ["${aws_security_group.monitoring_sg.id}"]
	subnet_id = "${var.subnet}"
	disable_api_termination = "true"
}	


## Create Security Group

resource "aws_security_group" "monitoring_sg" {
	name = "Monitoring-SG"
	description = "Used as the security group for monitoring servers"
	vpc_id = "$(vars.vpc)"
	
	# SSH 
	ingress {
		from_port 	= 22
		to_port		= 22
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
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
