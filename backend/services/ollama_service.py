import httpx
from typing import Optional, Dict, Any, List

class OllamaService:
    def __init__(self, base_url: str = "http://localhost:11434"):
        self.base_url = base_url
        self.model = "gemma4:2b"
    
    async def is_available(self) -> bool:
        try:
            async with httpx.AsyncClient(timeout=5.0) as client:
                response = await client.get(f"{self.base_url}/api/tags")
                return response.status_code == 200
        except:
            return False
    
    async def generate(
        self, 
        prompt: str, 
        system: Optional[str] = None,
        temperature: float = 0.7,
        max_tokens: int = 512
    ) -> str:
        payload = {
            "model": self.model,
            "prompt": prompt,
            "stream": False,
            "options": {
                "temperature": temperature,
                "num_predict": max_tokens,
            }
        }
        
        if system:
            payload["system"] = system
        
        async with httpx.AsyncClient(timeout=120.0) as client:
            try:
                response = await client.post(
                    f"{self.base_url}/api/generate",
                    json=payload
                )
                response.raise_for_status()
                return response.json().get("response", "")
            except Exception as e:
                print(f"Ollama error: {e}")
                raise

ollama_service = OllamaService()