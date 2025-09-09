terraform {
  backend "s3" {
    bucket         = "lz-tf-state-<org-uniq>"
    key            = "global/landing-zone.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "lz-tf-locks"
    encrypt        = true
  }
}