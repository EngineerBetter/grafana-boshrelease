provider "aws" {}

resource "aws_s3_bucket" "blobstore" {
  bucket        = "grafana-blobstore"
  acl           = "public-read"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "blob-public-read" {
  bucket = aws_s3_bucket.blobstore.id

  policy = <<POLICY
{
  "Statement": [{
    "Action": [ "s3:GetObject" ],
    "Effect": "Allow",
    "Resource": "arn:aws:s3:::grafana-blobstore/*",
    "Principal": { "AWS": ["*"] }
  }]
}
POLICY
}

resource "aws_s3_bucket" "releases" {
  bucket        = "grafana-boshreleases"
  acl           = "public-read"
  force_destroy = true

  versioning {
    enabled = true
  }
}
