provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

module "security_baseline" {
  source          = "../../modules/security-baseline"
  trail_name      = "org-trail"
  log_bucket_name = var.trail_bucket_name
  tags            = var.tags
}

module "networking" {
  source          = "../../modules/networking"
  name            = "prod-shared"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  create_tgw      = true
  tags            = var.tags
}

module "monitoring" {
  source            = "../../modules/monitoring-logging"
  alarm_topic_email = var.alarm_email
  tags              = var.tags
}

module "security_advanced" {
  source                 = "../../modules/security-advanced"
  config_delivery_bucket = var.config_bucket_name
  tags                   = var.tags
}