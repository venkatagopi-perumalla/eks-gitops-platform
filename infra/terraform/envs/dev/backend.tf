# State lives in the S3 bucket created by ../../bootstrap.
# scripts/configure.sh replaces ACCOUNT_ID with your AWS account ID.
terraform {
  backend "s3" {
    bucket       = "tfstate-ACCOUNT_ID-eks-gitops"
    key          = "dev/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true # S3 native locking, no DynamoDB table needed
  }
}
