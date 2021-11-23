variable "sg_config" {
    type    = object({
    name = string
  })
  default = {
    name = "default_name"
  }
}