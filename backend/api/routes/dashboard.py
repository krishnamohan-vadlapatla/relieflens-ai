from fastapi import APIRouter, HTTPException
from datetime import datetime

router = APIRouter()

@router.get("/dashboard/status")
async def get_dashboard_status():
    return {
        "alerts": [
            {"id": "1", "type": "Emergency Alerts", "severity": "Critical", "location": "Zone A, B", "time": "10 min ago", "count": 12},
            {"id": "2", "type": "Medical Alerts", "severity": "High", "location": "Multiple zones", "time": "15 min ago", "count": 8},
        ],
        "shelters": [
            {"name": "Zone A Shelter", "occupancy": 0.80, "capacity": 500, "current": 400},
            {"name": "Zone B Shelter", "occupancy": 0.50, "capacity": 300, "current": 150},
        ],
        "rescue_queue": [
            {"priority": 1, "type": "House Collapse", "details": "3 people trapped", "location": "Sector 7", "status": "Critical"},
            {"priority": 2, "type": "Flood Rescue", "details": "Family of 4", "location": "Sector 12", "status": "High"},
        ],
        "stats": {
            "people_rescued": 147,
            "medical_aid": 89,
            "meals_served": 2400,
            "water_distributed": 5200,
        },
        "timestamp": datetime.now().isoformat(),
    }

@router.post("/dashboard/alert")
async def submit_alert(alert: dict):
    return {"success": True, "alert": {**alert, "id": "new"}, "message": "Alert submitted"}