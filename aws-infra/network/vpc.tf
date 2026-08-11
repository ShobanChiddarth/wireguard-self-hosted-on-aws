resource "aws_vpc" "WGDemoVPC" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "WGDemoVPC"
    }
}

resource "aws_internet_gateway" "WGDemoIGW" {
    vpc_id = aws_vpc.WGDemoVPC.id

    tags = {
        Name = "WGDemoIGW"
    }
}
