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

### Lib Directory Structure (Feature-Based)
```
lib/
├── main.dart                    # App entry point
├── app/                         # App-level configuration
│   ├── app.dart                # Main app widget
│   ├── routes.dart             # Route definitions
│   ├── theme.dart              # App theme configuration
│   └── di/                     # Dependency injection
│       └── injection.dart      # Service locator setup
├── core/                       # Core utilities and constants
│   ├── constants/              # App constants
│   ├── utils/                  # Utility functions
│   ├── errors/                 # Error handling
│   ├── extensions/             # Dart extensions
│   └── network/                # Network utilities
│       ├── api_client.dart     # HTTP client
│       └── interceptors.dart   # Request/response interceptors
├── features/                   # Feature modules
│   ├── auth/                   # Authentication feature
│   │   ├── data/              # Data layer for auth
│   │   │   ├── datasources/   # Auth data sources
│   │   │   ├── models/        # Auth data models
│   │   │   └── repositories/  # Auth repository implementations
│   │   ├── domain/            # Domain layer for auth
│   │   │   ├── entities/      # Auth entities
│   │   │   ├── repositories/  # Auth repository interfaces
│   │   │   └── usecases/      # Auth use cases
│   │   └── presentation/      # Presentation layer for auth
│   │       ├── pages/         # Auth pages
│   │       ├── widgets/       # Auth-specific widgets
│   │       └── blocs/         # Auth BLoCs
│   │           ├── auth_bloc.dart
│   │           ├── auth_event.dart
│   │           └── auth_state.dart
│   ├── user/                  # User management feature
│   │   ├── data/             # Data layer for user
│   │   │   ├── datasources/  # User data sources
│   │   │   ├── models/       # User data models
│   │   │   └── repositories/ # User repository implementations
│   │   ├── domain/           # Domain layer for user
│   │   │   ├── entities/     # User entities
│   │   │   ├── repositories/ # User repository interfaces
│   │   │   └── usecases/     # User use cases
│   │   └── presentation/     # Presentation layer for user
│   │       ├── pages/        # User pages
│   │       ├── widgets/      # User-specific widgets
│   │       └── blocs/        # User BLoCs
│   │           ├── user_bloc.dart
│   │           ├── user_event.dart
│   │           └── user_state.dart
│   ├── activity_tracking/    # Activity tracking feature
│   │   ├── data/            # Data layer for activity tracking
│   │   ├── domain/          # Domain layer for activity tracking
│   │   └── presentation/    # Presentation layer for activity tracking
│   │       ├── pages/       # Activity tracking pages
│   │       ├── widgets/     # Activity tracking widgets
│   │       └── blocs/       # Activity tracking BLoCs
│   ├── request_management/   # Request management feature
│   │   ├── data/           # Data layer for request management
│   │   ├── domain/         # Domain layer for request management
│   │   └── presentation/   # Presentation layer for request management
│   │       ├── pages/      # Request management pages
│   │       ├── widgets/    # Request management widgets
│   │       └── blocs/      # Request management BLoCs
│   └── analytics/           # Analytics feature
│       ├── data/          # Data layer for analytics
│       ├── domain/        # Domain layer for analytics
│       └── presentation/  # Presentation layer for analytics
│           ├── pages/     # Analytics pages
│           ├── widgets/   # Analytics widgets
│           └── blocs/     # Analytics BLoCs
└── shared/                 # Shared components
    ├── widgets/           # Common widgets
    ├── services/          # Shared services
    ├── models/            # Shared data models
    └── utils/             # Shared utilities
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

## Feature-Based Architecture Principles

### Feature Independence
- Each feature should be self-contained with its own data, domain, and presentation layers
- Features should have minimal dependencies on other features
- Use dependency injection to provide shared services
- Features can be developed, tested, and maintained independently

### Feature Boundaries
- Clear separation between features
- Shared code should be in the `shared/` directory
- Features communicate through well-defined interfaces
- Avoid direct imports between features

### Feature Structure
Each feature follows the same structure:
```
feature_name/
├── data/              # Data layer (implementation)
│   ├── datasources/   # Data sources (API, local storage)
│   ├── models/        # Data models (JSON serialization)
│   └── repositories/  # Repository implementations
├── domain/            # Domain layer (business logic)
│   ├── entities/      # Business entities
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business use cases
└── presentation/      # Presentation layer (UI)
    ├── pages/         # Feature pages/screens
    ├── widgets/       # Feature-specific widgets
    └── blocs/         # Feature BLoCs
