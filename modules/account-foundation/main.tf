resource "aws_organizations_organization" "this" {
  feature_set = var.org_feature_set
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "guardduty.amazonaws.com",
    "securityhub.amazonaws.com"
  ]
  tags = var.tags
}

resource "aws_organizations_account" "acct" {
  for_each = var.accounts
  name     = each.value.name
  email    = "${each.value.email_prefix}@${var.account_email_domain}"
  tags     = merge(var.tags, { "lz:account" = each.value.name })
}

output "account_ids" {
  value = { for k, v in aws_organizations_account.acct : k => v.id }
}