commit 5e38c6879c436334e8e0d0403bc399c9ab44873f
Author: Drunkod Library <you@example.com>
Date:   Fri Dec 5 16:52:55 2025 +0500

    Replaced all (swap! atom (constantly value)) with (reset! atom value) in:
    src/club/bhikers/lib/app.cljd
     - 9 instances
    src/club/bhikers/lib/appupdate.cljd
     - 2 instances
    src/club/bhikers/lib/logging.cljd
     - 1 instance
    src/club/bhikers/lib/pois.cljd
     - 3 instances
    src/club/bhikers/screens/settings/ui.cljd
     - 8 instances
    Standardized lifecycle naming by renaming logging/close! to logging/dispose! in:
    src/club/bhikers/lib/logging.cljd
     - function definition
    src/club/bhikers/main.cljd
     - function call
    Verification
    Both search patterns now return no results, confirming that:
    
    No instances of (swap! atom (constantly value)) remain
    No references to logging/close! remain

diff --git a/TODO.md b/TODO.md
new file mode 100644
index 0000000..083df6b
--- /dev/null
+++ b/TODO.md
@@ -0,0 +1,90 @@
+
+## 🔧 TODO: Next Refactoring Steps
+
+### Priority 1: Code Quality Issues
+
+| # | Task | File(s) | Notes |
+|---|------|---------|-------|
+| 1 | **Use `reset!` instead of `swap! (constantly ...)`** | All files | `(reset! atom value)` is cleaner than `(swap! atom (constantly value))` |
+| 2 | **Remove commented code** | `lib/map.cljd` | FloatingActionButton block ~L160 |
+| 3 | **Fix inconsistent lifecycle naming** | Various | Standardize on `init!`/`dispose!` or `start!/stop!` |
+
+### Priority 2: Split Large Modules
+
+| # | Task | File | Proposed Split |
+|---|------|------|----------------|
+| 4 | **Split `lib/utils.cljd`** | `lib/utils.cljd` | → `lib/i18n.cljd` (l10n-str)<br>→ `lib/http.cljd` (dio, cache)<br>→ `lib/uuid.cljd`<br>→ `lib/io.cljd` (log-file-dir) |
+| 5 | **Split `lib/map.cljd`** | `lib/map.cljd` (~170 lines) | → `lib/map/state.cljd` (new-state, state-streams protocol)<br>→ `lib/map/widgets.cljd` (msg, control-buttons) |
+| 6 | **Split `lib/position.cljd`** | `lib/position.cljd` (~140 lines) | → `lib/position/settings.cljd`<br>→ `lib/position/streams.cljd` |
+
+### Priority 3: Configuration Cleanup
+
+| # | Task | File | Notes |
+|---|------|------|-------|
+| 7 | **Separate constants from runtime state** | `lib/config.cljd` | Create `lib/state.cljd` for atoms, keep `config.cljd` for constants only |
+| 8 | **Move POI OSM tags to config** | `lib/pois.cljd` | `poi-types->osm-tags` is config data |
+| 9 | **Extract icon mappings** | `lib/pois/ui.cljd` | `osm-tags->icons` (~40 lines) → `resources/` or separate config |
+
+### Priority 4: Dependency Fixes
+
+| # | Task | Issue | Fix |
+|---|------|-------|-----|
+| 10 | **Move `log-file-dir` to logging** | `utils.cljd` → `logging.cljd` | Avoid cross-cutting concern in utils |
+| 11 | **Fix `notifications` direct reference** | `common/appbar.cljd` | Uses both `:get [:notifications]` AND direct `notifications` atom reference in watch |
+
+### Priority 5: Testing & Documentation
+
+| # | Task | Notes |
+|---|------|-------|
+| 12 | **Add docstrings** | Public functions in lib/ lack documentation |
+| 13 | **Add unit tests for lib functions** | Current tests are integration/widget only |
+| 14 | **Test POI query logic** | `dynamic-map-pois` is complex, needs tests |
+| 15 | **Test position stream logic** | `new-position-stream-controller` is critical |
+
+### Priority 6: Future Improvements
+
+| # | Task | Notes |
+|---|------|-------|
+| 16 | **Standardize error handling** | Add consistent try/catch patterns or error boundary |
+| 17 | **Extract magic numbers** | `100000` (lat/lon precision), `40` (marker size), etc. |
+| 18 | **Consider replacing atom watches** | `add-watch` chains can be hard to debug; consider reactive patterns |
+
+---
+
+## 📁 Suggested Final Structure
+
+```
+lib/
+├── config.cljd          # Constants only (no atoms)
+├── state.cljd           # Runtime atoms
+├── app.cljd             # Initialization
+├── i18n.cljd            # l10n-str
+├── http.cljd            # dio, cache utilities  
+├── logging.cljd         # (move log-file-dir here)
+├── notifications.cljd
+├── permissions.cljd
+├── map/
+│   ├── state.cljd       # new-state, ->state-streams
+│   └── widgets.cljd     # msg, control-buttons
+├── position/
+│   ├── settings.cljd    # location settings per platform
+│   └── streams.cljd     # stream controllers
+├── pois/
+│   ├── core.cljd        # poi-types->osm-tags, query logic
+│   ├── ui.cljd          # widgets
+│   └── icons.cljd       # osm-tags->icons mapping
+└── overpassapi.cljd
+
+screens/
+├── common/
+│   ├── appbar.cljd
+│   └── drawer.cljd
+├── aroundme/
+│   ├── core.cljd        # main screen
+│   ├── layers.cljd
+│   └── ui.cljd
+├── settings/
+│   ├── core.cljd
+│   └── ui.cljd
+└── ...
+```
\ No newline at end of file
diff --git a/src/club/bhikers/lib/app.cljd b/src/club/bhikers/lib/app.cljd
index ed83aa7..857fe7f 100644
--- a/src/club/bhikers/lib/app.cljd
+++ b/src/club/bhikers/lib/app.cljd
@@ -40,20 +40,20 @@
 
         _tile-server-setting (#/(.getValue String) Settings server-key .defaultValue default-server)]
 
-    (swap! config/app-info (constantly {:build-name (.-version pkg-info)
-                                        :build-number (.-buildNumber pkg-info)
-                                        :app-name (.-appName pkg-info)
-                                        :git-commit (String.fromEnvironment "GIT_COMMIT" .defaultValue "undef")
-                                        :git-branch (String.fromEnvironment "GIT_BRANCH" .defaultValue "undef")
-                                        :repo-url  (String.fromEnvironment "REPO_URL" .defaultValue "undef")
-                                        :latest-release-api  (String.fromEnvironment "LATEST_RELEASE_API"
-                                                                                     .defaultValue config/default-latest-release-api)}))
-    (swap! config/refresh-location-distance-filter (constantly (int/tryParse _distance-setting)))
-    (swap! config/refresh-location-interval-duration (constantly (Duration .seconds _duration-setting)))
-    (swap! config/refresh-location-accuracy (constantly (str->location-accuracy _accuracy-setting)))
-    (swap! config/pois-radius (constantly _radius-setting))
-    (swap! config/api-query-timeout (constantly (int/tryParse _query-timeout-setting)))
-    (swap! config/force-debug-mode? (constantly _debug-setting))
-    (swap! config/selected-poi-type (constantly _poi-type-setting))
-    (swap! config/selected-tile-server (constantly _tile-server-setting))
-    (swap! config/tile-layer-type (constantly (keyword _tile-layer-type-setting)))))
\ No newline at end of file
+    (reset! config/app-info {:build-name (.-version pkg-info)
+                             :build-number (.-buildNumber pkg-info)
+                             :app-name (.-appName pkg-info)
+                             :git-commit (String.fromEnvironment "GIT_COMMIT" .defaultValue "undef")
+                             :git-branch (String.fromEnvironment "GIT_BRANCH" .defaultValue "undef")
+                             :repo-url  (String.fromEnvironment "REPO_URL" .defaultValue "undef")
+                             :latest-release-api  (String.fromEnvironment "LATEST_RELEASE_API"
+                                                                          .defaultValue config/default-latest-release-api)})
+    (reset! config/refresh-location-distance-filter (int/tryParse _distance-setting))
+    (reset! config/refresh-location-interval-duration (Duration .seconds _duration-setting))
+    (reset! config/refresh-location-accuracy (str->location-accuracy _accuracy-setting))
+    (reset! config/pois-radius _radius-setting)
+    (reset! config/api-query-timeout (int/tryParse _query-timeout-setting))
+    (reset! config/force-debug-mode? _debug-setting)
+    (reset! config/selected-poi-type _poi-type-setting)
+    (reset! config/selected-tile-server _tile-server-setting)
+    (reset! config/tile-layer-type (keyword _tile-layer-type-setting))))
\ No newline at end of file
diff --git a/src/club/bhikers/lib/appupdate.cljd b/src/club/bhikers/lib/appupdate.cljd
index 5d3b602..a06e5d1 100644
--- a/src/club/bhikers/lib/appupdate.cljd
+++ b/src/club/bhikers/lib/appupdate.cljd
@@ -20,8 +20,8 @@
                               current-version (get new-info :build-name)]
                           (logging/d "last release: " tag-name ", current: " current-version)
                           (when (not= tag-name (str "v" current-version))
-                            (swap! new-version-url (constantly browser-dl-url))
-                            (swap! new-version (constantly tag-name))
+                            (reset! new-version-url browser-dl-url)
+                            (reset! new-version tag-name)
                             (logging/d "NEW VERSION! " @new-version ": " @new-version-url)))))))]
     (add-watch app-info :check-for-update refresh!)
     (refresh! nil nil nil @app-info)))
