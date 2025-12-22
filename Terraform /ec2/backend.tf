terraform {
  backend "s3" {
    bucket = "om_remote_backend"
    key = "terraform.tfstate"
    region = "ap-south-1"
    #  dynamodb_table = "remote_backend_table" // This is optional method, now s3 lockfile meachnism is there.
    use_lockfile = true
    encrypt = true
  }
}