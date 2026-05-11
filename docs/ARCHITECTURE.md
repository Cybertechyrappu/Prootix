# Prootix Architecture Documentation

## Overview

Prootix is a modern Android Linux workstation platform that transforms Android devices into portable Linux workstations using PRoot containers.

## Architecture Layers

### 1. Flutter UI Layer
- **Framework**: Flutter 3.x with Material 3
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Theme**: Futuristic dark theme with neon accents

### 2. Bridge Layer (Platform Channels)
- **Purpose**: Communication between Flutter and Android native code
- **Implementation**: Method channels for JNI calls

### 3. Android Native Layer (Kotlin)
- **Services**: TerminalService, DownloadService
- **Receivers**: BootReceiver for auto-start
- **Native**: JNI bridge for PRoot integration

### 4. Linux Container Layer (PRoot)
- **Technology**: PRoot for user-space Linux container
- **Filesystem**: Extracted rootfs images
- **Package Manager**: apt (Kali) / pkg (Termux)

## Data Flow

```
Flutter App → MethodChannel → Kotlin Native → JNI → C++ Native → PRoot Container
                    ↓                                    ↓
              Android Services                     Linux Environment
```

## Key Components

### Terminal Service
- Manages active terminal sessions
- Handles background execution
- Provides persistent session state

### Download Service
- Handles rootfs downloads
- Progress tracking
- Checksum verification

### Repository Manager
- Manages package sources
- Mirror switching
- Health checks

## Security Model

1. PRoot containers run without root privileges
2. Filesystem isolation through PRoot
3. Checksum verification for all downloads
4. Repository signature validation

## Build Matrix

| Flutter | Android SDK | NDK | Min SDK | Target SDK |
|---------|-------------|-----|---------|------------|
| 3.22.x | 34 | r26+ | 24 | 34 |