diff --git a/src/club/bhikers/lib/logging.cljd b/src/club/bhikers/lib/logging.cljd
index 0042a23..1adc857 100644
--- a/src/club/bhikers/lib/logging.cljd
+++ b/src/club/bhikers/lib/logging.cljd
@@ -42,6 +42,6 @@
                                  file-output)
                        .printer (SimplePrinter .colors true .printTime true))]
        (d (str "swap logging system (see file in " (.-path log-dir) ")"))
-       (swap! logger (constantly new-logger))))))
+       (reset! logger new-logger))))))
 
-(defn close! [] (await (.close ^Logger @logger)))
+(defn dispose! [] (await (.close ^Logger @logger)))
diff --git a/src/club/bhikers/lib/pois.cljd b/src/club/bhikers/lib/pois.cljd
index 30468a3..d6548e1 100644
--- a/src/club/bhikers/lib/pois.cljd
+++ b/src/club/bhikers/lib/pois.cljd
@@ -100,20 +100,20 @@
                        (reset! pois [])
                        (doseq [t ["node" "way"]
                                tags (partition-all 2 osm-tags)]
-                         (swap! query-reporter (constantly (str "fetch:" t tags)))
+                         (reset! query-reporter (str "fetch:" t tags))
                          (let [all-items (await (oapi/query overpass-api t lat lon tags radius))
                                typed-items (filter #(= t (get % "type")) all-items)
                                _pois (map #(overpass-item->poi % all-items selected-poi-type)
                                           typed-items)]
                            (cond
                              (= _pois nil)
-                             (swap! query-reporter (constantly (str "FAILED! " t tags)))
+                             (reset! query-reporter (str "FAILED! " t tags))
                              (= (count _pois) 0)
                              (logging/d "no pois fetched! map-state was: " new-state)
                              :else
                              (do (logging/d "adding " (count _pois) " pois fetched!")
                                  (reset! pois (into @pois _pois))))))
-                       (swap! query-reporter (constantly (str "fetched " (count @pois) " pois."))))))))
+                       (reset! query-reporter (str "fetched " (count @pois) " pois."))))))))
 
     pois))
 
