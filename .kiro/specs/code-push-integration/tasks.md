# Implementation Plan

- [x] 1. Add flutter_eval dependencies to the project
  - Add flutter_eval, dart_eval, and eval_annotation to pubspec.yaml dependencies section
  - Run flutter pub get to resolve dependencies
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 2. Create hot update package structure
  - [x] 2.1 Create hot_update directory and pubspec.yaml
    - Create `hot_update/` directory in project root
    - Create pubspec.yaml with eval_annotation dependency
    - _Requirements: 4.1, 4.3_
  - [x] 2.2 Set up dart_eval bindings
    - Create `.dart_eval/bindings/` directory structure
    - Download and place flutter_eval.json bindings file
    - _Requirements: 4.2_
  - [x] 2.3 Create initial hot_update.dart with example override
    - Create lib/hot_update.dart with @RuntimeOverride example
    - Add placeholder override functions for each HotSwap ID
    - _Requirements: 4.4_

- [ ] 3. Integrate HotSwapLoader in main app
  - [ ] 3.1 Add flutter_eval imports to main.cljd
    - Import flutter_eval.dart and widgets.dart packages
    - _Requirements: 2.1_
  - [ ] 3.2 Wrap BhikersClubApp with HotSwapLoader
    - Add HotSwapLoader as outermost widget
    - Configure URI to load from assets initially
    - Set appropriate strategy (immediate for dev)
    - _Requirements: 2.1, 2.2, 2.3, 2.4_

- [ ] 4. Add HotSwap widgets to screens
  - [ ] 4.1 Add HotSwap to around-me screen
    - Wrap around-me screen content with HotSwap widget
    - Set ID to "#bhikers_around_me"
    - Pass BuildContext as wrapped argument
    - _Requirements: 3.1, 3.3, 3.4_
  - [ ] 4.2 Add HotSwap to settings screen
    - Wrap settings screen content with HotSwap widget
    - Set ID to "#bhikers_settings"
    - Pass BuildContext as wrapped argument
    - _Requirements: 3.2, 3.3, 3.4_

- [ ] 5. Configure assets and compile initial EVC
  - [ ] 5.1 Add assets configuration to pubspec.yaml
    - Add assets/hot_update.evc to flutter assets section
    - Create assets directory if needed
    - _Requirements: 2.4_
  - [ ] 5.2 Compile hot_update package to EVC
    - Run dart_eval compile in hot_update directory
    - Copy resulting EVC file to assets/hot_update.evc
    - _Requirements: 5.1, 5.2_
  - [ ] 5.3 Add compilation documentation
    - Create README in hot_update with compilation instructions
    - Document the update deployment workflow
    - _Requirements: 5.3_

- [ ] 6. Add code push configuration to app settings
  - Add code-push-uri atom to app.cljd for configurable update URL
  - Add code-push-strategy atom for update strategy selection
  - _Requirements: 6.1, 6.2, 6.3_
