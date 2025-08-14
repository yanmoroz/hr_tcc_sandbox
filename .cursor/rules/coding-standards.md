# Coding Standards & Best Practices

## Dart Language Standards

### Code Style
- Follow the official Dart style guide
- Use 2-space indentation
- Maximum line length: 80 characters
- Use trailing commas for better formatting
- Prefer `const` constructors when possible

### Naming Conventions
```dart
// Classes and enums: PascalCase
class EmployeeProfile {}
enum EmployeeStatus { active, inactive, terminated }

// Variables and methods: camelCase
String employeeName;
void calculateSalary() {}

// Constants: SCREAMING_SNAKE_CASE
const String API_BASE_URL = 'https://api.example.com';

// Private members: underscore prefix
String _privateVariable;
void _privateMethod() {}
```

### Documentation
```dart
/// Represents an employee in the HR system.
/// 
/// This class contains all the essential information about an employee
/// including personal details, work information, and status.
class Employee {
  /// The unique identifier for the employee.
  final String id;
  
  /// The employee's full name.
  final String fullName;
  
  /// Creates an employee with the given [id] and [fullName].
  /// 
  /// Throws [ArgumentError] if [id] is empty or [fullName] is null.
  Employee({
    required this.id,
    required this.fullName,
  }) : assert(id.isNotEmpty, 'Employee ID cannot be empty'),
       assert(fullName.isNotEmpty, 'Full name cannot be empty');
}
```

## Flutter-Specific Standards

### Widget Structure
```dart
class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    this.onTap,
  });

  final Employee employee;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.fullName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                employee.position,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### State Management
```dart
// Event
abstract class EmployeeEvent {}

class LoadEmployee extends EmployeeEvent {
  final String id;
  LoadEmployee(this.id);
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;
  UpdateEmployee(this.employee);
}

// State
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}
class EmployeeLoading extends EmployeeState {}
class EmployeeLoaded extends EmployeeState {
  final Employee employee;
  EmployeeLoaded(this.employee);
}
class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError(this.message);
}

// BLoC
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc(this._repository) : super(EmployeeInitial()) {
    on<LoadEmployee>(_onLoadEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
  }

  final EmployeeRepository _repository;

  Future<void> _onLoadEmployee(LoadEmployee event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    try {
      final employee = await _repository.getEmployee(event.id);
      emit(EmployeeLoaded(employee));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> _onUpdateEmployee(UpdateEmployee event, Emitter<EmployeeState> emit) async {
    // Implementation
  }
}

// Usage in Widget
class EmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(context.read<EmployeeRepository>()),
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return CircularProgressIndicator();
          } else if (state is EmployeeLoaded) {
            return EmployeeCard(employee: state.employee);
          } else if (state is EmployeeError) {
            return ErrorWidget(message: state.message);
          }
          return Container();
        },
      ),
    );
  }
}
```

## Error Handling

### Exception Handling
```dart
class ApiException implements Exception {
  ApiException({
    required this.message,
    this.statusCode,
    this.details,
  });

  final String message;
  final int? statusCode;
  final Map<String, dynamic>? details;

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

// Usage in services
class EmployeeService {
  Future<Employee> getEmployee(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/employees/$id'));
      
      if (response.statusCode == 200) {
        return Employee.fromJson(jsonDecode(response.body));
      } else {
        throw ApiException(
          message: 'Failed to load employee',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException(message: 'No internet connection');
    } on FormatException {
      throw ApiException(message: 'Invalid response format');
    }
  }
}
```

### Error Widgets
```dart
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
```

## Testing Standards

### Unit Tests
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:hr_sandbox/domain/entities/employee.dart';
import 'package:hr_sandbox/data/repositories/employee_repository_impl.dart';
import 'package:hr_sandbox/data/datasources/employee_remote_datasource.dart';

@GenerateMocks([EmployeeRemoteDataSource])
import 'employee_repository_impl_test.mocks.dart';

void main() {
  group('EmployeeRepositoryImpl', () {
    late EmployeeRepositoryImpl repository;
    late MockEmployeeRemoteDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockEmployeeRemoteDataSource();
      repository = EmployeeRepositoryImpl(mockDataSource);
    });

    group('getEmployee', () {
      const employeeId = '123';
      const employee = Employee(
        id: employeeId,
        fullName: 'John Doe',
        email: 'john.doe@example.com',
      );

      test('should return employee when data source is successful', () async {
        // arrange
        when(mockDataSource.getEmployee(employeeId))
            .thenAnswer((_) async => employee);

        // act
        final result = await repository.getEmployee(employeeId);

        // assert
        expect(result, equals(employee));
        verify(mockDataSource.getEmployee(employeeId)).called(1);
      });

      test('should throw exception when data source fails', () async {
        // arrange
        when(mockDataSource.getEmployee(employeeId))
            .thenThrow(ApiException(message: 'Network error'));

        // act & assert
        expect(
          () => repository.getEmployee(employeeId),
          throwsA(isA<ApiException>()),
        );
      });
    });
  });
}
```

### Widget Tests
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:hr_sandbox/presentation/widgets/employee_card.dart';
import 'package:hr_sandbox/domain/entities/employee.dart';
import 'package:hr_sandbox/presentation/providers/employee_provider.dart';

void main() {
  group('EmployeeCard', () {
    const employee = Employee(
      id: '123',
      fullName: 'John Doe',
      email: 'john.doe@example.com',
    );

    testWidgets('displays employee information correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(employee: employee),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmployeeCard(
              employee: employee,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(EmployeeCard));
      expect(tapped, isTrue);
    });
  });
}
```

## Performance Standards

### Widget Optimization
```dart
// Use const constructors
const EmployeeCard({super.key, required this.employee});

// Implement shouldRebuild for custom widgets
class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is CustomWidget && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

// Use ListView.builder for large lists
ListView.builder(
  itemCount: employees.length,
  itemBuilder: (context, index) {
    return EmployeeCard(employee: employees[index]);
  },
)
```

### Memory Management
```dart
class EmployeeProvider extends ChangeNotifier {
  // Dispose resources properly
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  // Use weak references when needed
  final WeakReference<BuildContext> _contextRef;
}
```

## Security Standards

### Data Validation
```dart
class EmployeeValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }
}
```

### Input Sanitization
```dart
class InputSanitizer {
  static String sanitizeText(String input) {
    return input.trim().replaceAll(RegExp(r'<[^>]*>'), '');
  }

  static String sanitizeEmail(String email) {
    return email.trim().toLowerCase();
  }
}
``` 