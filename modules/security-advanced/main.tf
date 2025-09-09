resource "aws_s3_bucket" "config" {
  bucket        = var.config_delivery_bucket
  force_destroy = false
  tags          = var.tags
}

resource "aws_iam_role" "config" {
  name = "AWSConfigRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "config.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "config_attach" {
  role       = aws_iam_role.config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_config_configuration_recorder" "rec" {
  name     = "default"
  role_arn = aws_iam_role.config.arn
}

resource "aws_config_delivery_channel" "dc" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.config.bucket
  depends_on     = [aws_config_configuration_recorder.rec]
}

resource "aws_config_configuration_recorder_status" "status" {
  name       = aws_config_configuration_recorder.rec.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.dc]
}

resource "aws_guardduty_detector" "this" { enable = true }

resource "aws_securityhub_account" "this" {}

resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:::standards/cis-aws-foundations-benchmark/v/1.4.0"
  depends_on    = [aws_securityhub_account.this]
}

resource "aws_xray_sampling_rule" "default" {
  rule_name      = "default"
  priority       = 10000
  reservoir_size = 10
  service_name   = "*"
  service_type   = "*"
  http_method    = "*"
  url_path       = "*"
  fixed_rate     = 0.05
}

output "config_bucket" { value = aws_s3_bucket.config.bucket }