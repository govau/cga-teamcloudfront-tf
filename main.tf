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

  logging_config {
    include_cookies = false

    bucket = "${aws_s3_bucket.logs.bucket_domain_name}"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.domain}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 600
    max_ttl                = 86400
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
