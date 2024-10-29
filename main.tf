---
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"  # North Virginia region
  access_key = AKIA2UC3AGHJC53FVU4G 
  secret_key = WvJRgHdSRRnrSZscDmjpXmILJRz+qYaUvZV3dAS
}