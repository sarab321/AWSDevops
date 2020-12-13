resource "aws_kms_key" "delegate_admin_kms_key" {
  description             = "This is the KMS key created for S3 bucket and EC2 instance"
  policy = data.template_file.kms_key_policy.rendered
  deletion_window_in_days = 7
  enable_key_rotation = false
}

resource "aws_kms_alias" "delegate_admin_kms_alias" {
  name          = "alias/delegate-admin-kms-test-key"
  target_key_id = aws_kms_key.delegate_admin_kms_key.key_id
}