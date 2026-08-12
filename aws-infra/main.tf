provider "aws" {
    region = "ap-south-1"
}

data "aws_region" "current" {
  
}

module "network" {
    source = "./network"
}

module "compute_data" {
    source = "./compute_data"
}

module "compute" {
    source = "./compute"

    private_subnet_id = module.network.private_subnet_id
    public_subnet_id = module.network.public_subnet_id
    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr

    bastion_key_name = module.compute_data.bastion_key_name
    management_key_name = module.compute_data.management_key_name

    my_public_ip = var.my_public_ip
    ubuntu_ami_id = module.compute_data.ubuntu_ami_id

    current_region_name = data.aws_region.current.name

    depends_on = [ module.network ] # for NAT instance EIP -> IGW dependency
}
