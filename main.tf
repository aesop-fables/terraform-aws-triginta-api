provider "aws" {
  region = var.region

  access_key = "fake"
  secret_key = "fake"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}
