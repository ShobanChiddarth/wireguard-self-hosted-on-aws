# TODO:
# :22 must be open to bastion, VPC CIDR
# :80 must be open to VPC CIDR
# later :22 must be be open to only VPC CIDR

locals {
    private_webserver_init = <<-EOF
    #!/bin/bash

    echo 'Acquire::ForceIPv4 "true";' > /etc/apt/apt.conf.d/99force-ipv4

    until curl -sf --max-time 5 http://${var.current_region_name}.ec2.archive.ubuntu.com > /dev/null; do
        sleep 5
    done

    apt-get update
    apt-get upgrade -y
    apt-get install -y nginx

    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Private Webserver</title>
    </head>
    <body>
        <h1>Webserver is accessible only to LAN</h1>
        <h3>If you are seeing this you are in the LAN</h3>
    </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl restart nginx
EOF
}


resource "aws_security_group" "private_webserver_sg" {
    name = "private_webserver_sg"
    vpc_id = var.vpc_id


    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ var.vpc_cidr_block ]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [ aws_security_group.bastion_sg.id ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.vpc_cidr_block ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

resource "aws_instance" "private_webserver" {
    ami = var.ubuntu_ami_id
    instance_type = "t3.micro"
    subnet_id = var.private_subnet_id

    user_data = local.private_webserver_init
    vpc_security_group_ids = [ aws_security_group.private_webserver_sg.id ]
    key_name = var.management_key_name

    tags = {
        Name = "private_webserver"
    }
}
