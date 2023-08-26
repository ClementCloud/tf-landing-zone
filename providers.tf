resource "aws_s3_bucket" "cjbucket2" {
    bucket = "cjtestbucket072923"

}


terraform {
  backend "s3" {
    bucket = "cjtestbucket072923"
    key    = "tfstate/tfstatetest1"
    region = "us-west-2"
  }
}