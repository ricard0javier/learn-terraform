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
  key    = "learn-terraform.zip"
  source = "${var.lamdaZipFile}"
  etag   = "${md5(file("${var.lamdaZipFile}"))}"
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "example" {
  function_name = "ServerlessExample"
  s3_bucket = "${aws_s3_bucket.example.bucket}"
  s3_key    = "${aws_s3_bucket_object.object.key}"
  handler = "main.handler"
  runtime = "nodejs6.10"
  role = "${aws_iam_role.lambda_exec.arn}"
}

