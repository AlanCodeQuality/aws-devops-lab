resource "aws_instance" "website_server" {
  ami           = "ami-098e39bafa7e7303d" #Amazon Linux 2 AMI 
  instance_type = "t2.micro"
  key_name = "chave-site-prod"
  vpc_security_group_ids = [aws_security_group.website_sg.id]
  iam_instance_profile = "ECR-EC2-Role"

  tags = {
    Name = "website-server"
    Provisioned = "Terraform"
    Cliente = "Maria"
  }
}

resource "aws_security_group" "website_sg" {
  name        = "website_sg"
  vpc_id      = "vpc-0063859106005c800"



  tags = {
    Name = "website_sg"
    Provisioned = "Terraform"
    Cliente = "Maria"

  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "138.185.145.130/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.website_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.website_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
