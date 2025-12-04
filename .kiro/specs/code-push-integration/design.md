# Design Document: Code Push Integration

## Overview

This design describes how to integrate flutter_eval code push functionality into the bhikers.club ClojureDart/Flutter application. The integration enables over-the-air updates to specific UI components without requiring app store releases.

Since the app is written in ClojureDart (which compiles to Dart), we'll use Dart interop to integrate flutter_eval widgets into the ClojureDart codebase, while the hot update code itself will be written in pure Dart in a separate package.

## Architecture

```mermaid
graph TB
    subgraph "Main App (ClojureDart)"
        A[main.cljd] --> B[HotSwapLoader]
        B --> C[MaterialApp]
        C --> D[around-me screen]
        C --> E[settings screen]
        D --> F[HotSwap #around-me]
        E --> G[HotSwap #settings]
    end
    
    subgraph "Hot Update Package (Dart)"
        H[hot_update.dart] --> I[@RuntimeOverride functions]
        I --> J[dart_eval compile]
        J --> K[update.evc]
    end
    
    subgraph "Update Server"
        L[https://server/update.evc]
    end
    
    K -.-> L
    L -.-> B
    B -.-> F
    B -.-> G
```

## Components and Interfaces

### 1. Dart Interop Layer

ClojureDart requires explicit imports for Dart packages. We'll add flutter_eval imports:

```clojure
;; In main.cljd
(:require ["package:flutter_eval/flutter_eval.dart" :as fe]
          ["package:flutter_eval/widgets.dart" :as few])
```

### 2. HotSwapLoader Integration

The HotSwapLoader wraps the entire app and manages EVC file loading:

```clojure
;; Modified main.cljd structure
(defn BhikersClubApp [initialRoute]
  (f/widget
   ;; HotSwapLoader at the outermost level
   (fe/HotSwapLoader
    .uri "asset://assets/hot_update.evc"  ;; or https:// for remote
    .strategy fe/HotSwapStrategy.immediate
    .loading (m/Center .child (m/CircularProgressIndicator)))
   ;; Then localization
   (l10n/EasyLocalization ...)
   ;; Then the rest of the app
   ...))
```

### 3. HotSwap Widget Integration

Each hot-swappable location uses the HotSwap widget with a unique ID:

```clojure
;; In around-me screen
(defn around-me-screen []
  (f/widget
   :context ctx
   (fe/HotSwap
    .id "#bhikers_around_me"
    .args [(few/$BuildContext.wrap ctx)]
    .childBuilder (fn [_] 
                    ;; Original screen content
                    (around-me-content ctx)))))
```

### 4. Hot Update Package Structure

```
hot_update/
├── .dart_eval/
│   └── bindings/
│       └── flutter_eval.json    # Downloaded from flutter_eval releases
├── lib/
│   └── hot_update.dart          # Override functions
├── pubspec.yaml
└── README.md
```

### 5. Hot Update Package pubspec.yaml

```yaml
name: bhikers_hot_update
description: Hot update package for bhikers.club app
version: 1.0.0

environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: ">=1.17.0"

dependencies:
  eval_annotation: ^0.7.0
  flutter:
    sdk: flutter
```

### 6. Example Override Function

```dart
// lib/hot_update.dart
import 'package:eval_annotation/eval_annotation.dart';
import 'package:flutter/material.dart';

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
```

## Data Models

### Update Configuration

```clojure
;; In app.cljd - add configuration atoms
(defonce code-push-uri (atom "asset://assets/hot_update.evc"))
(defonce code-push-strategy (atom :immediate)) ;; :immediate, :cache, :cache-apply-on-restart
```

### HotSwap IDs Registry

| ID | Screen | Description |
|----|--------|-------------|
| `#bhikers_around_me` | around-me | Main map/POI screen |
| `#bhikers_settings` | settings | App settings screen |
| `#bhikers_enhance_gpx` | enhance-gpx | GPX enhancement screen |
| `#bhikers_fall_detector` | fall-detector | Fall detection screen |

## Error Handling

### EVC Load Failures

```clojure
;; HotSwapLoader handles failures gracefully
;; If URI fails to load, app continues with built-in code
(fe/HotSwapLoader
 .uri @code-push-uri
 .strategy (case @code-push-strategy
             :immediate fe/HotSwapStrategy.immediate
             :cache fe/HotSwapStrategy.cache
             :cache-apply-on-restart fe/HotSwapStrategy.cacheApplyOnRestart)
 .loading (m/SizedBox.shrink)  ;; Minimal loading indicator
 .child ...)
```

### Missing Override Handling

When a HotSwap widget's ID has no corresponding @RuntimeOverride in the loaded EVC, the childBuilder is executed automatically - no explicit error handling needed.

## Testing Strategy

### 1. Local Asset Testing

1. Compile hot_update package to EVC
2. Place EVC in `assets/hot_update.evc`
3. Add asset to pubspec.yaml
4. Test with `asset://` URI

### 2. Remote Update Testing

1. Host EVC file on a web server
2. Configure HotSwapLoader with `https://` URI
3. Test update download and application

### 3. Fallback Testing

1. Configure invalid URI
2. Verify app loads with built-in code
3. Check no crashes occur

## File Changes Summary

| File | Change Type | Description |
|------|-------------|-------------|
| `pubspec.yaml` | Modify | Add flutter_eval, dart_eval dependencies |
| `src/club/bhikers/main.cljd` | Modify | Add HotSwapLoader wrapper |
| `src/club/bhikers/screens/aroundme.cljd` | Modify | Add HotSwap widget |
| `src/club/bhikers/screens/settings.cljd` | Modify | Add HotSwap widget |
| `hot_update/` | Create | New Dart package for updates |
| `assets/hot_update.evc` | Create | Placeholder/initial EVC file |
