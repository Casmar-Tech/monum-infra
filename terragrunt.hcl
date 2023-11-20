remote_state {
  backend = "s3"
  config = {
    region         = "eu-west-1"
    bucket         = "monum-tf-state"
    key            = "infra/${path_relative_to_include()}/terraform.tfstate"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
