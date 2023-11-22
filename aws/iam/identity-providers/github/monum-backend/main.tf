module "github_oidc_provider_monum_backend" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.1.0"

  create_oidc_provider = true
  create_oidc_role     = true

  role_name        = "github-oidc-role-monum-backend-repo"
  role_description = "Role used in GitHub Actions in the monum-backend repo."

  repositories              = ["pauvilella/monum-backend"]
  oidc_role_attach_policies = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"]
}
