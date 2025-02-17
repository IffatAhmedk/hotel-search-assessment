## Test Dependencies
### Overview

The following dependencies were added to support the testing infrastructure of the application. These dependencies should be added to your pubspec.yaml file under the dev_dependencies section.

### Required Dependencies
```
dev_dependencies:
  integration_test:
    sdk: flutter
  mockito: ^5.4.4
  bloc_test: ^9.1.5
  mocktail: ^1.0.4
```

### Purpose of Dependencies

#### Integration Test
Enables end-to-end (E2E) testing of Flutter applications

#### Mockito (v5.4.4)
Used for creating mock objects in unit tests
Helps isolate the code being tested

#### Bloc Test (v9.1.5)
Testing library for the Bloc state management library

#### Mocktail (v1.0.4)
Modern mocking library for Dart
Alternative to Mockito with null-safety support

