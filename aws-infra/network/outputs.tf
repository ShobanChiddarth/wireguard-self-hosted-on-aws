output "vpc_id" {
    value = aws_vpc.WGDemoVPC.id
}

output "vpc_cidr" {
    value = aws_vpc.WGDemoVPC.cidr_block
}

output "public_subnet_id" {
    value = aws_subnet.WGDemoPublicSubnet.id
}

output "private_subnet_id" {
    value = aws_subnet.WGDemoPrivateSubnet.id
}
