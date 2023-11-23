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

resource "aws_iam_role_policy_attachment" "app_runner_role_access_ecr" {
  role       = aws_iam_role.app_runner_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_apprunner_auto_scaling_configuration_version" "autoscaling_config" {
  auto_scaling_configuration_name = "monum_backend_autoscaling_config"
  max_concurrency                 = 50
  max_size                        = 3
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

  tags = {
    Name = "monum-backend"
  }
}

resource "aws_apprunner_custom_domain_association" "api_monum_es" {
  domain_name          = "api.monum.es"
  service_arn          = aws_apprunner_service.monum_backend.arn
  enable_www_subdomain = false
}
