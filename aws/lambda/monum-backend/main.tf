locals {
  lambda_policies = [
    "arn:aws:iam::aws:policy/AmazonPollyFullAccess",
    "arn:aws:iam::670989880542:policy/s3_monum_polly_read_write",
    "arn:aws:iam::670989880542:policy/s3_monum_profile_images_read_write",
    "arn:aws:iam::670989880542:policy/ses_send_email"
  ]
}

module "lambda_function_container_image" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "6.5.0"

  function_name = "monum-backend"
  description   = "Backend service for Monum."

  create_package = false

  image_uri    = "670989880542.dkr.ecr.eu-west-1.amazonaws.com/monum-backend:sha-c7919b4"
  package_type = "Image"

  memory_size = 512 # MB
  timeout     = 60  # seconds (1min)

  create_role      = true
  role_name        = "monum-backend-lambda-role"
  role_description = "Role for monum-backend lambda."

  attach_policies    = true
  policies           = local.lambda_policies
  number_of_policies = length(local.lambda_policies)

  attach_cloudwatch_logs_policy     = true
  cloudwatch_logs_retention_in_days = 30
  cloudwatch_logs_tags = {
    Name = "monum-backend"
  }

  tags = {
    Name = "monum-backend"
  }
}
