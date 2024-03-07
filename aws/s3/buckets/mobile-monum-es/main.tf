resource "aws_s3_bucket" "mobile_monum_es" {
  bucket = "mobile-monum-es"
}

resource "aws_s3_bucket_ownership_controls" "mobile_monum_es" {
  bucket = aws_s3_bucket.mobile_monum_es.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "mobile_monum_es" {
  depends_on = [aws_s3_bucket_ownership_controls.mobile_monum_es]

  bucket = aws_s3_bucket.mobile_monum_es.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "mobile_monum_es" {
  bucket = aws_s3_bucket.mobile_monum_es.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mobile_monum_es" {
  bucket = aws_s3_bucket.mobile_monum_es.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.mobile_monum_es.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "domain_name" {
  value = aws_s3_bucket.mobile_monum_es.bucket_domain_name
}
