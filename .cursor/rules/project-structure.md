# Project Structure Guidelines

## Overview
This project follows a **feature-based Clean Architecture** approach, organizing code by business features rather than technical layers.

## Root Structure
```
lib/
├── app/                    # Application-level configuration
│   ├── router/            # Navigation and routing
│   │   └── app_router.dart
│   └── [other app configs]
├── core/                   # Shared utilities and constants
│   ├── constants/
│   ├── utils/
│   └── [other core files]
├── features/              # Business features
│   ├── profile/           # Profile feature
│   ├── auth/              # Authentication feature
│   └── [other features]
└── shared/                # Shared components and widgets
    ├── widgets/
    ├── models/
    └── [other shared files]
```

## Feature Structure
Each feature follows the same structure:

```
features/[feature_name]/
├── data/                  # Data layer
│   ├── datasources/       # Remote and local data sources
│   ├── models/           # Data models (JSON serialization)
│   └── repositories/     # Repository implementations
├── domain/               # Business logic layer
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business use cases
└── presentation/         # UI layer
    ├── blocs/           # BLoC state management
    ├── pages/           # Full-screen pages
    └── widgets/         # Feature-specific widgets
```

## Navigation Structure
- **Router Configuration**: `lib/app/router/app_router.dart`
- **Route Constants**: Define in `AppRouter` class
- **Navigation Methods**: Use `context.go()` and `context.push()`
- **Route Organization**: Group related routes together

## BLoC Organization
```
presentation/blocs/
├── [feature]_bloc.dart      # Main BLoC
├── [feature]_event.dart     # Events
└── [feature]_state.dart     # States
```

## Widget Organization
```
presentation/widgets/
├── [feature]_[section]_widget.dart  # Specific widgets
└── [feature]_[action]_widget.dart   # Action widgets
```

## Import Organization
```dart
// Dart imports
import 'dart:async';
import 'dart:io';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Third-party imports
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

// Local imports - Core
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/helpers.dart';

// Local imports - Shared
import '../../../shared/widgets/common_widgets.dart';

// Local imports - Feature
import '../../domain/entities/entity.dart';
import '../blocs/bloc.dart';
```

## File Naming Conventions
- **Files**: snake_case (`user_profile_page.dart`)
- **Classes**: PascalCase (`UserProfilePage`)
- **Variables/Methods**: camelCase (`userName`, `getUserData()`)
- **Constants**: SCREAMING_SNAKE_CASE (`API_BASE_URL`)

## Testing Structure
```
test/
├── unit/                  # Unit tests
│   ├── features/
│   │   └── [feature]/
│   │       ├── domain/
│   │       └── presentation/
│   └── core/
├── widget/                # Widget tests
│   └── features/
└── integration/           # Integration tests
```

## Key Principles
1. **Feature Isolation**: Each feature is self-contained
2. **Dependency Direction**: Domain → Data, Presentation → Domain
3. **Single Responsibility**: Each file has one clear purpose
4. **Testability**: Easy to test each layer independently
5. **Scalability**: Easy to add new features
6. **Maintainability**: Clear structure for easy navigation 