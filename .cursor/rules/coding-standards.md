# Coding Standards

## Dart Language Standards

### Naming Conventions
- **Classes**: PascalCase (`UserProfile`, `ApiService`)
- **Variables/Methods**: camelCase (`userName`, `getUserData()`)
- **Constants**: SCREAMING_SNAKE_CASE (`API_BASE_URL`)
- **Files**: snake_case (`user_profile_page.dart`)

### Code Organization
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

## Flutter-Specific Standards

### DI Conventions
- Use modular GetIt across the app.
- Only DI modules call `register*`; no inline registrations in `main.dart` or widgets.
- Each feature exposes a single `DiModule.register(GetIt)` entry point in `lib/features/<feature>/di/`.
- Lifetimes: lazySingleton for services/datasources/repos/use cases; factory for BLoCs.
- Domain layer must not reference GetIt; depend on abstractions only.

### Use Case Naming
- All use case classes must end with the `UseCase` postfix.
- Examples: `LoginUseCase`, `GetProfileUseCase`, `UpdateProfileUseCase`, `GetKpisUseCase`.


### PR Checklist (DI)
- Uses DI modules; no ad-hoc registrations added.
- BLoCs registered as factories; services/repos/use cases as lazy singletons.
- New feature includes `di/<feature>_module.dart` and is composed in `setupDependencies()`.
- Use case classes follow `UseCase` postfix naming.

### Widget Structure
- Use `StatelessWidget` when possible
- Use `StatefulWidget` only when local state is needed
- Implement `dispose()` methods for controllers and animations
- Use `const` constructors for immutable widgets

### BLoC Pattern
```dart
// Event
abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String userId;
  LoadProfile(this.userId);
  
  @override
  List<Object?> get props => [userId];
}

// State
abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final Profile profile;
  ProfileLoaded(this.profile);
  
  @override
  List<Object?> get props => [profile];
}

// BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._getProfile) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
  }
  
  final GetProfile _getProfile;
  
  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _getProfile.call(event.userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
```

### Navigation Standards
```dart
// Router Configuration
class AppRouter {
  static const String profile = '/';
  static const String profileKpi = '/profile/kpi';
  
  static GoRouter get router => GoRouter(
    initialLocation: profile,
    routes: [
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: profileKpi,
        name: 'profileKpi',
        builder: (context, state) => const ProfileKpiPage(),
      ),
    ],
  );
}

// Navigation Usage
// Forward navigation
context.go(AppRouter.profileKpi);

// Stack-based navigation
context.push(AppRouter.profileKpi);

// Back navigation
context.pop(); // Only when using push()
context.go(AppRouter.profile); // When using go()
```

## Error Handling Standards

### Exception Handling
```dart
try {
  final result = await repository.getData();
  return result;
} catch (e) {
  if (e is NetworkException) {
    throw NetworkError('Network connection failed');
  } else if (e is ValidationException) {
    throw ValidationError('Invalid data format');
  } else {
    throw UnknownError('An unexpected error occurred');
  }
}
```

### BLoC Error Handling
```dart
Future<void> _onLoadData(LoadData event, Emitter<DataState> emit) async {
  emit(DataLoading());
  try {
    final data = await _repository.getData();
    emit(DataLoaded(data));
  } catch (e) {
    emit(DataError(e.toString()));
  }
}
```

## Testing Standards

### Unit Tests
```dart
group('ProfileBloc', () {
  late ProfileBloc bloc;
  late MockGetProfile mockGetProfile;
  
  setUp(() {
    mockGetProfile = MockGetProfile();
    bloc = ProfileBloc(mockGetProfile);
  });
  
  tearDown(() {
    bloc.close();
  });
  
  test('initial state is ProfileInitial', () {
    expect(bloc.state, isA<ProfileInitial>());
  });
  
  blocTest<ProfileBloc, ProfileEvent, ProfileState>(
    'emits [ProfileLoading, ProfileLoaded] when LoadProfile is added',
    build: () {
      when(mockGetProfile.call(any)).thenAnswer(
        (_) async => Profile(id: '1', name: 'Test'),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadProfile('1')),
    expect: () => [
      isA<ProfileLoading>(),
      isA<ProfileLoaded>(),
    ],
  );
});
```

### Widget Tests
```dart
testWidgets('ProfilePage displays user information', (tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (context) => ProfileBloc(mockGetProfile),
      child: const MaterialApp(home: ProfilePage()),
    ),
  );
  
  expect(find.text('User Profile'), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

## Performance Standards

### Widget Optimization
- Use `const` constructors when possible
- Implement `shouldRebuild` in custom widgets
- Use `ListView.builder` for large lists
- Avoid unnecessary rebuilds

### Memory Management
```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## Security Standards

### Input Validation
```dart
class InputValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }
}
```

### Data Sanitization
```dart
String sanitizeInput(String input) {
  return input.trim().replaceAll(RegExp(r'[<>]'), '');
}
``` 