```

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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// 4. Local imports (relative to current file)
import '../models/user.dart';
import '../services/api_service.dart';
import '../../../shared/widgets/custom_button.dart';
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

### Feature-Based BLoC Organization
```
lib/features/
├── auth/
│   └── presentation/
│       └── blocs/
│           ├── auth_bloc.dart
│           ├── auth_event.dart
│           └── auth_state.dart
├── user/
│   └── presentation/
│       └── blocs/
│           ├── user_bloc.dart
│           ├── user_event.dart
│           └── user_state.dart
├── activity_tracking/
│   └── presentation/
│       └── blocs/
│           ├── activity_bloc.dart
│           ├── activity_event.dart
│           └── activity_state.dart
├── request_management/
│   └── presentation/
│       └── blocs/
│           ├── request_bloc.dart
│           ├── request_event.dart
│           └── request_state.dart
└── analytics/
    └── presentation/
        └── blocs/
            ├── analytics_bloc.dart
            ├── analytics_event.dart
            └── analytics_state.dart
```

### Feature-Based Widget Organization
```
lib/features/
├── auth/
│   └── presentation/
│       └── widgets/
│           ├── login_form.dart
│           ├── password_field.dart
│           └── auth_button.dart
├── user/
│   └── presentation/
│       └── widgets/
│           ├── user_card.dart
│           ├── user_form.dart
│           └── user_list.dart
├── activity_tracking/
│   └── presentation/
│       └── widgets/
│           ├── activity_button.dart
│           ├── activity_entry_card.dart
│           └── activity_summary.dart
├── request_management/
│   └── presentation/
│       └── widgets/
│           ├── request_form.dart
│           ├── request_card.dart
│           └── request_calendar.dart
└── analytics/
    └── presentation/
        └── widgets/
            ├── analytics_card.dart
            ├── stats_widget.dart
            └── quick_actions.dart

lib/shared/
└── widgets/               # Shared widgets across features
    ├── common/           # Common UI components
    │   ├── custom_button.dart
    │   ├── loading_indicator.dart
    │   └── error_widget.dart
    ├── forms/            # Form components
    │   ├── text_input_field.dart
    │   ├── date_picker.dart
    │   └── dropdown_field.dart
    └── layout/           # Layout components
        ├── app_scaffold.dart
        ├── page_header.dart
        └── bottom_navigation.dart
```

## Testing Structure

### Feature-Based Test Organization
```
test/
├── unit/                 # Unit tests
│   ├── core/            # Core utility tests
│   │   ├── utils/       # Utility function tests
│   │   └── network/     # Network utility tests
│   └── features/        # Feature-specific unit tests
│       ├── auth/        # Auth feature tests
│       │   ├── domain/  # Auth domain tests
│       │   └── data/    # Auth data tests
│       ├── user/        # User feature tests
│       ├── activity_tracking/ # Activity tracking tests
│       ├── request_management/ # Request management tests
│       └── analytics/   # Analytics tests
├── widget/              # Widget tests
│   ├── shared/          # Shared widget tests
│   └── features/        # Feature-specific widget tests
│       ├── auth/        # Auth widget tests
│       ├── user/        # User widget tests
│       ├── activity_tracking/ # Activity tracking widget tests
│       ├── request_management/ # Request management widget tests
│       └── analytics/   # Analytics widget tests
└── integration/         # Integration tests
    ├── auth_flow_test.dart
    ├── user_flow_test.dart
    ├── activity_tracking_flow_test.dart
    └── request_management_flow_test.dart
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