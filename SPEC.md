# ReliefLens AI - Technical Specification

## 1. Concept & Vision

**ReliefLens AI** is an offline-first humanitarian operating system designed for disaster zones where infrastructure collapses. It delivers local AI intelligence, emergency guidance, multilingual support, disaster analysis, and aid coordination directly on low-end devices—without any internet dependency.

The experience should feel like a **deployable humanitarian operating system**: urgent, emotional, socially important, globally scalable, and visually cinematic. This is not an AI chatbot or research prototype—it's a mission-critical tool that saves lives.

---

## 2. Design Language

### Aesthetic Direction
Inspired by **Tesla UI, Linear, Stripe, Apple Health, and modern emergency alert systems**. Clean, minimal, professional, trustworthy. Dark mode by default with high-contrast emergency states.

### Color Palette
```
Primary:       #1E40AF (Deep Blue - trust, stability)
Secondary:     #3B82F6 (Bright Blue - action)
Alert:         #F97316 (Emergency Orange - urgency)
Danger:        #DC2626 (Critical Red - life-threatening)
Success:       #10B981 (Green - safe, resolved)
Warning:       #FBBF24 (Yellow - caution)
Background:    #0F172A (Dark Slate)
Surface:       #1E293B (Elevated Dark)
Surface Light: #334155 (Cards, inputs)
Text Primary:  #F8FAFC (Near White)
Text Secondary:#94A3B8 (Muted)
```

### Typography
- **Primary Font**: Inter (clean, modern, highly readable)
- **Headings**: Inter Bold, 24-32px
- **Body**: Inter Regular, 14-16px
- **Emergency Text**: Inter Black, uppercase for alerts
- **Monospace**: JetBrains Mono (for confidence scores, data)

### Spatial System
- Base unit: 8px
- Card padding: 16-24px
- Section spacing: 32-48px
- Border radius: 12px (cards), 8px (buttons), 24px (pills)

### Motion Philosophy
- **Transitions**: 200-300ms ease-out for state changes
- **Loading**: Pulsing gradients, skeleton screens
- **Alerts**: Subtle shake animation for critical states
- **Cards**: Fade-in with slight upward translation (staggered 50ms)

### Visual Assets
- **Icons**: Lucide Icons (clean, consistent)
- **Illustrations**: Minimal line art for empty states
- **Gradients**: Subtle blue-to-purple for hero sections
- **Emergency**: Red/orange glow effects for critical alerts

---

## 3. Layout & Structure

### App Architecture
```
┌─────────────────────────────────────────┐
│           ReliefLens AI                 │
│    "Offline intelligence for            │
│         disaster survival"              │
├─────────────────────────────────────────┤
│  ┌─────────────────────────────────┐   │
│  │     AI DISASTER ANALYZER       │   │
│  │     [Camera] [Gallery]         │   │
│  │     Emergency Analysis Cards   │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   VOICE EMERGENCY ASSISTANT    │   │
│  │   🎤 Multilingual Voice Input  │   │
│  │   Telugu / Hindi / English      │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   RELIEF COORDINATION           │   │
│  │   Dashboard (NGO/Volunteer)     │   │
│  └─────────────────────────────────┘   │
│                                         │
│  ┌─────────────────────────────────┐   │
│  │   OFFLINE KNOWLEDGE BASE        │   │
│  │   Emergency SOPs & Guides       │   │
│  └─────────────────────────────────┘   │
├─────────────────────────────────────────┤
│  [🏠] [📷] [🎤] [📊] [📚]             │
│  Bottom Navigation                      │
└─────────────────────────────────────────┘
```

### Screen Flow
1. **Home/Dashboard** - Quick access to all features, status overview
2. **Image Analyzer** - Camera/gallery upload, emergency analysis cards
3. **Voice Assistant** - Push-to-talk, conversation history, emergency responses
4. **Coordination Dashboard** - Emergency queues, shelter status, alerts
5. **Knowledge Base** - Searchable offline emergency guides

### Responsive Strategy
- Mobile-first (primary target: Android low-end devices)
- Single column layout on mobile
- Two-column on tablets (coordination dashboard)
- Touch-friendly: minimum 48px touch targets

