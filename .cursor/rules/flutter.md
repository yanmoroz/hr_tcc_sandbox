# Flutter Development Rules

## Code Style & Structure

### Widget Organization
- Use `StatelessWidget` for widgets that don't change state
- Use `StatefulWidget` only when necessary for state management
- Prefer composition over inheritance
- Keep widgets small and focused on a single responsibility

### File Naming
- Use snake_case for file names: `user_profile_screen.dart`
- Use PascalCase for class names: `UserProfileScreen`
- Use camelCase for variables and methods: `userName`, `getUserData()`

### Import Organization
```dart
// Dart imports
import 'dart:async';
import 'dart:io';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Third-party imports
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Local imports
import '../models/user.dart';
import '../services/api_service.dart';
```

## State Management

### Provider Pattern (Recommended)
- Use `ChangeNotifierProvider` for simple state
- Use `MultiProvider` for complex state hierarchies
- Keep providers close to where they're used

### StatefulWidget Guidelines
- Minimize the use of `StatefulWidget`
- Use `initState()` for initialization only
- Dispose resources in `dispose()` method
- Use `setState()` sparingly

## UI/UX Guidelines

### Material Design
- Follow Material Design 3 principles
- Use consistent spacing (8dp grid system)
- Implement proper accessibility features
- Support both light and dark themes

### Responsive Design
- Use `MediaQuery` for screen size detection
- Implement flexible layouts with `Flex` widgets
- Test on different screen sizes
- Support both portrait and landscape orientations

## Performance

### Widget Optimization
- Use `const` constructors when possible
- Implement `shouldRebuild` in custom widgets
- Use `ListView.builder` for large lists
- Avoid unnecessary rebuilds

### Asset Management
- Optimize images and assets
- Use appropriate image formats (WebP for photos, PNG for icons)
- Implement proper asset loading and caching

## Testing

### Unit Tests
- Write tests for business logic
- Test widget behavior with `WidgetTester`
- Mock external dependencies
- Aim for >80% code coverage

### Integration Tests
- Test complete user flows
- Test platform-specific features
- Use `integration_test` package

## Platform-Specific Code

### iOS Guidelines
- Follow iOS Human Interface Guidelines
- Use iOS-specific widgets when appropriate
- Test on iOS Simulator and real devices
- Handle iOS-specific permissions properly

### Android Guidelines
- Follow Material Design guidelines
- Use Android-specific widgets when appropriate
- Test on Android emulator and real devices
- Handle Android-specific permissions properly

## Error Handling

### Exception Handling
- Use try-catch blocks for async operations
- Provide meaningful error messages
- Implement proper error boundaries
- Log errors for debugging

### User Feedback
- Show loading indicators for async operations
- Display error messages in user-friendly format
- Implement retry mechanisms
- Provide offline support when possible 