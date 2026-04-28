# state.tf
terraform {
  backend "s3" {
    bucket = "terraform-state-alan-cloud" 
    key    = "site2/terraform.tfstate"
    region = "us-east-1"
    encrypt= true
    use_lockfile = true
  }
}
