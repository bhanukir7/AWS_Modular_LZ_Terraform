variable "log_group_names" { type = list(string), default = ["/lz/app", "/lz/platform"] }
variable "alarm_topic_email" { type = string }
variable "tags" { type = map(string), default = {} }