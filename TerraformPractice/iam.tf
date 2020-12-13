resource "aws_iam_role" "delegate_admin_ec2_role" {
  name = local.iam_role_name

  assume_role_policy = data.template_file.delegate_admin_ec2_role.rendered

  tags = merge(
    local.labels,
    map("Name", local.iam_role_name)
  )
}

resource "aws_iam_policy" "delegate_admin_ec2_policy" {
  name = "delegate-admin-ec2-policy"

  policy = data.template_file.delegate_admin_ec2_policy.rendered

}

data "aws_iam_policy" "delegate_admin_S3_access" {
    arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "delegate_admin_ec2_role_policy_attachment" {
  role       = aws_iam_role.delegate_admin_ec2_role.name
  policy_arn = aws_iam_policy.delegate_admin_ec2_policy.arn
}

resource "aws_iam_role_policy_attachment" "delegate_admin_s3_role_policy_attachment" {
  role       = aws_iam_role.delegate_admin_ec2_role.name
  policy_arn = data.aws_iam_policy.delegate_admin_S3_access.arn
}

resource "aws_iam_instance_profile" "delegate_admin_ec2_profile" {
  name = local.iam_instance_profile_name
  role = aws_iam_role.delegate_admin_ec2_role.name
}


