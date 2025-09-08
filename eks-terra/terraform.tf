terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.12.0"
    }
  }

  backend "s3" {
    bucket = "terra-statefile-s3bucket"
    key = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "statefile-table"
  }


}