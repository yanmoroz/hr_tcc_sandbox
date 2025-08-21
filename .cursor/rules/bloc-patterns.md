# BLoC Patterns & Testing

## BLoC Architecture Overview

### Core Concepts
- **BLoC (Business Logic Component)**: Separates business logic from UI
- **Event**: Input to the BLoC (user actions, system events)
- **State**: Output from the BLoC (UI state, data)
- **Stream**: One-way data flow from Event → BLoC → State

### BLoC Structure
```dart
// 1. Events (Input)
abstract class EmployeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEmployee extends EmployeeEvent {
  final String id;
  LoadEmployee(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;
  UpdateEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

// 2. States (Output)
abstract class EmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}
class EmployeeLoading extends EmployeeState {}
class EmployeeLoaded extends EmployeeState {
  final Employee employee;
  EmployeeLoaded(this.employee);

  @override
  List<Object?> get props => [employee];
}
class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}

// 3. BLoC (Business Logic)
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
    try {
      final updatedEmployee = await _repository.updateEmployee(event.employee);
      emit(EmployeeLoaded(updatedEmployee));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}
```

## Widget Integration

### DI with GetIt (policy)
- Register BLoCs as `factory` in the feature's `di/<feature>_module.dart`.
- UI resolves BLoCs via `BlocProvider(create: (_) => getIt<FeatureBloc>())`.
- Do not make BLoCs singletons.
- Do not construct BLoCs inside other layers (repositories, use cases).
- Use case classes should be injected by their `UseCase`-postfixed names, e.g., `GetProfileUseCase`.

### BlocProvider
```dart
class EmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(
        context.read<EmployeeRepository>(),
      ),
      child: EmployeeView(),
    );
  }
}
```

### BlocBuilder
```dart
class EmployeeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EmployeeLoaded) {
          return EmployeeCard(employee: state.employee);
        } else if (state is EmployeeError) {
          return ErrorWidget(message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
```

### BlocListener
```dart
class EmployeeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EmployeeLoaded) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                ElevatedButton(
                  onPressed: state is EmployeeLoading
                      ? null
                      : () => context.read<EmployeeBloc>().add(
                            UpdateEmployee(employee),
                          ),
                  child: state is EmployeeLoading
                      ? CircularProgressIndicator()
                      : Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

### MultiBlocProvider
```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(context.read<AuthRepository>()),
        ),
        BlocProvider<EmployeeBloc>(
          create: (context) => EmployeeBloc(context.read<EmployeeRepository>()),
        ),
        BlocProvider<TimeBloc>(
          create: (context) => TimeBloc(context.read<TimeRepository>()),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
```

## BLoC Testing

### Unit Tests with bloc_test
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:hr_sandbox/features/employee/presentation/blocs/employee_bloc.dart';
import 'package:hr_sandbox/features/employee/domain/entities/employee.dart';
import 'package:hr_sandbox/features/employee/domain/repositories/employee_repository.dart';

@GenerateMocks([EmployeeRepository])
import 'employee_bloc_test.mocks.dart';

void main() {
  group('EmployeeBloc', () {
    late EmployeeBloc employeeBloc;
    late MockEmployeeRepository mockRepository;

    setUp(() {
      mockRepository = MockEmployeeRepository();
      employeeBloc = EmployeeBloc(mockRepository);
    });

    tearDown(() {
      employeeBloc.close();
    });

    group('LoadEmployee', () {
      const employeeId = '123';
      const employee = Employee(
        id: employeeId,
        fullName: 'John Doe',
        email: 'john.doe@example.com',
      );

      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoading, EmployeeLoaded] when LoadEmployee is successful',
        build: () {
          when(mockRepository.getEmployee(employeeId))
              .thenAnswer((_) async => employee);
          return employeeBloc;
        },
        act: (bloc) => bloc.add(LoadEmployee(employeeId)),
        expect: () => [
          EmployeeLoading(),
          EmployeeLoaded(employee),
        ],
      );

      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoading, EmployeeError] when LoadEmployee fails',
        build: () {
          when(mockRepository.getEmployee(employeeId))
              .thenThrow(ApiException(message: 'Network error'));
          return employeeBloc;
        },
        act: (bloc) => bloc.add(LoadEmployee(employeeId)),
        expect: () => [
          EmployeeLoading(),
          EmployeeError('ApiException: Network error'),
        ],
      );
    });

    group('UpdateEmployee', () {
      const employee = Employee(
        id: '123',
        fullName: 'John Doe',
        email: 'john.doe@example.com',
      );

      blocTest<EmployeeBloc, EmployeeState>(
        'emits [EmployeeLoaded] when UpdateEmployee is successful',
        build: () {
          when(mockRepository.updateEmployee(employee))
              .thenAnswer((_) async => employee);
          return employeeBloc;
        },
        act: (bloc) => bloc.add(UpdateEmployee(employee)),
        expect: () => [
          EmployeeLoaded(employee),
        ],
      );
    });
  });
}
```

### Widget Tests with BLoC
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'package:hr_sandbox/features/employee/presentation/pages/employee_page.dart';
import 'package:hr_sandbox/features/employee/presentation/blocs/employee_bloc.dart';
import 'package:hr_sandbox/features/employee/domain/entities/employee.dart';

class MockEmployeeBloc extends MockBloc<EmployeeEvent, EmployeeState>
    implements EmployeeBloc {}

void main() {
  group('EmployeePage', () {
    late MockEmployeeBloc mockEmployeeBloc;

    setUp(() {
      mockEmployeeBloc = MockEmployeeBloc();
    });

    testWidgets('shows loading indicator when state is EmployeeLoading',
        (tester) async {
      whenListen(
        mockEmployeeBloc,
        Stream.fromIterable([EmployeeLoading()]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeBloc>.value(
            value: mockEmployeeBloc,
            child: EmployeePage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows employee card when state is EmployeeLoaded',
        (tester) async {
      const employee = Employee(
        id: '123',
        fullName: 'John Doe',
        email: 'john.doe@example.com',
      );

      whenListen(
        mockEmployeeBloc,
        Stream.fromIterable([EmployeeLoaded(employee)]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeBloc>.value(
            value: mockEmployeeBloc,
            child: EmployeePage(),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john.doe@example.com'), findsOneWidget);
    });

    testWidgets('shows error message when state is EmployeeError',
        (tester) async {
      whenListen(
        mockEmployeeBloc,
        Stream.fromIterable([EmployeeError('Network error')]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeBloc>.value(
            value: mockEmployeeBloc,
            child: EmployeePage(),
          ),
        ),
      );

      expect(find.text('Network error'), findsOneWidget);
    });
  });
}
```

## Best Practices

### Event Design
- Keep events simple and focused
- Use descriptive event names
- Include only necessary data in events
- Make events immutable

### State Design
- Make states immutable
- Use sealed classes or enums for state types
- Include only UI-relevant data in states
- Avoid storing business logic in states

### BLoC Design
- Keep BLoCs focused on specific business logic
- Use dependency injection for repositories
- Handle errors gracefully
- Implement proper cleanup in close() method

### Performance
- Use `BlocBuilder` only when needed
- Use `BlocListener` for side effects
- Avoid unnecessary state emissions
- Use `BlocProvider.value` for sharing BLoCs

### Testing
- Test all event handlers
- Test error scenarios
- Use `bloc_test` for unit testing
- Mock dependencies properly
- Test widget integration 