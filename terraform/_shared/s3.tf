resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${local.aws_resource_name_prefix}-20250428-s3-bucket-shirai"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}