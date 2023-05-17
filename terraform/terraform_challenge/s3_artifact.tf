resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "my-terraform-bucket2023"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
