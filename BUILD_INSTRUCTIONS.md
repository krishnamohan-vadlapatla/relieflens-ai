# ReliefLens AI - Build Instructions

## Prerequisites

1. **Flutter SDK** (3.x or later)
   - Download from: https://flutter.dev/docs/get-started/install
   - Add Flutter to your PATH

2. **Android SDK**
   - Install Android Studio: https://developer.android.com/studio
   - Or install standalone SDK tools

## Build Commands

### Option 1: Debug APK (Recommended for testing)

```bash
cd relieflens_app
flutter pub get
flutter build apk --debug
```

The APK will be at: `build/app/outputs/flutter-apk/app-debug.apk`

### Option 2: Release APK (For submission)

```bash
cd relieflens_app
flutter pub get
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### Option 3: Build with bundle (For Play Store)

```bash
flutter build appbundle --release
```

## Troubleshooting

### If you get "Flutter not found"
Add Flutter to your PATH:
```powershell
# Windows - Add to User PATH
$env:PATH += ";C:\path\to\flutter\bin"
```

### If Android SDK not found
```bash
flutter config --android-sdk "C:\Users\YourName\AppData\Local\Android\Sdk"
```

### Accept Android licenses
```bash
flutter doctor --android-licenses
```

## Quick Build Script

Save as `build.bat` and run:

```batch
@echo off
echo Building ReliefLens AI APK...
cd /d "%~dp0relieflens_app"
flutter pub get
flutter build apk --release
echo.
echo Build complete! APK at: relieflens_app\build\app\outputs\flutter-apk\app-release.apk
pause
```