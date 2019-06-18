# cga-teamcloudfront-tf

A terraform module for providing cloud front to a team using cloud.gov.au.

The module expects a certificate for the domain to already be issued in ACM in us-east-1 so it can be used with cloud front. 
Since terraform 0.12, you will have to pass in an aws provider for us_east_aws e.g.

```terraform
provider "aws" {
    region  = "ap-southeast-2"
}
provider "aws" {
  alias   = "us_east_aws"
  region  = "us-east-1"
}
module "cloudfront" {
  source = "github.com/govau/cga-teamcloudfront-tf?ref=v2.0.1"
  providers = {
    "aws"             = "aws"
    "aws.us_east_aws" = "aws.us_east_aws"
  }
  ...
``` 
