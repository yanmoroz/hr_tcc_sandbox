# Feature-Based Architecture

## Overview

Feature-based architecture organizes code by business features rather than technical layers. Each feature is self-contained with its own data, domain, and presentation layers, promoting modularity, maintainability, and team scalability.

## Core Principles

### 1. Feature Independence
- Each feature should be self-contained
- Minimal dependencies between features
- Features can be developed and tested independently
- Clear feature boundaries

### 2. Clean Architecture Within Features
- Each feature follows Clean Architecture principles
- Data layer (implementation)
- Domain layer (business logic)
- Presentation layer (UI)

### 3. Shared Code Management
- Shared code goes in `shared/` directory
- Features communicate through well-defined interfaces
- Avoid direct imports between features

## Feature Structure

### Standard Feature Layout
```
feature_name/
├── data/                    # Data layer (implementation)
│   ├── datasources/        # Data sources
│   │   ├── remote/         # API data sources
│   │   └── local/          # Local storage data sources
│   ├── models/             # Data models (JSON serialization)
│   │   ├── feature_model.dart
│   │   └── feature_model.g.dart
│   └── repositories/       # Repository implementations
│       └── feature_repository_impl.dart
├── domain/                 # Domain layer (business logic)
│   ├── entities/           # Business entities
│   │   └── feature_entity.dart
│   ├── repositories/       # Repository interfaces
│   │   └── feature_repository.dart
│   └── usecases/           # Business use cases
│       ├── get_feature.dart
│       └── update_feature.dart
└── presentation/           # Presentation layer (UI)
    ├── pages/             # Feature pages/screens
    │   ├── feature_list_page.dart
    │   └── feature_detail_page.dart
    ├── widgets/           # Feature-specific widgets
    │   ├── feature_card.dart
    │   └── feature_form.dart
    └── blocs/             # Feature BLoCs
        ├── feature_bloc.dart
        ├── feature_event.dart
        └── feature_state.dart
```

## Example Features Breakdown

### 1. Authentication Feature (`auth/`)
```dart
// Domain
class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final UserRole role;
  
  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
  });
}

// Use Cases
class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<User> call(String email, String password) async {
    return await repository.login(email, password);
  }
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  
  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }
}
```

### 2. User Management Feature (`user/`)
```dart
// Domain
class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final DateTime createdAt;
  final UserStatus status;
  
  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.status,
  });
}

// Use Cases
class GetUsersUseCase {
  final UserRepository repository;
  
  GetUsersUseCase(this.repository);
  
  Future<List<User>> call() async {
    return await repository.getUsers();
  }
}

class UpdateUserUseCase {
  final UserRepository repository;
  
  UpdateUserUseCase(this.repository);
  
  Future<User> call(User user) async {
    return await repository.updateUser(user);
  }
}
```

### 3. Activity Tracking Feature (`activity_tracking/`)
```dart
// Domain
class ActivityEntry extends Equatable {
  final String id;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final String location;
  final ActivityType type;
  
  const ActivityEntry({
    required this.id,
    required this.userId,
    required this.startTime,
    this.endTime,
    required this.location,
    required this.type,
  });
}

// Use Cases
class StartActivityUseCase {
  final ActivityTrackingRepository repository;
  
  StartActivityUseCase(this.repository);
  
  Future<ActivityEntry> call(String userId, String location) async {
    return await repository.startActivity(userId, location);
  }
}

class EndActivityUseCase {
  final ActivityTrackingRepository repository;
  
  EndActivityUseCase(this.repository);
  
  Future<ActivityEntry> call(String activityEntryId) async {
    return await repository.endActivity(activityEntryId);
  }
}
```

