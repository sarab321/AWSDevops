terraform {
  backend "s3" {
    bucket = "bmo-terraform-s3-backend"
    key    = "terraform.tf.state"
    region = "us-east-1"
  }
}
