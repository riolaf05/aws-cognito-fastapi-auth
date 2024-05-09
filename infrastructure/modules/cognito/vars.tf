variable "aws_provider_info" {
  description = "Region of the provider"
  default = {
    region = "us-east-2"
  }
  type = map(string)
}

variable "project_info" {
  description = "Name, prefix and env of the project"
  default = {
    name   = "poc"
    prefix = "poc"
    env    = "dev"
  }
  type = map(string)
}

#Cognito vars
variable "cognito" {
  description = "List of the server resources and its clients"
  default     = {}
}

variable "saml_provider_name" {
  description = "The IAM SAML provider name"
  default     = ""
}


