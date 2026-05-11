# Contributing to Prootix

Thank you for your interest in contributing to Prootix!

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a feature branch from `main`

## Development Workflow

### 1. Creating Changes

```bash
git checkout -b feature/your-feature-name
```

Make your changes in the appropriate directories:
- `apps/flutter/` - Flutter application code
- `apps/android/` - Android native code
- `scripts/` - Build and bootstrap scripts

### 2. Testing

All tests run through GitHub Actions. Before pushing:

1. Ensure your code passes analysis
2. Add appropriate tests for new features
3. Update documentation as needed

### 3. Submitting Changes

1. Commit your changes with clear messages
2. Push to your fork
3. Open a Pull Request
4. Wait for CI checks to pass
5. Address any review feedback

## Code Standards

### Flutter/Dart

- Follow Flutter's official style guide
- Use Riverpod for state management
- Implement proper error handling
- Add documentation comments for public APIs

### Kotlin

- Follow Kotlin conventions
- Use coroutines for async operations
- Implement proper null safety
- Add documentation comments

### Native Code

- Follow C++ best practices
- Use proper memory management
- Handle errors gracefully
- Document JNI interfaces

## Pull Request Process

1. PRs must pass all CI checks
2. At least one review required
3. Squash commits if needed
4. Keep PRs focused and small

## Reporting Issues

- Use GitHub Issues for bug reports
- Include device information
- Include reproduction steps
- Add logs and screenshots if applicable

## Questions?

Feel free to open a Discussion or reach out to maintainers.