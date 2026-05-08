from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional, List, Dict

router = APIRouter()

class ChatRequest(BaseModel):
    message: str
    language: Optional[str] = None
    context: Optional[Dict] = None

@router.post("/chat")
async def chat(request: ChatRequest):
    try:
        if not request.message:
            raise HTTPException(status_code=400, detail="Message is required")
        
        message = request.message.lower()
        language = request.language or "english"
        
        emergency_keywords = ['injury', 'hurt', 'trapped', 'flood', 'help', 'emergency', 'నా', 'मेरा']
        is_emergency = any(kw in message for kw in emergency_keywords)
        
        responses = {
            "telugu": {
                "response_text": "మీ గురించి తెలుసుకోవడం చాలా ముఖ్యం. వెంటనే చర్యలు తీసుకోండి.",
                "priority": "HIGH" if is_emergency else "MEDIUM",
                "detected_situation": ["ఫ్లడ్ జొనశ", "కుటుంబ సభ్యుడు గాయపడ్డారు", "తక్కువ ఎత్తులో ఉన్నారు"],
                "recommended_actions": [
                    "తక్కువ ఎత్తులో ఉన్న ప్రాంతాల నుండి ఎత్తైన ప్రాంతాలకు వెళ్ళండి",
                    "నీటితో కలుషితమైన ప్రాంతాలను నివారించండి",
                    "తకుండ�్�న అత్యవసర సేవలను సంప్రదించండి"
                ],
                "confidence": 97,
                "language": "telugu"
            },
            "hindi": {
                "response_text": "आपकी सुरक्षा सबसे महत्वपूर्ण है। कृपया तुरंत सुरक्षित स्थान पर जाएं।",
                "priority": "HIGH" if is_emergency else "MEDIUM",
                "detected_situation": ["बाढ़ की स्थिति", "परिवार के सदस्य को चोट", "तुरंत निकलना जरूरी"],
                "recommended_actions": [
                    "तुरंत ऊंची जगह पर जाएं",
                    "दूषित पानी से बचें",
                    "आपातकालीन सेवाओं से संपर्क करें"
                ],
                "confidence": 97,
                "language": "hindi"
            },
            "english": {
                "response_text": "Your safety is our priority. Please stay calm and follow these immediate steps.",
                "priority": "HIGH" if is_emergency else "MEDIUM",
                "detected_situation": ["Flood situation detected", "Possible injury reported", "Immediate relocation required"],
                "recommended_actions": [
                    "Move to higher ground immediately",
                    "Avoid contaminated water and areas",
                    "Contact emergency services",
                    "Seek nearest shelter or safe location"
                ],
                "confidence": 97,
                "language": "english"
            }
        }
        
        return responses.get(language, responses["english"])
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))