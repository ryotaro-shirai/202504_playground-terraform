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
    sid = "AllowCloudFrontAccessUsingOAC"
    effect = "Allow"
    principals {
        type = "Service"
        identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
        "s3:GetObject"
    ]

    resources = [
        "${aws_s3_bucket.s3_bucket.arn}/*"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.playground-cloudfront.arn]
    }
  }
}