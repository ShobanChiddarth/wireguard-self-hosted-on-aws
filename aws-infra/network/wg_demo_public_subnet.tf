resource "aws_subnet" "WGDemoPublicSubnet" {
    vpc_id = aws_vpc.WGDemoVPC.id
    cidr_block = "10.0.0.0/24"

    tags = {
        Name = "WGDemoPublicSubnet"
    }
}

resource "aws_route_table" "to_igw" {
    vpc_id = aws_vpc.WGDemoVPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.WGDemoIGW.id
    }

    tags = {
        Name = "to_igw"
    }
}

resource "aws_route_table_association" "to_igw_rt_assoc" {
    subnet_id = aws_subnet.WGDemoPublicSubnet.id
    route_table_id = aws_route_table.to_igw.id
}
