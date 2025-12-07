---
inclusion: always
---
<!------------------------------------------------------------------------------------
   Add rules to this file or a short description and have Kiro refine them for you.
   
   Learn about inclusion modes: https://kiro.dev/docs/steering/#inclusion-modes
-------------------------------------------------------------------------------------> 

Directory structure:
└── samples/
    ├── README.md
    ├── animated_container/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── animated_container.cljd
    ├── animated_string/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── animated_string.cljd
    ├── bottom_navigation_bar/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── bottom_navigation_bar.cljd
    ├── counter/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           ├── counter.cljd
    │           └── counter.cljd-e
    ├── datatable/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── datatable.cljd
    ├── drawer/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── drawer.cljd
    ├── drawer_navigate_named/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── drawer_navigate_named.cljd
    ├── fab/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── fab.cljd
    ├── fade_widget/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── fade_widget.cljd
    ├── fetch-data/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── fetch_data.cljd
    ├── ffi/
    │   ├── README.md
    │   ├── CHANGELOG.md
    │   ├── deps.edn
    │   ├── pubspec.yaml
    │   ├── hello_library/
    │   │   ├── CMakeLists.txt
    │   │   ├── hello.c
    │   │   ├── hello.def
    │   │   └── hello.h
    │   └── src/
    │       └── sample/
    │           └── ffi.cljd
    ├── fficjson/
    │   ├── README.md
    │   ├── config.yaml
    │   ├── deps.edn
    │   ├── example.json
    │   ├── src/
    │   │   └── sample/
    │   │       └── ffigen.cljd
    │   └── third_party/
    │       └── cjson_library/
    │           ├── cJSON.h
    │           ├── CMakeLists.txt
    │           └── license.txt
    ├── first_flutter_app_codelabs/
    │   ├── README.md
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── first_flutter_app_codelabs.cljd
    ├── fizzbuzz/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── fizzbuzz.cljd
    ├── form_handle_change_textfield/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── form.cljd
    ├── form_retrieve_input/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── form.cljd
    ├── form_validate/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── form.cljd
    ├── gesture_detector/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── gesture_detector.cljd
    ├── go_router/
    │   ├── README.md
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── gorouter.cljd
    ├── gridlist/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── gridlist.cljd
    ├── hero_animations/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── hero_animations.cljd
    ├── isolates/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── isolates.cljd
    ├── keep_alive/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── keep_alive.cljd
    ├── navigate_named_routes/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── navigate_named_routes.cljd
    ├── navigation/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── navigation.cljd
    ├── physics_simulation/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── physics_sim.cljd
    ├── platform_view/
    │   ├── cljd_platform_view.iml
    │   ├── deps.edn
    │   ├── ios/
    │   │   ├── Flutter/
    │   │   │   ├── AppFrameworkInfo.plist
    │   │   │   ├── Debug.xcconfig
    │   │   │   └── Release.xcconfig
    │   │   ├── Runner/
    │   │   │   ├── AppDelegate.swift
    │   │   │   ├── FLNativeViewFactory.swift
    │   │   │   ├── Info.plist
    │   │   │   ├── Runner-Bridging-Header.h
    │   │   │   ├── Assets.xcassets/
    │   │   │   │   ├── AppIcon.appiconset/
    │   │   │   │   │   └── Contents.json
    │   │   │   │   └── LaunchImage.imageset/
    │   │   │   │       ├── README.md
    │   │   │   │       └── Contents.json
    │   │   │   └── Base.lproj/
    │   │   │       ├── LaunchScreen.storyboard
    │   │   │       └── Main.storyboard
    │   │   └── RunnerTests/
    │   │       └── RunnerTests.swift
    │   └── src/
    │       └── sample/
    │           └── platform_view.cljd
    ├── scoped_watch/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── scoped_watch.cljd
    ├── shopper/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── shopper.cljd
    ├── snackbar/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── snackbar.cljd
    ├── syncfusion_flutter_charts/
    │   ├── README.md
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── charts.cljd
    ├── tabs/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── tabs.cljd
    ├── twocounters/
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── two_counters.cljd
    ├── video_player/
    │   ├── README.md
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── video_player.cljd
    ├── webview/
    │   ├── README.md
    │   ├── deps.edn
    │   └── src/
    │       └── sample/
    │           └── webview.cljd
    └── widget_tests/
        ├── cljd_widget_tests.iml
        ├── deps.edn
        ├── src/
        │   └── samples/
        │       └── widget.cljd
        └── test/
            └── samples/
                └── widgets_test.cljd


Files Content:

================================================
FILE: samples/README.md
================================================
This repo aims at training yourself and others by practicing/reading Flutter the ClojureDart way.
You will find listed below in the `Sample` section all of the current samples, and what do they cover.

## Run a sample

```sh
clj -M:cljd init
clj -M:cljd flutter
```
A native application will be created. If you want to test it on mobile, please follow [those instructions.](https://github.com/Tensegritics/ClojureDart/blob/main/doc/flutter-quick-start.md#7-start-a-simulator)

## Samples

### [Animated container](./animated_container)

- state with `:state`

- Particular widgets
    - AnimatedContainer
    - BoxDecoration
    - FloatingActionButton

### [Counter](./counter)
- state with `:state`
- Widget.of(context) with `:inherit`
- nested widgets

- Particular widgets
    - Column
    - FloatingActionButton
    - Theme / ThemeData


### [DataTable](./datatable)
- stateless

- Particular widgets
    - SingleChildScrollView
    - DataTable


### [Drawer](./drawer)
- stateless
- Navigator in Scaffold widget with `:inherit`

- Particular widgets
    - Navigator
    - ListView
    - ListTile


### [Fab](./fab)
- BuildContext with `:context`
- key with `:key`
- state with `:state`
- Theme.of(context) with `:inherit`
- `:ticker`
- dispose/init ressources with `:with`

- Particular widgets
    - Theme / ThemeData
    - InkWell
    - AnimatedContainer
    - AnimatedOpacity
    - SizedBox
    - Icon
    - Stack
    - AnimatedBuilder
    - FadeTransition
    - BoxDecoration
    - Container
    - FloatingActionButton


### [Fade Widget](./fade_widget)
- state with `:state`

- Particular widgets
    - AnimatedOpacity
    - FloatingActionButton


### [Form - handle change TextField](./form_handle_change_textfield)
- state with `:state`
- `:controller`
- dispose/init ressources with `:with`

- Particular widgets
    - TextField


### [Form - Retrieve Input](./form_retrieve_input)
- `:controller`
- dispose/init ressources with `:with`

- Particular widgets
    - AlertDialog
    - FloatingActionButton

### [Form - with validation](./form_validate)
- ScaffoldMessenger.of(context) with `:get`
- `cljd.string/blank?`
- GlobalKey\<FormState\> with `#/(m/GlobalKey m/FormState)`

- Particular widgets
    - TextFormField
    - ScaffoldMessenger
    - SnackBar


### [Gesture Detector](./gesture_detector)
- state with `:state`
- anonymous class extention with `reify :extends`

- Particular widgets
    - CustomPaint
    - CustomPainter
    - Canvas
    - GestureDetector
    - Offset
    - Paint

### [GridList](./gridlist)
- stateless
- Particular widgets
    - GridView

### [Hero animations](./hero_animations)
- Navigator in Scaffold widgets with `:inherit`

- Particular widgets
    - Navigator
    - GestureDetector
    - Hero

### [Navigation](./navigation)
- Navigator in Scaffold widgets with `:inherit`

- Particular widgets
    - Navigator
    - ElevatedButton

### [Physics simulation](./physics_simulation)
- BuildContext with `:context`
- key with `:key`
- state with `:state`
- MediaQuery.of(context) with `:inherit`
- `:ticker`
- dispose/init ressources with `:with`

- Particular widgets
    - GestureDetector
    - SpringDetection
    - SpringSimulation
    - Align
    - Card

### [Snackbar](./snackbar)
- ScaffoldMessenger.of(context) with `:inherit`

- Particular widgets
    - ElevatedButton
    - SnackBar
    - SnackBarAction

### [Tabs](./tabs)
- stateless

- Particular widgets
    - DefaultTabController
    - TabBar
    - TabBarView

### [Two counters](./twocounters)
- closure with `:bind`
- Theme.of(context) with `:inherit`

- Particular widgets
    - Center
    - Row
    - ElevatedButton



================================================
FILE: samples/animated_container/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.animated-container
             :kind :flutter}}



================================================
FILE: samples/animated_container/src/sample/animated_container.cljd
================================================
(ns sample.animated-container
  "Faithful port of https://docs.flutter.dev/cookbook/animation/animated-container"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn random-color []
  (m/Color.fromRGBO (rand-int 256)
                    (rand-int 256)
                    (rand-int 256)
                    1))

(def animated-container
  (let [config (atom {:width 50.0 :height 50.0 :color m/Colors.green :border-radius (m/BorderRadius.circular 8.0)})]
    (m/Scaffold
     .appBar (m/AppBar .title (m/Text "AnimatedContainer Demo"))
     .body
     (m/Center
      .child
      (f/widget
       :watch [{:keys [width height color border-radius]} config]
       (m/AnimatedContainer
        .width width
        .height height
        .decoration (m/BoxDecoration .color color .borderRadius border-radius)
        .duration (Duration .seconds 1)
        .curve m/Curves.fastOutSlowIn)))
     .floatingActionButton
     (m/FloatingActionButton .onPressed
       #(swap! config assoc
          :width (rand-int 300)
          :height (rand-int 300)
          :color (random-color)
          :border-radius (m/BorderRadius.circular (rand-int 100)))
       .child (m/Icon. m/Icons.play_arrow)))))

(defn main [] (f/run m/MaterialApp .home animated-container))



================================================
FILE: samples/animated_string/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.animated-string
             :kind :flutter}}



================================================
FILE: samples/animated_string/src/sample/animated_string.cljd
================================================
(ns sample.animated-string
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(def animated-text
  (f/widget
    (m/Scaffold
      .appBar (m/AppBar .title (m/Text ":animate demo")))
    .body
    :watch [text (atom "") :as *text]
    m/Column
    .children
    [(m/Text "Enter text below and press enter:")
     (m/TextField
       .onSubmitted (fn [x] (reset! *text x) nil))
     (m/Text "See text being slowly animated (interpolated) between actual value.")
     (m/Text "(Try changing text again while the animation is running.)")
     (f/widget
       :animate [s text
                 :duration (Duration .seconds 3)
                 :lerp (fn [from to]
                         (if (= from to)
                           (constantly to)
                           (let [common (count (take-while true? (map = from to)))
                                 nfrom (- (count from) common)
                                 nto (- (count to) common)
                                 n (+ nfrom nto)
                                 threshold (/ nfrom (double n))]
                             (fn [t]
                               (if (< t threshold)
                                 (subs from 0 (+ common (int (* n (- threshold t)))))
                                 (subs to 0 (+ common (int (* n (- t threshold))))))))))]
       (m/Text (str s "◼️")
         .style (m/TextStyle .fontSize 36 .fontFamily "courier")))
     (m/Text "Animated length but with a shorter duration")
     (f/widget
       :animate [n (count text)]
       (m/Text (str "n=" n)))]))

(defn main [] (f/run m/MaterialApp .home animated-text))



================================================
FILE: samples/bottom_navigation_bar/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {tensegritics/clojuredart
        {:git/url "https://github.com/tensegritics/ClojureDart.git"
         :sha "0e1ef256cf3a0ee9b71db6d4af3d8be581b95195"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:kind :flutter
             :main sample.bottom-navigation-bar}}



================================================
FILE: samples/bottom_navigation_bar/src/sample/bottom_navigation_bar.cljd
================================================
(ns sample.bottom-navigation-bar
  "Faithful port of https://docs.flutter.dev/cookbook/design/tabs"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn main
  []
  (let
      [title "Bottom Navigation Bar Demo"
       pages [(m/Icon. m/Icons.directions_car)
              (m/Icon. m/Icons.directions_transit)
              (m/Icon. m/Icons.directions_bike)]
       selected-index (atom 0)]
    (f/run
      (m/MaterialApp .title title)

      .home
      (m/Scaffold

       .appBar
       (m/AppBar
        .title
        (m/Text "BottomNavigationBar"))
       
       .body
       (m/Center
        .child
        (f/widget :watch [current-index selected-index] (get pages current-index)))
       
       .bottomNavigationBar
       (f/widget
        :watch [current-index selected-index]
        (m/BottomNavigationBar
         .items [(m/BottomNavigationBarItem .icon (m/Icon. m/Icons.directions_car) .label "directions_car")
                 (m/BottomNavigationBarItem .icon (m/Icon. m/Icons.directions_transit) .label "directions_transit")
                 (m/BottomNavigationBarItem .icon (m/Icon. m/Icons.directions_bike) .label "directions_bike")]
         .currentIndex current-index
         .onTap (fn [index] (reset! selected-index index))))))))



================================================
FILE: samples/counter/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.counter
             :kind :flutter}}



