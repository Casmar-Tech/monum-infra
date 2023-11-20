resource "aws_iam_group" "admins" {
  name = "admins"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "admins_policy_1" {
  group      = aws_iam_group.admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "admins_memberships" {
  name  = "admins_memberships"
  group = aws_iam_group.admins.name
  users = [
    "pauvilella",
    "xevihuix",
  ]
}
