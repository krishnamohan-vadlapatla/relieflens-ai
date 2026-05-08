# ReliefLens AI

<p align="center">
  <img src="docs/logo.png" alt="ReliefLens AI Logo" width="200"/>
</p>

<p align="center">
  <strong>Offline intelligence for disaster survival.</strong>
</p>

<p align="center">
  <a href="https://github.com/yourusername/relieflens-ai/stargazers">
    <img src="https://img.shields.io/github/stars/yourusername/relieflens-ai?style=social" alt="GitHub stars">
  </a>
  <a href="https://github.com/yourusername/relieflens-ai/network/members">
    <img src="https://img.shields.io/github/forks/yourusername/relieflens-ai?style=social" alt="GitHub forks">
  </a>
  <a href="https://github.com/yourusername/relieflens-ai/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/yourusername/relieflens-ai" alt="License">
  </a>
  <img src="https://img.shields.io/badge/Gemma-4.0-blue" alt="Gemma 4">
</p>

---

## 🚨 The Problem

When disasters strike, the infrastructure we depend on fails:
- **Internet connectivity drops** exactly when it's most needed
- **Communication networks collapse** preventing coordination
- **Language barriers** hinder effective aid distribution
- **Cloud AI services** become inaccessible

Traditional AI solutions require internet connectivity. ReliefLens AI requires nothing but a device.

## 💡 Our Solution

ReliefLens AI is a **deployable humanitarian operating system** that delivers AI-powered emergency response capabilities directly to disaster zones—completely offline.

### Features

| Feature | Description |
|---------|-------------|
| **AI Disaster Analyzer** | Upload disaster images for instant AI-powered analysis with severity ratings and recommended actions |
| **Voice Emergency Assistant** | Speak in Telugu, Hindi, or English. Get immediate emergency guidance in your language |
| **RAG Knowledge System** | Access WHO guidelines, Red Cross manuals, and first aid instructions offline |
| **Coordination Dashboard** | NGO/volunteer dashboard for real-time emergency status and rescue coordination |
| **Confidence + Safety Layer** | Every response includes confidence scores and safety verification prompts |

## 🏆 Built with Gemma 4

This project demonstrates the power of local AI inference using Google's Gemma 4 models:

- **Gemma 4 2B**: Runs on low-end devices with 4-bit quantization
- **Gemma 4 7B**: Enhanced accuracy on capable hardware
- **Local inference via Ollama**: Zero cloud dependency
- **Multilingual support**: Native Telugu, Hindi, English

## 📱 Screenshots

<div align="center">
  <img src="docs/screenshots/home.png" alt="Home Screen" width="250"/>
  <img src="docs/screenshots/analyzer.png" alt="Disaster Analyzer" width="250"/>
  <img src="docs/screenshots/voice.png" alt="Voice Assistant" width="250"/>
</div>

*Add your own screenshots in the `docs/screenshots/` directory*

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        User Input                           │
│              (Image / Voice / Text / Search)                │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                   Flutter Mobile App                        │
│                   (Dark Theme, Offline)                     │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                    FastAPI Backend                          │
│              (Ollama + ChromaDB + Whisper)                  │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                   Gemma 4 via Ollama                        │
│               (Local AI Inference)                          │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                   Emergency Knowledge Base                  │
│     (WHO, Red Cross, First Aid - Cached Locally)            │
└─────────────────────────────────────────────────────────────┘
```

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| Frontend | Flutter 3.x |
| Backend | FastAPI |
| AI Runtime | Ollama |
| Model | Gemma 4 (2B/7B) |
| Speech-to-Text | Whisper.cpp |
| Vector DB | ChromaDB |
| State Management | Riverpod |

## 🚀 Quick Start

### Prerequisites

- Flutter SDK 3.x
- Python 3.10+
- Ollama installed
- Gemma 4 model downloaded

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/relieflens-ai.git
cd relieflens-ai
```

### 2. Setup Backend