================================================
FILE: samples/counter/src/sample/counter.cljd
================================================
(ns sample.counter
  "The perennial counter demo."
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn main []
  (let [counter (atom 0)]
    (f/run
      (m/MaterialApp
        .title "Cljd Demo"
        .theme (m/ThemeData .primarySwatch m/Colors.blue))
      .home
      (m/Scaffold
        .appBar (m/AppBar .title (m/Text "ClojureDart Home Page"))
        .floatingActionButton
        (f/widget
          (m/FloatingActionButton
            .onPressed #(swap! counter inc)
            .tooltip "Increment")
          (m/Icon m/Icons.add)))
      .body
      m/Center
      (m/Column .mainAxisAlignment m/MainAxisAlignment.center)
      .children
      [(m/Text "You have pushed the button this many times:")
       (f/widget
         :get {{{:flds [displayLarge]} .-textTheme} m/Theme}
         :watch [N counter]
         (m/Text (str N) .style displayLarge))])))



================================================
FILE: samples/counter/src/sample/counter.cljd-e
================================================
(ns sample.counter
  "The perennial counter demo."
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter.alpha2 :as f]))

(defn main []
  (let [counter (atom 0)]
    (f/run
      (m/MaterialApp
        .title "Cljd Demo"
        .theme (m/ThemeData .primarySwatch m/Colors.blue))
      .home
      (m/Scaffold
        .appBar (m/AppBar .title (m/Text "ClojureDart Home Page"))
        .floatingActionButton
        (f/widget
          (m/FloatingActionButton
            .onPressed #(swap! counter inc)
            .tooltip "Increment")
          (m/Icon m/Icons.add)))
      .body
      m/Center
      (m/Column .mainAxisAlignment m/MainAxisAlignment.center)
      .children
      [(m/Text "You have pushed the button this many times:")
       (f/widget
         :get {{{:flds [displayLarge]} .-textTheme} m/Theme}
         :watch [N counter]
         (m/Text (str N) .style displayLarge))])))



================================================
FILE: samples/datatable/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.datatable
             :kind :flutter}}



================================================
FILE: samples/datatable/src/sample/datatable.cljd
================================================
(ns sample.datatable
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn data-table [& {:keys [cols rows]}]
  (f/widget
   (m/SingleChildScrollView .scrollDirection m/Axis.horizontal)
   (m/DataTable
    .headingTextStyle (m/TextStyle
                       .fontWeight m/FontWeight.bold
                       .color m/Colors.blue)
    ;; .columnSpacing 18.0
    ;; .sortColumnIndex 2
    ;; .sortAscending true
    .showBottomBorder true
    .columns (for [col cols] (m/DataColumn .label (m/Text col)))
    .rows (for [row rows]
            (m/DataRow .cells (for [cell row] (m/DataCell (m/Text cell))))))))

(def demo
  (f/widget
    (m/Scaffold .appBar (m/AppBar .title (m/Text "DataTable Sample")))
    .body
    m/Center
    (data-table :cols ["#" "Name" "Age" "City"]
      :rows [["1" "zm" "42" "guangzhou"]
             ["2" "zrj" "10" "guangzhou"]
             ["3" "wrp" "13" "hongkong"]
             ["4" "wrl" "11" "guangzhou"]
             ["5" "wrj" "10" "beijing"]])))

(defn main []
  (f/run m/MaterialApp .home demo))



================================================
FILE: samples/drawer/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.drawer
             :kind :flutter}}



================================================
FILE: samples/drawer/src/sample/drawer.cljd
================================================
(ns sample.drawer
  "Faithful port of https://docs.flutter.dev/cookbook/design/drawer"
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn my-home-page [title]
  (m/Scaffold
   .appBar (m/AppBar .title (m/Text title))
   .body (f/widget m/Center (m/Text "My Page!"))
   .drawer
   (f/widget
     m/Drawer
     ; Add a ListView to the drawer. This ensures the user can scroll
     ; through the options in the drawer if there isn't enough vertical
     ; space to fit everything.
     :get [m/Navigator]
     ; Important: Remove any padding from the ListView.
     (m/ListView .padding m/EdgeInsets.zero)
     .children
     (cons
       (f/widget
         (m/DrawerHeader .decoration (m/BoxDecoration .color m/Colors.blue))
         (m/Text "Drawer Header"))
       (for [title ["Item 1" "Item 2"]]
         (m/ListTile
           .title (m/Text title)
           .onTap
           ; Update the state of the app
           ; ...
           ; Then close the drawer
           #(.pop navigator)))))))

(defn main []
  (f/run m/MaterialApp .home (my-home-page "Drawer Demo")))



================================================
FILE: samples/drawer_navigate_named/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.drawer-navigate-named
             :kind :flutter}}



================================================
FILE: samples/drawer_navigate_named/src/sample/drawer_navigate_named.cljd
================================================
(ns sample.drawer-navigate-named
  "Example for using drawer with named routes navigation."
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn drawer
  [component]
  (f/widget
    :let [drawer-routes [["/"
                          "Initial Page"
                          m/Icons.home]
                         ["/favorites"
                          "Favorite Page"
                          m/Icons.favorite]
                         ["/movies"
                          "Movies Page"
                          m/Icons.local_movies]]]
    (m/Scaffold
      .appBar (m/AppBar
                .title (m/Text "Drawer"))
      .drawer (f/widget
                :get [m/Navigator]
                m/Drawer
                (m/ListView
                  .padding (m/EdgeInsets.all 20)
                  .children (into [(f/widget
                                     (m/SizedBox .height 50)
                                     (m/Container))]
                                  (map (fn [[route
                                             title
                                             icon]]
                                         (f/widget
                                           (m/ListTile
                                             .leading (m/Icon icon)
                                             .title (m/Text title)
                                             .onTap
                                             (fn []
                                               (.pop navigator)
                                               (.pushNamed navigator route)
                                               nil)))))
                                  drawer-routes)))
      .body component)))


(def routes
  {"/"          (drawer
                  (f/widget
                    m/Center
                    (m/Text "Initial Page!")))
   "/favorites" (drawer
                  (f/widget
                    m/Center
                    (m/Text "Favorites Page!")))
   "/movies"    (drawer
                  (f/widget
                    m/Center
                    (m/Text "Movies Page!")))})


(defn main []
  (f/run
    (m/MaterialApp
      .title "Drawer with Named Routes Demo"
      .initialRoute "/"
      .routes       (into {}
                          (keep (fn [[k v]]
                                  {k (fn ^m/Widget k [ctx]
                                       v)}))
                          routes))))



================================================
FILE: samples/fab/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.fab
             :kind :flutter}}



================================================
FILE: samples/fab/src/sample/fab.cljd
================================================
(ns sample.fab
  "Faithful port of https://docs.flutter.dev/cookbook/effects/expandable-fab#interactive-example"
  (:require
   ["package:flutter/material.dart" :as m]
   ["dart:math" :as math]
   [cljd.flutter :as f]))

;; https://docs.flutter.dev/cookbook/effects/expandable-fab#interactive-example

(defn fake-item [is-big]
  (m/Container
    .margin (m/EdgeInsets.symmetric .vertical 8.0 .horizontal 24.0)
    .height (if is-big 128.0 36.0)
    .decoration
    (m/BoxDecoration
      .borderRadius (-> 8.0 m/Radius.circular m/BorderRadius.all)
      .color m/Colors.grey.shade300)))

(def action-titles ["Create Post" "Upload Photo" "Upload Video"])

(defn show-action [ctx i]
  (m/showDialog
   .context ctx
   .builder (f/build
              :get [m/Navigator]
              (m/AlertDialog
               .content (m/Text (action-titles i))
               .actions [(m/TextButton
                          .onPressed #(.pop navigator)
                          .child (m/Text "CLOSE"))]))))

(defn action-button [& {:keys [on-pressed icon]}]
  (f/widget
    :get {{{:flds [secondary onSecondary]} .-colorScheme} m/Theme}
    (m/Material
      .shape (m/CircleBorder)
      .clipBehavior m/Clip.antiAlias
      .color secondary
      .elevation 4.0)
    (m/IconButton
      .onPressed on-pressed
      .icon icon
      .color onSecondary)))

(defn expanding-action-button
  [& {:keys [direction-degrees max-distance ^#/(m/Animation double) progress child]}]
  (f/widget
    :watch [v progress]
    :let [{:flds [dx dy]} (m/Offset.fromDirection
                            (* direction-degrees (/ math/pi 180.0))
                            (* v max-distance))]
    (m/Positioned .right (+ 4.0 dx) .bottom (+ 4.0 dy))
    (m/Transform.rotate .angle (* (- 1.0 v) math/pi 0.5))
    (m/Opacity .opacity v)
    child))

(defn expandable-fab [& {:keys [distance children]}]
  (f/widget
   :let [open-state (atom false)]
   :vsync vsync
   :managed [controller (m/AnimationController
                          .value 0.0
                          .duration (dart:core/Duration .milliseconds 250)
                          .vsync vsync)
             expand-animation (m/CurvedAnimation
                                .curve m/Curves.fastOutSlowIn
                                .reverseCurve m/Curves.easeOutQuad
                                .parent controller)]
   :let [toggle #(if (swap! open-state not)
                   (.forward controller)
                   (.reverse controller))
         tap-to-close-fab
         (f/widget
           (m/SizedBox
             .width 56.0
             .height 56.0)
           m/Center
           (m/Material
             .shape (m/CircleBorder)
             .clipBehavior m/Clip.antiAlias
             .elevation 4.0)
           (m/InkWell .onTap toggle)
           (m/Padding .padding (m/EdgeInsets.all 8.0))
           :get {{:flds [primaryColor]} m/Theme}
           (m/Icon m/Icons.close .color primaryColor))
         tap-to-open-fab
         (f/widget
           :watch [is-open open-state]
           (m/IgnorePointer .ignoring is-open)
           :let [scaling (if is-open 0.7 1.0)]
           (m/AnimatedContainer
             .transformAlignment m/Alignment.center
             .transform (m.Matrix4/diagonal3Values scaling scaling 1.0)
             .duration (dart:core/Duration .milliseconds 250)
           .curve (m/Interval 0.0 0.5 .curve m/Curves.easeOut))
           (m/AnimatedOpacity
             .opacity (if is-open 0.0 1.0)
             .curve (m/Interval 0.25 1.0 .curve m/Curves.easeInOut)
             .duration (dart:core/Duration .milliseconds 250))
           (m/FloatingActionButton .onPressed toggle)
           (m/Icon m/Icons.create))
         step (/ 90.0 (dec (count children)))]
   m/SizedBox.expand
   (m/Stack
    .alignment m/Alignment.bottomRight
    .clipBehavior m/Clip.none
    .children (concat [tap-to-close-fab]
                (map-indexed
                  (fn [i child]
                    (expanding-action-button
                      :direction-degrees (* i step)
                      :max-distance distance
                      :progress expand-animation
                      :child child))
                  children)
                [tap-to-open-fab]))))

(def example-expandable-fab
  (f/widget
   :context ctx
   (m/Scaffold
    .appBar (m/AppBar .title (m/Text "Expandable Fab"))
    .body (m/ListView.builder
           .padding (m/EdgeInsets.symmetric .vertical 8.0)
           .itemCount 25
           .itemBuilder (f/build [i] (fake-item (odd? i))))
    .floatingActionButton
    (expandable-fab
     :distance 112.0
     :children [(action-button :on-pressed #(show-action ctx 0)
                               :icon (m/Icon m/Icons.format_size))
                (action-button :on-pressed #(show-action ctx 1)
                               :icon (m/Icon m/Icons.insert_photo))
                (action-button :on-pressed #(show-action ctx 2)
                               :icon (m/Icon m/Icons.videocam))]))))

(defn main []
  (f/run (m/MaterialApp .home example-expandable-fab)))



================================================
FILE: samples/fade_widget/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.fade-widget
             :kind :flutter}}



================================================
FILE: samples/fade_widget/src/sample/fade_widget.cljd
================================================
(ns sample.fade-widget
  "Faithful port of https://docs.flutter.dev/cookbook/animation/opacity-animation"
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn my-home-page [title]
  (let [visible-state (atom true)]
    (f/widget
      (m/Scaffold
        .appBar (m/AppBar .title (m/Text title))
        .floatingActionButton
        (m/FloatingActionButton .onPressed (fn [] (swap! visible-state not))
          .tooltip "Toggle Opacity"
          .child (m/Icon m/Icons.flip)))
      .body
      m/Center
      :watch [visible visible-state]
      (m/AnimatedOpacity
        .opacity (if visible 1.0 0.0)
        .duration (Duration .milliseconds 500))
      (m/Container .width 200.0 .height 200.0 .color m/Colors.green))))

(defn main []
  (let [title "Opacity Demo"]
    (f/run
      (m/MaterialApp .title title)
      .home
      (my-home-page title))))



================================================
FILE: samples/fetch-data/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.fetch-data
             :kind :flutter}}



================================================
FILE: samples/fetch-data/src/sample/fetch_data.cljd
================================================
(ns sample.fetch-data
  "Faithful port of https://docs.flutter.dev/cookbook/networking/fetch-data"
  (:require
   ["dart:convert" :as c]
   ["package:flutter/material.dart" :as m]
   ["package:http/http.dart" :as http]
   [cljd.flutter :as f]))

