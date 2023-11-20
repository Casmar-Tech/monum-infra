resource "mongodbatlas_database_user" "dev_user" {
  username           = "dev_user"
  password           = jsondecode(data.aws_secretsmanager_secret_version.terraform_secrets.secret_string)["monum_main_cluster_dev_user_password"]
  project_id         = local.atlas_project_id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "test"
  }
  scopes {
    name = mongodbatlas_advanced_cluster.cluster.name
    type = "CLUSTER"
  }
}

resource "mongodbatlas_database_user" "restore_user" {
  username           = "restore_user"
  password           = jsondecode(data.aws_secretsmanager_secret_version.terraform_secrets.secret_string)["monum_main_cluster_restore_user_password"]
  project_id         = local.atlas_project_id
  auth_database_name = "admin"
  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}
