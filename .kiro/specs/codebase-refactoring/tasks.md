# Implementation Plan

- [ ] 1. Separate State from Configuration
  - [ ] 1.1 Create lib/state.cljd with runtime atoms
    - Create new file `src/club/bhikers/lib/state.cljd`
    - Move all `defonce atom` definitions from `config.cljd`: `selected-poi-type`, `selected-tile-server`, `tile-layer-type`, `api-query-timeout`, `pois-radius`, `new-version-url`, `new-version`, `refresh-location-distance-filter`, `refresh-location-interval-duration`, `refresh-location-accuracy`, `force-debug-mode?`, `app-info`
    - Add namespace declaration with required imports (geolocator for LocationAccuracy)
    - Import default values from config.cljd where needed
    - _Requirements: 1.1, 1.2_

  - [ ] 1.2 Update config.cljd to keep only constants
    - Remove all atom definitions that were moved to state.cljd
    - Keep immutable constants: `default-latest-release-api`, `supported-locales`, `default-locale`, `max-pois-radius`, `min-pois-radius`, `supported-poi-types`, `default-poi-type`, `raster-tile-servers`, `vector-tile-styles`, `icicommencelaventure`, `vertouplage`, `feat-fall-detector?`, `feat-enhance-gpx?`
    - Keep `debug-mode?` function (update to reference state.cljd for force-debug-mode?)
    - _Requirements: 1.3_

  - [ ] 1.3 Update imports across codebase for state atoms
    - Update `lib/map.cljd` to import from state.cljd
    - Update `lib/position.cljd` to import from state.cljd
    - Update `lib/logging.cljd` to import from state.cljd
    - Update `lib/app.cljd` to import from state.cljd
    - Update `screens/settings/ui.cljd` to import from state.cljd
    - Update any other files referencing moved atoms
    - _Requirements: 1.4_

- [ ] 2. Deconstruct utils.cljd into focused modules
  - [ ] 2.1 Create lib/http.cljd with HTTP utilities
    - Create new file `src/club/bhikers/lib/http.cljd`
    - Move `create-cache-store` function
    - Move `create-dio-instance` function
    - Add docstrings explaining parameters and usage
    - Import uuid-v5 from utils.cljd for cache key generation
    - _Requirements: 2.1_

  - [ ] 2.2 Create lib/i18n.cljd with localization utilities
    - Create new file `src/club/bhikers/lib/i18n.cljd`
    - Move `l10n-str` function
    - Add docstring explaining usage
    - _Requirements: 2.2_

  - [ ] 2.3 Move log-file-dir to logging.cljd
    - Move `log-file-dir` function from utils.cljd to logging.cljd
    - Update logging.cljd imports (remove utils.cljd reference for log-file-dir)
    - _Requirements: 2.3_

  - [ ] 2.4 Clean up utils.cljd
    - Remove moved functions (create-dio-instance, create-cache-store, l10n-str, log-file-dir)
    - Keep only: `uuidgen`, `uuid-v5`, `uuid-v4`, `str->int`, `str->location-accuracy`, `location-accuracy->str`
    - Update namespace requires to remove unused imports
    - _Requirements: 2.4_

  - [ ] 2.5 Update imports for extracted utilities
    - Update `lib/overpassapi.cljd` to import from http.cljd
    - Update `lib/pois/ui.cljd` to import l10n-str from i18n.cljd
    - Update `lib/map.cljd` to import l10n-str from i18n.cljd
    - Update all other files using moved functions
    - _Requirements: 2.5_

- [ ] 3. Split map.cljd into state and widgets
  - [ ] 3.1 Create lib/map/state.cljd with state logic
    - Create directory `src/club/bhikers/lib/map/`
    - Create new file `src/club/bhikers/lib/map/state.cljd`
    - Move `new-state` function
    - Move `disposable-streams` protocol
    - Move `->state-streams` function
    - Update namespace and imports
    - _Requirements: 3.1_

  - [ ] 3.2 Create lib/map/widgets.cljd with UI components
    - Create new file `src/club/bhikers/lib/map/widgets.cljd`
    - Move `msg` widget function
    - Move `control-buttons` widget function
    - Remove commented FloatingActionButton code block
    - Update namespace and imports
    - _Requirements: 3.2, 7.2_

  - [ ] 3.3 Update imports for map module consumers
    - Update `screens/aroundme.cljd` to import from map/state.cljd and map/widgets.cljd
    - Update any other files importing from lib/map.cljd
    - _Requirements: 3.3_

  - [ ] 3.4 Remove original map.cljd
    - Delete `src/club/bhikers/lib/map.cljd` after verifying all imports work
    - _Requirements: 3.4_

- [ ] 4. Externalize static POI data
  - [ ] 4.1 Move poi-types->osm-tags to config.cljd
    - Copy `poi-types->osm-tags` hashmap from pois.cljd to config.cljd
    - Update pois.cljd to import from config.cljd
    - Remove original definition from pois.cljd
    - _Requirements: 4.1_

  - [ ] 4.2 Move osm-tags->icons to config.cljd
    - Move `osm-tag-icon` helper function to config.cljd
    - Move `osm-tags->icons` hashmap to config.cljd
    - Update pois/ui.cljd to import from config.cljd
    - _Requirements: 4.2_

  - [ ] 4.3 Extract fetch-pois-by-type helper
    - Create `fetch-pois-by-type` function in pois.cljd
    - Extract the inner doseq logic for API calls
    - Refactor `dynamic-map-pois` to use the new helper
    - Use `(swap! pois into items)` for atomic accumulation
    - _Requirements: 5.1, 5.2, 5.3_

- [ ] 5. Code hygiene and documentation
  - [ ] 5.1 Replace swap! with reset! for constant values
    - Search for `swap! .* (constantly` patterns across codebase
    - Replace with `reset!` where value doesn't depend on previous state
    - Keep `swap!` for atomic updates based on previous state
    - _Requirements: 8.1, 8.2_

  - [ ] 5.2 Verify lifecycle naming consistency
    - Audit all stateful namespaces for lifecycle functions
    - Ensure all use `init!` and `dispose!` naming
    - Update any inconsistent naming
    - _Requirements: 6.1, 6.2, 6.3_

  - [ ] 5.3 Add docstrings to new modules
    - Add docstrings to all public functions in state.cljd
    - Add docstrings to all public functions in http.cljd
    - Add docstrings to all public functions in i18n.cljd
    - Add docstrings to all public functions in map/state.cljd
    - Add docstrings to all public functions in map/widgets.cljd
    - _Requirements: 9.1, 9.2, 9.3_

- [ ] 5.4 Write unit tests for new modules
    - Write tests for http.cljd cache store creation
    - Write tests for utils.cljd type conversion functions
    - Write tests for fetch-pois-by-type helper
    - _Requirements: Testing Strategy_
