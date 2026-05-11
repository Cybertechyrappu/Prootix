#!/bin/bash

set -e

FLUTTER_VERSION="${FLUTTER_VERSION:-3.22.0}"
ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-/opt/android-sdk}"
NDK_VERSION="${NDK_VERSION:-26b}"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=========================================="
echo "  Prootix Build Script"
echo "=========================================="
echo "Flutter Version: $FLUTTER_VERSION"
echo "Android SDK: $ANDROID_SDK_ROOT"
echo "Project Root: $PROJECT_ROOT"
echo ""

cd "$PROJECT_ROOT"

echo "[1/5] Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Please install Flutter $FLUTTER_VERSION"
    exit 1
fi

echo "[2/5] Installing Flutter dependencies..."
cd apps/flutter
flutter pub get

echo "[3/5] Running Flutter analyze..."
flutter analyze --no-fatal-infos || true

echo "[4/5] Building debug APK..."
flutter build apk --debug

echo "[5/5] Building release APK..."
flutter build apk --release

echo ""
echo "=========================================="
echo "  Build Complete!"
echo "=========================================="
echo "APKs available at:"
echo "  - apps/flutter/build/app/outputs/flutter-apk/app-debug.apk"
echo "  - apps/flutter/build/app/outputs/flutter-apk/app-release.apk"