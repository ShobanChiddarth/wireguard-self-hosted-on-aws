provider "aws" {
    region = "ap-south-1"
}

module "network" {
    source = "./network"
}
