output "vpc_id" {
    value = aws_vpc.WGDemoVPC.id
}

output "vpc_cidr" {
    value = aws_vpc.WGDemoVPC.cidr_block
}
