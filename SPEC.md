# Prootix - Android Linux Workstation Platform

## 1. Project Overview

**Project Name:** Prootix  
**Package Name:** `com.qorvode.prootix`  
**Application ID:** `com.qorvode.prootix`

**Core Functionality:** A futuristic Android Linux workstation platform that transforms Android devices into portable Linux workstations using PRoot containers, featuring modular Linux environments (Termux/Kali), terminal sessions, package management, and future desktop acceleration support.

## 2. Technology Stack & Choices

### Frontend
- **Framework:** Flutter 3.x (stable)
- **Language:** Dart 3.x
- **State Management:** Riverpod 2.x (flutter_riverpod)
- **Routing:** GoRouter 14.x
- **UI Library:** Material 3 with custom futuristic theme
- **Animations:** Flutter Animate 4.x
- **Architecture:** Clean Architecture (Presentation/Domain/Data layers)

### Native Android
- **Language:** Kotlin 1.9.x
- **Build:** Android Gradle Plugin 8.x
- **NDK:** Latest stable (r26+)
- **JNI:** Java Native Interface for native code bridging
- **Min SDK:** 24 (Android 7.0)
- **Target SDK:** 34 (Android 14)

### Linux Layer
- **Container Technology:** PRoot
- **Root Filesystem:** Debian/Kali base via rootfs tarballs
- **Shell:** bash/zsh
- **Package Manager:** apt (Kali), pkg (Termux compatibility)

### CI/CD
- **Platform:** GitHub Actions ONLY
- **Build Environment:** Ubuntu 22.04/24.04 runners
- **Artifact Storage:** GitHub Releases & Artifacts
- **Supported ABIs:** arm64-v8a, armeabi-v7a, x86_64

### Key Dependencies
```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  go_router: ^14.2.0
  flutter_animate: ^4.5.0
  dio: ^5.4.0
  path_provider: ^2.1.2
  shared_preferences: ^2.2.2
  permission_handler: ^11.3.0
  flutter_secure_storage: ^9.0.0
  flutter_local_notifications: ^17.0.0
```

## 3. Feature List

### Core Features (MVP)
1. **Onboarding System** - Environment selection with three modes
2. **Linux Installer** - Automated rootfs download, verification, extraction
3. **Terminal Emulator** - ANSI colors, Unicode, touch/keyboard support, tabs
4. **Session Manager** - Persistent sessions, background execution, restore
5. **Package Manager UI** - Search, install, update, uninstall with progress
6. **Repository Manager** - Mirror switching, health checks, source validation
7. **File Manager** - Android/Linux storage browsing, ZIP extraction
8. **SSH Client** - Integrated SSH terminal sessions
9. **Notification Service** - Background task notifications

### Advanced Features (Planned)
1. **Plugin System** - Extensible architecture
2. **Workspace Snapshots** - Environment state preservation
3. **Multiple Environments** - Simultaneous Termux + Kali
4. **Cloud Sync** - Configuration backup/restore
5. **Container Profiles** - Custom environment templates

## 4. UI/UX Design Direction

### Visual Style
- **Theme:** Futuristic, premium, AMOLED-optimized
- **Primary Approach:** Glassmorphism with subtle neon accents
- **Animations:** Smooth 60fps transitions, blur panels
- **Typography:** Modern monospace for terminal, sans-serif for UI

### Color Scheme
```
Primary: #00D9FF (Cyan neon)
Secondary: #7B2FFF (Purple neon)
Background: #0A0E14 (Deep dark)
Surface: #12161F (Card dark)
Accent: #00FF88 (Green neon)
Error: #FF4757 (Red)
```

### Layout Approach
- **Navigation:** Bottom navigation bar (5 items) + drawer
- **Sections:**
  - Home (dashboard)
  - Terminal (main terminal)
  - Linux (environment management)
  - Packages (package manager)
  - Settings (configuration)

### Screen Flow
1. Splash → Onboarding → Environment Selection → Installation → Home
2. Tab-based navigation with floating action buttons
3. Modal sheets for quick actions
4. Gesture-based navigation support

## 5. Architecture

### Clean Architecture Layers
```
lib/
├── core/              # Shared utilities, constants, theme
├── features/          # Feature modules
│   ├── onboarding/
│   ├── terminal/
│   ├── linux/
│   ├── packages/
│   ├── sessions/
│   ├── files/
│   └── settings/
├── infrastructure/    # Repositories, data sources
└── main.dart
```

### Native Layer Structure
```
native/
├── app/              # Android app module
│   ├── src/main/java/com/qorvode/prootix/
│   └── src/main/kotlin/com/qorvode/prootix/
├── proot/           # PRoot native code
└── terminal/        # Terminal emulation native code
```

## 6. Repository Structure
```
prootix/
├── apps/
│   ├── android/      # Android native code
│   └── flutter/      # Flutter application
├── native/           # Native C/C++ libraries
├── scripts/         # Build & bootstrap scripts
├── docs/            # Documentation
├── .github/
│   └── workflows/   # CI/CD pipelines
├── SPEC.md
├── README.md
└── CONTRIBUTING.md
```

## 7. GitHub Actions Workflows

### Workflows Required
1. **flutter-ci.yml** - Flutter analysis, test, build
2. **pr-validation.yml** - PR checks, lint, test
3. **release.yml** - Stable release automation
4. **nightly.yml** - Daily nightly builds

### Build Matrix
- **Flutter SDK:** 3.19.x, 3.22.x, latest stable
- **Android SDK:** 34 (target), 24 (min)
- **ABI Splits:** arm64-v8a, armeabi-v7a, x86_64

## 8. Security Considerations

- Rootfs checksum verification (SHA256)
- Repository signature validation
- Sandboxed PRoot environments
- No privilege escalation
- Secure storage for credentials
- Isolated filesystem namespaces

## 9. Installation Modes

### Minimal Terminal
- **Size:** 300MB-800MB
- **Components:** Shell, Python, Node.js, Git, SSH, utilities
- **Repository:** Termux official

### Kali Minimal
- **Size:** 1-2GB
- **Components:** Kali base, networking tools, pentesting basics
- **Repository:** Kali rolling

### Full Kali Desktop
- **Size:** 4-10GB+
- **Components:** XFCE, GUI apps, X11, full Kali toolset
- **Repository:** Kali rolling
