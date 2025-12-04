// ignore_for_file: no_leading_underscores_for_local_identifiers
library hot_update;

import 'package:eval_annotation/eval_annotation.dart';
import 'package:flutter/material.dart';

/// Hot-swappable override for the around-me screen.
/// This function will replace the around-me screen content when loaded via code push.
@RuntimeOverride('#bhikers_around_me')
Widget aroundMeUpdate(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Around Me - Updated!"),
      backgroundColor: Colors.green,
    ),
    body: const Center(
      child: Text('This content was updated via code push!'),
    ),
  );
}

/// Hot-swappable override for the settings screen.
/// This function will replace the settings screen content when loaded via code push.
@RuntimeOverride('#bhikers_settings')
Widget settingsUpdate(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Settings - Updated!"),
      backgroundColor: Colors.blue,
    ),
    body: const Center(
      child: Text('Settings updated via code push!'),
    ),
  );
}

/// Hot-swappable override for the enhance-gpx screen.
@RuntimeOverride('#bhikers_enhance_gpx')
Widget enhanceGpxUpdate(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Enhance GPX - Updated!"),
      backgroundColor: Colors.orange,
    ),
    body: const Center(
      child: Text('Enhance GPX updated via code push!'),
    ),
  );
}

/// Hot-swappable override for the fall-detector screen.
@RuntimeOverride('#bhikers_fall_detector')
Widget fallDetectorUpdate(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Fall Detector - Updated!"),
      backgroundColor: Colors.red,
    ),
    body: const Center(
      child: Text('Fall Detector updated via code push!'),
    ),
  );
}
