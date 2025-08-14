# Flutter Development Guidelines

## State Management
- Use **BLoC (Business Logic Component)** pattern for state management
- Implement events, states, and blocs for each feature
- Use `flutter_bloc` package for BLoC implementation
- Follow unidirectional data flow: Event → Bloc → State → UI

## Navigation
- Use **go_router** for declarative routing
- Define routes in `lib/app/router/app_router.dart`
- Use `context.go()` for navigation to specific routes
- Use `context.push()` for stack-based navigation
- Avoid `Navigator.push()` in favor of go_router methods
- Define route constants in `AppRouter` class

## Project Structure
- Follow feature-based Clean Architecture
- Organize code by business features, not technical layers
- Each feature contains: `data/`, `domain/`, `presentation/` layers
- Keep shared utilities in `lib/shared/` or `lib/core/`

## Widget Guidelines
- Use `StatelessWidget` when possible
- Use `StatefulWidget` only when local state is needed
- Implement `dispose()` methods for controllers and animations
- Use `const` constructors for immutable widgets

## Code Organization
- One file per class/entity
- Use meaningful file and class names
- Group related functionality together
- Follow Dart naming conventions

## Error Handling
- Implement proper error states in BLoCs
- Use try-catch blocks for async operations
- Provide user-friendly error messages
- Handle loading states appropriately

## Testing
- Write unit tests for BLoCs using `bloc_test`
- Test use cases and repositories
- Mock external dependencies
- Maintain high test coverage 