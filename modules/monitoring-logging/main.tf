resource "aws_cloudwatch_log_group" "lg" {
  for_each          = toset(var.log_group_names)
  name              = each.value
  retention_in_days = 90
  tags              = var.tags
}

resource "aws_sns_topic" "alarms" {
  name = "lz-alarms"
  tags = var.tags
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.alarm_topic_email
}

resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "lz-example-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Example EC2 CPU high"
  alarm_actions       = [aws_sns_topic.alarms.arn]
}

output "alarm_topic_arn" { value = aws_sns_topic.alarms.arn }