provider "aws" {
  version    = "~> 1.26"
  region     = "us-east-1"
  profile    = "tp-cts-intl-ps-ote-prod"
}

resource "aws_s3_bucket" "example" {
  bucket = "cts-intl-ps-rvillanueva"
  acl    = "private"
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.example.bucket}"
  key    = "${var.lamdaZipS3Key}"
  source = "${var.lamdaZipFile}"
  etag   = "${md5(file("${var.lamdaZipFile}"))}"
}