---

## 4. Features & Interactions

### Feature 1: AI Disaster Image Analyzer

**Core Flow:**
1. User taps camera icon or selects from gallery
2. Image is captured/selected
3. Loading state: "Analyzing disaster scene..."
4. AI processes locally via Gemma 4
5. Emergency card appears with analysis

**Emergency Card Format:**
```
┌──────────────────────────────────────┐
│ ⚠️  DISASTER ANALYSIS COMPLETE       │
├──────────────────────────────────────┤
│ TYPE: Urban Flood                    │
│ SEVERITY: ████████░░ CRITICAL        │
│                                      │
│ RISKS DETECTED:                      │
│ • Electrical exposure                │
│ • Unsafe water current               │
│ • Structural collapse risk           │
│                                      │
│ RECOMMENDED ACTIONS:                  │
│ 1. Immediate evacuation              │
│ 2. Avoid submerged metal objects     │
│ 3. Prioritize elderly and children   │
│                                      │
│ AI CONFIDENCE: 94%                   │
│ ⚠️ Verify with emergency personnel    │
└──────────────────────────────────────┘
```

**Interactions:**
- Tap to expand details
- Share button (saves locally, exports summary)
- "New Analysis" to reset
- Error state: "Image unclear, please retake"

### Feature 2: Offline Voice Emergency Assistant

**Core Flow:**
1. User holds mic button
2. Whisper STT processes locally
3. Detects language (Telugu/Hindi/English)
4. Gemma 4 generates contextual response
5. Text displayed + optional TTS playback

**Demo Moment:**
```
User (Telugu):
"నా అమ్మకు గాయం అయింది, నీళ్లు ఇంట్లోకి వచ్చాయి."

AI Response:
┌──────────────────────────────────────┐
│ 🔴 EMERGENCY PRIORITY: HIGH          │
│                                      │
│ Detected Situation:                  │
│ • Flood intrusion detected           │
│ • Possible injury to family member  │
│ • Immediate relocation required      │
│                                      │
│ Recommended Actions:                 │
│ 1. Move victim to elevated dry area  │
│ 2. Avoid contaminated floodwater    │
│ 3. Apply basic first aid if trained │
│ 4. Seek nearest relief shelter       │
│                                      │
│ 🗣️ Language: Telugu | Confidence: 97%│
└──────────────────────────────────────┘
```

**Interactions:**
- Long-press to record
- Release to process
- Tap history to review past conversations
- Language indicator badge

### Feature 3: Relief Coordination Dashboard

**Target Users:** NGO coordinators, volunteers

**Dashboard Cards:**
```
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│  EMERGENCY  │ │   MEDICAL   │ │   FOOD      │
│  ALERTS     │ │   ALERTS    │ │  SHORTAGE   │
│     12      │ │     8       │ │     5       │
│  ▲ Critical │ │  ⚠️ High    │ │  ▼ Moderate │
└─────────────┘ └─────────────┘ └─────────────┘

┌─────────────────────────────────────┐
│ SHELTER OCCUPANCY                   │
│ ┌──────────────────────────────┐    │
│ │ Zone A: ████████░░ 80%      │    │
│ │ Zone B: █████░░░░░ 50%      │    │
│ │ Zone C: ██████████ 95% FULL │    │
│ └──────────────────────────────┘    │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ RESCUE PRIORITY QUEUE               │
│ #1 🔴 House collapse - 3 trapped    │
│ #2 🟠 Flood rescue - family of 4    │
│ #3 🟡 Medical - elderly injured      │
└─────────────────────────────────────┘
```

**Interactions:**
- Tap card to expand details
- Swipe to update status
- Filter by severity/location
- No complex maps - clean cards only

### Feature 4: Offline RAG Knowledge System

**Stored Documents:**
- WHO Emergency Guidelines
- Red Cross Manuals
- Flood Safety SOPs
- First Aid Instructions
- Earthquake Response
- Cyclone Preparedness

**Search Experience:**
- Natural language queries
- Instant local retrieval
- Source attribution
- Confidence indicators

