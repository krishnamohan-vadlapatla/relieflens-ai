# ReliefLens AI: When Lives Depend On It, Offline Isn't Optional

**Gemma 4 Good Hackathon — Global Resilience Track**

---

## Executive Summary

When Cyclone Amphan devastated West Bengal in 2020, communication networks failed within hours. Families couldn't call for help. Coordination between agencies collapsed. Traditional AI solutions—dependent on internet connectivity—were useless when needed most. This is the problem ReliefLens AI solves.

**ReliefLens AI is a deployable humanitarian operating system that delivers Gemma 4-powered emergency response completely offline.** Our solution brings local AI intelligence, multilingual voice support, disaster image analysis, and aid coordination to any Android device—regardless of network availability.

We're not building another AI chatbot. We're building mission-critical infrastructure for the world's most vulnerable populations.

---

## The Problem We Solve

**1.2 billion people** live in areas at high risk of natural disasters. When catastrophe strikes:

| Challenge | Impact | Our Solution |
|-----------|--------|--------------|
| Internet fails | AI services become inaccessible | 100% local inference |
| Communication breaks | Families can't call for help | Voice in Telugu/Hindi/English |
| Coordination collapses | Agencies work in silos | Real-time dashboard |
| Language barriers | Aid distribution fails | Native multilingual support |
| Cloud dependency | No resilience | Zero network requirements |

### Why Existing Solutions Fail

1. **Cloud AI requires connectivity** — When infrastructure is down, so is the AI
2. **Single language support** — English-only apps exclude billions
3. **No offline knowledge** — Guidelines unavailable when needed most
4. **No coordination tools** — NGOs work with spreadsheets and WhatsApp
5. **No safety layers** — AI hallucinations in emergency contexts

---

## Our Solution: ReliefLens AI

### Core Architecture

```
User Input (Image / Voice / Text)
         ↓
   Flutter Mobile App
         ↓
   FastAPI Local Backend
         ↓
   Gemma 4 via Ollama
   (Local Inference)
         ↓
   RAG Retrieval System
   (ChromaDB)
         ↓
Emergency Knowledge Base
         ↓
   AI Response with
   Confidence Scores
```

### Key Differentiators

| Feature | ReliefLens AI | Typical Apps |
|---------|---------------|--------------|
| **Offline Mode** | 100% functional | No |
| **Language Support** | Telugu, Hindi, English | English only |
| **Knowledge Base** | Offline WHO/Red Cross | None |
| **Confidence Scores** | Every response | Rarely |
| **Coordinator Dashboard** | Real-time | None |
| **Low-End Device** | Android 6.0+ | Requires high-end |

---

## Features

### Feature 1: AI Disaster Image Analyzer

**The Primary Demo Feature**

Users upload disaster photos—floods, collapsed structures, injuries, blocked roads. Gemma 4 provides:

- **Disaster Type Classification** — Flood, earthquake, cyclone, fire, collapse
- **Severity Assessment** — CRITICAL / HIGH / MODERATE / LOW
- **Risk Detection** — Specific hazards with descriptions
- **Action Recommendations** — Numbered, prioritized steps
- **Confidence Score** — Transparency in AI limitations

**Demo Output:**
```
DISASTER TYPE: Urban Flood
SEVERITY: ████████░░ CRITICAL (94%)

RISKS DETECTED:
• Electrical exposure from submerged power lines
• Unsafe water current with debris
• Structural collapse risk from saturation
• Contaminated water spreading disease

RECOMMENDED ACTIONS:
1. Immediate evacuation to higher ground
2. Avoid all submerged metal objects
3. Prioritize elderly, children, disabled
4. Do not attempt to drive through floodwater
5. Move to nearest designated shelter

AI CONFIDENCE: 94%
⚠️ Verify with emergency personnel
```

### Feature 2: Multilingual Voice Emergency Assistant

**The Emotional Demo Feature**

Users speak in their native language. The system:

1. **Transcribes locally** — Whisper.cpp for offline speech-to-text
2. **Detects language** — Unicode script recognition for Telugu/Hindi/English
3. **Generates response** — Gemma 4 contextual emergency guidance
4. **Prioritizes situations** — Emergency level assessment

**Demo Scenario:**

User speaks (Telugu):
> "నా అమ్మకు గాయం అయింది, నీళ్లు ఇంట్లోకి వచ్చాయి"
>
> *(My mother is injured, water has come into the house)*

AI Response:
```
🔴 EMERGENCY PRIORITY: HIGH

Detected Situation:
• Flood intrusion detected
• Possible injury to family member
• Immediate relocation required

Recommended Actions:
1. Move victim to elevated dry area
2. Avoid contaminated floodwater
3. Apply basic first aid if trained
4. Seek nearest relief shelter

Language: Telugu | Confidence: 97%
```

### Feature 3: Offline RAG Knowledge System

**Makes AI Trustworthy**

Emergency knowledge stored locally:

- WHO Emergency Guidelines
- Red Cross Manuals
- Flood Safety SOPs
- First Aid Instructions
- Earthquake Protocols
- Cyclone Preparedness

**Technical Implementation:**

- **Vector embeddings** stored in ChromaDB
- **Semantic search** for natural language queries
- **Grounded responses** with source attribution
- **Source verification** from authoritative sources

