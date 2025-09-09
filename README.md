# Modular AWS Landing Zone with Terraform

## Purpose
A modular Terraform implementation of an AWS Landing Zone. Each module can be rolled out independently and updated in-place. Works in a multi-account AWS Organizations setup.

## Prereqs
- AWS CLI configured with Organization Management account admin credentials.
- Terraform >= 1.6.
- A remote state backend (S3 + DynamoDB) bootstrapped once.

### Bootstrap remote state (run once)
```bash
AWS_REGION=ap-south-1
STATE_BUCKET="lz-tf-state-<org-uniq>"
LOCK_TABLE="lz-tf-locks"
aws s3api create-bucket --bucket "$STATE_BUCKET" --create-bucket-configuration LocationConstraint=$AWS_REGION --region $AWS_REGION
aws s3api put-bucket-versioning --bucket "$STATE_BUCKET" --versioning-configuration Status=Enabled
aws dynamodb create-table   --table-name "$LOCK_TABLE"   --attribute-definitions AttributeName=LockID,AttributeType=S   --key-schema AttributeName=LockID,KeyType=HASH   --billing-mode PAY_PER_REQUEST   --region $AWS_REGION
```

Copy `backend.example.tf` to `backend.tf` and edit bucket/table names.

## Deploy order
1. `modules/account-foundation` from the **management account**.
2. `modules/security-baseline` in the **security account**.
3. `modules/networking` in the **infrastructure/shared services account**.
4. `modules/monitoring-logging` in the **security or shared** account.
5. `modules/security-advanced` in the **security account**.

Use the example stacks under `environments/<env>` to orchestrate.

## Apply (per environment)
```bash
cd environments/prod
terraform init
terraform plan -out plan.tfplan
terraform apply plan.tfplan
```

## Destroy
Do not destroy org-wide resources casually. If needed:
```bash
env TF_VAR_allow_destroy=true terraform destroy
```
