

resource "aws_s3_bucket" "remote_s3" {

    bucket = "terra-statefile-s3bucket"

    tags = {
        Name        = "terra-stateFile-s3bucket"
    }
  
}