diff --git a/src/club/bhikers/main.cljd b/src/club/bhikers/main.cljd
index 2517469..667fd7c 100644
--- a/src/club/bhikers/main.cljd
+++ b/src/club/bhikers/main.cljd
@@ -70,4 +70,4 @@
   (check-for-update!)
   (logging/d "starting app")
   (f/run (BhikersClubApp "/around-me"))
-  (await logging/close!))
+  (await logging/dispose!))
diff --git a/src/club/bhikers/screens/settings/ui.cljd b/src/club/bhikers/screens/settings/ui.cljd
index 38d63c2..60be632 100644
--- a/src/club/bhikers/screens/settings/ui.cljd
+++ b/src/club/bhikers/screens/settings/ui.cljd
@@ -37,7 +37,7 @@
      .defaultValue 1000
      .min min-pois-radius
      .max max-pois-radius
-     .onChange #(swap! pois-radius (constantly %))
+     .onChange #(reset! pois-radius %)
      .step 500)
     (#/(settings/DropDownSettingsTile String)
      .leading (m/Icon m/Icons.location_searching)
@@ -46,7 +46,7 @@
      .values (into {} (map (fn [poi] [poi (l10n-str (str "around_me.pois." poi))])
                            supported-poi-types))
      .selected @selected-poi-type
-     .onChange #(swap! selected-poi-type (constantly %)))
+     .onChange #(reset! selected-poi-type %))
     (#/(settings/DropDownSettingsTile String)
      .leading (m/Icon m/Icons.language)
      .settingKey "/general/language"
@@ -79,10 +79,10 @@
                "vector" (l10n-str "settings.tile_layer_vector")}
       .selected (name layer-type)
       .onChange #(let [new-type (keyword %)]
-                   (swap! tile-layer-type (constantly new-type))
+                   (reset! tile-layer-type new-type)
                    ;; Reset server selection to default of new type to avoid invalid state
                    (let [new-default (if (= new-type :raster) "osm" "protomaps")]
-                     (swap! selected-tile-server (constantly new-default)))))
+                     (reset! selected-tile-server new-default)))))
 
      ;; Tile Server Selector
      (let [is-raster (= layer-type :raster)
@@ -99,7 +99,7 @@
         .title (l10n-str "settings.tile_server")
         .values (into {} (map (fn [[id {:keys [name]}]] [id name]) options))
         .selected current-val
-        .onChange #(swap! selected-tile-server (constantly %))))])))
+        .onChange #(reset! selected-tile-server %))))])))
 
 ;; =============================================================================
 ;; Location Settings
@@ -114,7 +114,7 @@
      .title (l10n-str "settings.location_distance_filter")
      .keyboardType m/TextInputType.number
      .onChange #(let [distance (str->int % 0 10000)]
-                  (when distance (swap! refresh-location-distance-filter (constantly distance))))
+                  (when distance (reset! refresh-location-distance-filter distance)))
      .validator #(when (not (str->int % 0 10000))
                    (l10n-str "settings.distance_filter_input_validation_error"))
      .initialValue (str @refresh-location-distance-filter))
