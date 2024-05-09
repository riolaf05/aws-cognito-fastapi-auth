# FastAPI Project with Cognito Authentication
This repository contains a FastAPI project with Cognito-based authentication. Below are the steps to install, configure, and use the application.

## Prerequisites
Make sure you have Terraform installed on your system and configured correctly for managing infrastructure.

1. Installing Infrastructure
Navigate to the infrastructure folder.
Run `terraform init` and `terraform apply` to create the necessary infrastructure.

2. Configuring Environment Variables
Copy the Cognito ID and Cognito Secret from the AWS console.
Add these values to your environment variables file as COGNITO_ID and COGNITO_SECRET.

3. Launching the FastAPI Application
Ensure you have all Python dependencies installed (`pip install -r requirements.txt`).
Run the following command to start the FastAPI application:

```console
uvicorn app.service:app --host 0.0.0.0 --port 3000 --reload
```

4. Requesting Access Token
Execute the following curl command to obtain the access token:

```console
curl --request POST \
  --url https://fastapi-auth-pool.auth.eu-south-1.amazoncognito.com/oauth2/token \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data grant_type=client_credentials \
  --data scope=fastapi-auth/api\
  --data client_id=YOUR_CLIENT_ID \
  --data client_secret=YOUR_CLIENT_SECRET
```

Make sure to replace YOUR_CLIENT_ID and YOUR_CLIENT_SECRET with the correct values.

5. Invoking the Secure Endpoint
To call the /secure endpoint, use the token obtained in the previous step as part of the authorization header:

```console
curl --request GET \
  --url http://localhost:3000/secure \
  --header 'Authorization: Bearer YOUR_ACCESS_TOKEN'
```

Make sure to replace YOUR_ACCESS_TOKEN with the token obtained from the previous step.