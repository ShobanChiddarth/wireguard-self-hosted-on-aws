output "bastion_public_ip" {
    value = aws_instance.bastion.public_ip
}

output "private_webserver_private_ip" {
    value = aws_instance.private_webserver.private_ip
}

output "wg_public_ip" {
    value = aws_eip.wg_eip.public_ip
}

output "nat_instance_public_ip" {
    value = aws_eip.nat_instance_eip.public_ip
}

output "wg_private_ip" {
    value = aws_instance.wg_server.private_ip
}
