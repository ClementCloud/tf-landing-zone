provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "cjtfstatestore-0825"
    key    = "tfstate/tfstatetest1"
    region = "us-west-2"
  }
}