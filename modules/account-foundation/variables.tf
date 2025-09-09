variable "org_feature_set" { type = string, default = "ALL" }
variable "account_email_domain" { type = string }
variable "accounts" {
  description = "Map of accounts to create: { name = string, email_prefix = string }"
  type = map(object({
    name         = string
    email_prefix = string
    parent_ou_id = optional(string)
  }))
}
variable "enable_sso" { type = bool, default = true }
variable "tags" { type = map(string), default = {} }