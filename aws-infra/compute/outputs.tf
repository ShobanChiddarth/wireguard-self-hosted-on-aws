output "bastion_public_ip" {
    value = aws_instance.bastion.public_ip
}

output "private_webserver_private_ip" {
    value = aws_instance.private_webserver.private_ip
}