### 4. Request Management Feature (`request_management/`)
```dart
// Domain
class Request extends Equatable {
  final String id;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final RequestType type;
  final String reason;
  final RequestStatus status;
  
  const Request({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.reason,
    required this.status,
  });
}

// Use Cases
class CreateRequestUseCase {
  final RequestRepository repository;
  
  CreateRequestUseCase(this.repository);
  
  Future<Request> call(Request request) async {
    return await repository.createRequest(request);
  }
}

class ApproveRequestUseCase {
  final RequestRepository repository;
  
  ApproveRequestUseCase(this.repository);
  
  Future<Request> call(String requestId) async {
    return await repository.approveRequest(requestId);
  }
}
```

### 5. Analytics Feature (`analytics/`)
```dart
// Domain
class AnalyticsData extends Equatable {
  final int totalUsers;
  final int activeUsers;
  final int pendingRequests;
  final double averageActivityHours;
  
  const AnalyticsData({
    required this.totalUsers,
    required this.activeUsers,
    required this.pendingRequests,
    required this.averageActivityHours,
  });
}

// Use Cases
class GetAnalyticsDataUseCase {
  final AnalyticsRepository repository;
  
  GetAnalyticsDataUseCase(this.repository);
  
  Future<AnalyticsData> call() async {
    return await repository.getAnalyticsData();
  }
}
```

## Dependency Injection

### Service Locator Pattern
```dart
// lib/app/di/injection.dart
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupInjection() {
  // Core services
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  
  // Auth feature
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
    ),
  );
  
  // User feature
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: getIt<UserRemoteDataSource>(),
      localDataSource: getIt<UserLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
    ),
  );
}
```

## Feature Communication

### Cross-Feature Communication
```dart
// Using events or callbacks
class UserListPage extends StatelessWidget {
  final VoidCallback? onUserSelected;
  
  const UserListPage({this.onUserSelected});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return UserCard(
                user: state.users[index],
                onTap: () => onUserSelected?.call(),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

// Using shared state
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<UserSelected>(_onUserSelected);
  }
  
  void _onUserSelected(UserSelected event, Emitter<AppState> emit) {
    // Handle cross-feature communication
  }
}
```

## Testing Strategy

### Feature-Level Testing
```dart
// test/unit/features/user/domain/usecases/get_users_test.dart
void main() {
  group('GetUsersUseCase', () {
    late GetUsersUseCase useCase;
    late MockUserRepository mockRepository;

    setUp(() {
      mockRepository = MockUserRepository();
      useCase = GetUsersUseCase(mockRepository);
    });

    test('should return list of users from repository', () async {
      // arrange
      final users = [
        User(id: '1', fullName: 'John Doe'),
        User(id: '2', fullName: 'Jane Smith'),
      ];
      when(mockRepository.getUsers())
          .thenAnswer((_) async => users);

      // act
      final result = await useCase();

      // assert
      expect(result, equals(users));
      verify(mockRepository.getUsers()).called(1);
    });
  });
}

// test/widget/features/user/presentation/pages/user_list_page_test.dart
void main() {
  group('UserListPage', () {
    late MockUserBloc mockUserBloc;

    setUp(() {
      mockUserBloc = MockUserBloc();
    });

    testWidgets('should display list of users', (tester) async {
      // arrange
      final users = [
        User(id: '1', fullName: 'John Doe'),
        User(id: '2', fullName: 'Jane Smith'),
      ];
      whenListen(
        mockUserBloc,
        Stream.fromIterable([UserLoaded(users)]),
      );

      // act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: UserListPage(),
          ),
        ),
      );

      // assert
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);
    });
  });
}
```

## Best Practices

### 1. Feature Boundaries
- Keep features independent
- Use dependency injection for shared services
- Avoid direct imports between features
- Communicate through events or shared state

### 2. Code Organization
- Follow consistent naming conventions
- Keep related code close together
- Use clear separation of concerns
- Document feature responsibilities

### 3. Testing
- Test each layer independently
- Use feature-specific test organization
- Mock dependencies properly
- Test feature integration

### 4. Performance
- Lazy load features when possible
- Optimize feature-specific assets
- Use efficient state management
- Monitor feature-specific metrics

### 5. Team Development
- Assign features to teams
- Use feature branches
- Review feature boundaries
- Maintain feature documentation
