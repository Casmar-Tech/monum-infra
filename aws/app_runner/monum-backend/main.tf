resource "aws_apprunner_auto_scaling_configuration_version" "autoscaling_config" {
  auto_scaling_configuration_name = "monum_backend_autoscaling_config"
  max_concurrency                 = 50
  max_size                        = 2
  min_size                        = 1

  tags = {
    Name = "monum_backend_autoscaling_config"
  }
}

resource "aws_apprunner_service" "monum_backend" {
  service_name = "monum-backend"
  source_configuration {
    image_repository {
      image_configuration {
        port = "8080"
        runtime_environment_variables = {
          S3_BUCKET_IMAGES        = "monum-profile-images"
          S3_BUCKET_AUDIOS        = "monum-polly"
          S3_BUCKET_PLACES_IMAGES = "monum-place-photos"
          NODE_ENV                = "production" # development
          MEDIA_CLOUDFRONT_URL    = "https://media.monum.es"
        }
        runtime_environment_secrets = {
          DEEPL_AUTH_KEY         = "${data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn}:DEEPL_AUTH_KEY::"
          OPENAI_API_KEY         = "${data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn}:OPENAI_API_KEY::"
          OPENAI_ORGANIZATION_ID = "${data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn}:OPENAI_ORGANIZATION_ID::"
          PEXELS_API_KEY         = "${data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn}:PEXELS_API_KEY::"
          SECRET_KEY             = "${data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn}:SECRET_KEY::"
          MONGODB_URI            = "${data.aws_secretsmanager_secret.monum_backend_environment_secrets.arn}:MONGODB_URI::"
        }
      }
      image_identifier      = "670989880542.dkr.ecr.eu-west-1.amazonaws.com/monum-backend:latest"
      image_repository_type = "ECR"
    }
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_service_role.arn
    }
    auto_deployments_enabled = false
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.autoscaling_config.arn

  instance_configuration {
    cpu               = "1024"
    memory            = "2048"
    instance_role_arn = aws_iam_role.app_runner_instance_role.arn
  }

  tags = {
    Name = "monum-backend"
  }
}

resource "aws_apprunner_custom_domain_association" "api_monum_es" {
  domain_name          = "api.monum.es"
  service_arn          = aws_apprunner_service.monum_backend.arn
  enable_www_subdomain = false
}
