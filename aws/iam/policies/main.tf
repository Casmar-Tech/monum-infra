resource "aws_iam_policy" "s3_list_all_buckets" {
  name        = "s3_list_all_buckets"
  path        = "/"
  description = "List all S3 buckets."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ListAllMyBuckets"
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
        ]
        Resource = [
          "*",
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "s3_monum_polly_read_write" {
  name        = "s3_monum_polly_read_write"
  path        = "/"
  description = "Read and write access to the 'monum-polly' S3 bucket."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowReadWrite"
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::monum-polly",
          "arn:aws:s3:::monum-polly/*",
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "s3_monum_place_photos_read_write" {
  name        = "s3_monum_place_photos_read_write"
  path        = "/"
  description = "Read and write access to the 'monum-place-photos' S3 bucket."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowReadWrite"
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::monum-place-photos",
          "arn:aws:s3:::monum-place-photos/*",
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "s3_monum_profile_images_read_write" {
  name        = "s3_monum_profile_images_read_write"
  path        = "/"
  description = "Read and write access to the 'monum-profile-images' S3 bucket."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowReadWrite"
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::monum-profile-images",
          "arn:aws:s3:::monum-profile-images/*",
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ses_send_email" {
  name        = "ses_send_email"
  path        = "/"
  description = "Send emails with SES."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "SendEmail"
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
        ]
        Resource = [
          "arn:aws:ses:eu-west-1:670989880542:identity/*",
        ]
      }
    ]
  })
}
