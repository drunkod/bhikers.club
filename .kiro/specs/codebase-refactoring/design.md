# Design Document

## Overview

This document describes the technical design for refactoring the bhikers.club ClojureDart codebase. The refactoring separates Static Configuration, Runtime State, Logic, and UI Components to improve maintainability and code organization.

The refactoring follows a specific order to minimize breakage:
1. Separate state from configuration (foundation for other changes)
2. Split utils.cljd into focused modules
3. Split map.cljd into state and widgets
4. Externalize static POI data
5. Code hygiene improvements

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        screens/                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │  aroundme/  │  │  settings/  │  │   common/   │              │
│  │   core      │  │    core     │  │   appbar    │              │
│  │   layers    │  │     ui      │  │   drawer    │              │
│  │     ui      │  │             │  │             │              │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘              │
└─────────┼────────────────┼────────────────┼─────────────────────┘
          │                │                │
          ▼                ▼                ▼
┌─────────────────────────────────────────────────────────────────┐
│                          lib/                                    │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    Core Modules                           │   │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────────┐  │   │
│  │  │ config  │  │  state  │  │  i18n   │  │    http     │  │   │
│  │  │(consts) │  │ (atoms) │  │(l10n-str)│ │(dio,cache)  │  │   │
│  │  └─────────┘  └─────────┘  └─────────┘  └─────────────┘  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                   Feature Modules                         │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐   │   │
│  │  │    map/     │  │  position/  │  │      pois/      │   │   │
│  │  │  state.cljd │  │ settings    │  │   (logic only)  │   │   │
│  │  │ widgets.cljd│  │  streams    │  │                 │   │   │
│  │  └─────────────┘  └─────────────┘  └─────────────────┘   │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                  Support Modules                          │   │
│  │  ┌─────────┐  ┌─────────────┐  ┌─────────────────────┐   │   │
│  │  │ logging │  │notifications│  │    permissions      │   │   │
│  │  └─────────┘  └─────────────┘  └─────────────────────┘   │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

## Components and Interfaces

### 1. State Module (`lib/state.cljd`)

**Purpose:** Centralize all runtime mutable state atoms.

**Interface:**
```clojure
;; Runtime state atoms (moved from config.cljd)
(defonce selected-poi-type (atom default-poi-type))
(defonce selected-tile-server (atom "osm"))
(defonce tile-layer-type (atom :raster))
(defonce api-query-timeout (atom 3))
(defonce pois-radius (atom 1000))
(defonce new-version-url (atom nil))
(defonce new-version (atom nil))
(defonce refresh-location-distance-filter (atom 500))
(defonce refresh-location-interval-duration (atom (Duration .seconds 30)))
(defonce refresh-location-accuracy (atom geo/LocationAccuracy.low))
(defonce force-debug-mode? (atom false))
(defonce app-info (atom nil))
```

**Dependencies:** `config.cljd` (for default values), `geolocator` package

### 2. Config Module (`lib/config.cljd`) - Refactored

**Purpose:** Store only immutable constants and static configuration data.

**Interface:**
```clojure
;; Constants
(defonce default-latest-release-api "...")
(defonce supported-locales ["en" "fr" ...])
(defonce default-locale "en")
(defonce max-pois-radius 10000)
(defonce min-pois-radius 500)
(defonce supported-poi-types [...])
(defonce default-poi-type "sandwich")

;; Map configuration
(defonce raster-tile-servers {...})
(defonce vector-tile-styles {...})
(defonce icicommencelaventure (ll/LatLng ...))
(defonce vertouplage (ll/LatLng ...))

;; POI data (moved from pois.cljd)
(defonce poi-types->osm-tags {...})

;; Icon mappings (moved from pois/ui.cljd)
(defonce osm-tags->icons {...})

;; Feature flags
(defonce feat-fall-detector? false)
(defonce feat-enhance-gpx? false)

;; Helper
(defn debug-mode? [] ...)
```

**Dependencies:** `latlong2`, `geolocator` packages

### 3. HTTP Module (`lib/http.cljd`)

**Purpose:** HTTP client creation and caching utilities.

