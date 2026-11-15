"""Settings come from environment variables (.env), never from code (NFR-06)."""
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file='../.env', extra='ignore')
    database_url: str = 'postgresql://localhost/muscle_mania'
    session_secret: str = 'change-me'
    free_delivery_from: float = 400


settings = Settings()
