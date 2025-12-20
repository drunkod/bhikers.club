# Location Service Disabled Popup Implementation - Current Architecture

> 📅 **Created:** 19 декабря 2025 г. в 17:17

## Overview

Maps the existing location service detection, dialog display patterns, and permission handling systems in the bhikers.club app. Key entry points: location stream initialization **[1b]**, service status checking **[1c]**, dialog display patterns [2b, 2c], and settings navigation **[3d]**.

## Table of Contents

1. [Location service status detection and error propagation](#1-location-service-status-detection-and-error-propag)
2. [Dialog display patterns in the app](#2-dialog-display-patterns-in-the-app)
3. [Permission handling and device settings navigation](#3-permission-handling-and-device-settings-navigation)
4. [Localization system for user-facing messages](#4-localization-system-for-user-facing-messages)

---

## 1. Location service status detection and error propagation

> Core location system: traces how location services are checked and errors propagate when disabled.

<details>
<summary>📖 <strong>Guide</strong> (click to expand)</summary>

#### Motivation

The bhikers.club app needs to track the user's GPS position to show nearby points of interest (POIs) like shelters, restaurants, and campsites. However, **location services can be disabled at the device level**, independent of app permissions. When this happens, the app must detect it and inform the user—but currently, **there's no UI handler for this error condition** **[1e]**.

The problem: The app checks if location services are enabled **[1c]** and throws a `ServiceDisabledException` into the position stream **[1e]**, but this error is never caught or displayed to the user. Users see no feedback explaining why their location isn't updating.


#### Details

**Stream initialization flow**: When the AroundMe screen loads, it initializes a managed position stream **[1a]** that subscribes to device location updates **[1b]**. This creates a `StreamController` that manages the entire location data pipeline.

**Service status checking**: The position stream controller has an `onListen` callback that first checks permissions, then critically calls `isLocationServiceEnabled` **[1c]** to verify the device's location services are turned on. It also subscribes to a service status stream **[1d]** that monitors for changes while the app runs.

**Error propagation**: When location services are detected as disabled, the code adds a `ServiceDisabledException` to the stream's error sink **[1e]**. This error flows through the stream but **is never caught by UI code**—it simply gets logged or ignored.

**The gap**: The position stream subscription **[1b]** in `map/state.cljd` handles position updates but has no error handler for service-disabled scenarios. To fix this, you need to:

1. Catch `ServiceDisabledException` errors from the position stream
2. Show a dialog with "Please enable location services on device"
3. Provide a button to open device settings (similar to how permission denials use `openAppSettings`)

</details>


### Location Service Status Detection Flow

  - AroundMe Screen Initialization

    #### [1a] Stream initialization in aroundme screen
    📄 `aroundme.cljd:26`

    ```clojure
    :managed [dms (-> map-state map-state/->state-streams map-state/init!) :dispose map-state/dispose!]
    ```

      - map-state/init! called
        - new-position-stream-controller
          - onListen callback setup
            - checkPermission()
            - setup() function called

              #### [1c] Location service status check
              📄 `position.cljd:65`

              ```clojure
              service-enabled? (await (.isLocationServiceEnabled geo/Geolocator))
              ```


              #### [1d] Service status stream listener
              📄 `position.cljd:69`

              ```clojure
              (.getServiceStatusStream geo/Geolocator)
              ```

                - listen callback
                  - if disabled: addError

                  #### [1e] Service disabled error injection
                  📄 `position.cljd:74`

                  ```clojure
                  (-> stream-controller .-sink (.addError maploc/ServiceDisabledException))
                  ```

          - getPositionStream subscription

            #### [1b] Position stream subscription
            📄 `state.cljd:87`

            ```clojure
            pss (subscribe-position-stream
            ```

              - position updates flow to UI
    - [No UI handler for ServiceDisabledException]

---

## 2. Dialog display patterns in the app

> UI system: demonstrates how the app currently shows modal dialogs and bottom sheets to users.

<details>
<summary>📖 <strong>Guide</strong> (click to expand)</summary>

### Motivation

The bhikers.club app needs to show **modal dialogs and bottom sheets** to display information to users (like POI details, notifications, and alerts). In Flutter/ClojureDart, showing any dialog requires a **BuildContext** object, which represents the widget's position in the widget tree and provides access to theme data and navigation.

The challenge: dialogs must be shown in response to user actions (button taps, errors) but need the proper context to render correctly within the app's UI hierarchy.


### Details


#### Getting BuildContext

ClojureDart's `f/widget` macro provides the **`:context ctx` directive** **[2a]** to capture the BuildContext. This makes `ctx` available as a variable within the widget's scope. Alternatively, widgets can use **`:get`** to retrieve inherited dependencies from ancestor widgets.


#### Showing Modal Bottom Sheets

The app uses Flutter's `m/showModalBottomSheet` function to display sliding panels from the bottom of the screen. Two main patterns exist:

**POI information display** **[2b]**: When a user taps a map marker, `show-poi-info` receives the context and POI data, then calls `showModalBottomSheet` with `.context ctx`, `.isScrollControlled true` for flexible height, and a `.builder` parameter **[2d]** that uses `f/build` to construct the content widget tree.

**Notifications panel** **[2c]**: The notifications button in the app bar uses a similar pattern, capturing context via `:context ctx` in its `f/widget` definition, then showing a bottom sheet with a fixed 300px height container and ListView.


#### Builder Pattern

Both examples use the **`.builder` parameter** with `f/build` macro to lazily construct the dialog content. This ensures the dialog's widgets are built with the correct context and only when needed, not when the parent widget initializes.

</details>


### Dialog Display System in bhikers.club

  - Widget with BuildContext
    - f/widget macro

      #### [2a] Context acquisition in widget
      📄 `layers.cljd:47`

      ```clojure
      :context ctx :get [:map-state :overpass-api]
      ```

        - captures BuildContext for dialogs
    - :get directive
      - retrieves inherited dependencies
  - Show POI Info Flow
    - show-poi-info function
      - receives ctx parameter

      #### [2b] Bottom sheet dialog invocation
      📄 `ui.cljd:58`

      ```clojure
      (m/showModalBottomSheet
      ```

        - .context ctx
        - .isScrollControlled true

        #### [2d] Dialog content builder
        📄 `ui.cljd:62`

        ```clojure
        .builder (f/build
        ```

          - (f/build ...) macro
            - constructs widget tree
  - Show Notifications Flow
    - notifications-button function
      - :context ctx in f/widget

      #### [2c] Another dialog pattern
      📄 `appbar.cljd:46`

      ```clojure
      (m/showModalBottomSheet
      ```

        - .context ctx
        - .builder (f/build ...)
          - Container with ListView

---

## 3. Permission handling and device settings navigation

> Permission system: shows how the app checks permissions and opens device settings when needed.

<details>
<summary>📖 <strong>Guide</strong> (click to expand)</summary>

#### Motivation

The bhikers.club app needs location access to show nearby points of interest (POIs) like shelters, restaurants, and campsites. However, users can **permanently deny** location permissions in their device settings, preventing the app from functioning. When this happens, the app must guide users to their device settings to re-enable permissions, since Android/iOS don't allow apps to request permanently denied permissions again through normal permission dialogs.


#### Details


##### Permission Status Flow

The permission system uses the `permission_handler` package to check location permission status **[3b]**. There are three possible states:

- **granted**: Permission is active, callback executes immediately **[3a]**
- **denied**: First-time denial, triggers a permission request dialog
- **permanentlyDenied**: User denied multiple times or disabled in settings **[3d]**


##### Handling Permanent Denial

When permissions are permanently denied, the app takes two actions:

1. **Shows a notification** to inform the user **[3c]**, using the localized message from `common.permission-denied`
2. **Opens device settings** via `perms/openAppSettings` **[3d]**, which launches the system settings app where users can manually enable location permissions

This pattern is implemented in `check-permission()` **[3b]** and used specifically for location via `check-location-permission()` **[3a]**, which handles platform differences between Android (uses `locationWhenInUse`) and iOS/Web (uses generic `location`).


##### Integration Point

The same `openAppSettings` mechanism should be used for the location **services** disabled popup, since both scenarios require users to change device-level settings that the app cannot modify programmatically.

</details>


### Permission & Settings Navigation System


  #### [3a] Location permission check function
  📄 `permissions.cljd:48`

  ```clojure
  (defn check-location-permission
  ```

    - check-permission() helper

      #### [3b] Permission status query
      📄 `permissions.cljd:32`

      ```clojure
      status (await (-> permission perms/PermissionActions (.-status)))]
      ```

        - perms/PermissionActions.status
      - Handle permission state
        - granted → execute callback
        - denied → request permission
        - permanentlyDenied

          #### [3c] Permission denied notification
          📄 `permissions.cljd:44`

          ```clojure
          (new-notif (str (l10n/tr "common.permission-denied") permission))
          ```

            - new-notif() with i18n

          #### [3d] Open device settings
          📄 `permissions.cljd:45`

          ```clojure
          (perms/openAppSettings))
          ```

            - perms/openAppSettings

---

## 4. Localization system for user-facing messages

> i18n system: demonstrates how to add and retrieve localized strings for the popup message.

<details>
<summary>📖 <strong>Guide</strong> (click to expand)</summary>

#### Motivation

The bhikers.club app needs to support **multiple languages** to serve hikers worldwide. User-facing messages like "Please grant Location permission" **[4a]** must be displayed in the user's preferred language (English, French, German, Italian, Spanish, or Russian). Rather than hardcoding English strings throughout the codebase, the app uses a **centralized translation system** that separates text content from code logic.


#### Details

**Translation files** store all user-facing strings in YAML format, organized by feature area. Each supported language has its own file (e.g., `en.yaml`, `fr.yaml`) **[4a]**. Keys use dot notation like `around_me.no_permission` to namespace messages by screen or feature.

**The `l10n-str` helper function** **[4b]** retrieves translated strings at runtime. It takes translation keys as arguments, looks them up via `l10n/tr`, and returns the localized text for the user's current language setting. The function can concatenate multiple translation keys if needed.

**In UI widgets**, developers call `l10n-str` with the appropriate key to display translated text **[4c]**. For example: `(m/Text (l10n-str "notifications.title"))`. The translation system automatically selects the correct language based on user preferences or device settings, configured during app initialization in `main.cljd`.

To add a new message like "Please enable location services on device", you would:

1. Add the key-value pair to all language YAML files
2. Use `l10n-str` with that key wherever the message needs to appear in the UI

</details>


### Localization System for User Messages

  - Translation Files (YAML)
    - en.yaml (around_me section)

      #### [4a] Existing location permission message
      📄 `en.yaml:44`

      ```yaml
      no_permission: Please grant Location permission
      ```

  - Translation Retrieval Layer
    - i18n.cljd
      - l10n-str function

        #### [4b] Translation key lookup
        📄 `i18n.cljd:9`

        ```clojure
        (apply str (map l10n/tr args))
        ```

  - UI Widget Integration
    - appbar.cljd (example usage)

      #### [4c] Using localized strings in UI
      📄 `appbar.cljd:22`

      ```clojure
      .title (m/Text (l10n-str "notifications.title"))
      ```


---

---

## Referenced Files

```xml
<files>
<file path="appbar.cljd">
(ns club.bhikers.screens.common.appbar
  (:require ["package:flutter/material.dart" :as m]
            [club.bhikers.lib.i18n :refer [l10n-str]]
            [club.bhikers.lib.notifications
             :refer [dismiss-notif dismiss-all-notifs notifications]]
            [club.bhikers.screens.debuglog :refer [debuglog-screen]]
            [cljd.flutter :as f]))

;; =============================================================================
;; Notifications Widgets
;; =============================================================================

(defn notifications-list-widget []
  (f/widget
   :get [:notifications]
   :watch [*notifs notifications]
   (m/ListView
    .padding (m/EdgeInsets.all 2.0)
    .children
    (into [(m/ListTile
            .leading (m/Icon m/Icons.notification_important)
<!-- [4c] Using localized strings in UI (line 22) -->
            .title (m/Text (l10n-str "notifications.title"))
            .trailing (m/IconButton
                       .icon (m/Icon m/Icons.delete_sweep)
                       .tooltip (l10n-str "notifications.dismiss_all")
                       .onPressed #(dismiss-all-notifs)))]
          (map
           (fn [[id txt]] (m/Dismissible
                           .key (m/ValueKey id)
                           .onDismissed (fn [_] (dismiss-notif id))
                           .child (m/ListTile .title (m/Text txt))))
           *notifs)))))

(defn notifications-button []
  (f/widget
   :context ctx
   :get [:notifications]
   :watch [*notifs notifications]
   (m/Stack .children
            (let [nb-notifs (count *notifs)]
              (if (> 1 nb-notifs)
                []
                [(m/IconButton .icon (m/Icon m/Icons.notification_important)
                               .tooltip "important"
                               .onPressed (fn []
<!-- [2c] Another dialog pattern (line 46) -->
                                            (m/showModalBottomSheet
                                             .context ctx
                                             .builder (f/build
                                                       (f/widget
                                                        (m/Container .height 300)
                                                        (notifications-list-widget))))
                                            nil))
                 (f/widget
                  (m/Positioned .right 12 .top 12)
                  (m/Container  .padding (m/EdgeInsets.all 5)
                                .decoration (m/BoxDecoration
                                             .shape m/BoxShape.circle
                                             .color m/Colors.red)
                                .constraints (m/BoxConstraints
                                              .minWidth 5
                                              .minHeight 5)))])))))

;; =============================================================================
;; Debug Log Button
;; =============================================================================

(defn debuglog-screen-button []
  (f/widget :get [m/Navigator]
            (m/IconButton .icon (m/Icon m/Icons.article)
                          .tooltip "logs"
                          .onPressed (fn []
                                       (.push navigator
                                              (m/MaterialPageRoute
                                               .builder (f/build [] (debuglog-screen))))
                                       nil))))

;; =============================================================================
;; Shared App Bar
;; =============================================================================

(defn app-bar [& {:keys [title
                         additional-actions]
                  :or {title "app.title"
                       additional-actions []}}]
  (m/AppBar .title (m/Text (l10n-str title))
            .actions (concat
                      [(debuglog-screen-button)
                       (notifications-button)]
                      additional-actions)))

</file>
<file path="aroundme.cljd">
(ns club.bhikers.screens.aroundme
(:require ["package:flutter/material.dart" :as m]
["package:flutter_map/flutter_map.dart" :as fmap]
["package:latlong2/latlong.dart" :refer [LatLng]]
["package:flutter_map_location_marker/flutter_map_location_marker.dart" :as maploc]
["package:flutter_map_compass/flutter_map_compass.dart" :refer [MapCompass]]
[club.bhikers.lib.config :refer [icicommencelaventure
vertouplage]]
[club.bhikers.lib.state :refer [debug-mode?]]
[club.bhikers.lib.map.state :as map-state]
[club.bhikers.lib.map.widgets :as map-widgets]
[club.bhikers.screens.common.appbar :refer [app-bar]]
[club.bhikers.screens.common.drawer :refer [drawer]]
;; Imported Modules
[club.bhikers.screens.aroundme.ui :as ui]
[club.bhikers.screens.aroundme.layers :as layers]
[cljd.flutter :as f]))

;; Around me ( +/- 10/20km): POIs*

(defn around-me-screen []
(f/widget
:let [scaffold-key (#/(m/GlobalKey m/ScaffoldState))]
:bind {:map-state (map-state/new-state)}
:get [:map-state m/Theme]
<!-- [1a] Stream initialization in aroundme screen (line 26) -->
:managed [dms (-> map-state map-state/->state-streams map-state/init!) :dispose map-state/dispose!]
:watch [{:keys [align-position-on-update current-pos-as-center? current-center]} map-state]
(m/Scaffold
.key scaffold-key
.appBar (app-bar :additional-actions
[(m/IconButton .icon (m/Icon m/Icons.layers)
.tooltip "layers"
.onPressed #(-> scaffold-key
.-currentState
.openEndDrawer))])
.drawer (drawer)
.endDrawer (ui/end-drawer)
.body
(fmap/FlutterMap
.options (fmap/MapOptions
.initialZoom 14
.initialCenter (if (debug-mode?) vertouplage icicommencelaventure)
.minZoom 0
.maxZoom 18
.onLongPress (fn [_ ^LatLng point]
(map-state/new-center! dms [(.-latitude point) (.-longitude point)]))

;; Stop aligning the location marker to the center of the map widget
           ;; if user interacted with the map
           .onPositionChanged (fn [_ hasGesture] (when hasGesture (map-state/stop-alignment! dms))))
 .children
 [(layers/base-map-layer)
  (layers/pois-markers-widget)
  (maploc/CurrentLocationLayer
   .style (layers/current-location-marker-style current-pos-as-center? theme)
   .positionStream (map-state/location-marker-stream dms)
   .alignPositionStream (map-state/align-position-stream dms)
   .alignPositionOnUpdate align-position-on-update
   .alignDirectionOnUpdate maploc/AlignOnUpdate.never)
  (map-widgets/control-buttons :alignment m/Alignment.bottomRight
                               :onMyLocation (map-state/align-on-current-pos-callback dms false)
                               :onMyLocationSecondary (map-state/align-on-current-pos-callback dms true))
  (fmap/Scalebar
   .textStyle (m/TextStyle .color m/Colors.black .fontSize 14)
   .alignment m/Alignment.bottomLeft
   .length fmap/ScalebarLength.m)
  (MapCompass.cupertino .alignment m/Alignment.topLeft)
  (layers/current-center-marker current-pos-as-center? current-center)
  (map-widgets/msg)]))))

</file>
<file path="en.yaml">
app:
  title: Bhikers Club
settings:
  emergency_contact_phone_number: Emerengcy Contact Phone Number
  alert_mode: Alert mode
  fall_detector_group_title: Fall detector
  language: Language
  default_poi_type: Default POI Type
  general_group_title: General
  screen_title: Settings
  map_group_title: Map
  tile_server: Tile Server
  tile_layer_type: Tile Layer Type
  tile_layer_raster: Raster
  tile_layer_vector: Vector
  advanced_group_title: Advanced
  api_query_timeout: API query timeout (in seconds)
  timeout_input_validation_error: Timeout must be a valid integer 2 < timeout < 10
  debug_mode: Enable debug mode
  advanced_location_title: Advanced refresh location settings
  location_distance_filter: min. distance
  distance_filter_input_validation_error: Distance must be a valid integer 0 < d < 10000
  refresh_location_accuracy: Accuracy
  location_accuracy_low: Low
  location_accuracy_medium: Medium
  location_accuracy_high: High
  refresh_location_interval_duration: Interval (android)
  langs:
    en: English
    fr: French
    de: German
    it: Italian
    es: Espagnol
    ru: Russian
fall_detector:
  screen_title: Fall Detector
  description: Send alert to contacts if fall detected using accelerometer!
enhance_gpx:
  screen_title: Enhance Gpx
  description: Enhance GPX trace with the POIs all along!
around_me:
  screen_title: Around me
  description: POIs around my current GPS position
<!-- [4a] Existing location permission message (line 44) -->
  no_permission: Please grant Location permission
  unknown_location: Current location unknown...
  poi_types:
    shelter: Shelters
    hotel: Hotels
    campsite: Camp sites
    restaurant: Restaurants
    bottlerefill: Bottle refills
    sandwich: Sandwichs
    bikeshop: Bike shops
    toilet: Toilets
  pois:
    shelter: "@:common.shelter_emoji @:around_me.poi_types.shelter"
    hotel: "@:common.hotel_emoji @:around_me.poi_types.hotel"
    campsite: "@:common.campsite_emoji @:around_me.poi_types.campsite"
    restaurant: "@:common.restaurant_emoji @:around_me.poi_types.restaurant"
    bottlerefill: "@:common.bottlerefill_emoji @:around_me.poi_types.bottlerefill"
    sandwich: "@:common.sandwich_emoji @:around_me.poi_types.sandwich"
    bikeshop: "@:common.bikeshop_emoji @:around_me.poi_types.bikeshop"
    toilet: "@:common.toilet_emoji @:around_me.poi_types.toilet"
about:
  screen_title: About
  description: Bhikers Club by ParaSitid
  legalese: 🪲 ParaSitid
  new_version: New version
common:
  close: Close
  permission-denied: permission permanently denied for
  shelter_emoji: ☔
  hotel_emoji: 🛏️
  campsite_emoji: ⛺
  restaurant_emoji: 🍽️ ☕
  bottlerefill_emoji: 🚰
  sandwich_emoji: 🥪🥐🥖
  bikeshop_emoji: 🚴🔧
  toilet_emoji: 🚽
  radius: Search radius
  no_name: No name
notifications:
  title: Notifications
debuglog:
  title: Debug Log File
  description: Debug Log File
  no_log_file: Log file does not exist

</file>
<file path="i18n.cljd">
(ns club.bhikers.lib.i18n
"Internationalization utilities."
(:require ["package:easy_localization/easy_localization.dart" :as l10n]))


(defn l10n-str
"Returns a localized string for the given translation keys.
If multiple keys are provided, their values are concatenated."
<!-- [4b] Translation key lookup (line 9) -->
[& args]
(apply str (map l10n/tr args)))

</file>
<file path="layers.cljd">
(ns club.bhikers.screens.aroundme.layers
(:require ["package:flutter/material.dart" :as m]
["package:flutter_map/flutter_map.dart" :as fmap]
["package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart"
:refer [CancellableNetworkTileProvider]]
["package:flutter_map_maplibre/flutter_map_maplibre.dart" :refer [MapLibreLayer]]
["package:flutter_map_location_marker/flutter_map_location_marker.dart" :as maploc]
["package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart"
:refer [MarkerClusterLayerWidget MarkerClusterLayerOptions]]
[club.bhikers.lib.config :refer [raster-tile-servers
vector-tile-styles]]
[club.bhikers.lib.state :refer [selected-tile-server
tile-layer-type]]
[club.bhikers.lib.pois :refer [dynamic-map-pois
poi->LatLng]]
[club.bhikers.lib.pois.ui :refer [poi->map-location-marker]]
[club.bhikers.lib.logging :as logging]
[club.bhikers.screens.aroundme.ui :as ui]
[cljd.flutter :as f]))


;; =============================================================================
;; Base Map Layer (Raster / Vector)
;; =============================================================================

(defn base-map-layer []
(f/widget
:watch [layer-type tile-layer-type
selected-server selected-tile-server]
(if (= layer-type :raster)
(fmap/TileLayer
.urlTemplate (:url (get raster-tile-servers selected-server (get raster-tile-servers "osm")))
.userAgentPackageName "club.bhikers"
.tileProvider (CancellableNetworkTileProvider)
.maxZoom 18)
(let [style-url (:url (get vector-tile-styles selected-server (get vector-tile-styles "protomaps")))]
(MapLibreLayer.
.key (m/ValueKey style-url)
.initStyle style-url)))))

;; =============================================================================
;; POI Markers Layer
;; =============================================================================

(defn pois-markers-widget []
(f/widget
<!-- [2a] Context acquisition in widget (line 47) -->
:context ctx :get [:map-state :overpass-api]
:watch [pois (dynamic-map-pois map-state overpass-api)]
(MarkerClusterLayerWidget
.options
(MarkerClusterLayerOptions
.maxClusterRadius 100
.size (m/Size 40 40)
.alignment m/Alignment.center
.padding (m/EdgeInsets.all 50)
.centerMarkerOnClick false
.maxZoom 15
.builder (fn [_ markers]
(f/widget
(m/Container
.decoration (m/BoxDecoration .borderRadius (m/BorderRadius.circular 20)
.color m/Colors.blue))
(m/Center .child
(m/Text (str (count markers))
.style (m/TextStyle .color m/Colors.white)))))
.markers (map #(fmap/Marker .point (poi->LatLng %)
.height 40
.width 40
.child (m/GestureDetector
.onTap (fn [] (ui/show-poi-info ctx %))
.child (poi->map-location-marker %)))
pois)))))

;; =============================================================================
;; Current Center Marker
;; =============================================================================

(defn current-center-marker [current-pos-as-center? current-center]
(if (and current-center (not current-pos-as-center?))
(let [[lat lon] current-center]
(maploc/AnimatedLocationMarkerLayer
.position (maploc/LocationMarkerPosition .latitude lat .longitude lon .accuracy 0)))
(m/Container)))

;; =============================================================================
;; Location Marker Style
;; =============================================================================

(defn current-location-marker-style [current-pos-as-center? theme]
(maploc/LocationMarkerStyle
.showAccuracyCircle false
.showHeadingSector false
.marker (maploc/DefaultLocationMarker
.color (if current-pos-as-center?
(-> ^m/ThemeData theme .-colorScheme .-primary)
(-> ^m/ThemeData theme .-colorScheme .-secondary)))))

</file>
<file path="permissions.cljd">
(ns club.bhikers.lib.permissions
(:require
["package:permission_handler/permission_handler.dart" :as perms]
["package:easy_localization/easy_localization.dart" :as l10n]
["package:flutter/foundation.dart" :as foundation]
["dart:io" :as io]
[club.bhikers.lib.notifications :refer [new-notif]]
[club.bhikers.lib.logging :as logging]))


;; permissions helpers
;;
(defn permission-request
"Requests a specific permission.
If granted, executes the granted-fn callback."
[permission granted-fn]
(logging/d "requesting permission " permission)
(let [status (await (-> permission perms/PermissionActions (.request)))]
(cond
(== perms/PermissionStatus.granted status) (granted-fn)
(== perms/PermissionStatus.denied status) (permission-request permission granted-fn)
(== perms/PermissionStatus.permanentlyDenied status) (perms/openAppSettings)
:else (logging/d "permission status " status " unsupported. ignoring."))))

(defn check-permission
"Checks if a permission is granted.
If granted, executes granted-fn.
If denied, requests permission.
If permanently denied, shows notification and opens app settings."
[permission granted-fn]
(logging/d "checking permission " permission)
<!-- [3b] Permission status query (line 32) -->
(let [status (await (-> permission perms/PermissionActions (.-status)))]
(cond
(== perms/PermissionStatus.granted status)
(do
(logging/d "check granted for " permission)
(granted-fn))
(== perms/PermissionStatus.denied status)
(do
(logging/d "check denied for " permission)
(await (permission-request permission granted-fn)))
(== perms/PermissionStatus.permanentlyDenied status)
(do
<!-- [3c] Permission denied notification (line 44) -->
(new-notif (str (l10n/tr "common.permission-denied") permission))
<!-- [3d] Open device settings (line 45) -->
(perms/openAppSettings))
:else (logging/d "permission status " status " unsupported. ignoring?"))))

<!-- [3a] Location permission check function (line 48) -->
(defn check-location-permission
"Checks/Requests location permission depending on the platform (Android/Web/iOS)."
[]
(check-permission (if (and (not foundation/kIsWeb) io/Platform.isAndroid)
perms/Permission.locationWhenInUse
perms/Permission.location)
#(logging/d "location perm granted!")))

</file>
<file path="position.cljd">
(ns club.bhikers.lib.position
  (:require
   ["package:flutter/foundation.dart" :as foundation]
   ["dart:async" :as async]
   ["dart:io" :as io]
   ["package:geolocator/geolocator.dart" :as geo]
   ["package:flutter_map_location_marker/flutter_map_location_marker.dart" :as maploc]
   [club.bhikers.lib.state :refer [refresh-location-distance-filter
                                   refresh-location-interval-duration
                                   refresh-location-accuracy]]
   [club.bhikers.lib.logging :as logging]))

;; per device type location settings
(defn streams-location-settings []
  (let [distance-filter @refresh-location-distance-filter
        interval-duration @refresh-location-interval-duration
        accuracy @refresh-location-accuracy]
    (cond
      ;; kIsWeb must be checked first because platform on web is throwing errors
      foundation/kIsWeb (geo/LocationSettings .accuracy accuracy
                                              .distanceFilter distance-filter)
      (io/Platform.isAndroid) (geo/AndroidSettings .accuracy accuracy
                                                   .intervalDuration interval-duration
                                                   .distanceFilter distance-filter
                                                   .forceLocationManager true) ; use legacy location manager to avoid google play services requirement
      (io/Platform.isIOS) (geo/AppleSettings .accuracy accuracy
                                             .pauseLocationUpdatesAutomatically true
                                             .distanceFilter distance-filter)
      :else (geo/LocationSettings .accuracy accuracy
                                  .distanceFilter distance-filter))))

(defn force-refresh-location-settings []
  (let [accuracy geo/LocationAccuracy.high]
    (cond
      ;; kIsWeb must be checked first because platform on web is throwing errors
      foundation/kIsWeb (geo/LocationSettings .accuracy accuracy)
      (io/Platform.isAndroid) (geo/AndroidSettings .accuracy accuracy
                                                   .forceLocationManager true) ; use legacy location manager to avoid google play services requirement
      (io/Platform.isIOS) (geo/AppleSettings .accuracy accuracy
                                             .pauseLocationUpdatesAutomatically true)
      :else (geo/LocationSettings .accuracy accuracy))))

(defn force-current-position []
  (await (-> geo/Geolocator (.getCurrentPosition
                             .locationSettings (force-refresh-location-settings)))))

(defn new-position-stream-controller ^#/(async/StreamController geo/Position?) []
  (let [cancel-functions (atom [])
        stream-controller (#/(async/StreamController.broadcast geo/Position?))
        location-settings* (streams-location-settings)
        setup (fn [permission]
                (cond
                  ;; forbidden close: perm ko, add error & close stream controller
                  (or (== permission geo/LocationPermission.denied)
                      (== permission geo/LocationPermission.deniedForever))
                  (when (not (.-isClosed stream-controller))
                    (logging/d "permission denied, closing stream controller")
                    (-> stream-controller .-sink (.addError maploc/PermissionDeniedException))
                    (await (.close stream-controller)))
                  ;; main clause: perm ok: check services and subscribe
                  (or (== permission geo/LocationPermission.whileInUse)
                      (== permission geo/LocationPermission.always))
                  (when (not (.-isClosed stream-controller))
                    (logging/d "permission granted, setup stream controller")
<!-- [1c] Location service status check (line 65) -->
                    (let [service-enabled? (await (.isLocationServiceEnabled geo/Geolocator))
                          status-stream-subscription (when (not foundation/kIsWeb)
                                                       (logging/d "listen to service status strean")
                                                       (.listen
<!-- [1d] Service status stream listener (line 69) -->
                                                        (.getServiceStatusStream geo/Geolocator)
                                                        (fn [status]
                                                          (if (not= status geo/ServiceStatus.enabled)
                                                            (do
                                                              (logging/d "service status is disabled. error.")
<!-- [1e] Service disabled error injection (line 74) -->
                                                              (-> stream-controller .-sink (.addError maploc/ServiceDisabledException)))
                                                            (-> stream-controller .-sink (.add nil))))))
                          last-known-position (when (and service-enabled? (not foundation/kIsWeb))
                                                (logging/d "await for last known position")
                                                (await (-> geo/Geolocator .getLastKnownPosition)))
                          position-subscription (do
                                                  (logging/d "listening on position stream source")
                                                  (->
                                                   geo/Geolocator
                                                   (.getPositionStream .locationSettings location-settings*)
                                                   (.listen
                                                    (fn [position]
                                                      (when (not (.-isClosed stream-controller))
                                                        (logging/d "new position, add to stream controller sink: " position)
                                                        (-> stream-controller .-sink (.add position)))))))]
                      (when (and last-known-position (not (.-isClosed stream-controller)))
                        (logging/d "add last-known-position to stream controller sink: " last-known-position)
                        (-> stream-controller .-sink (.add last-known-position)))
                      (when status-stream-subscription (swap! cancel-functions conj #(.cancel status-stream-subscription)))
                      (when position-subscription (swap! cancel-functions conj #(.cancel position-subscription)))))

                  :else (-> stream-controller .-sink (.addError maploc/IncorrectSetupException))))]

    (doto stream-controller
      (.-onCancel!
       (fn []
         (logging/d "cancelling stream controller listeners and closing!")
         (await (.wait Future (map #(%) @cancel-functions)))
         (.close stream-controller)))
      (.-onListen!
       (fn []
         (logging/d "listening on position stream controller!")
         (try
           (let [permission (await (.checkPermission geo/Geolocator))]
             (logging/d (str "location permission is " permission))
             (if (== permission geo/LocationPermission.denied)
               (do
                 (-> stream-controller .-sink (.addError maploc/PermissionDeniedException))
                 (setup (await (->  geo/Geolocator .requestPermission))))
               (setup permission)))

           (catch geo/PermissionDefinitionsNotFoundException _
             (-> stream-controller .-sink (.addError maploc/IncorrectSetupException)))))))
    stream-controller))

(defn new-position-bstream ^#/(async/Stream geo/Position?)
  [^#/(async/StreamController geo/Position?) controller]
  (logging/d "starting position broadcast stream...")
  ;(.asBroadcastStream (.defaultPositionStreamSource (maploc/LocationMarkerDataStreamFactory)))
  (.asBroadcastStream (.-stream controller)
                      .onListen (fn [^#/(async/StreamSubscription geo/Position?) controller]
                                  (logging/d "listening on position b-stream")
                                  (when (.-isPaused controller)
                                    (logging/d "resumimg position b-stream controller")
                                    (.resume controller)
                                  ;; returning nil is important as callback must be void func
                                    nil))
                      .onCancel (fn  [^#/(async/StreamSubscription geo/Position?) controller]
                                  (logging/d "pausing position b-stream controller")
                                  (.cancel controller)
                                  ;; returning nil is important as callback must be void func
                                  nil)))

;; location marker stream stream helpers / not used
;; from maploc, returns a stream of markers from a stream of locations
(defn ->location-marker-stream
  [^#/(async/Stream geo/Position?) stream]
  (logging/d "convert position stream to location marker stream")
  (-> stream (.map (fn [^geo/Position? position]
                     (maploc/LocationMarkerPosition
                      .latitude (.-latitude position)
                      .longitude (.-longitude position)
                      .accuracy (.-accuracy position))))))

(defn subscribe-position-stream ^#/(async/StreamSubscription geo/Position?)
  [^#/(async/Stream geo/Position?) stream listener]
  (logging/d "subscribe to position stream")
  (.listen stream (fn [^geo/Position? position]
                    (listener (.-latitude position)
                              (.-longitude position)))))

</file>
<file path="state.cljd">
(ns club.bhikers.lib.state
"Runtime state atoms for the application."
(:require
["package:flutter/foundation.dart" :refer [kDebugMode]]
["package:geolocator/geolocator.dart" :as geo]
[club.bhikers.lib.config :as config]))


;; =============================================================================
;; APP STATE ATOMS
;; =============================================================================

(defonce selected-poi-type (atom config/default-poi-type))
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

;; =============================================================================
;; LOGIC HELPERS
;; =============================================================================

(defn debug-mode?
"Returns true if the application is running in debug mode.
Checks both the Flutter kDebugMode constant and the internal force-debug-mode? atom."
[]
(or @force-debug-mode? kDebugMode))

</file>
<file path="ui.cljd">
(ns club.bhikers.screens.settings.ui
  (:require ["package:flutter/material.dart" :as m]
            ["package:flutter_settings_screens/flutter_settings_screens.dart" :as settings]
            ["package:easy_localization/easy_localization.dart" :as l10n]
            [club.bhikers.lib.i18n :refer [l10n-str]]
            [club.bhikers.lib.utils :refer [str->int
                                            str->location-accuracy
                                            location-accuracy->str]]
            [club.bhikers.lib.logging :as logging]
            [club.bhikers.lib.state :refer [selected-poi-type
                                            force-debug-mode?
                                            pois-radius
                                            api-query-timeout
                                            refresh-location-distance-filter
                                            refresh-location-interval-duration
                                            refresh-location-accuracy
                                            selected-tile-server
                                            tile-layer-type]]
            [club.bhikers.lib.config :refer [supported-poi-types
                                          supported-locales default-locale
                                          max-pois-radius
                                          min-pois-radius
                                          raster-tile-servers
                                          vector-tile-styles]]
            [cljd.flutter :as f]))

;; =============================================================================
;; General Settings
;; =============================================================================

(defn general-group [ctx]
  (settings/SettingsGroup
   .title  (l10n-str "settings.general_group_title")
   .children
   [(settings/SliderSettingsTile
     .leading (m/Icon m/Icons.adjust)
     .settingKey "/general/pois-radius"
     .title (l10n-str "common.radius")
     .defaultValue 1000
     .min min-pois-radius
     .max max-pois-radius
     .onChange #(reset! pois-radius %)
     .step 500)
    (#/(settings/DropDownSettingsTile String)
     .leading (m/Icon m/Icons.location_searching)
     .settingKey "/general/default-poi-type"
     .title  (l10n-str "settings.default_poi_type")
     .values (into {} (map (fn [poi] [poi (l10n-str (str "around_me.pois." poi))])
                           supported-poi-types))
     .selected @selected-poi-type
     .onChange #(reset! selected-poi-type %))
    (#/(settings/DropDownSettingsTile String)
     .leading (m/Icon m/Icons.language)
     .settingKey "/general/language"
     .title  (l10n-str "settings.language")
     .values (into {} (map (fn [lang] [lang (l10n-str (str "settings.langs." lang))])
                           supported-locales))
<!-- [2b] Bottom sheet dialog invocation (line 58) -->
     .selected default-locale
     .onChange (fn [lang]
                 (logging/d "Changing language to: " lang)
                 (try
<!-- [2d] Dialog content builder (line 62) -->
                   (-> ctx
                       l10n/BuildContextEasyLocalizationExtension
                       (.setLocale (m/Locale lang)))
                   (catch Exception e
                     (logging/e "Failed to change language: " e)))
                 nil))]))

;; =============================================================================
;; Map Settings
;; =============================================================================

(defn map-group []
  (f/widget
   :watch [layer-type tile-layer-type
           selected-server selected-tile-server]
   (settings/SettingsGroup
    .title (l10n-str "settings.map_group_title")
    .children
    [;; Tile Layer Type Selector
     (#/(settings/DropDownSettingsTile String)
      .leading (m/Icon m/Icons.layers)
      .settingKey "/general/tile-layer-type"
      .title (l10n-str "settings.tile_layer_type")
      .values {"raster" (l10n-str "settings.tile_layer_raster")
               "vector" (l10n-str "settings.tile_layer_vector")}
      .selected (name layer-type)
      .onChange #(let [new-type (keyword %)]
                   (reset! tile-layer-type new-type)
                   ;; Reset server selection to default of new type to avoid invalid state
                   (let [new-default (if (= new-type :raster) "osm" "protomaps")]
                     (reset! selected-tile-server new-default))))

     ;; Tile Server Selector
     (let [is-raster (= layer-type :raster)
           options (if is-raster raster-tile-servers vector-tile-styles)
           ;; Use separate keys to avoid value mismatch crashes
           setting-key (if is-raster "/general/tile-server/raster" "/general/tile-server/vector")
           ;; Ensure selected value exists in options, else fallback
           current-val (if (contains? options selected-server) selected-server (first (keys options)))]
       (#/(settings/DropDownSettingsTile String)
        ;; Key forces rebuild when type changes, ensuring cleaner state transition
        .key (m/ValueKey setting-key)
        .leading (m/Icon m/Icons.map)
        .settingKey setting-key
        .title (l10n-str "settings.tile_server")
        .values (into {} (map (fn [[id {:keys [name]}]] [id name]) options))
        .selected current-val
        .onChange #(reset! selected-tile-server %)))])))

;; =============================================================================
;; Location Settings
;; =============================================================================

(defn advanced-location-group []
  (settings/SettingsGroup
   .title  (l10n-str "settings.advanced_location_title")
   .children
   [(settings/TextInputSettingsTile
     .settingKey "/advanced-location/refresh-location-distance-filter"
     .title (l10n-str "settings.location_distance_filter")
     .keyboardType m/TextInputType.number
     .onChange #(let [distance (str->int % 0 10000)]
                  (when distance (reset! refresh-location-distance-filter distance)))
     .validator #(when (not (str->int % 0 10000))
                   (l10n-str "settings.distance_filter_input_validation_error"))
     .initialValue (str @refresh-location-distance-filter))
    (#/(settings/DropDownSettingsTile String)
     .leading (m/Icon m/Icons.location_searching)
     .settingKey "/advanced-location/refresh-location-accuracy"
     .title  (l10n-str "settings.refresh_location_accuracy")
     .values {"low" (l10n-str "settings.location_accuracy_low")
              "medium" (l10n-str "settings.location_accuracy_medium")
              "high" (l10n-str "settings.location_accuracy_high")}
     .selected (location-accuracy->str @refresh-location-accuracy)
     .onChange #(reset! refresh-location-accuracy (str->location-accuracy %)))
    (#/(settings/DropDownSettingsTile int)
     .leading (m/Icon m/Icons.location_searching)
     .settingKey "/advanced-location/refresh-location-interval-duration"
     .title  (l10n-str "settings.refresh_location_interval_duration")
     .values {5 "5s"
              30 "30s"
              60 "1m"
              (* 5 60) "5m"
              (* 10 60) "10m"
              (* 30 60) "30m"
              (* 60 60) "1h"}
     .selected (.-inSeconds ^Duration @refresh-location-interval-duration)
     .onChange #(reset! refresh-location-interval-duration (Duration .seconds %)))]))

;; =============================================================================
;; Advanced Settings
;; =============================================================================

(defn advanced-group []
  (settings/SettingsGroup
   .title  (l10n-str "settings.advanced_group_title")
   .children
   [(settings/TextInputSettingsTile
     .settingKey "/advanced/api-query-timeout"
     .title (l10n-str "settings.api_query_timeout")
     .keyboardType m/TextInputType.number
     .onChange #(let [timeout (str->int % 2 10)]
                  (when timeout (reset! api-query-timeout timeout)))
     .validator #(when (not (str->int % 2 10))
                   (l10n-str "settings.timeout_input_validation_error"))
     .initialValue (str @api-query-timeout))
    (settings/SwitchSettingsTile
     .leading (m/Icon m/Icons.bug_report)
     .settingKey "/advanced/debug-mode?"
     .title (l10n-str "settings.debug_mode")
     .onChange #(reset! force-debug-mode? %))]))
</file>
</files>
```

---

*Exported from Code Map on 19.12.2025*