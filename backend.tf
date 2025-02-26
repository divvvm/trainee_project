terraform {
  backend "s3" {
    bucket = "dmisi-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}