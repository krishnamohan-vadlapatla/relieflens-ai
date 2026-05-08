from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    OLLAMA_HOST: str = "http://localhost:11434"
    OLLAMA_MODEL: str = "gemma4:2b"
    WHISPER_MODEL: str = "base"
    API_HOST: str = "0.0.0.0"
    API_PORT: int = 8000
    LOG_LEVEL: str = "info"
    RAG_COLLECTION: str = "relief_lens_knowledge"
    
    class Config:
        env_file = ".env"
        extra = "allow"

settings = Settings()