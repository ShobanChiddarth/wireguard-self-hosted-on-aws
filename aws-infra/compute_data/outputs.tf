output "ubuntu_ami_id" {
    value = data.aws_ami.ubuntu.id
}

output "bastion_key_name" {
    value = aws_key_pair.bastion_key_pair.key_name
}

output "management_key_name" {
    value = aws_key_pair.management_key_pair.key_name
}
