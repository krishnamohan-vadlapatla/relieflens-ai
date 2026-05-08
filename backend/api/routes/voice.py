from fastapi import APIRouter, UploadFile, File, HTTPException

router = APIRouter()

@router.post("/transcribe")
async def transcribe(file: UploadFile = File(...)):
    try:
        if not file.content_type.startswith(('audio/', 'video/')):
            raise HTTPException(status_code=400, detail="File must be audio or video")
        
        return {
            "text": "నా అమ్మకు గాయం అయింది, నీళ్లు ఇంట్లోకి వచ్చాయి",
            "language": "telugu",
            "confidence": 0.97,
            "note": "Demo transcription"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))