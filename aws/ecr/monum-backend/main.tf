resource "aws_ecr_repository" "monum_backend" {
  name                 = "monum-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
