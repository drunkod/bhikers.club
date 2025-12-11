# Implementation Plan

- [ ] 1. Create shared test utilities module
  - [ ] 1.1 Create `test/club/bhikers/test_utils.cljd` with namespace `club.bhikers.test-utils`
    - Add required imports for Flutter test framework, Material, SharedPreferences
    - Implement `init-test-env!` function that initializes Flutter binding, sets mock SharedPreferences, and initializes logging/app in mock mode
    - _Requirements: 1.1, 1.4, 3.1_
  - [ ] 1.2 Implement mock factory functions
    - Add `mock-overpass-api` function using `reify` pattern from existing `pois_test.cljd`
    - _Requirements: 3.2, 3.4_
  - [ ] 1.3 Implement widget test helper functions
    - Add `pump-and-settle!` helper that wraps `pumpWidget` and `pumpAndSettle`
    - Add `open-drawer!` helper with proper `^m/ScaffoldState` type hint to avoid dynamic warning
    - Add `tap-widget!` helper for tapping and settling
    - _Requirements: 1.2, 1.3, 4.1, 4.4_

- [ ] 2. Move and refactor widget tests
  - [ ] 2.1 Move `commontest.cljd` to test directory
    - Create `test/club/bhikers/screens/common_test.cljd`
    - Update namespace to `club.bhikers.screens.common-test`
    - Delete `src/club/bhikers/screens/commontest.cljd`
    - _Requirements: 2.1, 2.2, 2.3, 2.4_
  - [ ] 2.2 Move `settingstest.cljd` to test directory
    - Create `test/club/bhikers/screens/settings_test.cljd`
    - Update namespace to `club.bhikers.screens.settings-test`
    - Delete `src/club/bhikers/screens/settingstest.cljd`
    - _Requirements: 2.1, 2.2, 2.3, 2.4_
  - [ ] 2.3 Refactor widget tests to use shared utilities
    - Update `common_test.cljd` to use `test-utils` helpers
    - Update `settings_test.cljd` to use `test-utils` helpers
    - Remove duplicated setup code
    - _Requirements: 1.5, 3.3_

- [ ] 3. Fix dynamic warnings and standardize naming
  - [ ] 3.1 Fix dynamic warning in common test
    - Replace inline `openDrawer` call with `tu/open-drawer!` helper
    - Verify no dynamic warnings on compilation
    - _Requirements: 4.1, 4.2, 4.3_
  - [ ] 3.2 Rename tests to follow conventions
    - Rename `aboutversiontest` to `about-version-test`
    - Rename `titledumbtest` to `settings-title-display-test`
    - _Requirements: 5.1, 5.2, 5.3_

- [ ] 4. Clean up production code
  - [ ] 4.1 Remove mock initialization from app.cljd
    - Move `SharedPreferences.setMockInitialValues` call from `app.cljd` to `test-utils/init-test-env!`
    - Ensure production code has no test-specific logic
    - _Requirements: 1.6_

- [ ] 5. Add missing test coverage
  - [ ]* 5.1 Create `test/club/bhikers/lib/state_test.cljd`
    - Implement unit tests for `debug-mode?` checking priority of atom vs constant
    - Test core state management functions
    - _Requirements: 6.1, 6.3, 6.4_
  - [ ]* 5.2 Create `test/club/bhikers/lib/config_test.cljd`
    - Implement tests verifying default values and configuration integrity
    - Test configuration loading functions
    - _Requirements: 6.2, 6.3, 6.4_

- [ ] 6. Verify and validate
  - [ ] 6.1 Run full test suite
    - Execute `make test` and verify all tests pass
    - Verify zero dynamic warnings in test compilation output
    - _Requirements: 4.2_
