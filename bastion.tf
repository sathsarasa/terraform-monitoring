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
