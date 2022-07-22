data "aws_ip_ranges" "mumbai_ec2" {
  regions = ["ap-south-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from_mumbai" {
    name="from_mumbai"
  ingress = {
    from_port="443"
    to_port="443"
    protocol="tcp"
    cidr_blocks= slice(data.aws_ip_ranges.mumbai_ec2.cidr_blocks, 0, 50) #mumbai_ec2.cidr_blocks is a attribute

  }

#    ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [aws_vpc.main.cidr_block]
#     ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
#   }


  tags = {
    CreateDate="${data.aws_ip_ranges.mumbai_ec2.create_date}"
    SyncToken="${data.aws_ip_ranges.mumbai_ec2.sync_token}"
  }
}