# New change for terraform 0.12 - we must specify the providers needed 
# from the root module
# https://www.terraform.io/docs/configuration/modules.html#passing-providers-explicitly
provider "aws" {
}

provider "aws" {
  alias = "us_east_aws"
}

