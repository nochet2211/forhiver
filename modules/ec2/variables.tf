variable "ec2_config" {
    type    = object({
    ami = string
    instance_type = string
    name = string
    count = number
  })
  default = {
    count = 0
    ami = "default_ami"
    instance_type = "t3.micro"
    name = "default_name"
  }
}

variable "sg_id" {
  default = "sg_default"
}

variable "region" {
  default = "default_region"
}