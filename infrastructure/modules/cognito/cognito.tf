resource "aws_cognito_user_pool" "pool" {
  name = join("-", [var.project_info["prefix"], "user-pool", var.project_info["env"]])

  tags = {
    Name = join("-", [var.project_info["prefix"], "user-pool", var.project_info["env"]])
  }

  user_pool_add_ons {
    advanced_security_mode = "AUDIT"
  }
}

resource "aws_cognito_user_pool_domain" "pool_domain" {
  domain       = join("-", [var.project_info["prefix"], var.project_info["env"]])
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_resource_server" "resource" {
  count      = length(var.cognito["resources"])
  identifier = join(".", [var.project_info["prefix"], var.cognito["resources"][count.index]["name"]])
  name       = join("-", [var.project_info["prefix"], "resource-server", var.cognito["resources"][count.index]["name"], var.project_info["env"]])

  dynamic "scope" {

    for_each = var.cognito["resources"][count.index]["scopes"]
    content {
      scope_name        = scope.value["name"]
      scope_description = scope.value["description"]
    }
  }

  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_client" "dynamic_user_pool_client" {
  count                                = length(var.cognito["clients"])
  user_pool_id                         = aws_cognito_user_pool.pool.id
  name                                 = join("-", [var.project_info["prefix"], var.cognito["clients"][count.index]["name"], var.project_info["env"]])
  generate_secret                      = true
  explicit_auth_flows                  = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  supported_identity_providers         = ["COGNITO"]
  allowed_oauth_flows_user_pool_client = var.cognito["clients"][count.index]["enabled"]
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes                 = formatlist("backend.%s", var.cognito["clients"][count.index]["allowed_scopes"])
  depends_on                           = [aws_cognito_resource_server.resource]
}

# resource "aws_iam_saml_provider" "default" {
#   name                   = var.saml_provider_name
#   #saml_metadata_document = file("saml-metadata.xml")
# }

# resource "aws_cognito_identity_pool" "main" {
#   identity_pool_name               = join(".", ["weaving","idp"])
#   allow_unauthenticated_identities = false
#   allow_classic_flow               = true

#   cognito_identity_providers {
#     client_id               = "6lhlkkfbfb4q5kpp90urffae"
#     provider_name           = "cognito-idp.us-east-1.amazonaws.com/us-east-1_Tv0493apJ"
#     server_side_token_check = false
#   }
# }