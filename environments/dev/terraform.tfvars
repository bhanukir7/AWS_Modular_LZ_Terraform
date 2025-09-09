region          = "ap-south-1"
aws_profile     = "lz-dev"
vpc_cidr        = "10.30.0.0/16"
public_subnets  = ["10.30.0.0/24", "10.30.1.0/24"]
private_subnets = ["10.30.10.0/24", "10.30.11.0/24"]
alarm_email     = "devops@example.com"
tags = { environment = "dev", costcenter = "cc-002" }