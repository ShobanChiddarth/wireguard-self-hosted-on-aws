output "bastion_public_ip" {
    value = module.compute.bastion_public_ip
}

output "private_webserver_private_ip" {
    value = module.compute.private_webserver_private_ip
}

output "wg_public_ip" {
    value = module.compute.wg_public_ip
}

output "nat_instance_public_ip" {
    value = module.compute.nat_instance_public_ip
}

output "wg_private_ip" {
    value = module.compute.wg_private_ip
}
