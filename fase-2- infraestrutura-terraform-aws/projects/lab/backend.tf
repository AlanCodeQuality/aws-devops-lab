# state.tf
terraform {
  backend "s3" {
    bucket = "terraform-state-alan-cloud" 
    key    = "site/terraform.tfstate"
    region = "us-east-1"
    encrypt= true
  }
}
