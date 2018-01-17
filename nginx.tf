
## Create EC2 Instances

resource "aws_instance" "nginx" {
	instance_type = "${var.nginx_instance_type}"
	ami = "${var.instance_ami}"
	tags {
		Name = "${var.project_name}-Nginx-01"
	}

	key_name = "${var.key_pair_name}"
	vpc_security_group_ids = ["${aws_security_group.nginx_sg.id}"]
	subnet_id = "${var.subnet_1}"
#	disable_api_termination = "true"
}


## Create Security Group

resource "aws_security_group" "nginx_sg" {
	name = "${var.project_name}-Nginx-SG"
	description = "Security group for nginx servers"
	vpc_id = "${var.vpc}"
	
	# SSH 
	ingress {
		from_port 	= 22
		to_port		= 22
		protocol	= "tcp"
		security_groups = ["${aws_security_group.bastion_sg.id}"]
		description = "SSH"
	}
	
	# HTTP 
	ingress {
		from_port 	= 80
		to_port		= 80
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "HTTP"
	}
	
	# HTTPS 
	ingress {
		from_port 	= 9200
		to_port		= 9200
		protocol	= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		description = "HTTPS"
	}
}
