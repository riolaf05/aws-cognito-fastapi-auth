locals {
  PROJECT_NAME = "fastapi-auth"
  ENV          = "dev"
  REGION       = "eu-south-1"
  REDIRECT_URL = "http://localhost"
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${local.PROJECT_NAME}-pool"
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool" "pool" {
  name                = "${local.PROJECT_NAME}-auth"
  mfa_configuration   = "OFF"
  deletion_protection = "INACTIVE"
  username_configuration {
    case_sensitive = false
  }

  auto_verified_attributes = ["email"]

  /** Required Standard Attributes*/
  schema {
    attribute_data_type = "String"
    mutable             = true
    name                = "email"
    required            = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  schema {
    attribute_data_type = "String"
    mutable             = true
    name                = "given_name"
    required            = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  schema {
    attribute_data_type = "String"
    mutable             = true
    name                = "family_name"
    required            = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  /** Custom Attributes */
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "PersonalInfo"
    required                 = false
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
  #   lambda_config {
  #     post_confirmation  = module.post_confirmation.lambda_function_arn
  #   }
  # email_verification_message = "Your verification code is {####}."

  user_pool_add_ons {
    advanced_security_mode = "AUDIT"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "${local.PROJECT_NAME}" #is the scope prefix
  name       = "${local.PROJECT_NAME}-resource-server"

  scope {
    scope_name        = "api"
    scope_description = "api"
  }

  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "client" {
  name                         = "${local.PROJECT_NAME}-client"
  generate_secret              = true
  user_pool_id                 = aws_cognito_user_pool.pool.id
  explicit_auth_flows          = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  supported_identity_providers = ["COGNITO"]
  allowed_oauth_flows          = ["client_credentials"]
  allowed_oauth_scopes         = ["${local.PROJECT_NAME}/api"]
  callback_urls                = ["${local.REDIRECT_URL}"]
  #   logout_urls                          = [local.REDIRECT_URL]
  allowed_oauth_flows_user_pool_client = true

  lifecycle {
    ignore_changes = all
  }
}

output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "user_pool_name" {
  value = aws_cognito_user_pool.pool.name
}

output "client_id" {
  value = aws_cognito_user_pool_client.client.id
}

output "client_secret" {
  value     = aws_cognito_user_pool_client.client.client_secret
  sensitive = true
}