### Feature 5: Confidence + Safety Layer

**Every Response Includes:**
```
┌─────────────────────────────────────┐
│ AI Confidence: 94%                  │
│ ████████████████░░░░                │
│                                      │
│ ⚠️ This analysis is AI-generated.   │
│ Always verify with emergency        │
│ personnel when possible.            │
└─────────────────────────────────────┘
```

---

## 5. Component Inventory

### Emergency Card
- **Default**: Blue border, dark surface
- **Warning**: Orange border, subtle glow
- **Critical**: Red border, pulsing glow
- **Resolved**: Green border, muted

### Confidence Bar
- 0-50%: Red fill
- 51-75%: Orange fill
- 76-90%: Yellow fill
- 91-100%: Green fill

### Action Button
- **Default**: Primary blue, white text
- **Hover/Press**: Darken 10%
- **Disabled**: Gray, 50% opacity
- **Loading**: Spinner overlay

### Input Fields
- Dark surface (#1E293B)
- Light border on focus (#3B82F6)
- Error state: Red border
- Placeholder: Muted text

### Bottom Navigation
- 5 items: Home, Camera, Voice, Dashboard, Knowledge
- Active: Primary blue icon + label
- Inactive: Muted gray icon

### Voice Waveform
- Animated bars during recording
- Color: Primary blue gradient

---

## 6. Technical Approach

### Frontend: Flutter
```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   ├── constants/
│   └── utils/
├── features/
│   ├── home/
│   ├── image_analyzer/
│   ├── voice_assistant/
│   ├── coordination/
│   └── knowledge/
├── shared/
│   ├── widgets/
│   └── services/
└── models/
```

### Backend: FastAPI
```
backend/
├── main.py
├── api/
│   ├── routes/
│   └── deps.py
├── services/
│   ├── ai_service.py
│   ├── image_analysis.py
│   ├── voice_service.py
│   └── rag_service.py
├── models/
├── database/
└── requirements.txt
```

### AI Runtime: Ollama
- **Model**: gemma4:2b (or gemma4:7b for larger devices)
- Local inference only
- No cloud dependencies

### Speech-to-Text: Whisper
- whisper.cpp integration
- ONNX model for mobile
- Supports: Telugu, Hindi, English

### RAG: LangChain + ChromaDB
- Vector embeddings stored locally
- Chunked document retrieval
- Context-aware generation

### Storage: SQLite
- Lightweight, offline-friendly
- Stores: conversations, analysis history, shelter data

### API Endpoints
```
POST /api/analyze-image     - Disaster image analysis
POST /api/transcribe        - Voice to text
POST /api/chat              - Emergency chat
GET  /api/knowledge/search   - RAG knowledge search
GET  /api/dashboard/status   - Coordination status
POST /api/dashboard/alert    - Submit emergency alert
```

### Architecture
```
User Input
    ↓
Flutter Mobile App
    ↓
FastAPI Local Backend (localhost)
    ↓
Gemma 4 via Ollama (local inference)
    ↓
RAG Retrieval System
    ↓
Emergency Knowledge Base (ChromaDB)
    ↓
AI Emergency Response
```

---

## 7. Build Order

1. **Core Infrastructure** - Repo setup, Flutter, FastAPI, Ollama connection
2. **Disaster Image Analyzer** - Primary demo feature, polished cards
3. **Voice Emergency Assistant** - Whisper STT, multilingual support
4. **RAG Knowledge Integration** - Document indexing, grounded responses
5. **Coordination Dashboard** - Emergency cards, status panels
6. **UI Polish** - Animations, gradients, typography, loading states
7. **Offline Optimization** - Airplane mode testing, low-end device compatibility
8. **Final Polish** - Bug fixes, smoother flows, README

---

## 8. Success Metrics

- Offline functionality verified (airplane mode)
- Image analysis completes in < 30 seconds
- Voice response in < 10 seconds
- RAG retrieval in < 2 seconds
- Clean, professional UI that feels "expensive"
- Zero cloud dependencies
- Works on low-end Android devices
