output "bastion_public_ip" {
    value = module.compute.bastion_public_ip
}

output "private_webserver_private_ip" {
    value = module.compute.private_webserver_private_ip
}

output "wg_public_ip" {
    value = module.compute.wg_public_ip
}
