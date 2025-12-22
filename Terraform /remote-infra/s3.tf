resource "aws_s3_bucket" "remote_bucket" {
  bucket = "om_remote_backend"

  tags = {
    Name = "om_remote_backend"
  }
}