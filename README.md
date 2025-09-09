# 🚀 AWS Modular Landing Zone (Terraform)

[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D%201.6-blue)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Organizations-orange)](https://aws.amazon.com/organizations/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A **modular Terraform implementation of an AWS Landing Zone**.  
Provides a secure, scalable, and compliant foundation for **multi-account AWS deployments**.

---

## 🏗️ Architecture

This solution uses a **modular design**:
- Accounts and AWS Organizations
- Centralized Security Services (CloudTrail, Config, GuardDuty, Security Hub)
- Networking (VPCs, Subnets, Transit Gateway)
- Monitoring & Logging (CloudWatch, SNS, Alarms)
- Advanced Security (Config, X-Ray)

> Add an architecture diagram here for clarity:
>
> ```markdown
> ![AWS Modular Landing Zone](docs/diagram.png)
> ```

---

## 📂 Repository Structure

```text
├─ environments/               # Environment-specific configs (dev, prod)
├─ examples/                   # Example stacks (org management)
├─ modules/                    # Modular Terraform building blocks
│  ├─ account-foundation/      # AWS Org + accounts
│  ├─ security-baseline/       # CloudTrail, KMS, S3 logs
│  ├─ networking/              # VPCs, subnets, TGW
│  ├─ monitoring-logging/      # CloudWatch, SNS, Alarms
│  └─ security-advanced/       # Config, GuardDuty, Security Hub, X-Ray
├─ backend.example.tf          # Remote state backend template
├─ providers.tf                # AWS provider config
├─ versions.tf                 # Terraform version and providers
└─ README.md

| Module               | Purpose                                   |
| -------------------- | ----------------------------------------- |
| `account-foundation` | AWS Org + Accounts + IAM setup            |
| `security-baseline`  | CloudTrail, S3 logs, KMS                  |
| `networking`         | VPCs, Subnets, Transit Gateway            |
| `monitoring-logging` | CloudWatch Logs, Alarms, SNS              |
| `security-advanced`  | AWS Config, GuardDuty, SecurityHub, X-Ray |

🚀 Quick Start
Prerequisites

AWS CLI configured with Org Management account admin credentials.

Terraform >= 1.6.

Remote state backend (S3 + DynamoDB) bootstrapped once.

Bootstrap Remote State
AWS_REGION=ap-south-1
STATE_BUCKET="lz-tf-state-<org-uniq>"
LOCK_TABLE="lz-tf-locks"

aws s3api create-bucket --bucket "$STATE_BUCKET" \
  --create-bucket-configuration LocationConstraint=$AWS_REGION \
  --region $AWS_REGION

aws s3api put-bucket-versioning --bucket "$STATE_BUCKET" \
  --versioning-configuration Status=Enabled

aws dynamodb create-table \
  --table-name "$LOCK_TABLE" \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region $AWS_REGION

Deploy Order

Account Foundation (Org, Accounts, IAM)

Security Baseline (CloudTrail, Logs, KMS)

Networking (VPCs, Subnets, TGW)

Monitoring & Logging

Advanced Security (Config, GuardDuty, Security Hub, X-Ray)

Example Apply
cd environments/prod
terraform init
terraform plan -out plan.tfplan
terraform apply plan.tfplan

⚠️ Notes

Run organization-management example first in the management account.

Then switch profiles/roles and apply environments/dev or environments/prod.

Bucket names must be globally unique.

Add SCPs and IAM Identity Center integration if required.

📜 License

This project is licensed under the MIT License
.
