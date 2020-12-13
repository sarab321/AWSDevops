 locals {
     ec2_instance_name = "bmo-terraform-ec2-instance-${local.environment}"
     iam_role_name = "delegate-admin-ec2-role-${local.environment}"
     iam_instance_profile_name = "delegate-admin-ec2-profile-${local.environment}"
     iam_policy_name = "delegate-admin-ec2-policy-${local.environment}"
     environment = var.environment
     env_main = var.env_main
 
    # DEFAULT TAGS
    ###############################

    labels = {
        state = "active"
        version = "2020"
        project = "BMO"
        application = "bmo-account-creation"
        environment = local.environment
        App_Id = "app_123"
        Business_Id = "92123"
        Env_Id = "admin_1678"
        Project_Id = "794213"
        automation = "terraform"
 
    }

}