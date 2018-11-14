variable "domain" {}

variable "origin" {}

variable "cache_allowed_methods" {
  type        = "list"
  default     = ["HEAD", "GET"]
  description = "Cache allowed methods - allowed values are [HEAD, GET] or [HEAD, GET, OPTIONS] or [HEAD, DELETE, POST, GET, OPTIONS, PUT, PATCH]"
}

variable "forward_query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin"
  default     = false
}

variable "web_acl_id" {
  default     = ""
  description = "(Optional) The Id of the AWS WAF web ACL that is associated with the distribution."
}
