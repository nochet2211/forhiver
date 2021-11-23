variable "region" {
    default = "us-east-1"  
}

variable "sg_config" {
    type    = object({
    name = string
  })
  default = {
    name = "default_name"
  }
}

variable "ec2_config" {
    type    = object({
    count = number
    ami = string
    instance_type = string
    name = string
  })
  default = {
    count = 2
    ami = "ami-04902260ca3d33422"
    instance_type = "t3.large"
    name = "prod-web-server"
  }
}