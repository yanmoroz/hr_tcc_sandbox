# HR TCC Sandbox

A Flutter mobile application sandbox for HR (Human Resources) development and testing.

## 🚀 Features

- **Mobile-First Design**: Optimized for iOS and Android platforms only
- **Clean Architecture**: Built with Flutter best practices
- **Development Ready**: Configured for rapid prototyping and testing

## 📱 Supported Platforms

- ✅ **iOS** - iPhone and iPad support
- ✅ **Android** - All Android devices and emulators
- ❌ ~~Web~~ - Removed for mobile-only focus
- ❌ ~~Desktop~~ - Removed for mobile-only focus

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Xcode (for iOS development)
- Android Studio (for Android development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone git@github.com:yanmoroz/hr_tcc_sandbox.git
   cd hr_tcc_sandbox
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For iOS
   flutter run -d ios
   
   # For Android
   flutter run -d android
   ```

## 📁 Project Structure

```
flutter_hr_sandbox/
├── android/          # Android platform files
├── ios/             # iOS platform files
├── lib/             # Dart source code
│   └── main.dart    # Entry point
├── .cursor/         # Cursor IDE rules and guidelines
│   └── rules/       # AI coding assistance rules
├── pubspec.yaml     # Dependencies and project config
└── README.md        # This file
```

## 🔧 Development

### Available Commands

- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies
- `flutter run` - Run the app on connected device/emulator
- `flutter build ios` - Build iOS app
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle

### Code Quality

The project includes:
- `analysis_options.yaml` - Dart analyzer configuration
- `flutter_lints` - Code quality rules
- `.cursor/rules/` - AI coding assistance rules and guidelines
- Proper `.gitignore` for Flutter projects

## 📄 License

This project is for development and testing purposes.

## 🤝 Contributing

This is a sandbox project for HR development. Feel free to experiment and test new features.

---

**Note**: This project is configured for mobile-only development. Desktop and web platforms have been intentionally removed to focus on mobile HR applications.