(defn main []
  (f/run
    (m/MaterialApp
      .title "Fetch Data Example"
      .theme (m/ThemeData .primarySwatch m/Colors.blue))
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Fetch Data Example")))
    .body
    m/Center
    :watch [response (http/get (Uri/parse "https://jsonplaceholder.typicode.com/albums/1"))]
    (if-some [{sc .-statusCode body .-body} ^http/Response response] ;; type hint is not necessary here, it removes compiler warnings
      (case sc
        200 (m/Text (get (c/json.decode body) "title"))
        (m/Text (str "Something wrong happened, status code: " sc)))
      (m/CircularProgressIndicator))))



================================================
FILE: samples/ffi/README.md
================================================
# Install

``` shell
$ cd hello_library
$ cmake .
```

``` shell
$ make

```

``` shell
$ cd ..
$ clj -M:cljd init
$ clj -M:cljd compile
$ dart run bin/ffi.dart
# Returns `Hello World`
```



================================================
FILE: samples/ffi/CHANGELOG.md
================================================
## 1.0.0

- Initial version.



================================================
FILE: samples/ffi/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.ffi
             :kind :dart}}



================================================
FILE: samples/ffi/pubspec.yaml
================================================
name: ffi
description: A sample command-line application.
version: 1.0.0
# repository: https://github.com/my_org/my_repo

environment:
  sdk: ^3.0.3

# Add regular dependencies here.
dependencies:
  # path: ^1.8.0

dev_dependencies:
  lints: ^2.0.0
  test: ^1.21.0



================================================
FILE: samples/ffi/hello_library/CMakeLists.txt
================================================
cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(hello_library VERSION 1.0.0 LANGUAGES C)
add_library(hello_library SHARED hello.c hello.def)
add_executable(hello_test hello.c)

set_target_properties(hello_library PROPERTIES
    PUBLIC_HEADER hello.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "hello"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)



================================================
FILE: samples/ffi/hello_library/hello.c
================================================
// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include "hello.h"

int main()
{
    hello_world();
    return 0;
}

// Note:
// ---only on Windows---
// Every function needs to be exported to be able to access the functions by dart.
// Refer: https://stackoverflow.com/q/225432/8608146
void hello_world()
{
    printf("Hello World\n");
}


================================================
FILE: samples/ffi/hello_library/hello.def
================================================
LIBRARY   hello
EXPORTS
   hello_world



================================================
FILE: samples/ffi/hello_library/hello.h
================================================
// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

void hello_world();


================================================
FILE: samples/ffi/src/sample/ffi.cljd
================================================
(ns sample.ffi
  ;; ffi example from https://dart.dev/guides/libraries/c-interop
  (:require ["dart:ffi" :as ffi]
            ["dart:io" :as io]
            ["package:path/path.dart" :as path]))

