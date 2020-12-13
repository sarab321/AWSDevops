data "template_file" "kms_key_policy" {
    template = file("policy/kms-key-policy.json")
    vars = {
        kms_key_ec2_role_arn = aws_iam_role.delegate_admin_ec2_role.arn
    }
}

data "template_file" "delegate_admin_ec2_role" {
    template = file("policy/ec2-auth-trust-policy.json")
    vars = {
        assumerole = "ec2.amazonaws.com"
    }
}

data "template_file" "delegate_admin_ec2_policy" {
    template = file("policy/ec2-policy.json")
    vars = {
        kms_key_arn = aws_kms_key.delegate_admin_kms_key.arn
    }
}

data "template_file" "delegate_admin_s3_role" {
    template = file("policy/ec2-auth-trust-policy.json")
    vars = {
        assumerole = "s3.amazonaws.com"
    }
}
