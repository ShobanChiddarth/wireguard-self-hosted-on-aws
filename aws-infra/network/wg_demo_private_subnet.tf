resource "aws_subnet" "WGDemoPrivateSubnet" {
    vpc_id = aws_vpc.WGDemoVPC.id
    cidr_block = "10.0.1.0/24"

    tags = {
        Name = "WGDemoPrivateSubnet"
    }
}

