variable "domain" {
}

variable "origin" {
}

variable "cache_allowed_methods" {
  type        = list(string)
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
  type    = list(string)
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

variable "default_ttl" {
  description = "(Optional) The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day."
  default     = "86400"
}

variable "max_ttl" {
  description = " (Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days."
  default     = "31536000"
}

variable "min_ttl" {
  description = "(Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  default     = "0"
}

