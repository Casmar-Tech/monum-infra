resource "aws_s3_bucket" "monum_place_photos" {
  bucket = "monum-place-photos"
}

resource "aws_s3_bucket_ownership_controls" "monum_place_photos" {
  bucket = aws_s3_bucket.monum_place_photos.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "monum_place_photos" {
  depends_on = [aws_s3_bucket_ownership_controls.monum_place_photos]

  bucket = aws_s3_bucket.monum_place_photos.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "monum_place_photos" {
  bucket = aws_s3_bucket.monum_place_photos.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "monum_place_photos" {
  bucket = aws_s3_bucket.monum_place_photos.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.monum_place_photos.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "domain_name" {
  value = aws_s3_bucket.monum_place_photos.bucket_domain_name
}
