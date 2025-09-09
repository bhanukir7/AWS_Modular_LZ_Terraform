variable "name" { type = string }
variable "vpc_cidr" { type = string }
variable "az_count" { type = number, default = 2 }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "create_tgw" { type = bool, default = false }
variable "tgw_description" { type = string, default = "Landing Zone TGW" }
variable "tags" { type = map(string), default = {} }