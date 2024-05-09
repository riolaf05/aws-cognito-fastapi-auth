provider "aws" {
  region  = "eu-south-1"
  profile = "news4p"

  default_tags {
    tags = {
      Terraform = "True"
      PROJECT   = "POC"
    }
  }
}
