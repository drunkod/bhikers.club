# TODO: Debug Fixes Implementation

## High Priority
- [ ] Fix stream controller lifecycle in `src/club/bhikers/lib/position.cljd:185`
- [ ] Add location service disabled popup with message "Please enable location services on device"
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