(defn main []
  (let [lib-path (cond
                   io/Platform.isMacOS
                   (path/join io/Directory.current.path "hello_library" "libhello.dylib")
                   io/Platform.isWindows
                   (path/join io/Directory.current.path "hello_library" "Debug" "hello.dll")
                   :else
                   (path/join io/Directory.current.path "hello_library" "libhello.so"))
        dylib (ffi/DynamicLibrary.open lib-path)
        ;; NOTE: that's how one would write `.lookup<ffi.NativeFunction<ffi.Void Function()>>('hello_world')`
        hello (-> dylib
                (. #/(lookup (ffi/NativeFunction (-> ffi/Void))) "hello_world")
                ;; `ffi/NativeFunctionPointer` is currently the way to call a method on an extension.
                ffi/NativeFunctionPointer
                ;; NOTE: `asFunction` takes also a type parameter that is used by cljd
                ;; analyzer to guess the return type.
                ;; Note that return type is *needed* in this ffi case
                (. #/(asFunction (-> void))))]
    (hello)))



================================================
FILE: samples/fficjson/README.md
================================================
# cJson ClojureDart example

Demonstrates generation of bindings for a C library called
[cJson](https://github.com/DaveGamble/cJSON) and then using these bindings
to parse some json.

## Building the cJson dynamic library
From the root of this repository -
```
cd third_party/cjson_library
cmake .
make
cd ../../
```

## Generating bindings
At the root of this example (`example/c_json`), run -
```
clj -M:cljd init
dart pub get
dart pub add ffi
dart pub add path
dart pub add ffigen --dev
dart run ffigen --config config.yaml
```
This will generate bindings in a file: lib/cjson_generated_bindings.dart

## Running the example
```
clj -M:cljd compile
dart run
```



================================================
FILE: samples/fficjson/config.yaml
================================================
# yaml-language-server: $schema=../../ffigen.schema.json

output: 'lib/cjson_generated_bindings.dart'
name: 'CJson'
description: 'Holds bindings to cJSON.'
headers:
  entry-points:
    - 'third_party/cjson_library/cJSON.h'
  include-directives:
    - '**cJSON.h'
comments: false
preamble: |
  // Copyright (c) 2009-2017 Dave Gamble and cJSON contributors
  //
  // Permission is hereby granted, free of charge, to any person obtaining a copy
  // of this software and associated documentation files (the "Software"), to deal
  // in the Software without restriction, including without limitation the rights
  // to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  // copies of the Software, and to permit persons to whom the Software is
  // furnished to do so, subject to the following conditions:
  //
  // The above copyright notice and this permission notice shall be included in
  // all copies or substantial portions of the Software.
  //
  // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  // IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  // FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  // AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  // LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  // OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  // THE SOFTWARE.

  // ignore_for_file: camel_case_types, non_constant_identifier_names



================================================
FILE: samples/fficjson/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.ffigen
             :kind :dart}}



================================================
FILE: samples/fficjson/example.json
================================================
{
    "name": "CoolGuy",
    "age": 21,
    "nicknames": [
        {
            "name": "Mr. Cool",
            "length": 8
        },
        {
            "name": "Ice Cold",
            "length": 8
        }
    ]
}



================================================
FILE: samples/fficjson/src/sample/ffigen.cljd
================================================
(ns sample.ffigen
  "Source example: https://github.com/dart-lang/ffigen/tree/main/example/c_json"
  (:require ["dart:convert" :as dart:convert]
            ["dart:ffi" :as dart:ffi]
            ["dart:io" :as dart:io]
            ["package:ffi/ffi.dart" :as ffi]
            ["package:path/path.dart" :as path]
            ;; TODO: change this when bug #275
            ;;["cjson_generated_bindings.dart" :as cjson]
            ["package:fficjson/cjson_generated_bindings.dart" :as cjson]))

(defn get-path []
  (let [cjson-example-path dart:io/Directory.current.absolute.path
        p (path/join cjson-example-path "third_party/cjson_library/")]
    (cond
      dart:io/Platform.isMacOS
      (path/join p "libcjson.dylib")
      dart:io/Platform.isWindows
      (path/join p "Debug" "cjson.dll")
      :else (path/join p "libcjson.so"))))

;; Holds bindings to cJSON.
(def ^cjson/CJson json (cjson/CJson (dart:ffi/DynamicLibrary.open (get-path))))

;; UTILS
;; All 3 functions take a pointer of cJSON struct and manipulate the cJSON struct
(defn- ^cjson/cJSON cjson-ptr->cjson-struct [^#/(dart:ffi/Pointer cjson/cJSON) ptr]
  (-> ptr dart:ffi/StructPointer .-ref))

(defn ^String string-ptr->dart-string [^#/(dart:ffi/Pointer dart:ffi/Char) ptr]
  (-> ptr (. #/(cast ffi/Utf8)) ffi/Utf8Pointer .toDartString))

(defn- ^#/(dart:ffi/Pointer? cjson/cJSON) cjson-ptr->child-ptr [^#/(dart:ffi/Pointer cjson/cJSON) ptr]
  (-> ptr cjson-ptr->cjson-struct .-child))

;; Serialization function
(defn cjson->cljd [^#/(dart:ffi/Pointer cjson/cJSON) parsedcjson-ptr]
  (cond
    (== 1 (.cJSON_IsObject json (.cast parsedcjson-ptr)))
    (let [m (transient {})]
      (loop [^#/(dart:ffi/Pointer? cjson/cJSON) ptr (cjson-ptr->child-ptr parsedcjson-ptr)]
        (if-not (= ptr dart:ffi/nullptr)
          (do
            (conj! m [(-> ptr cjson-ptr->cjson-struct .-string string-ptr->dart-string)
                      (cjson->cljd ptr)])
            (recur (-> ptr cjson-ptr->cjson-struct .-next)))
          (persistent! m))))
    (== 1 (.cJSON_IsArray json (.cast parsedcjson-ptr)))
    (let [v (transient [])]
      (loop [^#/(dart:ffi/Pointer? cjson/cJSON) ptr (cjson-ptr->child-ptr parsedcjson-ptr)]
        (if-not (= ptr dart:ffi/nullptr)
          (do
            (conj! v (cjson->cljd ptr))
            (recur (-> ptr cjson-ptr->cjson-struct .-next)))
          (persistent! v))))
    (== 1 (.cJSON_IsString json (.cast parsedcjson-ptr)))
    (-> parsedcjson-ptr cjson-ptr->cjson-struct .-valuestring string-ptr->dart-string)
    (== 1 (.cJSON_IsNumber json (.cast parsedcjson-ptr)))
    (let [i (-> parsedcjson-ptr cjson-ptr->cjson-struct .-valueint)
          d (-> parsedcjson-ptr cjson-ptr->cjson-struct .-valuedouble)]
      (if (== i d) i d))))


(defn main []
  (let [json-string (-> (dart:io/File "./example.json") .readAsStringSync)
        cjson-parsed-json (.cJSON_Parse json (->
                                               json-string
                                               ffi/StringUtf8Pointer
                                               .toNativeUtf8
                                               .cast))]
    (when (= dart:ffi/nullptr cjson-parsed-json)
      (throw (Exception "Error parsing cjson")))
    (prn (cjson->cljd cjson-parsed-json))
    (.cJSON_Delete json cjson-parsed-json)))



================================================
FILE: samples/fficjson/third_party/cjson_library/cJSON.h
================================================
/*
  Copyright (c) 2009-2017 Dave Gamble and cJSON contributors

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/
#ifndef cJSON__h
#define cJSON__h

#ifdef __cplusplus
extern "C"
{
#endif

#if !defined(__WINDOWS__) && (defined(WIN32) || defined(WIN64) || defined(_MSC_VER) || defined(_WIN32))
#define __WINDOWS__
#endif

#ifdef __WINDOWS__

/* When compiling for windows, we specify a specific calling convention to avoid issues where we are being called from a project with a different default calling convention.  For windows you have 3 define options:

CJSON_HIDE_SYMBOLS - Define this in the case where you don't want to ever dllexport symbols
CJSON_EXPORT_SYMBOLS - Define this on library build when you want to dllexport symbols (default)
CJSON_IMPORT_SYMBOLS - Define this if you want to dllimport symbol

For *nix builds that support visibility attribute, you can define similar behavior by

setting default visibility to hidden by adding
-fvisibility=hidden (for gcc)
or
-xldscope=hidden (for sun cc)
to CFLAGS

then using the CJSON_API_VISIBILITY flag to "export" the same symbols the way CJSON_EXPORT_SYMBOLS does

*/

#define CJSON_CDECL __cdecl
#define CJSON_STDCALL __stdcall

/* export symbols by default, this is necessary for copy pasting the C and header file */
#if !defined(CJSON_HIDE_SYMBOLS) && !defined(CJSON_IMPORT_SYMBOLS) && !defined(CJSON_EXPORT_SYMBOLS)
#define CJSON_EXPORT_SYMBOLS
#endif

#if defined(CJSON_HIDE_SYMBOLS)
#define CJSON_PUBLIC(type)   type CJSON_STDCALL
#elif defined(CJSON_EXPORT_SYMBOLS)
#define CJSON_PUBLIC(type)   __declspec(dllexport) type CJSON_STDCALL
#elif defined(CJSON_IMPORT_SYMBOLS)
#define CJSON_PUBLIC(type)   __declspec(dllimport) type CJSON_STDCALL
#endif
#else /* !__WINDOWS__ */
#define CJSON_CDECL
#define CJSON_STDCALL

#if (defined(__GNUC__) || defined(__SUNPRO_CC) || defined (__SUNPRO_C)) && defined(CJSON_API_VISIBILITY)
#define CJSON_PUBLIC(type)   __attribute__((visibility("default"))) type
#else
#define CJSON_PUBLIC(type) type
#endif
#endif

/* project version */
#define CJSON_VERSION_MAJOR 1
#define CJSON_VERSION_MINOR 7
#define CJSON_VERSION_PATCH 12

#include <stddef.h>

/* cJSON Types: */
#define cJSON_Invalid (0)
#define cJSON_False  (1 << 0)
#define cJSON_True   (1 << 1)
#define cJSON_NULL   (1 << 2)
#define cJSON_Number (1 << 3)
#define cJSON_String (1 << 4)
#define cJSON_Array  (1 << 5)
#define cJSON_Object (1 << 6)
#define cJSON_Raw    (1 << 7) /* raw json */

#define cJSON_IsReference 256
#define cJSON_StringIsConst 512

/* The cJSON structure: */
typedef struct cJSON
{
    /* next/prev allow you to walk array/object chains. Alternatively, use GetArraySize/GetArrayItem/GetObjectItem */
    struct cJSON *next;
    struct cJSON *prev;
    /* An array or object item will have a child pointer pointing to a chain of the items in the array/object. */
    struct cJSON *child;

    /* The type of the item, as above. */
    int type;

    /* The item's string, if type==cJSON_String  and type == cJSON_Raw */
    char *valuestring;
    /* writing to valueint is DEPRECATED, use cJSON_SetNumberValue instead */
    int valueint;
    /* The item's number, if type==cJSON_Number */
    double valuedouble;

    /* The item's name string, if this item is the child of, or is in the list of subitems of an object. */
    char *string;
} cJSON;

typedef struct cJSON_Hooks
{
      /* malloc/free are CDECL on Windows regardless of the default calling convention of the compiler, so ensure the hooks allow passing those functions directly. */
      void *(CJSON_CDECL *malloc_fn)(size_t sz);
      void (CJSON_CDECL *free_fn)(void *ptr);
} cJSON_Hooks;

typedef int cJSON_bool;

/* Limits how deeply nested arrays/objects can be before cJSON rejects to parse them.
 * This is to prevent stack overflows. */
#ifndef CJSON_NESTING_LIMIT
#define CJSON_NESTING_LIMIT 1000
#endif

/* Precision of double variables comparison */
#ifndef CJSON_DOUBLE_PRECISION
#define CJSON_DOUBLE_PRECISION .0000000000000001
#endif

/* returns the version of cJSON as a string */
CJSON_PUBLIC(const char*) cJSON_Version(void);

/* Supply malloc, realloc and free functions to cJSON */
CJSON_PUBLIC(void) cJSON_InitHooks(cJSON_Hooks* hooks);

/* Memory Management: the caller is always responsible to free the results from all variants of cJSON_Parse (with cJSON_Delete) and cJSON_Print (with stdlib free, cJSON_Hooks.free_fn, or cJSON_free as appropriate). The exception is cJSON_PrintPreallocated, where the caller has full responsibility of the buffer. */
/* Supply a block of JSON, and this returns a cJSON object you can interrogate. */
CJSON_PUBLIC(cJSON *) cJSON_Parse(const char *value);
/* ParseWithOpts allows you to require (and check) that the JSON is null terminated, and to retrieve the pointer to the final byte parsed. */
/* If you supply a ptr in return_parse_end and parsing fails, then return_parse_end will contain a pointer to the error so will match cJSON_GetErrorPtr(). */
CJSON_PUBLIC(cJSON *) cJSON_ParseWithOpts(const char *value, const char **return_parse_end, cJSON_bool require_null_terminated);

/* Render a cJSON entity to text for transfer/storage. */
CJSON_PUBLIC(char *) cJSON_Print(const cJSON *item);
/* Render a cJSON entity to text for transfer/storage without any formatting. */
CJSON_PUBLIC(char *) cJSON_PrintUnformatted(const cJSON *item);
/* Render a cJSON entity to text using a buffered strategy. prebuffer is a guess at the final size. guessing well reduces reallocation. fmt=0 gives unformatted, =1 gives formatted */
CJSON_PUBLIC(char *) cJSON_PrintBuffered(const cJSON *item, int prebuffer, cJSON_bool fmt);
/* Render a cJSON entity to text using a buffer already allocated in memory with given length. Returns 1 on success and 0 on failure. */
/* NOTE: cJSON is not always 100% accurate in estimating how much memory it will use, so to be safe allocate 5 bytes more than you actually need */
CJSON_PUBLIC(cJSON_bool) cJSON_PrintPreallocated(cJSON *item, char *buffer, const int length, const cJSON_bool format);
/* Delete a cJSON entity and all subentities. */
CJSON_PUBLIC(void) cJSON_Delete(cJSON *item);

/* Returns the number of items in an array (or object). */
CJSON_PUBLIC(int) cJSON_GetArraySize(const cJSON *array);
/* Retrieve item number "index" from array "array". Returns NULL if unsuccessful. */
CJSON_PUBLIC(cJSON *) cJSON_GetArrayItem(const cJSON *array, int index);
/* Get item "string" from object. Case insensitive. */
CJSON_PUBLIC(cJSON *) cJSON_GetObjectItem(const cJSON * const object, const char * const string);
CJSON_PUBLIC(cJSON *) cJSON_GetObjectItemCaseSensitive(const cJSON * const object, const char * const string);
CJSON_PUBLIC(cJSON_bool) cJSON_HasObjectItem(const cJSON *object, const char *string);
/* For analysing failed parses. This returns a pointer to the parse error. You'll probably need to look a few chars back to make sense of it. Defined when cJSON_Parse() returns 0. 0 when cJSON_Parse() succeeds. */
CJSON_PUBLIC(const char *) cJSON_GetErrorPtr(void);

/* Check if the item is a string and return its valuestring */
CJSON_PUBLIC(char *) cJSON_GetStringValue(const cJSON * const item);

/* These functions check the type of an item */
CJSON_PUBLIC(cJSON_bool) cJSON_IsInvalid(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsFalse(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsTrue(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsBool(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsNull(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsNumber(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsString(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsArray(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsObject(const cJSON * const item);
CJSON_PUBLIC(cJSON_bool) cJSON_IsRaw(const cJSON * const item);

/* These calls create a cJSON item of the appropriate type. */
CJSON_PUBLIC(cJSON *) cJSON_CreateNull(void);
CJSON_PUBLIC(cJSON *) cJSON_CreateTrue(void);
CJSON_PUBLIC(cJSON *) cJSON_CreateFalse(void);
CJSON_PUBLIC(cJSON *) cJSON_CreateBool(cJSON_bool boolean);
CJSON_PUBLIC(cJSON *) cJSON_CreateNumber(double num);
CJSON_PUBLIC(cJSON *) cJSON_CreateString(const char *string);
/* raw json */
CJSON_PUBLIC(cJSON *) cJSON_CreateRaw(const char *raw);
CJSON_PUBLIC(cJSON *) cJSON_CreateArray(void);
CJSON_PUBLIC(cJSON *) cJSON_CreateObject(void);

/* Create a string where valuestring references a string so
 * it will not be freed by cJSON_Delete */
CJSON_PUBLIC(cJSON *) cJSON_CreateStringReference(const char *string);
/* Create an object/array that only references it's elements so
 * they will not be freed by cJSON_Delete */
CJSON_PUBLIC(cJSON *) cJSON_CreateObjectReference(const cJSON *child);
CJSON_PUBLIC(cJSON *) cJSON_CreateArrayReference(const cJSON *child);

/* These utilities create an Array of count items.
 * The parameter count cannot be greater than the number of elements in the number array, otherwise array access will be out of bounds.*/
CJSON_PUBLIC(cJSON *) cJSON_CreateIntArray(const int *numbers, int count);
CJSON_PUBLIC(cJSON *) cJSON_CreateFloatArray(const float *numbers, int count);
CJSON_PUBLIC(cJSON *) cJSON_CreateDoubleArray(const double *numbers, int count);
CJSON_PUBLIC(cJSON *) cJSON_CreateStringArray(const char *const *strings, int count);

/* Append item to the specified array/object. */
CJSON_PUBLIC(void) cJSON_AddItemToArray(cJSON *array, cJSON *item);
CJSON_PUBLIC(void) cJSON_AddItemToObject(cJSON *object, const char *string, cJSON *item);
/* Use this when string is definitely const (i.e. a literal, or as good as), and will definitely survive the cJSON object.
 * WARNING: When this function was used, make sure to always check that (item->type & cJSON_StringIsConst) is zero before
 * writing to `item->string` */
CJSON_PUBLIC(void) cJSON_AddItemToObjectCS(cJSON *object, const char *string, cJSON *item);
/* Append reference to item to the specified array/object. Use this when you want to add an existing cJSON to a new cJSON, but don't want to corrupt your existing cJSON. */
CJSON_PUBLIC(void) cJSON_AddItemReferenceToArray(cJSON *array, cJSON *item);
CJSON_PUBLIC(void) cJSON_AddItemReferenceToObject(cJSON *object, const char *string, cJSON *item);

/* Remove/Detach items from Arrays/Objects. */
CJSON_PUBLIC(cJSON *) cJSON_DetachItemViaPointer(cJSON *parent, cJSON * const item);
CJSON_PUBLIC(cJSON *) cJSON_DetachItemFromArray(cJSON *array, int which);
CJSON_PUBLIC(void) cJSON_DeleteItemFromArray(cJSON *array, int which);
CJSON_PUBLIC(cJSON *) cJSON_DetachItemFromObject(cJSON *object, const char *string);
CJSON_PUBLIC(cJSON *) cJSON_DetachItemFromObjectCaseSensitive(cJSON *object, const char *string);
CJSON_PUBLIC(void) cJSON_DeleteItemFromObject(cJSON *object, const char *string);
CJSON_PUBLIC(void) cJSON_DeleteItemFromObjectCaseSensitive(cJSON *object, const char *string);

/* Update array items. */
CJSON_PUBLIC(void) cJSON_InsertItemInArray(cJSON *array, int which, cJSON *newitem); /* Shifts pre-existing items to the right. */
CJSON_PUBLIC(cJSON_bool) cJSON_ReplaceItemViaPointer(cJSON * const parent, cJSON * const item, cJSON * replacement);
CJSON_PUBLIC(void) cJSON_ReplaceItemInArray(cJSON *array, int which, cJSON *newitem);
CJSON_PUBLIC(void) cJSON_ReplaceItemInObject(cJSON *object,const char *string,cJSON *newitem);
CJSON_PUBLIC(void) cJSON_ReplaceItemInObjectCaseSensitive(cJSON *object,const char *string,cJSON *newitem);

/* Duplicate a cJSON item */
CJSON_PUBLIC(cJSON *) cJSON_Duplicate(const cJSON *item, cJSON_bool recurse);
/* Duplicate will create a new, identical cJSON item to the one you pass, in new memory that will
 * need to be released. With recurse!=0, it will duplicate any children connected to the item.
 * The item->next and ->prev pointers are always zero on return from Duplicate. */
/* Recursively compare two cJSON items for equality. If either a or b is NULL or invalid, they will be considered unequal.
 * case_sensitive determines if object keys are treated case sensitive (1) or case insensitive (0) */
CJSON_PUBLIC(cJSON_bool) cJSON_Compare(const cJSON * const a, const cJSON * const b, const cJSON_bool case_sensitive);

/* Minify a strings, remove blank characters(such as ' ', '\t', '\r', '\n') from strings.
 * The input pointer json cannot point to a read-only address area, such as a string constant, 
 * but should point to a readable and writable adress area. */
CJSON_PUBLIC(void) cJSON_Minify(char *json);

/* Helper functions for creating and adding items to an object at the same time.
 * They return the added item or NULL on failure. */
CJSON_PUBLIC(cJSON*) cJSON_AddNullToObject(cJSON * const object, const char * const name);
CJSON_PUBLIC(cJSON*) cJSON_AddTrueToObject(cJSON * const object, const char * const name);
CJSON_PUBLIC(cJSON*) cJSON_AddFalseToObject(cJSON * const object, const char * const name);
CJSON_PUBLIC(cJSON*) cJSON_AddBoolToObject(cJSON * const object, const char * const name, const cJSON_bool boolean);
CJSON_PUBLIC(cJSON*) cJSON_AddNumberToObject(cJSON * const object, const char * const name, const double number);
CJSON_PUBLIC(cJSON*) cJSON_AddStringToObject(cJSON * const object, const char * const name, const char * const string);
CJSON_PUBLIC(cJSON*) cJSON_AddRawToObject(cJSON * const object, const char * const name, const char * const raw);
CJSON_PUBLIC(cJSON*) cJSON_AddObjectToObject(cJSON * const object, const char * const name);
CJSON_PUBLIC(cJSON*) cJSON_AddArrayToObject(cJSON * const object, const char * const name);

/* When assigning an integer value, it needs to be propagated to valuedouble too. */
#define cJSON_SetIntValue(object, number) ((object) ? (object)->valueint = (object)->valuedouble = (number) : (number))
/* helper for the cJSON_SetNumberValue macro */
CJSON_PUBLIC(double) cJSON_SetNumberHelper(cJSON *object, double number);
#define cJSON_SetNumberValue(object, number) ((object != NULL) ? cJSON_SetNumberHelper(object, (double)number) : (number))

/* Macro for iterating over an array or object */
#define cJSON_ArrayForEach(element, array) for(element = (array != NULL) ? (array)->child : NULL; element != NULL; element = element->next)

/* malloc/free objects using the malloc/free functions that have been set with cJSON_InitHooks */
CJSON_PUBLIC(void *) cJSON_malloc(size_t size);
CJSON_PUBLIC(void) cJSON_free(void *object);

#ifdef __cplusplus
}
#endif

#endif



================================================
FILE: samples/fficjson/third_party/cjson_library/CMakeLists.txt
================================================
cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(cjson_library VERSION 1.0.0 LANGUAGES C)
add_library(cjson_library SHARED cJSON.c)

set_target_properties(cjson_library PROPERTIES
    PUBLIC_HEADER cJSON.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "cjson"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)



================================================
FILE: samples/fficjson/third_party/cjson_library/license.txt
================================================
Copyright (c) 2009-2017 Dave Gamble and cJSON contributors

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.


Files generated from cJSON source code are
- example/c_json/cjson_generated_bindings.dart
- test/large_integration_tests/_expected_cjson_bindings.dart



================================================
FILE: samples/first_flutter_app_codelabs/README.md
================================================
# Description

  An example for [Flutter Codelab First](https://codelabs.developers.google.com/codelabs/flutter-codelab-first)

# How to run

- Before running Clojure flutter, this demo needs to install the flutter dependencies with:

```bash
clj -M:cljd init
```

- And:

```bash
flutter pub add english_words
```

and after these two processes, you can do

```bash
clj -M:cljd flutter
```




================================================
FILE: samples/first_flutter_app_codelabs/deps.edn
================================================
{:paths ["src"]
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m"
                              "cljd.build"]}}
 :cljd/opts {:kind :flutter
             :main sample.first-flutter-app-codelabs}}



================================================
FILE: samples/first_flutter_app_codelabs/src/sample/first_flutter_app_codelabs.cljd
================================================
(ns sample.first-flutter-app-codelabs
  (:require
    ["package:flutter/material.dart" :as m]
    ["package:english_words/english_words.dart" :as english]
    [cljd.flutter :as f]))

(def random-pair-fn english/WordPair.random)

(defonce app-state
  (atom {:pair (random-pair-fn)
         :favorites #{}
         :selected-index 0}))

(defn big-card [^english/WordPair pair]
  (f/widget
    :get {{{:flds [primary onPrimary]} .-colorScheme
           {:flds [displayMedium]} .-textTheme} m/Theme}
    (m/Card .color primary)
    (m/Padding .padding (m/EdgeInsets.all 20))
    (m/Text (.-asLowerCase pair)
            .style (.copyWith displayMedium .color onPrimary)
            .semanticsLabel (.-asPascalCase pair))))

(def generator-page
  (f/widget
    :watch [{:keys [pair
                    favorites]} app-state]
    :let [icon (if (favorites pair)
                 m/Icons.favorite
                 m/Icons.favorite_border)]
    m/Center
    (m/Column .mainAxisAlignment m/MainAxisAlignment.center)
    .children
    [(big-card pair)
     (m/SizedBox .height 10)
     (m/Row
       .mainAxisSize m/MainAxisSize.min
       .children [(m/ElevatedButton.icon
                    .onPressed (fn [] (swap! app-state update :favorites #((if (% pair) disj conj) % pair)))
                    .icon (m/Icon icon)
                    .label (m/Text "Like"))
                  (m/SizedBox .width 10)
                  (f/widget
                    (m/ElevatedButton .onPressed #(swap! app-state assoc :pair (random-pair-fn)))
                    (m/Text "Next"))])]))

(def favorites-page
  (f/widget
    :watch [{:keys [favorites]} app-state]
    :get {{{:flds [primary]} .-colorScheme
           {:flds [displaySmall]} .-textTheme} m/Theme}
    :let [fav-count (count favorites)]
    (if (zero? fav-count)
      (m/Center
        .child (m/Text "No favorites yet!"
                       .style (m/TextStyle .color primary)))
      (m/ListView
        .children
        (into [(f/widget
                 (m/Padding .padding (m/EdgeInsets.all 20))
                 (m/Text (str "You have " fav-count " favorites")
                         .style (m/TextStyle .color primary)))]
              (map #(m/ListTile
                      .leading (m/Icon m/Icons.favorite
                                           .color primary)
                      .title (m/Text (.-asLowerCase ^english/WordPair %)
                                     .style (m/TextStyle .color primary))))
              favorites)))))

(defn lateral-bar
  [constraints]
  (f/widget
    :get {{{:flds [onPrimaryContainer]} .-colorScheme} m/Theme}
    :watch [{:keys [selected-index]} app-state]
    m/Row
    .children
    [(f/widget
       m/SafeArea
       (m/NavigationRail
         .selectedIndex selected-index
         .extended (>= (.-maxWidth ^m/BoxConstraints constraints) 600)
         .onDestinationSelected #(swap! app-state assoc :selected-index %))
       .destinations [(m/NavigationRailDestination
                        .icon (m/Icon m/Icons.home)
                        .label (m/Text "Home"))
                      (m/NavigationRailDestination
                        .icon (m/Icon m/Icons.favorite)
                        .label (m/Text "Favorites"))])
     (f/widget
       m/Expanded
       (m/Container .color onPrimaryContainer)
       (case selected-index
                 0 generator-page
                 1 favorites-page))]))

(defn main []
  (f/run
    (m/MaterialApp
      .title "My first material app"
      .theme (m/ThemeData
               .useMaterial3 true
               .colorScheme (m/ColorScheme.fromSeed
                              .seedColor m/Colors.deepOrange)))
    .home (m/Scaffold)
    .body (m/LayoutBuilder
            .builder
            (f/build [constraints]
                     (lateral-bar constraints)))))



================================================
FILE: samples/fizzbuzz/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
  :deps {org.clojure/clojure {:mvn/version "1.10.1"}
         tensegritics/clojuredart {:local/root "../../"}}
  :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
  :cljd/opts {:main sample.fizzbuzz
              :kind :flutter}}



================================================
FILE: samples/fizzbuzz/src/sample/fizzbuzz.cljd
================================================
(ns sample.fizzbuzz
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(def ^m/TextStyle text-style (m/TextStyle .fontWeight m/FontWeight.w700 .fontSize 32))

(defn main []
  (f/run
    (m/MaterialApp .title "Fizz buzz Demo")
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Fizz buzz Demo")))
    .body
    :let [s1 (-> (Stream/periodic (Duration .seconds 1) identity) .asBroadcastStream)
          s3 (Stream/periodic (Duration .seconds 3) #(* 3 (inc %)))
          s5 (Stream/periodic (Duration .seconds 5) #(* 5 (inc %)))]
    (m/Column .mainAxisAlignment m/MainAxisAlignment.center .crossAxisAlignment m/CrossAxisAlignment.stretch)
    .children
    [(f/widget
       :watch [n s1
               :default 0]
       (m/Text (str n) .textAlign m/TextAlign.center .style text-style))
     (f/widget
       :watch [n (f/sub [s1 s3] (fn [[n n3]] (if (= n n3) "Fizz" " ")))
               :default " "]
       (m/Text n .textAlign m/TextAlign.center .style (.apply text-style .color m/Colors.red.shade200)))
     (f/widget
       :watch [n (f/sub [s1 s5] (fn [[n n5]] (if (= n n5) "Buzz" " ")))
               :default " "]
       (m/Text n .textAlign m/TextAlign.center .style (.apply text-style .color m/Colors.green.shade200)))]))



================================================
FILE: samples/form_handle_change_textfield/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.form
             :kind :flutter}}



================================================
FILE: samples/form_handle_change_textfield/src/sample/form.cljd
================================================
(ns sample.form
  "Faithful port of https://docs.flutter.dev/cookbook/forms/text-field-changes"
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn main []
  (let [title "Retrieve text input"]
    (m/runApp
      (f/widget
        (m/MaterialApp .title title)
        .home
        (m/Scaffold .appBar (m/AppBar .title (m/Text title)))
        .body
        (m/Padding .padding (m/EdgeInsets.all 16.0))
        :managed [text-controller (m/TextEditingController)]
        :bg-watcher ([^m/TextEditingValue {second-input-text .-text} text-controller ]
                     (dart:core/print (str "Second text field: " second-input-text)))
        m/Column
        .children
        [(m/TextField .onChanged (fn [text] (dart:core/print (str "First text field: " text))))
         (m/TextField .controller text-controller)]))))



================================================
FILE: samples/form_retrieve_input/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.form
             :kind :flutter}}



================================================
FILE: samples/form_retrieve_input/src/sample/form.cljd
================================================
(ns sample.form
  "Faithful port of https://docs.flutter.dev/cookbook/forms/retrieve-input"
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn my-custom-form-state [title]
  (f/widget
    :context ctx
    :managed [tc (m/TextEditingController)]
    (m/Scaffold
      .appBar (m/AppBar .title (m/Text title))
      .body
      (m/Padding. .padding (m/EdgeInsets.all 16.0)
        .child (m/TextField .controller tc))
      .floatingActionButton
      (m/FloatingActionButton
        .onPressed (fn []
                     (m/showDialog
                       .context ctx
                       .builder
                       (f/build
                         :let [{:flds [text]} tc]
                         (m/AlertDialog .content (m/Text text)))) nil)
        .tooltip "Show me the value!"
        .child (m/Icon m/Icons.text_fields)))))

(defn main []
  (let [title "Retrieve text input"]
    (m/runApp
      (m/MaterialApp
        .title title
        .home (my-custom-form-state title)))))



================================================
FILE: samples/form_validate/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.form
             :kind :flutter}}



================================================
FILE: samples/form_validate/src/sample/form.cljd
================================================
(ns sample.form
  "Faithful port of https://docs.flutter.dev/cookbook/forms/validation"
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]
            [cljd.string :as str]))

(def my-custom-form
  (let [form-key (#/(m/GlobalKey m/FormState))]
    (f/widget
     :get [m/ScaffoldMessenger]
     (m/Form .key form-key)
     (m/Column .crossAxisAlignment m/CrossAxisAlignment.start)
     .children
     [(m/TextFormField
       .validator (fn [value] (when (str/blank? value) "Please enter some text")))
      (m/Padding .padding (m/EdgeInsets.symmetric .vertical 16.0))
      (m/ElevatedButton
       .onPressed #(when (.validate (.-currentState form-key))
                     (.showSnackBar scaffold-messenger (m/SnackBar .content (m/Text "Processing Data")))
                     nil)
       .child (m/Text "Submit"))])))

(defn main []
  (let [title "Form Validation Demo"]
    (f/run
     (m/MaterialApp
      .title title
      .home (m/Scaffold
             .appBar (m/AppBar .title (m/Text title))
             .body my-custom-form)))))



================================================
FILE: samples/gesture_detector/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.gesture-detector
             :kind :flutter}}



================================================
FILE: samples/gesture_detector/src/sample/gesture_detector.cljd
================================================
(ns sample.gesture-detector
  (:require
   ["package:flutter/gestures.dart" :as g]
   ["package:flutter/material.dart" :as m]
   ["package:vector_math/vector_math_64.dart" :as vm]
   [cljd.flutter :as f]))

(def radius 25)

(defn inside-parallelogram
  [[^m/Offset o ^m/Offset a ^m/Offset b] ^m/Offset mouse-pos]
  (let [oa (.- a o)
        ob (.- b o)
        m (doto
           (vm/Matrix3 (.-dx oa) (.-dy oa) 0
                       (.-dx ob) (.-dy ob) 0
                       (.-dx o)  (.-dy o)  1)
           .invert)
        p-1 (.transform m (vm/Vector3 (.-dx mouse-pos) (.-dy mouse-pos) 1))]
    (when (and (<= 0 (.-x p-1) 1) (<= 0 (.-y p-1) 1))
      (.- mouse-pos o))))

(defn move-to
  [[^m/Offset o ^m/Offset a ^m/Offset b] ^m/Offset o']
  (let [oo' (.- o' o)]
    [o' (.+ a oo') (.+ b oo')]))

(def gesture-parallelogram
  (f/widget
    :let [app-state (atom {:vertices [(m/Offset 150 150) (m/Offset 250 150) (m/Offset 150 350)]
                           :delta nil :dragged nil})]
    :watch [as app-state]
    (m/GestureDetector
      .onPanStart
      (fn [{local-pos .-localPosition :as ^g/DragStartDetails details}]
        (let [{:keys [vertices]} as
              pointer local-pos
              [[id delta]]
              (concat
                (for [[i vertex] (map-indexed vector vertices)
                      :let [delta (.- pointer vertex)]
                      :when (< (.-distance delta) radius)]
                  [i delta])
                (when-some [delta (inside-parallelogram vertices pointer)]
                  [[:parallelogram delta]]))]
          (swap! app-state assoc :dragged id :delta delta)))
      .onPanUpdate
      (fn [^g/DragUpdateDetails details]
        (let [{:keys [dragged delta]} as
              new-pos (when dragged (.- (.-localPosition details) delta))]
          (cond
            (= dragged :parallelogram)
            (swap! app-state update :vertices move-to new-pos)
            (int? dragged)
            (swap! app-state assoc-in [:vertices dragged] new-pos)))))
    (m/CustomPaint
      .size (m/Size double/infinity double/infinity)
      .painter
      (reify :extends m/CustomPainter
        (paint [this canvas size]
          (let [[^m/Offset o ^m/Offset a ^m/Offset b] (:vertices as)
                c (.- (.+ b a) o)
                paint (doto (m/Paint)
                        (-> .-color (set! m/Colors.grey))
                        (-> .-style (set! m/PaintingStyle.fill)))]
            (doto canvas
              (.drawLine o a paint)
              (.drawLine o b paint)
              (.drawLine b c paint)
              (.drawLine a c paint)
              (.drawCircle o radius paint)
              (.drawCircle a radius paint)
              (.drawCircle b radius paint))
            nil))
        (shouldRepaint [this _] true)))))

(defn main []
  (m/runApp
   (m/MaterialApp .title "Gesture Demo App"
                  .home (m/Scaffold .body gesture-parallelogram))))



================================================
FILE: samples/go_router/README.md
================================================
# Run the `go_router` sample:

1. `clj -M:cljd init`
2. `flutter pub add go_router`
3. `clj -M:cljd flutter` (considering you already have a simulator opened)



================================================
FILE: samples/go_router/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.gorouter
             :kind :flutter}}



================================================
FILE: samples/go_router/src/sample/gorouter.cljd
================================================
(ns sample.gorouter
  ;; how to use https://pub.dev/packages/webview_flutter
  (:require
   ["package:flutter/material.dart" :as m]
   ["package:go_router/go_router.dart" :as go_router]
   [cljd.flutter :as f]))


(def theme
  (m/ThemeData
    .colorSchemeSeed m/Colors.yellow
    .useMaterial3 true
    .textTheme (m/TextTheme
                 .displayLarge (m/TextStyle
                                 .fontWeight m/FontWeight.w700
                                 .fontSize 24
                                 .color m/Colors.black))))

(def ^m/Widget home-screen
  (f/build [^go_router/GoRouterState router-state]
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Home screen")))
    .body
    m/Center
    :context ctx
    (m/ElevatedButton .onPressed #(-> ctx go_router/GoRouterHelper (.go "/details")))
    (m/Text "Go to the details screen")))

(def ^m/Widget details-screen
  (f/build [^go_router/GoRouterState router-state]
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Details screen")))
    .body
    m/Center
    :context ctx
    (m/ElevatedButton .onPressed #(-> ctx go_router/GoRouterHelper (.go "/")))
    (m/Text "Go to the home screen")))

(def router
  (go_router/GoRouter
    .initialLocation "/"
    .routes [(go_router/GoRoute
               .path "/"
               .builder home-screen)
             (go_router/GoRoute
               .path "/details"
               .builder details-screen)]))

(defn main []
  (f/run
    (m/MaterialApp.router .routerConfig router)))



================================================
FILE: samples/gridlist/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.gridlist
             :kind :flutter}}



================================================
FILE: samples/gridlist/src/sample/gridlist.cljd
================================================
(ns sample.gridlist
  "Faithful port of https://docs.flutter.dev/cookbook/lists/grid-lists"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn main []
  (let [title "Grid List"]
    (m/runApp
     (f/widget
      (m/MaterialApp .title title)
      .home
      (m/Scaffold .appBar (m/AppBar .title (m/Text title)))
      .body
      :get {{{:flds [headline3]} .-textTheme} m/Theme}
      (m/GridView.count .crossAxisCount 2)
      .children
      (for [i (range 100)]
        (m/Center .child (m/Text (str "Item " i) .style headline3)))))))



================================================
FILE: samples/hero_animations/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.hero-animations
             :kind :flutter}}



================================================
FILE: samples/hero_animations/src/sample/hero_animations.cljd
================================================
(ns sample.hero-animations
  "Faithful port of https://docs.flutter.dev/cookbook/navigation/hero-animations"
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(def detail-screen
  (m/Scaffold
    .body
    (f/widget
      :get [m/Navigator]
      (m/GestureDetector .onTap #(.pop navigator))
      m/Center
      (m/Hero .tag "imageHero")
      (m/Image.network "https://picsum.photos/250?image=9"))))

(def main-screen
  (m/Scaffold
    .appBar (m/AppBar .title (m/Text "Main Screen"))
    .body
    (f/widget :get [m/Navigator]
      (m/GestureDetector
        .onTap (fn []
                 (.push navigator (#/(m/MaterialPageRoute Object)
                                    .builder (f/build detail-screen)))
                 nil))
      (m/Hero .tag "imageHero")
      (m/Image.network "https://picsum.photos/250?image=9"))))

(defn main
  []
  (m/runApp
   (m/MaterialApp
    .home main-screen
    .debugShowCheckedModeBanner false)))



================================================
FILE: samples/isolates/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.isolates
             :kind :flutter}}



================================================
FILE: samples/isolates/src/sample/isolates.cljd
================================================
(ns sample.isolates
  "Isolate example, original code by Ian Fernandez (https://github.com/ianffcs)"
  (:require ["package:flutter/material.dart" :as m]
            ["dart:isolate" :as dart:isolate]
            [cljd.flutter :as f]
            [cljd.dart.isolates :as di]))

(def isolate-ui
  (f/widget
    m/Center
    (m/Column
      .mainAxisAlignment m/MainAxisAlignment.center
      .children
      [(f/widget
         (m/FilledButton .onPressed (fn [] (dotimes [_ (* 1000 1000 1000 10)])))
         (m/Text "Busy loop on default isolate (will block ui)"))

       (f/widget
         :padding {:top 8 :bottom 32}
         :watch [isolate-out (atom nil) :as running
                 ; here we can cascade `:watch` because `reset!` value is a `ReceivePort` which implements `Stream`
                 status isolate-out :default (when isolate-out :running)]
         (m/FilledButton
           .onPressed (case status
                        (nil :done)
                        (fn []
                          (let [{{:keys [out]} :ports}
                                (await
                                  (di/spawn! (fn [{:keys [in out]}]
                                               (dotimes [_ (* 1000 1000 1000 10)])
                                               (.send ^dart:isolate/SendPort out :done)
                                               (dart:core/print "done"))))]
                            (reset! running out)
                            nil))
                        ; nil disables the button
                        :running nil))
         (m/Text "Busy loop on new isolate (won't block ui)"))

       (m/Text "If the spinner stops, the UI is frozen")

       (f/widget
         :padding {:top 8}
         (m/CircularProgressIndicator))])))

(defn main []
  (f/run
    (m/MaterialApp
      .title "Isolates 101"
      .theme (m/ThemeData .useMaterial3 true))
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Isolates 101")))
    .body isolate-ui))



================================================
FILE: samples/keep_alive/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.keep-alive
             :kind :flutter}}



================================================
FILE: samples/keep_alive/src/sample/keep_alive.cljd
================================================
(ns sample.keep-alive
  (:require ["package:flutter/material.dart" :as m]
            [cljd.flutter :as f]))

(defn main []
  (f/run
    m/MaterialApp
    .home
    m/Scaffold
    .body
    (m/ListView.builder
      .itemCount 100
      .itemBuilder
      (f/build [idx]
        :key idx
        :height 80
        :let [kept-alive (odd? idx)]
        :color (cond
                 (zero? idx) m/Colors.white
                 kept-alive m/Colors.red.shade200
                 :else m/Colors.blue.shade200)
        :keep-alive kept-alive
        :let [now (DateTime.now)]
        m/Center
        (m/Text
          (if (zero? idx)
            "Scroll back and forth and you should see ephemeral items being rebuilt while kept-alive items are reused."
            (print-str idx
              (if kept-alive
                "KEPT ALIVE"
                "EPHEMERAL")
              " rebuilt at: "
              (.-hour now) "h"
              (.-minute now) "m"
              (.-second now) "s"))
          .style (m/TextStyle .fontSize 18 .fontWeight m/FontWeight.w700)
          .textAlign m/TextAlign.center)))))



================================================
FILE: samples/navigate_named_routes/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.navigate-named-routes
             :kind :flutter}}



================================================
FILE: samples/navigate_named_routes/src/sample/navigate_named_routes.cljd
================================================
(ns sample.navigate-named-routes
  "Port of https://docs.flutter.dev/cookbook/navigation/named-routes.html"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn ^m/Widget first-screen
  [ctx]
  (f/widget
    :get [m/Navigator]
    (m/Scaffold
       .appBar (m/AppBar
                .title (m/Text "First Screen"))
       .body   (m/Center
                .child (m/ElevatedButton
                            .onPressed #(do
                                          (.pushNamed navigator "/second")
                                          nil)
                            .child     (m/Text "Launch Screen"))))))


(defn ^m/Widget second-screen
  [ctx]
  (f/widget
    :get [m/Navigator]
    (m/Scaffold
       .appBar (m/AppBar
                .title (m/Text "Second Screen"))
       .body   (m/Center
                .child (m/ElevatedButton
                            .onPressed #(.pop navigator)
                            .child     (m/Text "Go Back!"))))))

(defn main []
  (m/runApp
   (m/MaterialApp
    .title "Navigation Basics"
    .initialRoute "/"
    .routes {"/"       first-screen
             "/second" second-screen})))



================================================
FILE: samples/navigation/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.navigation
             :kind :flutter}}



================================================
FILE: samples/navigation/src/sample/navigation.cljd
================================================
(ns sample.navigation
  "Port of https://docs.flutter.dev/cookbook/navigation/navigation-basics"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(def second-route
  (m/Scaffold
    .appBar (m/AppBar .title (m/Text "Second Route"))
    .body
    (f/widget
      :get [m/Navigator]
      m/Center
      (m/ElevatedButton .onPressed #(.pop navigator))
      (m/Text "Go back!"))))

(def first-route
  (m/Scaffold
    .appBar (m/AppBar .title (m/Text "First Route"))
    .body
    (f/widget
      :get [m/Navigator]
      m/Center
      (m/ElevatedButton
        .onPressed #(do
                      (.push navigator (#/(m/MaterialPageRoute Object) .builder (f/build second-route)))
                      nil))
      (m/Text "Open route"))))

(defn main []
  (m/runApp
   (m/MaterialApp
    .title "Navigation Basics"
    .home first-route)))



================================================
FILE: samples/physics_simulation/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.physics-sim
             :kind :flutter}}



================================================
FILE: samples/physics_simulation/src/sample/physics_sim.cljd
================================================
(ns sample.physics-sim
  "Port of https://docs.flutter.dev/cookbook/animation/physics-simulation#interactive-example"
  (:require
   ["package:flutter/material.dart" :as m]
   ["package:flutter/physics.dart" :as p]
   [cljd.flutter :as f]))

(defn draggable-card [& {:keys [child]}]
  (f/widget
   :get [m/MediaQuery]
   :vsync vsync
   :managed [animator (m/AnimationController .vsync vsync)]
   :let [state (atom {:alignment m/Alignment.center})]
   :watch [{:keys [alignment animation]} state]
   :bg-watcher ([animated-alignment animation]
                (swap! state assoc :alignment animated-alignment))
   :let [{:flds [width height]} (.-size media-query)
         run-animation
         (fn [^m/Offset {:flds [dx dy]}]
           (let [unit-velocity (.-distance (m/Offset (/ dx width) (/ dy height)))
                 spring (p/SpringDescription .mass 30 .stiffness 1 .damping 1)
                 simulation (p/SpringSimulation spring 0 1 (- unit-velocity))]
             (swap! state assoc :animation
               (.drive animator
                 (m/AlignmentTween .begin alignment .end m/Alignment.center)))
             (.animateWith animator simulation)))]
   (m/GestureDetector
     .onPanDown (fn [_]
                  (.stop animator)
                  (when animation
                    (swap! state dissoc :animation))
                  nil)
     .onPanUpdate (fn [^m/DragUpdateDetails {{:flds [dx dy]} .-localPosition}]
                    (swap! state assoc :alignment
                      (m/Alignment (- (* 2 (/ dx width)) 1) (- (* 2 (/ dy height)) 1)))
                    nil)
     .onPanEnd (fn [^m/DragEndDetails details]
                 (run-animation (-> details .-velocity .-pixelsPerSecond))
                 nil))
   (m/Align .alignment alignment)
   m/Card
   child))

(def physics-card-demo
  (m/Scaffold
    .appBar (m/AppBar)
    .body (draggable-card :child (m/FlutterLogo .size 128))))

(defn main []
  (m/runApp (m/MaterialApp .home physics-card-demo)))



================================================
FILE: samples/platform_view/cljd_platform_view.iml
================================================
<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output />
    <content url="file://$MODULE_DIR$">
      <sourceFolder url="file://$MODULE_DIR$/lib" isTestSource="false" />
      <sourceFolder url="file://$MODULE_DIR$/test" isTestSource="true" />
      <excludeFolder url="file://$MODULE_DIR$/.dart_tool" />
      <excludeFolder url="file://$MODULE_DIR$/.idea" />
      <excludeFolder url="file://$MODULE_DIR$/build" />
    </content>
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="Dart SDK" level="project" />
    <orderEntry type="library" name="Flutter Plugins" level="project" />
    <orderEntry type="library" name="Dart Packages" level="project" />
  </component>
</module>



================================================
FILE: samples/platform_view/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.platform-view
             :kind :flutter}}



================================================
FILE: samples/platform_view/ios/Flutter/AppFrameworkInfo.plist
================================================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>App</string>
  <key>CFBundleIdentifier</key>
  <string>io.flutter.flutter.app</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>App</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleSignature</key>
  <string>????</string>
  <key>CFBundleVersion</key>
  <string>1.0</string>
  <key>MinimumOSVersion</key>
  <string>12.0</string>
</dict>
</plist>



================================================
FILE: samples/platform_view/ios/Flutter/Debug.xcconfig
================================================
#include "Generated.xcconfig"



================================================
FILE: samples/platform_view/ios/Flutter/Release.xcconfig
================================================
#include "Generated.xcconfig"



================================================
FILE: samples/platform_view/ios/Runner/AppDelegate.swift
================================================
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        weak var registrar = self.registrar(forPlugin: "clojuredart_plugin")

        let factory = FLNativeViewFactory(messenger: registrar!.messenger())

        registrar!.register(
          factory,
          withId: "clojuredart_component")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}



================================================
FILE: samples/platform_view/ios/Runner/FLNativeViewFactory.swift
================================================
import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
    
    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    
    private var _view: UIView
    private var _methodChannel: FlutterMethodChannel
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        _methodChannel = FlutterMethodChannel(name: "method_channel_cljd_pasted", binaryMessenger: messenger!)
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "<3 from ClojureDart native UIView"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
    }
}



================================================
FILE: samples/platform_view/ios/Runner/Info.plist
================================================
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleDisplayName</key>
	<string>Cljd Platform View</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>cljd_platform_view</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$(FLUTTER_BUILD_NAME)</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>$(FLUTTER_BUILD_NUMBER)</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
</dict>
</plist>



================================================
FILE: samples/platform_view/ios/Runner/Runner-Bridging-Header.h
================================================
#import "GeneratedPluginRegistrant.h"



================================================
FILE: samples/platform_view/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
================================================
{
  "images" : [
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "Icon-App-20x20@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "20x20",
      "idiom" : "iphone",
      "filename" : "Icon-App-20x20@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "Icon-App-29x29@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "Icon-App-29x29@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "iphone",
      "filename" : "Icon-App-29x29@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "Icon-App-40x40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "iphone",
      "filename" : "Icon-App-40x40@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "Icon-App-60x60@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "60x60",
      "idiom" : "iphone",
      "filename" : "Icon-App-60x60@3x.png",
      "scale" : "3x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "Icon-App-20x20@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "20x20",
      "idiom" : "ipad",
      "filename" : "Icon-App-20x20@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "Icon-App-29x29@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "29x29",
      "idiom" : "ipad",
      "filename" : "Icon-App-29x29@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "Icon-App-40x40@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "40x40",
      "idiom" : "ipad",
      "filename" : "Icon-App-40x40@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "Icon-App-76x76@1x.png",
      "scale" : "1x"
    },
    {
      "size" : "76x76",
      "idiom" : "ipad",
      "filename" : "Icon-App-76x76@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "83.5x83.5",
      "idiom" : "ipad",
      "filename" : "Icon-App-83.5x83.5@2x.png",
      "scale" : "2x"
    },
    {
      "size" : "1024x1024",
      "idiom" : "ios-marketing",
      "filename" : "Icon-App-1024x1024@1x.png",
      "scale" : "1x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}



================================================
FILE: samples/platform_view/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
================================================
# Launch Screen Assets

You can customize the launch screen with your own desired assets by replacing the image files in this directory.

You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.


================================================
FILE: samples/platform_view/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
================================================
{
  "images" : [
    {
      "idiom" : "universal",
      "filename" : "LaunchImage.png",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "filename" : "LaunchImage@2x.png",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "filename" : "LaunchImage@3x.png",
      "scale" : "3x"
    }
  ],
  "info" : {
    "version" : 1,
    "author" : "xcode"
  }
}



================================================
FILE: samples/platform_view/ios/Runner/Base.lproj/LaunchScreen.storyboard
================================================
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="12121" systemVersion="16G29" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" launchScreen="YES" colorMatched="YES" initialViewController="01J-lp-oVM">
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12089"/>
    </dependencies>
    <scenes>
        <!--View Controller-->
        <scene sceneID="EHf-IW-A2E">
            <objects>
                <viewController id="01J-lp-oVM" sceneMemberID="viewController">
                    <layoutGuides>
                        <viewControllerLayoutGuide type="top" id="Ydg-fD-yQy"/>
                        <viewControllerLayoutGuide type="bottom" id="xbc-2k-c8Z"/>
                    </layoutGuides>
                    <view key="view" contentMode="scaleToFill" id="Ze5-6b-2t3">
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <subviews>
                            <imageView opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" image="LaunchImage" translatesAutoresizingMaskIntoConstraints="NO" id="YRO-k0-Ey4">
                            </imageView>
                        </subviews>
                        <color key="backgroundColor" red="1" green="1" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
                        <constraints>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="centerX" secondItem="Ze5-6b-2t3" secondAttribute="centerX" id="1a2-6s-vTC"/>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="centerY" secondItem="Ze5-6b-2t3" secondAttribute="centerY" id="4X2-HB-R7a"/>
                        </constraints>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="iYj-Kq-Ea1" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="53" y="375"/>
        </scene>
    </scenes>
    <resources>
        <image name="LaunchImage" width="168" height="185"/>
    </resources>
</document>



================================================
FILE: samples/platform_view/ios/Runner/Base.lproj/Main.storyboard
================================================
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="10117" systemVersion="15F34" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" initialViewController="BYZ-38-t0r">
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="10085"/>
    </dependencies>
    <scenes>
        <!--Flutter View Controller-->
        <scene sceneID="tne-QT-ifu">
            <objects>
                <viewController id="BYZ-38-t0r" customClass="FlutterViewController" sceneMemberID="viewController">
                    <layoutGuides>
                        <viewControllerLayoutGuide type="top" id="y3c-jy-aDJ"/>
                        <viewControllerLayoutGuide type="bottom" id="wfy-db-euE"/>
                    </layoutGuides>
                    <view key="view" contentMode="scaleToFill" id="8bC-Xf-vdC">
                        <rect key="frame" x="0.0" y="0.0" width="600" height="600"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite"/>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="dkx-z0-nzr" sceneMemberID="firstResponder"/>
            </objects>
        </scene>
    </scenes>
</document>



================================================
FILE: samples/platform_view/ios/RunnerTests/RunnerTests.swift
================================================
import Flutter
import UIKit
import XCTest

class RunnerTests: XCTestCase {

  func testExample() {
    // If you add code to the Runner application, consider adding tests here.
    // See https://developer.apple.com/documentation/xctest for more information about using XCTest.
  }

}



================================================
FILE: samples/platform_view/src/sample/platform_view.cljd
================================================
(ns sample.platform-view
  (:require
   ["package:flutter/foundation.dart" :as foundation]
   ["package:flutter/rendering.dart" :as rendering]
   ["package:flutter/services.dart" :as services]
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))


(defn main
  []
  (f/run
    (m/MaterialApp
      .debugShowCheckedModeBanner false
      .theme (m/ThemeData .useMaterial3 true))
    .home
    m/Scaffold
    .body
    m/Center
    :height 200
    (m/UiKitView
      .viewType "clojuredart_component"
      .layoutDirection m/TextDirection.ltr,
      .creationParams {}
      .creationParamsCodec (services/StandardMessageCodec),
      .hitTestBehavior rendering/PlatformViewHitTestBehavior.translucent)))



================================================
FILE: samples/scoped_watch/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.scoped-watch
             :kind :flutter}}



================================================
FILE: samples/scoped_watch/src/sample/scoped_watch.cljd
================================================
(ns sample.scoped-watch
  "Scoped watch demo"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn main []
  (let [flip (atom false)]
    (f/run
      (m/MaterialApp
        .title "Cljd Demo"
        .theme (m/ThemeData .primarySwatch m/Colors.blue))
      .home
      (m/Scaffold
        .appBar (m/AppBar .title (m/Text "ClojureDart Home Page"))
        .floatingActionButton
        (f/widget
          (m/FloatingActionButton
            .onPressed #(swap! flip not)
            .tooltip "Flip color")
          (m/Icon m/Icons.add)))
      .body
      m/Row
      .children
      [(f/widget
         m/Expanded
         :watch [is-flipped flip]
         :color (if is-flipped m/Colors.blue m/Colors.green)
         m/Center
         :let [_ (prn 'flat)]
         (m/Text "I shouldn't rebuild when flip changes"))
       (f/widget
         m/Expanded
         (f/widget
           :watch [is-flipped flip]
           :color (if is-flipped m/Colors.blue m/Colors.green))
         m/Center
         :let [_ (prn 'scoped)]
         (m/Text "I shouldn't rebuild when flip changes"))])))



================================================
FILE: samples/shopper/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.shopper
             :kind :flutter}}



================================================
FILE: samples/shopper/src/sample/shopper.cljd
================================================
(ns sample.shopper
  "Faithful port of https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defonce app-state (atom {:catalog [{:title "pain" :price 1 :color m/Colors.yellow}
                                    {:title "chocolatine" :price 2 :color m/Colors.brown}
                                    {:title "miel" :price 3 :color m/Colors.purple}]}))



