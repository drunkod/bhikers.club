# Requirements Document

## Introduction

This document specifies the requirements for refactoring the bhikers.club ClojureDart/Flutter mobile application codebase. The refactoring aims to improve code quality, maintainability, and organization by separating Static Configuration, Runtime State, Logic, and UI Components. The application is a hiking/biking companion app built with ClojureDart targeting Flutter.

## Glossary

- **ClojureDart**: A Clojure dialect that compiles to Dart, used for Flutter development
- **Atom**: A ClojureDart reference type for managing mutable state (`defonce atom`)
- **Constant**: An immutable value defined with `defonce` (without atom wrapper)
- **POI**: Point of Interest (e.g., shelters, restaurants, bike shops)
- **OSM**: OpenStreetMap, the source of POI data
- **Overpass API**: API for querying OpenStreetMap data
- **f/widget**: ClojureDart Flutter macro for building widgets
- **:get/:watch/:bind**: ClojureDart widget directives for dependency injection and state observation
- **lib/**: The library directory containing reusable modules
- **screens/**: The directory containing UI screen components
- **Lifecycle functions**: Functions that manage initialization and cleanup (`init!`/`dispose!`)

## Requirements

### Requirement 1: Separate State from Configuration

**User Story:** As a developer, I want configuration constants separated from runtime state atoms, so that I can clearly distinguish what is static (config) from what changes at runtime (state).

#### Acceptance Criteria

1. THE Codebase SHALL create `src/club/bhikers/lib/state.cljd` containing all `defonce atom` definitions currently in `lib/config.cljd`.
2. WHEN an atom is defined in `lib/config.cljd` (e.g., `selected-poi-type`, `selected-tile-server`, `tile-layer-type`, `pois-radius`, `force-debug-mode?`, `app-info`, `new-version-url`, `new-version`, `api-query-timeout`, `refresh-location-*` atoms), THE Codebase SHALL move it to `lib/state.cljd`.
3. THE Codebase SHALL keep only immutable constants in `lib/config.cljd` (e.g., `default-latest-release-api`, `raster-tile-servers`, `supported-locales`).
4. THE Codebase SHALL update all imports in files that reference moved atoms to use the new `state` namespace.

### Requirement 2: Deconstruct utils.cljd into focused modules

**User Story:** As a developer, I want utility functions organized by domain responsibility, so that HTTP logic doesn't live alongside string helpers and I can find related code easily.

#### Acceptance Criteria

1. THE Codebase SHALL create `src/club/bhikers/lib/http.cljd` containing `create-dio-instance` and `create-cache-store` functions.
2. THE Codebase SHALL create `src/club/bhikers/lib/i18n.cljd` containing the `l10n-str` function.
3. THE Codebase SHALL move `log-file-dir` function from `utils.cljd` to `logging.cljd`.
4. THE Codebase SHALL keep only generic helpers in `lib/utils.cljd` (e.g., `str->int`, `uuid-v5`, `uuid-v4`, `str->location-accuracy`, `location-accuracy->str`).
5. THE Codebase SHALL update all imports in files that reference moved functions to use the new module paths.

### Requirement 3: Split map.cljd into state and widgets

**User Story:** As a developer, I want map state logic separated from Flutter widgets, so that business logic and UI components have clear boundaries.

#### Acceptance Criteria

1. THE Codebase SHALL create `src/club/bhikers/lib/map/state.cljd` containing `new-state`, `disposable-streams` protocol, and `->state-streams` implementation.
2. THE Codebase SHALL create `src/club/bhikers/lib/map/widgets.cljd` containing `msg` and `control-buttons` widget functions.
3. THE Codebase SHALL update imports in `screens/aroundme.cljd` and other consumers to use the new module paths.
4. THE Codebase SHALL remove the original `lib/map.cljd` file after successful migration.

### Requirement 4: Externalize static POI data

**User Story:** As a developer, I want large static data hashmaps separated from logic, so that the logic files are shorter and more readable.

#### Acceptance Criteria

1. THE Codebase SHALL move `poi-types->osm-tags` hashmap from `lib/pois.cljd` to `lib/config.cljd`.
2. THE Codebase SHALL move `osm-tags->icons` hashmap from `lib/pois/ui.cljd` to `lib/config.cljd`.
3. THE Codebase SHALL update imports in `lib/pois.cljd` and `lib/pois/ui.cljd` to reference the moved data from `config.cljd`.

### Requirement 5: Refactor dynamic-map-pois for clarity

**User Story:** As a developer, I want complex nested logic extracted into helper functions, so that the code is easier to understand and test.

#### Acceptance Criteria

1. WHEN `pois.cljd` contains deeply nested `doseq` logic for API calls, THE Codebase SHALL extract the inner API call logic into a helper function named `fetch-pois-by-type`.
2. THE Helper function SHALL accept parameters for the POI type and query parameters.
3. THE Codebase SHALL replace the nested logic with calls to the extracted helper function.

### Requirement 6: Standardize lifecycle naming conventions

**User Story:** As a developer, I want consistent naming for lifecycle functions across all stateful namespaces, so that the codebase follows predictable patterns.

#### Acceptance Criteria

1. THE Codebase SHALL use `init!` and `dispose!` as the standard naming convention for lifecycle functions.
2. WHEN a stateful namespace has lifecycle functions with different names, THE Codebase SHALL rename them to `init!`/`dispose!`.
3. THE Codebase SHALL ensure `logging.cljd`, `app.cljd`, and `map/state.cljd` all follow the `init!`/`dispose!` convention.

### Requirement 7: Remove commented-out code

**User Story:** As a developer, I want clean source files without dead code, so that the codebase is easier to understand and maintain.

#### Acceptance Criteria

1. WHEN commented-out code blocks exist in source files, THE Codebase SHALL remove them.
2. THE Codebase SHALL specifically remove the FloatingActionButton commented block in `lib/map.cljd` (to be moved to `lib/map/widgets.cljd`).

### Requirement 8: Replace swap! with reset! for constant values

**User Story:** As a developer, I want consistent atom update patterns, so that the code is more readable and idiomatic.

#### Acceptance Criteria

1. WHEN a value is assigned to an atom without depending on its previous value, THE Codebase SHALL use `reset!` instead of `swap! (constantly ...)`.
2. THE Codebase SHALL maintain identical runtime behavior after the replacement.

### Requirement 9: Add docstrings to public functions

**User Story:** As a developer, I want public functions documented, so that I understand their purpose and usage.

#### Acceptance Criteria

1. THE Codebase SHALL add docstrings to all public functions in newly created `lib/` modules.
2. WHEN a function has complex parameters, THE Docstring SHALL describe each parameter's purpose.
3. THE Codebase SHALL prioritize docstrings for `http.cljd`, `i18n.cljd`, `state.cljd`, and `map/state.cljd`.