### Feature 4: Coordination Dashboard

**Makes It Real for NGOs**

Clean, card-based interface showing:

- **Emergency Alerts** — By severity and location
- **Shelter Occupancy** — Capacity tracking across zones
- **Rescue Priority Queue** — Real-time task management
- **Quick Statistics** — People rescued, supplies distributed

No complex maps. Just actionable information at a glance.

### Feature 5: Confidence + Safety Layer

**For the Safety & Trust Track**

Every AI response includes:

1. **Confidence Percentage** — Visual indicator of certainty
2. **Uncertainty Warnings** — When confidence is low
3. **Verification Prompts** — "Verify with emergency personnel"
4. **Safety Disclaimers** — Appropriate for critical decisions

---

## Technical Implementation

### Gemma 4 Integration

**How we use Gemma 4's unique features:**

1. **Local Inference** — Ollama deployment for zero connectivity
2. **Quantization** — 4-bit models for low-end devices (1.5GB RAM)
3. **Instruction Following** — Structured JSON output parsing
4. **Multilingual Capability** — Native Telugu/Hindi/English support
5. **Function Calling** — Extracting structured data from responses

**Model Selection:**
- `gemma4:2b` — Low-end devices (primary target)
- `gemma4:7b` — Capable devices (enhanced accuracy)

### Backend Implementation

```python
# Ollama integration for local inference
async def generate_ai_response(prompt: str, system: str):
    payload = {
        "model": "gemma4:2b",
        "prompt": prompt,
        "stream": False,
        "options": {
            "temperature": 0.5,
            "num_predict": 512,
        }
    }
    response = await client.post(
        f"{OLLAMA_URL}/api/generate",
        json=payload
    )
    return response.json()["response"]
```

### Mobile App Architecture

**Flutter with Riverpod:**

- **Clean separation** of concerns (screens, providers, services)
- **Reactive state management** for real-time updates
- **Offline-first** data persistence with SQLite
- **Dark theme UI** optimized for emergency conditions

---

## Challenges Overcome

### Challenge 1: Low-Resource Deployment

**Problem:** Target devices have limited RAM and CPU.

**Solution:** Gemma 4 2B with 4-bit quantization via Ollama, reducing memory footprint to ~1.5GB while maintaining response quality.

### Challenge 2: Language Detection

**Problem:** Telugu and Hindi use different scripts that look similar to algorithms.

**Solution:** Implemented Unicode range detection (0x0C00-0x0C7F for Telugu, 0x0900-0x097F for Hindi) combined with keyword analysis.

### Challenge 3: Grounded Responses

**Problem:** LLMs can hallucinate in emergency situations where accuracy is critical.

**Solution:** RAG system provides retrieval-grounded generation. Confidence scores and safety warnings reinforce reliability.

### Challenge 4: Offline Functionality

**Problem:** Traditional apps assume connectivity.

**Solution:** All inference happens locally via Ollama. The app detects backend availability and functions entirely offline.

---

## Impact & Scalability

### Current Impact

- **Production-ready** with all features functional
- **Language support** for 3 major Indian languages (affecting 600M+ people)
- **Low resource requirements** (2GB RAM minimum)
- **Works on Android 6.0+** (94% of devices)

### Scalability Path

| Enhancement | Timeline | Priority |
|-------------|----------|----------|
| Bengali, Tamil, Marathi support | Q3 2026 | High |
| Offline map integration | Q3 2026 | High |
| Team coordination features | Q4 2026 | Medium |
| Gemma 4 fine-tuning | Q4 2026 | Medium |
| AR damage assessment | Q1 2027 | Low |

---

## Demo Video Highlights

Our 3-minute submission video showcases:

1. **Opening Hook (0:00-0:15)** — "When disaster strikes, the internet fails. ReliefLens doesn't."

2. **Image Analysis (0:15-1:00)** — Upload flood photo → AI analysis with severity and actions

3. **Voice Assistant (1:00-1:45)** — Speak Telugu → Receive prioritized emergency guidance

4. **Knowledge Base (1:45-2:15)** — Search for flood safety → Grounded response with sources

5. **Dashboard (2:15-2:45)** — NGO coordination view with real-time status

6. **Emotional Close (2:45-3:00)** — "Offline intelligence that saves lives"

---

## Conclusion

ReliefLens AI demonstrates that frontier AI capabilities can be deployed in the most challenging connectivity environments. By leveraging Gemma 4's local inference, we provide:

- **Reliability** — Works when networks don't
- **Accessibility** — Runs on low-end devices
- **Trustworthiness** — Grounded responses with confidence indicators
- **Multilingual support** — Telugu, Hindi, English with automatic detection
- **Real-world utility** — Addresses a genuine humanitarian need

The judges will see a functioning system backed by production-quality code, thoughtful architecture, and a clear path to deployment in actual disaster response scenarios.

**When lives depend on it, offline isn't a feature—it's a requirement.**

---

## Links

- **GitHub Repository:** https://github.com/krishnamohan-vadlapatla/relieflens-ai
- **Live Demo:** APK available at repository releases
- **Video:** YouTube link (attached to submission)

---

*Submitted for the Gemma 4 Good Hackathon*
*Global Resilience Track*
*May 2026*