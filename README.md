# Prootix

**A modern Android Linux workstation platform with modular Linux environments, terminal sessions, and future desktop acceleration support.**

![Prootix Banner](docs/images/banner.png)

## Overview

Prootix transforms your Android device into a portable Linux workstation using PRoot containers. Inspired by Termux and Kali NetHunter, Prootix provides a premium developer experience with futuristic UI design.

## Features

- **Modular Linux Environments**: Choose between Minimal Terminal, Kali Minimal, or Full Kali Desktop
- **Terminal Emulator**: Full ANSI color support, Unicode, touch scrolling, tabs, and split terminals
- **Session Manager**: Persistent sessions with background execution support
- **Package Manager UI**: Search, install, update, and uninstall packages with a modern interface
- **Repository Manager**: Support for Termux and Kali repositories with mirror switching
- **SSH Client**: Integrated SSH terminal sessions
- **File Manager**: Browse Android and Linux storage, extract archives
- **Future Desktop Support**: Architecture ready for X11 and Wayland acceleration

## Installation Modes

### 1. Minimal Terminal
- **Size**: 300MB–800MB
- **Components**: Shell, Python, Node.js, Git, SSH, utilities
- **Repository**: Termux official repositories

### 2. Kali Minimal
- **Size**: 1–2GB
- **Components**: Kali base, networking tools, pentesting basics
- **Repository**: Kali rolling

### 3. Full Kali Desktop
- **Size**: 4–10GB+
- **Components**: XFCE, GUI apps, X11, full Kali toolset
- **Repository**: Kali rolling

## Tech Stack

- **Frontend**: Flutter 3.x, Material 3, Riverpod, GoRouter
- **Native Android**: Kotlin, JNI, Android NDK
- **Linux Layer**: PRoot, BusyBox, Debian/Kali rootfs
- **CI/CD**: GitHub Actions (builds run remotely only)

## Project Structure

```
prootix/
├── apps/
│   ├── android/          # Android native code
│   └── flutter/          # Flutter application
├── native/                # Native C/C++ libraries
├── scripts/              # Build & bootstrap scripts
├── docs/                 # Documentation
├── .github/
│   └── workflows/        # CI/CD pipelines
├── SPEC.md
└── README.md
```

## Building

All builds are performed through GitHub Actions. No local compilation is required.

### Available Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `flutter-ci.yml` | Push/PR | Flutter analysis, tests, debug builds |
| `pr-validation.yml` | PR | Quality checks, security scans |
| `release.yml` | Tag/push | Release APK and AAB builds |
| `nightly.yml` | Daily/schedule | Nightly builds with auto-upload |

### Supported ABIs

- `arm64-v8a` (64-bit ARM)
- `armeabi-v7a` (32-bit ARM)
- `x86_64` (64-bit x86)

## Installation

### From Releases

1. Download the latest APK from [GitHub Releases](https://github.com/qorvode/prootix/releases)
2. Enable "Install from unknown sources" in Android settings
3. Install the APK

### From Source

Releases are built automatically via GitHub Actions. Clone and push to trigger builds.

```bash
git clone https://github.com/qorvode/prootix.git
cd prootix
git push  # Triggers CI build
```

## Configuration

### Environment Variables

```yaml
FLUTTER_VERSION: '3.22.0'
JAVA_VERSION: '17'
MIN_SDK: 24
TARGET_SDK: 34
```

### Repository URLs

```yaml
termux: https://packages.termux.org/apt/termux-main
kali: https://http.kali.org/kali
```

## Development

### Prerequisites

- GitHub account for Actions access
- Android device with USB debugging enabled

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and push
4. Open a PR (triggers validation workflow)
5. Merge after approval

## Security

- Rootfs checksum verification (SHA256)
- Repository signature validation
- Sandboxed PRoot environments
- No privilege escalation
- Secure storage for credentials

## License

This project is licensed under the MIT License.

## Support

- [GitHub Issues](https://github.com/qorvode/prootix/issues)
- [Discussions](https://github.com/qorvode/prootix/discussions)

## Acknowledgments

- [Termux](https://termux.com/) - For the package manager inspiration
- [Kali Linux](https://www.kali.org/) - For the penetration testing tools
- [PRoot](http://proot-me.github.io/) - For the container technology