**Interface:**
```clojure
(defn create-cache-store 
  "Creates a memory cache store for HTTP responses.
   Args:
     max-nb-of-entries - Maximum number of cached entries
     max-entry-size - Maximum size per entry in bytes"
  ^cache/MemCacheStore [max-nb-of-entries max-entry-size])

(defn create-dio-instance 
  "Creates a configured Dio HTTP client instance.
   Options:
     :base-url - Base URL for requests
     :query-timeout - Request timeout duration
     :cache-store - Optional cache store
     :with-log? - Enable request logging"
  ^dio/Dio [& {:keys [base-url query-timeout cache-store with-log?]}])
```

**Dependencies:** `dio`, `dio_cache_interceptor` packages, `lib/utils.cljd` (for uuid-v5)

### 4. I18n Module (`lib/i18n.cljd`)

**Purpose:** Internationalization utilities.

**Interface:**
```clojure
(defn l10n-str 
  "Returns localized string for given translation keys.
   Concatenates multiple keys if provided."
  [& args])
```

**Dependencies:** `easy_localization` package

### 5. Map State Module (`lib/map/state.cljd`)

**Purpose:** Map state management and stream handling logic.

**Interface:**
```clojure
(defn new-state 
  "Creates a new map state atom with default values."
  [])

(defprotocol disposable-streams
  (dispose! [this] "Cleanup all streams and subscriptions")
  (init! [this] "Initialize position and alignment streams")
  (location-marker-stream [this] "Returns the location marker stream")
  (align-position-stream [this] "Returns the alignment position stream")
  (align-on-current-pos-callback [this force-position-refresh?] "Returns callback for centering on current position")
  (new-center! [this [lat lon]] "Sets a new map center")
  (stop-alignment! [this] "Stops automatic position alignment"))

(defn ->state-streams 
  "Creates a disposable-streams implementation for the given map state."
  [map-state])
```

**Dependencies:** `lib/state.cljd`, `lib/position.cljd`, `lib/logging.cljd`, `lib/notifications.cljd`, `lib/i18n.cljd`

### 6. Map Widgets Module (`lib/map/widgets.cljd`)

**Purpose:** Reusable map UI widgets.

**Interface:**
```clojure
(defn msg 
  "Displays a message overlay on the map.
   Options:
     :alignment - Widget alignment (default: bottomCenter)
     :bottom-padding - Padding from bottom (default: 50)"
  [& {:keys [alignment bottom-padding]}])

(defn control-buttons 
  "Renders zoom and location control buttons.
   Options:
     :minZoom/:maxZoom - Zoom limits
     :mini - Use mini FAB style
     :alignment - Button alignment
     :onMyLocation - Callback for location button tap
     :onMyLocationSecondary - Callback for long press/double tap"
  [& {:keys [...]}])
```

**Dependencies:** `flutter/material.dart`, `flutter_map`, `cljd.flutter`

### 7. Utils Module (`lib/utils.cljd`) - Refactored

**Purpose:** Generic utility functions only.

**Interface:**
```clojure
;; UUID generation
(defonce uuidgen (atom (uuid/Uuid)))
(defn uuid-v5 [url])
(defn uuid-v4 [])

;; Type conversions
(defn str->int [s min max])
(defn str->location-accuracy [s])
(defn location-accuracy->str [a])
```

**Dependencies:** `uuid` package, `geolocator` package

### 8. Logging Module (`lib/logging.cljd`) - Updated

**Purpose:** Logging infrastructure with file output support.

**Interface:**
```clojure
(defonce logger (atom nil))

(defn log-file-dir 
  "Returns the application documents directory for log files."
  ^#/(Future Directory) [])

(defn latest-log-file 
  "Returns the latest.log file if it exists."
  ^#/(Future File) [])

(defn d 
  "Debug log message."
  [& args])

(defn init! 
  "Initialize the logging system.
   Options:
     :mock-mode? - Skip file logging for tests"
  [& {:keys [mock-mode?]}])

(defn dispose! 
  "Close the logger and release resources."
  [])
```

**Dependencies:** `lib/state.cljd` (for force-debug-mode?), `lib/config.cljd` (for debug-mode?)

### 9. POIs Module (`lib/pois.cljd`) - Refactored

**Purpose:** POI fetching logic only (data moved to config).

