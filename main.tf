resource "aws_s3_bucket" "logs" {
  bucket_prefix = "cdnlogs-${substr(var.domain, 0, 28)}-"
  acl           = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# We expect the certificate for this domain to already be in ACM
data "aws_acm_certificate" "domain" {
  provider = "aws.us_east_aws"
  domain   = "${var.domain}"
  statuses = ["ISSUED"]
}

resource "aws_cloudfront_distribution" "distribution" {
  aliases = ["${var.domain}"]

  origin {
    domain_name = "${var.origin}"
    origin_id   = "${var.domain}"

    custom_origin_config {
      http_port  = 80
      https_port = 443

      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  web_acl_id = "${var.web_acl_id}"

  logging_config {
    include_cookies = false

    bucket = "${aws_s3_bucket.logs.bucket_domain_name}"
  }

  default_cache_behavior {
    allowed_methods  = "${var.cache_allowed_methods}"
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.domain}"

    forwarded_values {
      query_string = "${var.forward_query_string}"
      headers      = "${var.forward_headers}"

      cookies {
        forward           = "${var.forward_cookies}"
        whitelisted_names = "${var.forward_cookies_whitelist}"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = "${var.min_ttl}"
    default_ttl            = "${var.default_ttl}"
    max_ttl                = "${var.max_ttl}"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "${data.aws_acm_certificate.domain.arn}"
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method       = "sni-only"
  }
}