@@ -126,7 +126,7 @@
               "medium" (l10n-str "settings.location_accuracy_medium")
               "high" (l10n-str "settings.location_accuracy_high")}
      .selected (location-accuracy->str @refresh-location-accuracy)
-     .onChange #(swap! refresh-location-accuracy (constantly (str->location-accuracy %))))
+     .onChange #(reset! refresh-location-accuracy (str->location-accuracy %)))
     (#/(settings/DropDownSettingsTile int)
      .leading (m/Icon m/Icons.location_searching)
      .settingKey "/advanced-location/refresh-location-interval-duration"
@@ -139,8 +139,7 @@
               (* 30 60) "30m"
               (* 60 60) "1h"}
      .selected (.-inSeconds ^Duration @refresh-location-interval-duration)
-     .onChange #(swap! refresh-location-interval-duration (constantly
-                                                           (Duration .seconds %))))]))
+     .onChange #(reset! refresh-location-interval-duration (Duration .seconds %))))]))
 
 ;; =============================================================================
 ;; Advanced Settings
@@ -155,7 +154,7 @@
      .title (l10n-str "settings.api_query_timeout")
      .keyboardType m/TextInputType.number
      .onChange #(let [timeout (str->int % 2 10)]
-                  (when timeout (swap! api-query-timeout (constantly timeout))))
+                  (when timeout (reset! api-query-timeout timeout)))
      .validator #(when (not (str->int % 2 10))
                    (l10n-str "settings.timeout_input_validation_error"))
      .initialValue (str @api-query-timeout))
@@ -163,4 +162,4 @@
      .leading (m/Icon m/Icons.bug_report)
      .settingKey "/advanced/debug-mode?"
      .title (l10n-str "settings.debug_mode")
-     .onChange #(swap! force-debug-mode? (constantly %)))]))
\ No newline at end of file
+     .onChange #(reset! force-debug-mode? %))]))))
\ No newline at end of file
