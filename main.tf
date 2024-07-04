resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              =  http://s3.amazonaws.com/sctp-staticwebsite-files
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }
