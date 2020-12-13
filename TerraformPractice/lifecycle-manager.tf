resource "aws_dlm_lifecycle_policy" "delegate_admin_lifecycle_policy" {
  description        = "DLM lifecycle policy"
  execution_role_arn = aws_iam_role.delegate_admin_ec2_role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "2 weeks of daily snapshots"

      create_rule {
        interval      = 2
        interval_unit = "HOURS"
        times         = ["14:30"]
      }

      retain_rule {
        count = 1
      }

    #   tags_to_add = {
    #     SnapshotCreator = "DLM"
    #   }

      copy_tags = true
    }

    target_tags = {
      environment = local.environment
      application = "bmo-account-creation"
    }
  }
}
