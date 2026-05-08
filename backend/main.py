from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from api.routes import image, voice, chat, knowledge, dashboard
import uvicorn

app = FastAPI(
    title="ReliefLens AI API",
    description="Offline AI intelligence for disaster survival - Powered by Gemma 4",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(image.router, prefix="/api", tags=["Image Analysis"])
app.include_router(voice.router, prefix="/api", tags=["Voice"])
app.include_router(chat.router, prefix="/api", tags=["Chat"])
app.include_router(knowledge.router, prefix="/api", tags=["Knowledge"])
app.include_router(dashboard.router, prefix="/api", tags=["Dashboard"])

@app.get("/")
async def root():
    return {"message": "ReliefLens AI API", "status": "online", "version": "1.0.0", "offline_mode": True}

@app.get("/health")
async def health():
    return {
        "status": "healthy",
        "ai_model": "gemma4:2b",
        "features": ["disaster_image_analysis", "multilingual_voice", "emergency_chat", "rag_knowledge", "coordination_dashboard"]
    }

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)