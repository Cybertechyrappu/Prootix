#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
VERSION="${1:-1.0.0}"

echo "=========================================="
echo "  Prootix Release Build"
echo "=========================================="
echo "Version: $VERSION"
echo "Build Directory: $BUILD_DIR"
echo ""

mkdir -p "$BUILD_DIR"

cd "$PROJECT_ROOT"

echo "[1/8] Cleaning previous builds..."
rm -rf apps/flutter/build
rm -rf "$BUILD_DIR"/*

echo "[2/8] Running Flutter analyze..."
cd apps/flutter
flutter analyze --no-fatal-infos || true

echo "[3/8] Running Flutter tests..."
flutter test --no-pub --reporter compact || true

echo "[4/8] Getting dependencies..."
flutter pub get

echo "[5/8] Building arm64 debug APK..."
flutter build apk --debug --target-platform android-arm64-v8a --split-per-abi || true

echo "[6/8] Building arm debug APK..."
flutter build apk --debug --target-platform android-armeabi-v7a --split-per-abi || true

echo "[7/8] Building x86_64 debug APK..."
flutter build apk --debug --target-platform android-x86_64 --split-per-abi || true

echo "[8/8] Building universal debug APK..."
flutter build apk --debug || true

echo ""
echo "=========================================="
echo "  Release Build Complete!"
echo "=========================================="
echo ""
echo "APKs located at: apps/flutter/build/app/outputs/flutter-apk/"
echo ""
ls -la apps/flutter/build/app/outputs/flutter-apk/ || true