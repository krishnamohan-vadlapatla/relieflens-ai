@echo off
REM ReliefLens AI - APK Build Script

echo ================================================
echo   ReliefLens AI - Build APK
echo ================================================
echo.

cd /d "%~dp0relieflens_app"

echo Step 1: Getting dependencies...
flutter pub get

if %errorlevel% neq 0 (
    echo.
    echo Error: flutter pub get failed
    pause
    exit /b 1
)

echo.
echo Step 2: Building release APK...
flutter build apk --release

if %errorlevel% neq 0 (
    echo.
    echo Error: Build failed
    pause
    exit /b 1
)

echo.
echo ================================================
echo   Build Complete!
echo ================================================
echo.
echo APK Location:
echo %~dp0relieflens_app\build\app\outputs\flutter-apk\app-release.apk
echo.
pause