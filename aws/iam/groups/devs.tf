resource "aws_iam_group" "devs" {
  name = "devs"
  path = "/"
}

resource "aws_iam_group_membership" "devs_memberships" {
  name  = "devs_memberships"
  group = aws_iam_group.devs.name
  users = [
    "dev_user"
  ]
}

resource "aws_iam_group_policy_attachment" "devs_policy_1" {
  group      = aws_iam_group.devs.name
  policy_arn = "arn:aws:iam::670989880542:policy/s3_monum_polly_read_write"
}

resource "aws_iam_group_policy_attachment" "devs_policy_2" {
  group      = aws_iam_group.devs.name
  policy_arn = "arn:aws:iam::670989880542:policy/s3_monum_profile_images_read_write"
}

resource "aws_iam_group_policy_attachment" "devs_policy_3" {
  group      = aws_iam_group.devs.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPollyFullAccess"
}

resource "aws_iam_group_policy_attachment" "devs_policy_4" {
  group      = aws_iam_group.devs.name
  policy_arn = "arn:aws:iam::670989880542:policy/ses_send_email"
}
