variable "trail_name" { type = string, default = "org-trail" }
variable "log_bucket_name" { type = string }
variable "force_destroy" { type = bool, default = false }
variable "tags" { type = map(string), default = {} }