output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.distribution.domain_name
}

output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.distribution.arn
}

