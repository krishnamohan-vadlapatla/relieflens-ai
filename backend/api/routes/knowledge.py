from fastapi import APIRouter, HTTPException, Query
from typing import Optional

router = APIRouter()

KNOWLEDGE_BASE = [
    {
        "id": "1",
        "title": "Flood Emergency Response",
        "category": "Flood",
        "content": "Move to higher ground immediately. Avoid walking or driving through floodwater. Do not touch electrical equipment if wet.",
        "tags": ["Flood", "Emergency", "Evacuation", "Safety"],
    },
    {
        "id": "2",
        "title": "First Aid for Injuries",
        "category": "Medical",
        "content": "Apply direct pressure for bleeding. Cool burns under running water. Do not move fracture victims.",
        "tags": ["First Aid", "Medical", "Emergency", "Injuries"],
    },
    {
        "id": "3",
        "title": "Earthquake Safety",
        "category": "Earthquake",
        "content": "DROP to hands and knees. Take COVER under sturdy furniture. HOLD ON until shaking stops.",
        "tags": ["Earthquake", "Safety", "Emergency", "Drop Cover Hold"],
    },
    {
        "id": "4",
        "title": "Cyclone Preparedness",
        "category": "Cyclone",
        "content": "Secure loose outdoor items. Stay indoors away from windows. Listen to emergency broadcasts.",
        "tags": ["Cyclone", "Typhoon", "Emergency", "Preparation"],
    },
    {
        "id": "5",
        "title": "Fire Emergency Protocol",
        "category": "Fire",
        "content": "Alert others. Call emergency services. Evacuate using stairs. Close doors behind you.",
        "tags": ["Fire", "Emergency", "Evacuation", "Safety"],
    },
]

@router.get("/knowledge/search")
async def search_knowledge(q: str = Query(..., description="Search query"), category: Optional[str] = None):
    query_lower = q.lower()
    results = []
    
    for item in KNOWLEDGE_BASE:
        if category and item["category"] != category:
            continue
        score = 0
        if query_lower in item["title"].lower():
            score += 10
        if query_lower in item["content"].lower():
            score += 5
        for tag in item["tags"]:
            if query_lower in tag.lower():
                score += 3
        if score > 0:
            results.append({**item, "relevance_score": score})
    
    results.sort(key=lambda x: x["relevance_score"], reverse=True)
    return {"results": results[:10], "query": q, "total_results": len(results)}

@router.get("/knowledge/categories")
async def get_categories():
    return {"categories": list(set(item["category"] for item in KNOWLEDGE_BASE))}

@router.get("/knowledge/{item_id}")
async def get_knowledge_item(item_id: str):
    for item in KNOWLEDGE_BASE:
        if item["id"] == item_id:
            return item
    raise HTTPException(status_code=404, detail="Knowledge item not found")