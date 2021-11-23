resource "aws_instance" "ec2" {
  # for_each      = module.private_subnets.subnet_ids
  count         = var.ec2_config.count
  subnet_id     = module.private_subnets.subnet_ids[count.index]
  ami           = var.ec2_config.ami
  instance_type = var.ec2_config.instance_type
  vpc_security_group_ids = [var.sg_id]
  tags          = {
    Name = "${var.ec2_config.name}-${count.index + 1}"
  }
}
resource "aws_lb" "nlb" {
  internal           = false
  load_balancer_type = "network"
  subnets            = module.private_subnets.subnet_ids
  tags = {
    Name = "${var.ec2_config.name}"
  }
}
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
      
  }
}
resource "aws_lb_target_group" "this" {
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_default_vpc.default_vpc.id
}

resource "aws_lb_target_group_attachment" "this" {
  count            = var.ec2_config.count
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = "${element(aws_instance.ec2.*.id, count.index)}"
  port             = 80
}

module "private_subnets" {
  source  = "claranet/vpc-modules/aws//modules/private-subnets"
  version = "1.1.1"

  vpc_id             = aws_default_vpc.default_vpc.id
  cidr_block         = cidrsubnet(data.aws_vpc.this.cidr_block, 4, 15)
  subnet_count       = 2
  availability_zones = ["${var.region}a", "${var.region}b"]
}
data "aws_vpc" "this" {
  id = aws_default_vpc.default_vpc.id
}

resource "aws_default_vpc" "default_vpc" {
}