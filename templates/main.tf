module "main_security_group" {
    source = "../modules/security_group"
    sg_config = var.sg_config
}

module "ec2" {
    source = "../modules/ec2"
    region = var.region
    ec2_config = var.ec2_config
    sg_id = module.main_security_group.sg_id
}