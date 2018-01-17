
## Create EC2 Instances

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

resource "aws_security_group" "monitoring_sg" {
	name = "${var.project_name}-Monitoring-SG"
	description = "Security group for monitoring servers"
	vpc_id = "${var.vpc}"
	
	# SSH 
	ingress {
		from_port 	= 22
		to_port		= 22
		protocol	= "tcp"
		security_groups = ["${aws_security_group.bastion_sg.id}"]
		description = "SSH"
	}
	
	# HTTP for Nagios
	ingress {
		from_port 	= 80
		to_port		= 80
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "HTTP for Nagios"
	}
	
	# Elasticsearch 
	ingress {
		from_port 	= 9200
		to_port		= 9200
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "Elasticsearch"
	}
	
	# Logstash 
	ingress {
		from_port 	= 5043
		to_port		= 5043
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "Logstash"
	}
	
	# Kibana 
	ingress {
		from_port 	= 5601
		to_port		= 5601
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "Kibana"
	}
	
	# Nagios NRPE  
	ingress {
		from_port 	= 5666
		to_port		= 5666
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "Nagios NRPE"
	}

}