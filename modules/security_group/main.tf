resource "aws_security_group" "sg_module" {
  name        = var.sg_config.name
  description = "Security Group for Default VPC that allows access to TCP port 80 and 443 from anywhere"
  vpc_id      = aws_default_vpc.default_vpc.id
  revoke_rules_on_delete = true

  ingress {
    description      = "443 tcp from anywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "80 tcp from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.sg_config.name
  }
}
output "sg_id" {
  value = aws_security_group.sg_module.id
}
resource "aws_default_vpc" "default_vpc" {
}