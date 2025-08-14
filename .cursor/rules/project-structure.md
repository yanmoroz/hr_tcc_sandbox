# Project Structure Rules

## Directory Organization

### Root Level Structure
```
flutter_hr_sandbox/
├── android/                 # Android platform files
├── ios/                    # iOS platform files
├── lib/                    # Dart source code
├── test/                   # Unit and widget tests
├── integration_test/       # Integration tests
├── assets/                 # Images, fonts, and other assets
├── .cursor/               # Cursor IDE rules
├── pubspec.yaml           # Dependencies and project config
└── README.md              # Project documentation
```

### Lib Directory Structure
```
lib/
├── main.dart              # App entry point
├── app/                   # App-level configuration
│   ├── app.dart           # Main app widget
│   ├── routes.dart        # Route definitions
│   └── theme.dart         # App theme configuration
├── core/                  # Core utilities and constants
│   ├── constants/         # App constants
│   ├── utils/            # Utility functions
│   ├── errors/           # Error handling
│   └── extensions/       # Dart extensions
├── data/                 # Data layer
│   ├── models/           # Data models
│   ├── repositories/     # Repository implementations
│   ├── datasources/      # Local and remote data sources
│   └── mappers/          # Data mappers
├── domain/               # Business logic layer
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   ├── usecases/         # Business use cases
│   └── value_objects/    # Value objects
├── presentation/         # UI layer
│   ├── pages/           # Full pages/screens
│   ├── widgets/         # Reusable widgets
│   ├── providers/       # State management
│   └── controllers/     # Page controllers
└── shared/              # Shared components
    ├── widgets/         # Common widgets
    ├── services/        # Shared services
    └── helpers/         # Helper functions
```

## File Naming Conventions

### Dart Files
- **Screens/Pages**: `snake_case_screen.dart` (e.g., `employee_list_screen.dart`)
- **Widgets**: `snake_case_widget.dart` (e.g., `custom_button_widget.dart`)
- **Models**: `snake_case_model.dart` (e.g., `employee_model.dart`)
- **Services**: `snake_case_service.dart` (e.g., `api_service.dart`)
- **Providers**: `snake_case_provider.dart` (e.g., `auth_provider.dart`)
- **Utils**: `snake_case_utils.dart` (e.g., `date_utils.dart`)

### Asset Files
- **Images**: `snake_case.png` (e.g., `user_avatar.png`)
- **Icons**: `icon_snake_case.svg` (e.g., `icon_home.svg`)
- **Fonts**: `FontName-Regular.ttf` (e.g., `Roboto-Regular.ttf`)

## Code Organization Rules

### Single Responsibility Principle
- Each file should have a single, well-defined purpose
- Keep classes focused and cohesive
- Avoid mixing concerns in single files

### Import Organization
```dart
// 1. Dart imports
import 'dart:async';
import 'dart:io';

// 2. Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 3. Third-party imports
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// 4. Local imports (relative to current file)
import '../models/user.dart';
import '../services/api_service.dart';
import '../../shared/widgets/custom_button.dart';
```

### Class Organization
```dart
class ExampleClass {
  // 1. Static constants
  static const String _constant = 'value';
  
  // 2. Instance variables
  final String _privateField;
  String publicField;
  
  // 3. Constructor
  ExampleClass(this._privateField);
  
  // 4. Factory constructors
  factory ExampleClass.fromJson(Map<String, dynamic> json) {
    // Implementation
  }
  
  // 5. Getters
  String get computedValue => _privateField.toUpperCase();
  
  // 6. Public methods
  void publicMethod() {
    // Implementation
  }
  
  // 7. Private methods
  void _privateMethod() {
    // Implementation
  }
}
```

## State Management Structure

### BLoC Organization
```
lib/presentation/blocs/
├── auth/                   # Authentication BLoC
│   ├── auth_bloc.dart
│   ├── auth_event.dart
│   └── auth_state.dart
├── employee/               # Employee BLoC
│   ├── employee_bloc.dart
│   ├── employee_event.dart
│   └── employee_state.dart
├── time/                   # Time tracking BLoC
│   ├── time_bloc.dart
│   ├── time_event.dart
│   └── time_state.dart
├── leave/                  # Leave management BLoC
│   ├── leave_bloc.dart
│   ├── leave_event.dart
│   └── leave_state.dart
└── notification/           # Notification BLoC
    ├── notification_bloc.dart
    ├── notification_event.dart
    └── notification_state.dart
```

### Widget Organization
```
lib/presentation/widgets/
├── common/                # Shared widgets
│   ├── custom_button.dart
│   ├── loading_indicator.dart
│   └── error_widget.dart
├── forms/                 # Form-related widgets
│   ├── text_input_field.dart
│   ├── date_picker.dart
│   └── dropdown_field.dart
└── cards/                 # Card widgets
    ├── employee_card.dart
    ├── time_entry_card.dart
    └── leave_request_card.dart
```

## Testing Structure

### Test Organization
```
test/
├── unit/                  # Unit tests
│   ├── models/           # Model tests
│   ├── services/         # Service tests
│   └── utils/            # Utility tests
├── widget/               # Widget tests
│   ├── pages/            # Page tests
│   └── widgets/          # Widget tests
└── integration/          # Integration tests
    └── app_test.dart     # App flow tests
```

### Test File Naming
- **Unit tests**: `test_name_test.dart` (e.g., `employee_model_test.dart`)
- **Widget tests**: `widget_name_test.dart` (e.g., `login_page_test.dart`)
- **Integration tests**: `integration_name_test.dart` (e.g., `auth_flow_test.dart`)

## Asset Organization

### Asset Structure
```
assets/
├── images/               # Image assets
│   ├── icons/           # Icon images
│   ├── backgrounds/     # Background images
│   └── logos/           # Logo images
├── fonts/               # Font files
├── animations/          # Lottie animations
└── data/               # Static data files
    └── mock_data.json
```

## Configuration Files

### Environment Configuration
```
lib/core/config/
├── app_config.dart      # App configuration
├── api_config.dart      # API endpoints
├── theme_config.dart    # Theme configuration
└── constants.dart       # App constants
```

## Documentation Structure

### Code Documentation
- Use `///` for public API documentation
- Include parameter descriptions
- Provide usage examples
- Document complex business logic

### README Files
- Each major directory should have a README.md
- Document the purpose and usage of the directory
- Include setup instructions if needed
- Provide examples of common patterns 