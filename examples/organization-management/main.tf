module "account_foundation" {
  source               = "../../modules/account-foundation"
  account_email_domain = "example.com"
  accounts = {
    security      = { name = "Security",      email_prefix = "security" }
    infrastructure= { name = "Infrastructure", email_prefix = "infrastructure" }
    app_prod      = { name = "App-Prod",      email_prefix = "app-prod" }
    app_dev       = { name = "App-Dev",       email_prefix = "app-dev" }
  }
  tags = { environment = "shared", owner = "platform" }
}