provider "aws" {
  region = "us-east-2"
}

module "s3_bucket" {
  source = "./_shared"
}