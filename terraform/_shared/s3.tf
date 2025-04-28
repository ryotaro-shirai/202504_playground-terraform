resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${local.aws_resource_name_prefix}-20250428-s3-bucket-shirai"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket" {
    bucket = aws_s3_bucket.s3_bucket.id
    policy = data.aws_iam_policy_document.allow-cloudfront.json
}

data "aws_iam_policy_document" "allow-cloudfront" {
  statement {
    sid = "Allow CloudFront"
    effect = "Allow"
    principals {
        type = "AWS"
        identifiers = [aws_cloudfront_origin_access_identity.playground-cloudfront.iam_arn]
    }
    actions = [
        "s3:GetObject"
    ]

    resources = [
        "${aws_s3_bucket.s3_bucket.arn}/*"
    ]
  }
}