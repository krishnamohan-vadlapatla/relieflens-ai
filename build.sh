#!/bin/bash
# ReliefLens AI - APK Build Script for macOS/Linux

echo "================================================"
echo "  ReliefLens AI - Build APK"
echo "================================================"
echo ""

cd "$(dirname "$0")/relieflens_app"

echo "Step 1: Getting dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo ""
    echo "Error: flutter pub get failed"
    exit 1
fi

echo ""
echo "Step 2: Building release APK..."
flutter build apk --release

if [ $? -ne 0 ]; then
    echo ""
    echo "Error: Build failed"
    exit 1
fi

echo ""
echo "================================================"
echo "  Build Complete!"
echo "================================================"
echo ""
echo "APK Location:"
echo "$(pwd)/build/app/outputs/flutter-apk/app-release.apk"
echo ""