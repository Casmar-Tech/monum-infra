terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~>1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.10"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_secretsmanager_secret" "terraform_secrets" {
  name = "terraform-secrets"
}

data "aws_secretsmanager_secret_version" "terraform_secrets" {
  secret_id = data.aws_secretsmanager_secret.terraform_secrets.id
}

provider "mongodbatlas" {
  public_key  = "tnmfxxuo"
  private_key = jsondecode(data.aws_secretsmanager_secret_version.terraform_secrets.secret_string)["atlas_private_key"]
}
