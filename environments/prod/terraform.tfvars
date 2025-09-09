region            = "ap-south-1"
aws_profile       = "lz-prod"
trail_bucket_name = "lz-org-trail-logs-<uniq>"
config_bucket_name= "lz-config-logs-<uniq>"
vpc_cidr          = "10.20.0.0/16"
public_subnets    = ["10.20.0.0/24", "10.20.1.0/24"]
private_subnets   = ["10.20.10.0/24", "10.20.11.0/24"]
alarm_email       = "secops@example.com"
tags = { environment = "prod", costcenter = "cc-001" }