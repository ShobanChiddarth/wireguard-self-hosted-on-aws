provider "aws" {
    region = "ap-south-1"
}

module "network" {
    source = "./network"
}

module "compute_data" {
    source = "./compute_data"
}