;; catalog page
(defn add-button [item]
  (f/widget
    :get {{primary-color .-primaryColor} m/Theme}
    :watch [added (f/$ (some-> (f/<! app-state) :cart (contains? item)))]
    (m/TextButton
      .onPressed (when-not added
                   (fn []
                     (swap! app-state update :cart (fnil conj #{}) item)))
      .style
      (m/ButtonStyle
        .overlayColor
        (m/MaterialStateProperty.resolveWith
          (fn [s]
            (when (.contains ^Set s m/MaterialState.pressed)
              primary-color)))))
    (if added
      (m/Icon m/Icons.check .semanticLabel "ADDED")
      (m/Text "Add"))))

(defn my-list-item [{:keys [title color] :as item}]
  (f/widget
    :get {{{text-theme .-titleLarge} .-textTheme} m/Theme}
    (m/Padding .padding (m/EdgeInsets.symmetric .horizontal 16 .vertical 8))
    (m/LimitedBox .maxHeight 48)
    (m/Row)
    .children
    [(f/widget
       (m/AspectRatio .aspectRatio 1)
       (m/Container .color color))
     (m/SizedBox .width 24)
     (m/Expanded .child (m/Text title .style text-theme))
     (m/SizedBox .width 24)
     (add-button item)]))

(def catalog
  (f/widget
    :get {{{display-large .-displayLarge} .-textTheme} m/Theme}
    (m/Scaffold)
    .body
    (m/CustomScrollView)
    .slivers
    [(m/SliverAppBar .title (m/Text "Catalog" .style display-large)
       .floating true
       .actions [(f/widget
                   :context ctx
                   :get [m/Navigator]
                   (m/IconButton .icon (m/Icon m/Icons.shopping_cart))
                   .onPressed
                   (fn []
                     (.push navigator (widget->route ctx .child my-cart))
                     nil))])
     (m/SliverToBoxAdapter .child (m/SizedBox .height 12))
     (m/SliverList .delegate
       (m/SliverChildBuilderDelegate
         (f/build [idx]
           (my-list-item (get-in @app-state [:catalog idx])))
         .childCount (count (:catalog @app-state))))]))

;; cart page
(def cart-list
  (f/widget
    :get {{{title-large .-titleLarge} .-textTheme} m/Theme }
    :watch [cart-content (f/$ (some->> (f/<! app-state) :cart (into [])))]
    (m/ListView.builder
      .itemCount (count cart-content)
      .itemBuilder
      (f/build [idx]
        (let [item (get-in cart-content [idx])]
          (m/ListTile .leading (m/Icon m/Icons.done)
            .trailing (m/IconButton .icon (m/Icon m/Icons.remove_circle_outline)
                        .onPressed (fn [] (swap! app-state update :cart disj item)))
            .title (m/Text (:title item) .style title-large)))))))

(def cart-total
  (f/widget
    :get {{{display-large .-displayLarge} .-textTheme} m/Theme}
    (m/SizedBox .height 200)
    m/Center
    (m/Row .mainAxisAlignment m/MainAxisAlignment.center)
    .children
    [(f/widget
       :watch [total-price (f/$ (->> (f/<! app-state) :cart (transduce (map :price) +)))]
       (m/Text (str total-price "€") .style (.copyWith display-large .fontSize 48)))
     (m/SizedBox .width 24)
     (f/widget
       :get [m/ScaffoldMessenger]
       (m/FilledButton
         .onPressed (fn []
                      (.showSnackBar scaffold-messenger
                        (m/SnackBar .content (m/Text "Buying not supported yet.")))
                      nil)
         .style (m/TextButton.styleFrom .foregroundColor m/Colors.white))
       (m/Text "BUY"))]))

(def my-cart
  (f/widget
    :get {{{display-large .-displayLarge} .-textTheme} m/Theme}
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Cart" .style display-large) .backgroundColor m/Colors.white))
    .body
    (m/Container .color m/Colors.yellow)
    (m/Column)
    .children
    [(m/Expanded .child (m/Padding .padding (m/EdgeInsets.all 32) .child cart-list))
     (m/Divider .height 4 .color m/Colors.black)
     cart-total]))

;; utility
(defn widget->route [ctx .child]
  (.createRoute (m/MaterialPage .child child) ctx))

(def theme
  (m/ThemeData
    .colorSchemeSeed m/Colors.yellow
    .useMaterial3 true
    .textTheme (m/TextTheme
                 .displayLarge (m/TextStyle
                                 .fontWeight m/FontWeight.w700
                                 .fontSize 24
                                 .color m/Colors.black))))

(defn main []
  (f/run
    (m/MaterialApp
      .theme theme
      .home catalog)))



================================================
FILE: samples/snackbar/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
  :deps {org.clojure/clojure {:mvn/version "1.10.1"}
         tensegritics/clojuredart {:local/root "../../"}}
  :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
  :cljd/opts {:main sample.snackbar
              :kind :flutter}}



================================================
FILE: samples/snackbar/src/sample/snackbar.cljd
================================================
(ns sample.snackbar
  "Faithful port of https://docs.flutter.dev/cookbook/design/snackbars"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(def snackbar
  (m/SnackBar
   .content (m/Text "Yay! A SnackBar!")
   .action
   (m/SnackBarAction .label "Undo" .onPressed (fn []))))

(def snackbar-demo
  (f/widget
   :get [m/ScaffoldMessenger]
   m/Center
   (m/ElevatedButton
     .onPressed (fn []
                  (.showSnackBar scaffold-messenger snackbar)
                  nil))
   (m/Text "Show text")))

(defn main []
  (let [title "Snackbar Demo"]
    (m/runApp
     (m/MaterialApp
      .title title
      .home (m/Scaffold
             .appBar (m/AppBar .title (m/Text title))
             .body snackbar-demo)))))



================================================
FILE: samples/syncfusion_flutter_charts/README.md
================================================
# Description

An example for [Syncfusion flutter charts](https://pub.dev/packages/syncfusion_flutter_charts)

# How to run

- Before running Clojure flutter, this demo needs to install the flutter dependencies with:

```bash
clj -M:cljd init
```

- And:

```bash
flutter pub add syncfusion_flutter_charts
```

and after these two processes, you can do

```bash
clj -M:cljd flutter



================================================
FILE: samples/syncfusion_flutter_charts/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.charts
             :kind :flutter}}



================================================
FILE: samples/syncfusion_flutter_charts/src/sample/charts.cljd
================================================
(ns sample.charts
  (:require ["package:flutter/material.dart" :as m]
            ["package:syncfusion_flutter_charts/charts.dart" :as syncfusion_charts]
            ["package:syncfusion_flutter_charts/sparkcharts.dart" :as syncfusion_sparkcharts]
            [cljd.flutter :as f]))

(defn main []
  (f/run
    m/MaterialApp
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Syncfusion Cljd charts")))
    .body
    :let [data [{:year "Jan" :sales 35}
                {:year "Feb" :sales 28}
                {:year "Mar"  :sales 34}
                {:year "Apr"  :sales 32}
                {:year "May"  :sales 40}]]
    m/Column
    .children
    [(syncfusion_charts/SfCartesianChart
       .primaryXAxis (syncfusion_charts/CategoryAxis)
       .title (syncfusion_charts/ChartTitle .text "Half yearly sales analysis")
       .legend (syncfusion_charts/Legend .isVisible true)
       .tooltipBehavior (syncfusion_charts/TooltipBehavior .enable true)
       .series
       ;; here type hint is needed since syncfusion defined it as `dynamic` in their doc but
       ;; for some reason they are still waiting for a List<ChartSeries>
       #dart ^syncfusion_charts/ChartSeries
       [(syncfusion_charts/LineSeries
          .dataSource data
          .xValueMapper (fn [d _] (:year d))
          .yValueMapper (fn [d _] (:sales d))
          .name "Sales"
          .dataLabelSettings (syncfusion_charts/DataLabelSettings .isVisible true))])
     (f/widget
       m/Expanded
       (m/Padding .padding (m/EdgeInsets.all 8))
       (syncfusion_sparkcharts/SfSparkLineChart.custom
         .trackball
         (syncfusion_sparkcharts/SparkChartTrackball
           .activationMode syncfusion_sparkcharts/SparkChartActivationMode.tap)
         .marker (syncfusion_sparkcharts/SparkChartMarker
                   .displayMode syncfusion_sparkcharts/SparkChartMarkerDisplayMode.all)
         .labelDisplayMode syncfusion_sparkcharts/SparkChartLabelDisplayMode.all
         .xValueMapper #(get-in data [% :year])
         .yValueMapper #(get-in data [% :sales])
         .dataCount (count data)))]))



================================================
FILE: samples/tabs/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.tabs
             :kind :flutter}}



================================================
FILE: samples/tabs/src/sample/tabs.cljd
================================================
(ns sample.tabs
  "Faithful port of https://docs.flutter.dev/cookbook/design/tabs"
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

(defn main
  []
  (let [title "Tabs Demo"]
    (f/run
      (m/MaterialApp .title title)
      .home
      (m/DefaultTabController .length 3)
      (m/Scaffold
        .appBar
        (m/AppBar
          .bottom
          (m/TabBar
            .tabs [(m/Tab .icon (m/Icon. m/Icons.directions_car)),
                   (m/Tab .icon (m/Icon. m/Icons.directions_transit)),
                   (m/Tab .icon (m/Icon. m/Icons.directions_bike))])))
      .body
      (m/TabBarView
        .children [(m/Tab .icon (m/Icon. m/Icons.directions_car)),
                   (m/Tab .icon (m/Icon. m/Icons.directions_transit)),
                   (m/Tab .icon (m/Icon. m/Icons.directions_bike))]))))



================================================
FILE: samples/twocounters/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.two-counters
             :kind :flutter}}



================================================
FILE: samples/twocounters/src/sample/two_counters.cljd
================================================
(ns sample.two-counters
  (:require
   ["package:flutter/material.dart" :as m]
   [cljd.flutter :as f]))

;; this sample demos how to use :bind/:get

(def home
  (f/widget
   (m/Scaffold
    .appBar (m/AppBar .title (m/Text "ClojureDart Home Page")))
   .body
   m/Center
   (m/Row .mainAxisAlignment m/MainAxisAlignment.center)
   .children
   (for [k [:left :right]]
     (f/widget
      m/Expanded
      (m/Column
       .mainAxisAlignment m/MainAxisAlignment.center
       .children
       [(m/Text (str k))
        (f/widget
         :get {{{style .-displayLarge} .-textTheme} m/Theme
               :value-of [:counters]}
         :watch [{n k} counters]
         :let [_ (dart:core/print (str "build text " k))]
         (m/Text (str n) .style style))
        (f/widget
         :get [:counters]
         :let [_ (dart:core/print "build +")]
         (m/ElevatedButton .onPressed #(swap! counters update k inc))
         (m/Text "+"))])))))

(defn main []
  (m/runApp
   (f/widget
    (m/MaterialApp
     .title "Cljd Demo"
     .theme (m/ThemeData .primarySwatch m/Colors.blue))
    .home
    ; here we establish a dynamic binding for the name :counters
    :bind {:counters (atom {:left 0 :right 0})}
    home)))



================================================
FILE: samples/video_player/README.md
================================================
# Description

An example for [Video Player Plugin](https://pub.dev/packages/video_player)

OBS: This plugin does not support implementation for MacOS compilation!
like this: (```clj -M:cljd flutter -d macos```)
* [Flutter Issue for MacOS support on video_player](https://github.com/flutter/flutter/issues/41688)

# How to run

- Before running Clojure flutter, this demo needs to install the flutter dependencies with:

```bash
clj -M:cljd init
```

- And:

```bash
flutter pub add material
flutter pub add video_player
```

and after these two processes, you can do

```bash
clj -M:cljd flutter
```



================================================
FILE: samples/video_player/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.video-player
             :kind :flutter}}



================================================
FILE: samples/video_player/src/sample/video_player.cljd
================================================
(ns sample.video-player
  "Example of video player"
  (:require ["package:flutter/material.dart" :as m]
            ["package:video_player/video_player.dart" :as vp]
            [cljd.flutter :as f]))

(def video-player-widget
  (f/widget
    :managed [controller (vp/VideoPlayerController.network
                           "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")]
    :watch [_initialization! (.initialize controller)
            ^vp/VideoPlayerValue
            {:flds [isPlaying
                    aspectRatio
                    isInitialized]} controller]
    (m/Scaffold
      .floatingActionButton
      (f/widget
        (m/FloatingActionButton
          .onPressed (fn []
                         (if isPlaying
                           (.pause controller)
                           (.play controller))
                         nil))
        (m/Icon (if isPlaying m/Icons.pause m/Icons.play_arrow))))
    .body
    m/Center
    (if isInitialized
      (f/widget
        (m/AspectRatio .aspectRatio aspectRatio)
        (vp/VideoPlayer controller))
      (m/Container))))

(defn main []
  (f/run
    m/MaterialApp
    .home video-player-widget))



================================================
FILE: samples/webview/README.md
================================================
# Run the `webview` sample:

1. `clj -M:cljd init`
2. `flutter pub add webview_flutter`
3. `clj -M:cljd flutter` (considering you already have a simulator opened)



================================================
FILE: samples/webview/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}}
 :cljd/opts {:main sample.webview
             :kind :flutter}}



================================================
FILE: samples/webview/src/sample/webview.cljd
================================================
(ns sample.webview
  ;; how to use https://pub.dev/packages/webview_flutter
  (:require
   ["package:flutter/material.dart" :as m]
   ["package:webview_flutter/webview_flutter.dart" :as webview]
   ["package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart" :as webview-ios]
   [cljd.flutter :as f]))

(defn web-view [current-url]
  (f/widget
    :let [ios (dart/is? webview/WebViewPlatform.instance webview-ios/WebKitWebViewPlatform)
          ;; you can customize parameters passed to the underlying platform ios/android/web...
          ;; @see here: https://pub.dev/documentation/webview_flutter_wkwebview/latest/webview_flutter_wkwebview/WebKitWebViewControllerCreationParams-class.html
          params (if ios
                   (webview-ios/WebKitWebViewControllerCreationParams)
                   (webview/PlatformWebViewControllerCreationParams))]
    :managed [loading (m/ValueNotifier true)
              controller
              (doto (webview/WebViewController.fromPlatformCreationParams params)
                ;; depending on your needs
                (.setJavaScriptMode webview/JavaScriptMode.unrestricted)
                (.setBackgroundColor m/Colors.white)
                (.enableZoom true)
                (.setUserAgent "ClojureDart")
                (.setNavigationDelegate
                  (webview/NavigationDelegate
                    .onPageStarted (fn [_] (.-value! loading true) nil)
                    .onPageFinished (fn [_] (.-value! loading false) nil)
                    .onNavigationRequest
                    (fn [{for-main-frame .-isMainFrame
                          url .-url :as ^webview/NavigationRequest nav}]
                      webview/NavigationDecision.navigate
                      ;;webview/NavigationDecision.prevent
                      )
                    .onWebResourceError
                    (fn [{error-type .-errorType :as ^webview/WebResourceError error}]
                      ;; handle error here
                      nil)))
                (cond-> ios
                  (-> ^webview-ios/WebKitWebViewController (.-platform)
                    ;; if you want the user to be able to go back, ios only
                    (.setAllowsBackForwardNavigationGestures true)))
                (.loadRequest (Uri/parse current-url)))
              ;; WebViewController does not have a .dispose method so we must set the option to false
              :dispose false]
    :watch [ld loading]
    (if ld
      (m/CircularProgressIndicator)
      (webview/WebViewWidget .controller controller))))

(defn main []
  (f/run
    m/MaterialApp
    .home
    (m/Scaffold .appBar (m/AppBar .title (m/Text "Embed a webview")))
    .body
    m/Center
    (web-view "https://clojuredart.org")))



================================================
FILE: samples/widget_tests/cljd_widget_tests.iml
================================================
<?xml version="1.0" encoding="UTF-8"?>
<module type="JAVA_MODULE" version="4">
  <component name="NewModuleRootManager" inherit-compiler-output="true">
    <exclude-output />
    <content url="file://$MODULE_DIR$">
      <sourceFolder url="file://$MODULE_DIR$/lib" isTestSource="false" />
      <sourceFolder url="file://$MODULE_DIR$/test" isTestSource="true" />
      <excludeFolder url="file://$MODULE_DIR$/.dart_tool" />
      <excludeFolder url="file://$MODULE_DIR$/.idea" />
      <excludeFolder url="file://$MODULE_DIR$/build" />
    </content>
    <orderEntry type="sourceFolder" forTests="false" />
    <orderEntry type="library" name="Dart SDK" level="project" />
    <orderEntry type="library" name="Flutter Plugins" level="project" />
    <orderEntry type="library" name="Dart Packages" level="project" />
  </component>
</module>



================================================
FILE: samples/widget_tests/deps.edn
================================================
{:paths ["src"] ; where your cljd files are
 :deps {org.clojure/clojure {:mvn/version "1.10.1"}
        tensegritics/clojuredart {:local/root "../../"}}
 :aliases {:cljd {:main-opts ["-m" "cljd.build"]}
           :test-widgets
           {:extra-paths ["test"]
            :cljd/opts {:dart-test-args ["-t" "widget"]}}}
 :cljd/opts {:main sample.widget_tests
             :kind :flutter}}



================================================
FILE: samples/widget_tests/src/samples/widget.cljd
================================================
(ns samples.widget
  (:require [cljd.flutter :as f]
            ["package:flutter/material.dart" :as m]))

(defn my-widget [title message]
  (f/widget
    (m/MaterialApp .title "Flutter Demo")
    .home
    (m/Scaffold
      .appBar (m/AppBar .title (m/Text title)))
    .body
    m/Center
    (m/Text message)))



================================================
FILE: samples/widget_tests/test/samples/widgets_test.cljd
================================================
(ns samples.widgets-test
  #_{:dart.test/dir "wttests"}
  (:require [cljd.test :as t :refer [deftest is]]
            [samples.widget :as sw]
            ["package:flutter_test/flutter_test.dart" :as ft]))

(deftest whatever
  :tags [:widget]
  :runner (ft/testWidgets [tester])
  (let [^ft/WidgetTester {:flds [pumpWidget]} tester
        _ (await (pumpWidget (sw/my-widget "T" "M")))
        title-finder (ft/find.text "T")
        message-finder (ft/find.text "M")]
    (ft/expect title-finder ft/findsOneWidget)
    (ft/expect message-finder ft/findsOneWidget)))

(deftest main
  (is (= 0 1)))


