resource "aws_iam_role" "app_runner_service_role" {
  name = "monum-backend-app-runner-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_service_role_1" {
  role       = aws_iam_role.app_runner_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_role" "app_runner_instance_role" {
  name = "monum-backend-app-runner-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_1" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPollyFullAccess"
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_2" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::670989880542:policy/s3_list_all_buckets"
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_3" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::670989880542:policy/s3_monum_polly_read_write"
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_4" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::670989880542:policy/s3_monum_place_photos_read_write"
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_5" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::670989880542:policy/s3_monum_profile_images_read_write"
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_6" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = "arn:aws:iam::670989880542:policy/ses_send_email"
}

data "aws_kms_key" "secrets_manager_kms_key" {
  key_id = "bbe38656-f069-4fd1-925b-5ffdb701afe4"
}

data "aws_secretsmanager_secret" "monum_backend_environment_secrets" {
  name = "monum-backend-environment-secrets"
}

resource "aws_iam_policy" "access_monum_backend_environment_secrets" {
  name        = "access_monum_backend_environment_secrets"
  description = "Access monum-backend Environment Secrets."
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "kms:Decrypt*"
        ]
        Effect = "Allow"
        Resource = [
          data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn,
          data.aws_kms_key.secrets_manager_kms_key.arn
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_role_7" {
  role       = aws_iam_role.app_runner_instance_role.name
  policy_arn = aws_iam_policy.access_monum_backend_environment_secrets.arn
}
