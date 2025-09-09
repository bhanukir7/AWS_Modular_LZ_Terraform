provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

module "networking" {
  source          = "../../modules/networking"
  name            = "dev-shared"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  create_tgw      = false
  tags            = var.tags
}

module "monitoring" {
  source            = "../../modules/monitoring-logging"
  alarm_topic_email = var.alarm_email
  tags              = var.tags
}