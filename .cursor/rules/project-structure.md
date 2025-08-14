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
│   ├── employee/              # Employee management feature
│   │   ├── data/             # Data layer for employee
│   │   │   ├── datasources/  # Employee data sources
│   │   │   ├── models/       # Employee data models
│   │   │   └── repositories/ # Employee repository implementations
│   │   ├── domain/           # Domain layer for employee
│   │   │   ├── entities/     # Employee entities
│   │   │   ├── repositories/ # Employee repository interfaces
│   │   │   └── usecases/     # Employee use cases
│   │   └── presentation/     # Presentation layer for employee
│   │       ├── pages/        # Employee pages
│   │       ├── widgets/      # Employee-specific widgets
│   │       └── blocs/        # Employee BLoCs
│   │           ├── employee_bloc.dart
│   │           ├── employee_event.dart
│   │           └── employee_state.dart
│   ├── time_tracking/        # Time tracking feature
│   │   ├── data/            # Data layer for time tracking
│   │   ├── domain/          # Domain layer for time tracking
│   │   └── presentation/    # Presentation layer for time tracking
│   │       ├── pages/       # Time tracking pages
│   │       ├── widgets/     # Time tracking widgets
│   │       └── blocs/       # Time tracking BLoCs
│   ├── leave_management/     # Leave management feature
│   │   ├── data/           # Data layer for leave management
│   │   ├── domain/         # Domain layer for leave management
│   │   └── presentation/   # Presentation layer for leave management
│   │       ├── pages/      # Leave management pages
│   │       ├── widgets/    # Leave management widgets
│   │       └── blocs/      # Leave management BLoCs
│   └── dashboard/           # Dashboard feature
│       ├── data/          # Data layer for dashboard
│       ├── domain/        # Domain layer for dashboard
│       └── presentation/  # Presentation layer for dashboard
│           ├── pages/     # Dashboard pages
│           ├── widgets/   # Dashboard widgets
│           └── blocs/     # Dashboard BLoCs
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
├── employee/
│   └── presentation/
│       └── blocs/
│           ├── employee_bloc.dart
│           ├── employee_event.dart
│           └── employee_state.dart
├── time_tracking/
│   └── presentation/
│       └── blocs/
│           ├── time_bloc.dart
│           ├── time_event.dart
│           └── time_state.dart
├── leave_management/
│   └── presentation/
│       └── blocs/
│           ├── leave_bloc.dart
│           ├── leave_event.dart
│           └── leave_state.dart
└── dashboard/
    └── presentation/
        └── blocs/
            ├── dashboard_bloc.dart
            ├── dashboard_event.dart
            └── dashboard_state.dart
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
├── employee/
│   └── presentation/
│       └── widgets/
│           ├── employee_card.dart
│           ├── employee_form.dart
│           └── employee_list.dart
├── time_tracking/
│   └── presentation/
│       └── widgets/
│           ├── clock_in_button.dart
│           ├── time_entry_card.dart
│           └── time_summary.dart
├── leave_management/
│   └── presentation/
│       └── widgets/
│           ├── leave_request_form.dart
│           ├── leave_card.dart
│           └── leave_calendar.dart
└── dashboard/
    └── presentation/
        └── widgets/
            ├── dashboard_card.dart
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
│       ├── employee/    # Employee feature tests
│       ├── time_tracking/ # Time tracking tests
│       ├── leave_management/ # Leave management tests
│       └── dashboard/   # Dashboard tests
├── widget/              # Widget tests
│   ├── shared/          # Shared widget tests
│   └── features/        # Feature-specific widget tests
│       ├── auth/        # Auth widget tests
│       ├── employee/    # Employee widget tests
│       ├── time_tracking/ # Time tracking widget tests
│       ├── leave_management/ # Leave management widget tests
│       └── dashboard/   # Dashboard widget tests
└── integration/         # Integration tests
    ├── auth_flow_test.dart
    ├── employee_flow_test.dart
    ├── time_tracking_flow_test.dart
    └── leave_management_flow_test.dart
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