**Interface:**
```clojure
(defn poi-type->osm-tags 
  "Returns OSM tags for a given POI type."
  [type])

(defn overpass-item->poi 
  "Converts an Overpass API item to a POI map."
  [^Map item items selected-poi-type])

(defn fetch-pois-by-type 
  "Fetches POIs of a specific OSM type (node/way) for given tags.
   Returns a list of POI maps."
  [overpass-api osm-type lat lon tags radius])

(defn dynamic-map-pois 
  "Creates a reactive POI atom that updates based on map state changes."
  [map-state overpass-api])

(defn poi->LatLng [poi])
```

**Dependencies:** `lib/config.cljd` (for poi-types->osm-tags), `lib/logging.cljd`, `lib/overpassapi.cljd`

## Data Models

### Map State Atom Structure
```clojure
{:selected-poi-type "sandwich"      ; Current POI filter type
 :current-pos [lat lon]             ; User's current GPS position
 :current-center [lat lon]          ; Map center (may differ from current-pos)
 :current-pos-as-center? true       ; Whether to center on user position
 :transient-radius 1000             ; UI slider value
 :radius 1000                       ; Committed search radius
 :align-position-on-update :always  ; maploc/AlignOnUpdate value
 :message "..."                     ; Optional status message
 :streamz {:psc ... :ps ... :apsc ... :lms ... :pss ...}} ; Stream controllers
```

### POI Data Structure
```clojure
{"id" 12345
 "type" "node"                      ; or "way"
 "lat" 48.51479
 "lon" 2.65053
 "poi-type" "restaurant"            ; Injected by our code
 "tags" {"name" "Café Example"
         "amenity" "cafe"
         "phone" "+33..."}}
```

## Error Handling

### Stream Error Handling
- Position stream errors are handled via `addError` on the stream sink
- Error types: `PermissionDeniedException`, `ServiceDisabledException`, `IncorrectSetupException`
- Streams are closed gracefully on permission denial

### HTTP Error Handling
- Dio cache interceptor handles 401/403 errors by not caching
- Failed POI queries report status via `query-reporter` atom
- Logging captures all API interaction failures

## Testing Strategy

### Unit Testing Priorities
1. `lib/http.cljd` - Test cache store creation and dio configuration
2. `lib/utils.cljd` - Test type conversion functions
3. `lib/pois.cljd` - Test `fetch-pois-by-type` helper extraction
4. `lib/map/state.cljd` - Test state initialization and protocol methods

### Integration Testing
- Verify all imports resolve correctly after module splits
- Test that screens render without errors after refactoring
- Verify POI fetching still works with extracted helper

## Migration Steps

### Step 1: Create state.cljd
1. Create new file `lib/state.cljd`
2. Move all atom definitions from `config.cljd`
3. Update imports in: `app.cljd`, `map.cljd`, `position.cljd`, `logging.cljd`, `settings/ui.cljd`

### Step 2: Create http.cljd and i18n.cljd
1. Create `lib/http.cljd` with dio/cache functions
2. Create `lib/i18n.cljd` with l10n-str
3. Move `log-file-dir` to `logging.cljd`
4. Update imports in all consumers

### Step 3: Split map.cljd
1. Create `lib/map/state.cljd` with state logic
2. Create `lib/map/widgets.cljd` with UI components
3. Update imports in `screens/aroundme.cljd`
4. Delete original `lib/map.cljd`

### Step 4: Externalize POI data
1. Move `poi-types->osm-tags` to `config.cljd`
2. Move `osm-tags->icons` to `config.cljd`
3. Extract `fetch-pois-by-type` helper in `pois.cljd`
4. Update imports

### Step 5: Code hygiene
1. Replace `swap! (constantly ...)` with `reset!` for constant value assignments
2. Use `swap!` for atomic updates based on previous state (e.g., `(swap! pois into items)` instead of `(reset! pois (into @pois items))` to prevent race conditions)
3. Remove commented code blocks
4. Add docstrings to new modules
5. Verify lifecycle naming consistency

## Important Notes

### Atom Update Patterns
- Use `reset!` when setting a value that doesn't depend on previous state
- Use `swap!` when the new value depends on the previous state (prevents race conditions)
- Example: In `pois.cljd`, use `(swap! pois into items)` for accumulating fetched POIs during async operations
