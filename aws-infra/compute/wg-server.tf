# TODO: replace wireguard with netbird

locals {
    wg_init = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get upgrade -y

    apt-get install wireguard -y
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    sysctl -p

    # will replace wireguard with netbird
EOF
}

resource "aws_security_group" "wg_sg" {
    name = "wg_sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 51820
        to_port = 51820
        protocol = "udp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.bastion_sg.id ]
        description = "remove this rule later"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_instance" "wg_server" {
    ami = var.ubuntu_ami_id
    instance_type = "t3.micro"
    subnet_id = var.public_subnet_id
    # associate_public_ip_address = true
    user_data = local.wg_init
    vpc_security_group_ids = [ aws_security_group.wg_sg.id ]
    key_name = var.management_key_name
    source_dest_check = false

    tags = {
        Name = "wg_server"
    }
}

resource "aws_eip" "wg_eip" {
    instance = aws_instance.wg_server.id
    domain = "vpc"

    tags = {
        Name = "wg_eip"
    }
}
