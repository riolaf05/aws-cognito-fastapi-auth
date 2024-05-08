from fastapi import Depends, FastAPI
from fastapi_cognito import CognitoToken, CognitoAuth, CognitoSettings
import os
from dotenv import load_dotenv
load_dotenv()
app = FastAPI()

from pydantic_settings import BaseSettings
from pydantic.types import Any

class Settings(BaseSettings):
    check_expiration: bool = True
    jwt_header_prefix: str = "Bearer"
    jwt_header_name: str = "Authorization"
    userpools: dict[str, dict[str, Any]] = {
        "eu": {
            "region": os.environ.get('COGNITO_REGION'),
            "userpool_id": os.environ.get('COGNITO_POOL_ID'),
            "app_client_id": [os.environ.get('COGNITO_CLIENT_ID')] 
        },
    }

settings = Settings()

cognito = CognitoAuth(
  settings=CognitoSettings.from_global_settings(settings), userpool_name='eu'
)

@app.get("/secure")
def secure(auth: CognitoToken = Depends(cognito.auth_optional)):
    return {"message": "Hello world"}

@app.get("/not_secure")
async def not_secure() -> bool:
    return True
