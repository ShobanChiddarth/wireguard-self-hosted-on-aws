variable "public_subnet_id" {
    type = string
}

variable "private_subnet_id" {
    type = string
}

variable "bastion_key_name" {
    type = string
}

variable "management_key_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "vpc_cidr_block" {
    type = string
}

variable "my_public_ip" {
    type = string
}

variable "ubuntu_ami_id" {
    type = string
}

variable "current_region_name" {
    type = string
}
