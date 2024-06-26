## Requirements

No requirements.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_resource_server.resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_resource_server) | resource |
| [aws_cognito_user_pool.pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |
| [aws_cognito_user_pool_client.dynamic_user_pool_client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client) | resource |
| [aws_cognito_user_pool_domain.pool_domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_provider_info"></a> [aws\_provider\_info](#input\_aws\_provider\_info) | Region of the provider | `map(string)` | `"us-east-1"` | no |
| <a name="input_cognito"></a> [cognito](#input\_cognito) | List of the server resources and its clients | `map` | `{}` | no |
| <a name="input_project_info"></a> [project\_info](#input\_project\_info) | Name, prefix and env of the project | `map(string)` | <pre>{<br>  "env": "dev",<br>  "name": "poc",<br>  "prefix": "poc"<br>}</pre> | no |
| <a name="input_saml_provider_name"></a> [saml\_provider\_name](#input\_saml\_provider\_name) | The IAM SAML provider name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the user pool |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint name of the user pool. Example format: cognito-idp.REGION.amazonaws.com/xxxx\_yyyyy |
| <a name="output_id"></a> [id](#output\_id) | The id of the user pool |

## Cognito info

User pools are for authentication (identify verification). With a user pool, your app users can sign in through the user pool or federate through a third-party identity provider (IdP).

Identity pools are for authorization (access control). You can use identity pools to create unique identities for users and give them access to other AWS services.

## References

* [Using Amazon Cognito Identity to Authenticate Users](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/loading-browser-credentials-cognito.html)