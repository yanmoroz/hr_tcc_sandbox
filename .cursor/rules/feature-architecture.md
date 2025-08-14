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

## HR Features Breakdown

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

### 2. Employee Management Feature (`employee/`)
```dart
// Domain
class Employee extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String department;
  final String position;
  final DateTime hireDate;
  final EmployeeStatus status;
  
  const Employee({
    required this.id,
    required this.fullName,
    required this.email,
    required this.department,
    required this.position,
    required this.hireDate,
    required this.status,
  });
}

// Use Cases
class GetEmployeesUseCase {
  final EmployeeRepository repository;
  
  GetEmployeesUseCase(this.repository);
  
  Future<List<Employee>> call() async {
    return await repository.getEmployees();
  }
}

class UpdateEmployeeUseCase {
  final EmployeeRepository repository;
  
  UpdateEmployeeUseCase(this.repository);
  
  Future<Employee> call(Employee employee) async {
    return await repository.updateEmployee(employee);
  }
}
```

### 3. Time Tracking Feature (`time_tracking/`)
```dart
// Domain
class TimeEntry extends Equatable {
  final String id;
  final String employeeId;
  final DateTime clockIn;
  final DateTime? clockOut;
  final String location;
  final TimeEntryType type;
  
  const TimeEntry({
    required this.id,
    required this.employeeId,
    required this.clockIn,
    this.clockOut,
    required this.location,
    required this.type,
  });
}

// Use Cases
class ClockInUseCase {
  final TimeTrackingRepository repository;
  
  ClockInUseCase(this.repository);
  
  Future<TimeEntry> call(String employeeId, String location) async {
    return await repository.clockIn(employeeId, location);
  }
}

class ClockOutUseCase {
  final TimeTrackingRepository repository;
  
  ClockOutUseCase(this.repository);
  
  Future<TimeEntry> call(String timeEntryId) async {
    return await repository.clockOut(timeEntryId);
  }
}
```

### 4. Leave Management Feature (`leave_management/`)
```dart
// Domain
class LeaveRequest extends Equatable {
  final String id;
  final String employeeId;
  final DateTime startDate;
  final DateTime endDate;
  final LeaveType type;
  final String reason;
  final LeaveStatus status;
  
  const LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.reason,
    required this.status,
  });
}

// Use Cases
class RequestLeaveUseCase {
  final LeaveRepository repository;
  
  RequestLeaveUseCase(this.repository);
  
  Future<LeaveRequest> call(LeaveRequest request) async {
    return await repository.requestLeave(request);
  }
}

class ApproveLeaveUseCase {
  final LeaveRepository repository;
  
  ApproveLeaveUseCase(this.repository);
  
  Future<LeaveRequest> call(String leaveId) async {
    return await repository.approveLeave(leaveId);
  }
}
```

### 5. Dashboard Feature (`dashboard/`)
```dart
// Domain
class DashboardData extends Equatable {
  final int totalEmployees;
  final int activeEmployees;
  final int pendingLeaveRequests;
  final double averageWorkHours;
  
  const DashboardData({
    required this.totalEmployees,
    required this.activeEmployees,
    required this.pendingLeaveRequests,
    required this.averageWorkHours,
  });
}

// Use Cases
class GetDashboardDataUseCase {
  final DashboardRepository repository;
  
  GetDashboardDataUseCase(this.repository);
  
  Future<DashboardData> call() async {
    return await repository.getDashboardData();
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
  
  // Employee feature
  getIt.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(
      remoteDataSource: getIt<EmployeeRemoteDataSource>(),
      localDataSource: getIt<EmployeeLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetEmployeesUseCase>(
    () => GetEmployeesUseCase(getIt<EmployeeRepository>()),
  );
  getIt.registerLazySingleton<EmployeeBloc>(
    () => EmployeeBloc(
      getEmployeesUseCase: getIt<GetEmployeesUseCase>(),
      updateEmployeeUseCase: getIt<UpdateEmployeeUseCase>(),
    ),
  );
}
```

## Feature Communication

### Cross-Feature Communication
```dart
// Using events or callbacks
class EmployeeListPage extends StatelessWidget {
  final VoidCallback? onEmployeeSelected;
  
  const EmployeeListPage({this.onEmployeeSelected});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoaded) {
          return ListView.builder(
            itemCount: state.employees.length,
            itemBuilder: (context, index) {
              return EmployeeCard(
                employee: state.employees[index],
                onTap: () => onEmployeeSelected?.call(),
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
    on<EmployeeSelected>(_onEmployeeSelected);
  }
  
  void _onEmployeeSelected(EmployeeSelected event, Emitter<AppState> emit) {
    // Handle cross-feature communication
  }
}
```

## Testing Strategy

### Feature-Level Testing
```dart
// test/unit/features/employee/domain/usecases/get_employees_test.dart
void main() {
  group('GetEmployeesUseCase', () {
    late GetEmployeesUseCase useCase;
    late MockEmployeeRepository mockRepository;

    setUp(() {
      mockRepository = MockEmployeeRepository();
      useCase = GetEmployeesUseCase(mockRepository);
    });

    test('should return list of employees from repository', () async {
      // arrange
      final employees = [
        Employee(id: '1', fullName: 'John Doe'),
        Employee(id: '2', fullName: 'Jane Smith'),
      ];
      when(mockRepository.getEmployees())
          .thenAnswer((_) async => employees);

      // act
      final result = await useCase();

      // assert
      expect(result, equals(employees));
      verify(mockRepository.getEmployees()).called(1);
    });
  });
}

// test/widget/features/employee/presentation/pages/employee_list_page_test.dart
void main() {
  group('EmployeeListPage', () {
    late MockEmployeeBloc mockEmployeeBloc;

    setUp(() {
      mockEmployeeBloc = MockEmployeeBloc();
    });

    testWidgets('should display list of employees', (tester) async {
      // arrange
      final employees = [
        Employee(id: '1', fullName: 'John Doe'),
        Employee(id: '2', fullName: 'Jane Smith'),
      ];
      whenListen(
        mockEmployeeBloc,
        Stream.fromIterable([EmployeeLoaded(employees)]),
      );

      // act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeBloc>.value(
            value: mockEmployeeBloc,
            child: EmployeeListPage(),
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
