# TODO: Debug Fixes Implementation

## High Priority

### Performance: Unnecessary POI Refresh During Language Changes
> See: [Language-Change-State-Management-&-Widget-Rebuild-Flow.md](Language-Change-State-Management-&-Widget-Rebuild-Flow.md)

**Problem**: Language changes trigger EasyLocalization app rebuild → widget disposal/recreation → position streams restart → POI watcher detects "new" position → 4+ Overpass API calls fire unnecessarily.

**Root cause**: No caching for POI data; `:bind {:map-state}` creates ephemeral state that doesn't survive rebuilds.

**Fix options**:
- [x] **Option A (Minimal)**: Add guard in `pois.cljd` watcher to skip refresh if only locale changed
  - ✅ Added `last-poi-query-params` persistent atom outside widget lifecycle
  - ✅ Compare query params against cache before API calls
- [ ] **Option B (Better)**: Implement POI caching layer
  - Cache POI results by (lat, lon, radius, poi-type) key
  - Invalidate cache only on actual position/preference changes
- [ ] **Option C (Best)**: Decouple position streams from widget lifecycle
  - Move position stream management to app-level singleton
  - Widget subscribes to shared stream instead of creating new one

**Files to modify**:
- `src/club/bhikers/lib/pois.cljd:52-56` - POI refresh watcher
- `src/club/bhikers/lib/map/state.cljd` - Stream lifecycle management
- `src/club/bhikers/screens/aroundme.cljd:24-26` - Widget bind/managed hooks

---

- [+] Fix stream controller lifecycle in `src/club/bhikers/lib/position.cljd:185`
- [ ] Add location service disabled popup with message "Please enable location services on device"
  > **Architecture Reference**: [Location-Service-Disabled-Popup-Implementation---Current-Architecture.md](Location-Service-Disabled-Popup-Implementation---Current-Architecture.md)
  
  **Implementation Steps:**
  - [ ] **1. Localization**: Add translation keys to all language files
    - Add `around_me.location_service_disabled: Please enable location services on device` to:
      - `assets/l10n/en.yaml`
      - `assets/l10n/fr.yaml`, `de.yaml`, `it.yaml`, `es.yaml`, `ru.yaml`
    - Add `common.open_settings: Open Settings` button text
  
  - [ ] **2. Popup Component**: Create reusable popup widget
    - File: `src/club/bhikers/screens/common/location_service_popup.cljd`
    - Use `m/showDialog` or `m/showModalBottomSheet` pattern (see [2b] in arch doc)
    - Include "Open Settings" button calling `perms/openAppSettings` (see [3d])
    - Display localized message using `l10n-str` helper (see [4b])
  
  - [ ] **3. Error Handler**: Catch `ServiceDisabledException` from position stream
    - File: `src/club/bhikers/lib/map/state.cljd:87` (see [1b])
    - Add `.onError` handler to position stream subscription
    - Check for `maploc/ServiceDisabledException` error type
    - Call popup function with `BuildContext` when error detected
  
  - [ ] **4. Integration**: Wire popup to AroundMe screen
    - File: `src/club/bhikers/screens/aroundme.cljd`
    - Ensure `BuildContext` is available for popup display (see [2a])
    - Handle initial service disabled state on screen mount
    - Handle service disabled during active session (via stream listener [1d])
  
  **Key Files Changed:**
  - `assets/l10n/*.yaml` - Translation strings
  - `src/club/bhikers/screens/common/location_service_popup.cljd` [NEW]
  - `src/club/bhikers/lib/map/state.cljd` - Error handling in position stream
  - `src/club/bhikers/screens/aroundme.cljd` - Integration
- [ ] Add missing localization keys: `edit-everydoor`, `route-to-poi`

## Medium Priority
- [ ] Implement proper error handling for geolocator exceptions
- [ ] Add location service status indicator in UI
- [ ] Create comprehensive test coverage for location services

## Low Priority
- [ ] Optimize POI fetching logic
- [ ] Add location permission request flow improvements
- [ ] Implement location settings persistence

## Debug Log Reference
I/flutter (27655): [D] TIME: 2025-12-14T12:47:43.194588 [club.bhikers] permission granted, setup stream controller
I/flutter (27655): [D] TIME: 2025-12-14T12:47:43.288325 [club.bhikers] listen to service status strean
I/flutter (27655): [D] TIME: 2025-12-14T12:47:43.293951 [club.bhikers] listening on position stream source
E/FlutterGeolocator(27655): Geolocator position updates started
E/flutter (27655): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: The location service on the device is disabled.
E/flutter (27655): #0      GeolocatorAndroid.getPositionStream.<anonymous closure> (package:geolocator_android/src/geolocator_android.dart:202:7)

test with https://github.com/greensopinion/flutter-vector-map-tiles?tab=readme-ov-file 10.0 version
https://docs.flutter.dev/perf/impeller
https://github.com/greensopinion/flutter-vector-map-tiles-examples/tree/10.0.0


rewrite maps to https://github.com/bangonkali/agus-maps-flutter