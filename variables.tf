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

variable "forward_headers" {
  type    = "list"
  default = []
}

variable "forward_cookies" {
  description = "Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names"
  default     = "none"
}

variable "forward_cookies_whitelist" {
  description = "(Optional) - If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin."
  default     = [""]
}
