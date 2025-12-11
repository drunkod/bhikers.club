# Requirements Document

## Introduction

This document defines the requirements for refactoring the test suite in the BHikers Club ClojureDart/Flutter application. The current test structure has inconsistencies in organization, setup patterns, and lacks shared test utilities. The refactoring aims to improve test maintainability, reduce code duplication, and establish consistent patterns across unit tests and widget tests.

## Glossary

- **Unit_Test**: A test that verifies pure functions and business logic without Flutter widget dependencies
- **Widget_Test**: A test that verifies Flutter UI components using the Flutter test framework with `:tags [:widget]` and `:runner (ft/testWidgets [tester])`
- **Test_Fixture**: Reusable test setup code including mock objects and initialization routines
- **Mock_Mode**: Application initialization state that bypasses real services for testing purposes
- **WidgetTester**: Flutter test framework object providing methods like `pumpWidget`, `pumpAndSettle`, `tap`, and `firstState`

## Requirements

### Requirement 1: Consolidate Widget Test Setup with Dependency Injection

**User Story:** As a developer, I want shared widget test setup utilities with dependency injection, so that I can write widget tests with less boilerplate code and inject mock dependencies.

#### Acceptance Criteria

1. WHEN a widget test requires app initialization, THE Test_Fixture SHALL provide a `with-test-app` helper function that initializes app and logging in mock mode.
2. THE `with-test-app` helper SHALL accept an `:overrides` map parameter to inject mock dependencies (e.g., `:overpass-api`, `:notifications`) into the widget tree via `:bind`.
3. WHEN a widget test needs to pump and settle a widget, THE Test_Fixture SHALL provide a `pump-app` helper function that wraps `pumpWidget` and `pumpAndSettle` calls.
4. THE Test_Fixture SHALL ensure mock mode initialization occurs exactly once per test execution.
5. WHEN the shared setup is used, THE Widget_Test SHALL reduce setup code by a minimum of 50% compared to current implementation.
6. THE Test_Fixture SHALL move `SharedPreferences.setMockInitialValues` call from production `app.cljd` into the test utilities `init-test-env!` function.

### Requirement 2: Move Widget Tests to Test Directory with Proper Namespace Alignment

**User Story:** As a developer, I want all tests in the `test/` directory, so that test organization follows ClojureDart conventions.

#### Acceptance Criteria

1. THE Test_Suite SHALL locate all widget tests under `test/club/bhikers/screens/` directory.
2. THE Test_Suite SHALL remove widget test files from `src/club/bhikers/screens/` directory.
3. WHEN widget tests are moved, THE Test_Suite SHALL rename namespaces to use hyphenated `-test` suffix (e.g., `club.bhikers.screens.common-test` not `commontest`).
4. WHEN widget tests are moved, THE Test_Suite SHALL rename files to use underscored `_test` suffix matching the namespace (e.g., `common_test.cljd`).
5. THE Test_Suite SHALL update any imports or references to reflect new test locations.

### Requirement 3: Create Shared Test Utilities Module

**User Story:** As a developer, I want a shared test utilities namespace, so that common test helpers are reusable across all tests.

#### Acceptance Criteria

1. THE Test_Suite SHALL provide a `club.bhikers.test-utils` namespace containing shared test utilities.
2. THE Test_Utils namespace SHALL export mock factory functions for common dependencies (Overpass API, HTTP clients).
3. THE Test_Utils namespace SHALL export widget test helper functions for app initialization and widget pumping.
4. WHEN a test requires mock objects, THE Test_Utils namespace SHALL provide consistent mock implementations.

### Requirement 4: Resolve Dynamic Warnings in Tests

**User Story:** As a developer, I want tests free of dynamic warnings, so that test code follows ClojureDart best practices.

#### Acceptance Criteria

1. THE Widget_Test in `commontest.cljd` SHALL resolve the dynamic warning for `openDrawer` method call by extracting the `ScaffoldState` into a type-hinted local binding before calling `.openDrawer`.
2. WHEN tests are compiled, THE Test_Suite SHALL produce zero dynamic warnings.
3. THE Test_Suite SHALL use explicit type hints on WidgetTester destructuring where needed.
4. THE Test_Suite SHALL use the pattern `(let [^m/ScaffoldState state (firstState finder)] (.openDrawer state))` to ensure proper type inference.

### Requirement 5: Standardize Test Naming Conventions

**User Story:** As a developer, I want consistent test naming, so that test purpose is clear from the name.

#### Acceptance Criteria

1. THE Unit_Test names SHALL follow the pattern `<function-name>-test` (e.g., `str->int-test`).
2. THE Widget_Test names SHALL follow the pattern `<screen-name>-<behavior>-test` (e.g., `settings-title-display-test`).
3. THE Test_Suite SHALL rename existing tests to follow these conventions.
4. WHEN a test contains multiple assertions, THE Unit_Test SHALL use `testing` blocks with descriptive strings.

### Requirement 6: Add Missing Test Coverage

**User Story:** As a developer, I want comprehensive test coverage for critical functions, so that regressions are caught early.

#### Acceptance Criteria

1. THE Test_Suite SHALL include tests for `club.bhikers.lib.state` namespace core functions.
2. THE Test_Suite SHALL include tests for `club.bhikers.lib.config` namespace configuration loading.
3. WHEN new tests are added, THE Test_Suite SHALL follow established patterns from existing tests.
4. THE Test_Suite SHALL maintain a minimum of 2 test assertions per public function in tested namespaces.
