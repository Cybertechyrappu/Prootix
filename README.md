# Prootix

**A modern Android Linux workstation platform with modular Linux environments, terminal sessions, and future desktop acceleration support.**

![Prootix Banner](docs/images/banner.png)

## Overview

Prootix transforms your Android device into a portable Linux workstation using PRoot containers. Built with React Native for modern cross-platform support.

## Features

- **Modular Linux Environments**: Choose between Minimal Terminal, Kali Minimal, or Full Kali Desktop
- **Terminal Emulator**: Full ANSI color support, Unicode, touch scrolling
- **Package Manager**: Search, install, update, and uninstall packages
- **Session Management**: Persistent sessions with background execution
- **Modern UI**: Futuristic dark theme with smooth animations

## Tech Stack

- **Framework**: React Native 0.76
- **Navigation**: React Navigation 7.x
- **State**: React Context + Hooks
- **Styling**: StyleSheet API
- **Icons**: React Native Vector Icons

## Building

All builds are performed through GitHub Actions. No local compilation required.

### Available Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `react-native-ci.yml` | Push/PR | ESLint, tests, debug builds |
| `pr-validation.yml` | PR | Quality checks, type checking |
| `release.yml` | Tag/push | Release APK builds |
| `nightly.yml` | Daily | Nightly builds with auto-upload |

### Quick Start

```bash
# Clone the repository
git clone https://github.com/qorvode/prootix.git
cd prootix

# Install dependencies
cd apps/mobile
npm install

# Run on Android
npm run android

# Run tests
npm test
```

## Project Structure

```
prootix/
├── apps/
│   └── mobile/           # React Native application
│       ├── android/     # Android native code
│       ├── src/          # React Native source code
│       ├── App.tsx       # Main app component
│       └── package.json
├── .github/
│   └── workflows/       # CI/CD pipelines
├── docs/                 # Documentation
├── SPEC.md
└── README.md
```

## Environment Modes

### 1. Minimal Terminal
- **Size**: 300MB–800MB
- **Components**: Shell, Python, Node.js, Git, SSH, utilities

### 2. Kali Minimal
- **Size**: 1–2GB
- **Components**: Kali base, networking tools, pentesting basics

### 3. Full Kali Desktop
- **Size**: 4–10GB+
- **Components**: XFCE, GUI apps, X11, full Kali toolset

## Security

- Rootfs checksum verification (SHA256)
- Sandboxed PRoot environments
- No privilege escalation
- Secure storage for credentials

## License

MIT License

## Support

- [GitHub Issues](https://github.com/qorvode/prootix/issues)
- [Discussions](https://github.com/qorvode/prootix/discussions)