```bash
cd backend

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start Ollama (in another terminal)
ollama serve

# Pull Gemma 4 model
ollama pull gemma4:2b

# Start backend server
python main.py
```

The backend will run at `http://localhost:8000`

### 3. Setup Flutter App

```bash
cd relieflens_app

# Get dependencies
flutter pub get

# Run on connected device
flutter run
```

For Android emulator (backend runs on localhost):
```bash
# Use 10.0.2.2 instead of localhost for Android emulator
flutter run -d emulator-5554
```

### 4. Demo Mode

If Ollama isn't available, the app runs in demo mode with mock data. All UI features remain functional.

## 📖 Usage Guide

### Image Disaster Analyzer

1. Tap the **Camera** icon or select from gallery
2. Upload a disaster image (flood, fire, collapsed structure, etc.)
3. Wait for AI analysis (typically 3-5 seconds with Gemma 4)
4. View severity rating, detected risks, and recommended actions
5. Every result includes **confidence score** and **safety warnings**

### Voice Emergency Assistant

1. Hold the **microphone button**
2. Speak in **Telugu**, **Hindi**, or **English**
3. Release to process
4. Get instant emergency guidance in your language
5. Responses are prioritized by severity level

### Knowledge Base

1. Search for emergency topics
2. Filter by category (Flood, Medical, Earthquake, etc.)
3. Read detailed guides and procedures
4. All content is available offline

### Coordination Dashboard

1. View real-time emergency alerts
2. Monitor shelter occupancy
3. Track rescue priorities
4. Update incident statuses

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the backend directory:

```env
OLLAMA_HOST=http://localhost:11434
OLLAMA_MODEL=gemma4:2b
API_PORT=8000
LOG_LEVEL=info
```

### Changing the Gemma Model

The app supports both Gemma 4 2B and 7B:

```bash
# For 2B (faster, lower memory)
ollama pull gemma4:2b

# For 7B (better quality, higher memory)
ollama pull gemma4:7b
```

Update `OLLAMA_MODEL` in your `.env` file.

## 📂 Project Structure

```
relieflens-ai/
├── README.md
├── SPEC.md                    # Technical specification
├── KAGGLE_WRITEUP.md          # Hackathon writeup
├── backend/
│   ├── main.py               # FastAPI application
│   ├── config.py             # Configuration
│   ├── requirements.txt      # Python dependencies
│   ├── api/
│   │   └── routes/          # API endpoints
│   │       ├── image.py      # Image analysis
│   │       ├── voice.py      # Voice transcription
│   │       ├── chat.py       # Emergency chat
│   │       ├── knowledge.py  # RAG knowledge
│   │       └── dashboard.py  # Coordination
│   ├── services/
│   │   └── ollama_service.py # Gemma integration
│   └── models/
│       └── schemas.py        # Data models
├── relieflens_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app.dart          # Navigation
│   │   ├── core/             # Theme, constants
│   │   ├── features/         # Feature modules
│   │   │   ├── home/
│   │   │   ├── image_analyzer/
│   │   │   ├── voice_assistant/
│   │   │   ├── coordination/
│   │   │   └── knowledge/
│   │   ├── shared/           # Shared widgets, services
│   │   └── models/          # Data models
│   └── pubspec.yaml
└── docs/
    └── screenshots/         # Demo screenshots
```

## 🧪 Testing

### Backend Tests

```bash
cd backend
pytest tests/ -v
```

### Flutter Tests

```bash
cd relieflens_app
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Google DeepMind** for releasing Gemma 4 under permissive licensing
- **Ollama** for making local AI inference accessible
- **WHO** and **Red Cross** for open emergency response guidelines
- The humanitarian workers who inspired this project

---

<p align="center">
  <strong>When lives depend on it, offline isn't a feature—it's a requirement.</strong>
</p>

<p align="center">
  Built with ❤️ for the <a href="https://www.kaggle.com/competitions/gemma-4-good-hackathon">Gemma 4 Good Hackathon</a>
</p>