# Requirements Document

## Introduction

This document specifies the requirements for integrating flutter_eval code push functionality into the bhikers.club ClojureDart/Flutter application. Code push enables over-the-air updates to specific parts of the app without requiring a full app store release. Since the app is written in ClojureDart (which compiles to Dart), the integration requires careful consideration of how flutter_eval's Dart-based hot-swap mechanism can work with ClojureDart-generated code.

## Glossary

- **Code_Push_System**: The flutter_eval-based system that enables runtime code updates via EVC bytecode files
- **HotSwapLoader**: A flutter_eval widget that loads and manages EVC update files from a specified URI
- **HotSwap**: A flutter_eval widget that marks a location in the widget tree as dynamically replaceable
- **EVC_File**: Compiled bytecode file produced by dart_eval containing runtime-executable Dart code
- **Hot_Update_Package**: A separate Flutter/Dart package containing the code that will be compiled to EVC for updates
- **ClojureDart**: The language used to write the bhikers.club app, which compiles to Dart
- **Bhikers_App**: The bhikers.club mobile application for hikers/bikers

## Requirements

### Requirement 1: Add flutter_eval Dependencies

**User Story:** As a developer, I want to add flutter_eval and related dependencies to the project, so that the code push infrastructure is available.

#### Acceptance Criteria

1. WHEN the developer runs `flutter pub get`, THE Code_Push_System SHALL resolve flutter_eval, dart_eval, and eval_annotation packages successfully
2. THE Bhikers_App SHALL include flutter_eval version compatible with the current Flutter SDK (^3.6.0)
3. THE Bhikers_App SHALL include dart_eval as a dependency for runtime evaluation support

### Requirement 2: Create HotSwapLoader Root Widget

**User Story:** As a developer, I want to wrap the app with HotSwapLoader, so that EVC update files can be loaded at app startup.

#### Acceptance Criteria

1. WHEN the Bhikers_App starts, THE Code_Push_System SHALL attempt to load an EVC file from a configurable URI
2. IF the EVC file is unavailable or fails to load, THEN THE Bhikers_App SHALL continue running with the built-in code
3. THE HotSwapLoader SHALL be placed at the root of the widget tree before MaterialApp
4. THE Code_Push_System SHALL support loading EVC files from both network (https://) and local asset (asset://) URIs

### Requirement 3: Implement HotSwap Points in Key Screens

**User Story:** As a developer, I want to mark specific screens as hot-swappable, so that those screens can be updated via code push.

#### Acceptance Criteria

1. THE Bhikers_App SHALL have HotSwap widgets wrapping the around-me screen content
2. THE Bhikers_App SHALL have HotSwap widgets wrapping the settings screen content
3. WHEN a HotSwap widget has no corresponding override in the loaded EVC, THE Code_Push_System SHALL render the default childBuilder content
4. THE HotSwap widgets SHALL pass required context and state as wrapped arguments

### Requirement 4: Create Hot Update Package Structure

**User Story:** As a developer, I want a separate Dart package for hot updates, so that I can write and compile update code independently.

#### Acceptance Criteria

1. THE Hot_Update_Package SHALL be created as a Flutter package in a `hot_update/` subdirectory
2. THE Hot_Update_Package SHALL include the flutter_eval.json bindings file in `.dart_eval/bindings/`
3. THE Hot_Update_Package SHALL depend on eval_annotation for @RuntimeOverride annotations
4. THE Hot_Update_Package SHALL contain example override functions matching the HotSwap IDs in the main app

### Requirement 5: Configure EVC Compilation

**User Story:** As a developer, I want to compile the hot update package to EVC format, so that updates can be deployed.

#### Acceptance Criteria

1. WHEN the developer runs `dart_eval compile` in the Hot_Update_Package directory, THE Code_Push_System SHALL produce a valid EVC file
2. THE EVC_File SHALL be named with a version identifier for cache management
3. THE Hot_Update_Package SHALL include documentation on the compilation process

### Requirement 6: Support Update Strategies

**User Story:** As a developer, I want to configure how updates are applied, so that I can balance between immediate updates and app stability.

#### Acceptance Criteria

1. THE Code_Push_System SHALL support the `immediate` strategy for development/testing
2. THE Code_Push_System SHALL support the `cacheApplyOnRestart` strategy for production releases
3. THE HotSwapLoader SHALL display a configurable loading placeholder while fetching updates
