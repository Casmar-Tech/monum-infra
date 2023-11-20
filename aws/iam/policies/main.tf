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
