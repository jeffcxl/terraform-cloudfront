data "aws_s3_bucket" "b" {
  bucket = "sctp-staticwebsite-files"
  }

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = data.aws_s3_bucket.b.bucket_regional_domain_name
    origin_id                = "s3-jeffstaticwebsite.sctp-sandbox.com"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "No comment"
  default_root_object = "home.html"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-jeffstaticwebsite.sctp-sandbox.com"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
