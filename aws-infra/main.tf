provider "aws" {
    region = "ap-south-1"
}

module "network" {
    source = "./network"
}

module "compute_data" {
    source = "./compute_data"
}

module "nat_instance" {
    source = "./nat_instance"

    vpc_id = module.network.vpc_id
    vpc_cidr_block = module.network.vpc_cidr
    public_subnet_id = module.network.public_subnet_id
    private_subnet_id = module.network.private_subnet_id

    management_key_name = module.compute_data.management_key_name
    ubuntu_ami_id = module.compute_data.ubuntu_ami_id

    depends_on = [ module.network ] # for EIP -> IGW dependency
}
