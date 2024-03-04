resource "aws_s3_bucket" "monum_public_images" {
  bucket = "monum-public-images"
}

resource "aws_s3_bucket_policy" "monum_public_images_policy" {
  bucket = aws_s3_bucket.monum_public_images.id
  policy = data.aws_iam_policy_document.monum_public_images_policy_document.json
}

data "aws_iam_policy_document" "monum_public_images_policy_document" {

  statement {
    sid    = "EnforcedTLS"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:*"]
    resources = [
      "${aws_s3_bucket.monum_public_images.arn}/*",
      aws_s3_bucket.monum_public_images.arn,
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.monum_public_images.arn}/*"]
  }
}

resource "aws_s3_bucket_ownership_controls" "monum_public_images" {
  bucket = aws_s3_bucket.monum_public_images.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "monum_public_images" {
  depends_on = [aws_s3_bucket_ownership_controls.monum_public_images]

  bucket = aws_s3_bucket.monum_public_images.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "monum_public_images" {
  bucket = aws_s3_bucket.monum_public_images.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "monum_public_images" {
  bucket = aws_s3_bucket.monum_public_images.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "arn:aws:kms:eu-west-1:${local.account_id}:alias/aws/s3"
    }
  }
}
