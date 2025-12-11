# Testing Manual

This project uses `cljd.test`, a port of `clojure.test` built on top of `dart test` to leverage existing Flutter/Dart tooling.

## Running Tests

### Via Makefile (Recommended)

To run all tests:

```bash
make test
```

### Via Clojure CLI

To run all tests manually:

```bash
clj -M:test:cljd test
```

### Running Specific Tests

You can narrow the namespaces searched for tests by specifying them after `test`:

```bash
clj -M:test:cljd test club.bhikers.lib.utils-test
```

### Running Widget Tests

To run tests tagged with `:widget`:

```bash
clj -M:test-widgets:cljd test
```

Everything after `--` will be passed to `dart test`. For example, to run tests with a specific name:

```bash
clj -M:test:cljd test -- -n "my specific test name"
```

## Writing Tests

By default, tests are compiled to the `test` directory. The structure should mirror the `src` directory:

```
src/club/bhikers/lib/utils.cljd
test/club/bhikers/lib/utils_test.cljd
```

### Basic Structure

```clojure
(ns club.bhikers.lib.example-test
  (:require [cljd.test :refer [deftest is testing]]))

(deftest simple-math-test
  (testing "Arithmetic"
    (is (= 4 (+ 2 2)))))
```

### Testing Macros and Assertions

The primary testing constructs in ClojureDart are:

- **`deftest`** - Define a test function
- **`is`** - Make assertions within tests
- **`testing`** - Group related assertions with a description

Example:

```clojure
(deftest addition-tests
  (is (= 5 (+ 3 2)))
  (is (= 10 (+ 5 5))))
```

### Widget Tests & Options

`deftest` supports inline options, specifically `:tags` and `:runner`:

```clojure
(deftest my-widget-test
  :tags [:widget]
  :runner (ft/testWidgets [tester])
  (let [^ft/WidgetTester {:flds [pumpWidget]} tester
        _ (await (pumpWidget (my-widget "Title")))
        finder (ft/find.text "Title")]
    (ft/expect finder ft/findsOneWidget)))
```

- `:tags` allows tests selection using `dart test -t <tag>` (e.g., `-t widget`).
- `:runner` allows specifying a specialized test runner. `[tester]` is the binding vector for arguments provided by the runner (e.g., `WidgetTester`).

### Mocking

For logic that depends on external services (like Overpass API or HTTP clients), use `reify` to implement protocols locally within the test.

Example from `test/club/bhikers/lib/pois_test.cljd`:

```clojure
(defn mock-overpass-api [return-value]
  (reify oapi/disposable-overpass-api
    (dispose! [this] this)
    (query [this type lat lon osm-tags radius]
      (Future.value return-value))))
```

## Configuration

Configuration is located in `deps.edn`:

```clojure
:aliases {:cljd {:main-opts ["-m" "cljd.build"]}
           :test {:extra-paths ["test"]}
           :test-widgets
           {:extra-paths ["test"]
            :cljd/opts {:dart-test-args ["-t" "widget"]}}}
```

- `:test`: Adds the `test/` folder to the classpath.
- `:test-widgets`: Adds `test/` and pre-configures arguments to only run tests tagged with `:widget`.

When you combine several aliases, `:dart-test-args` are concatenated. However, if you use `--` on the command line, it will discard the computed `:dart-test-args`. Replace `--` by `++` to append instead.

## Documentation and Resources

### Official ClojureDart Resources

- **Main Repository**: https://github.com/Tensegritics/ClojureDart[8][9]
- **Quick Start Guide**: https://github.com/Tensegritics/ClojureDart/blob/main/doc/quick-start.md[8]
- **ClojureDart Cheatsheet**: Available on the main repository[10]
- **GitHub Wiki**: https://github.com/Tensegritics/ClojureDart/wiki[11]

### Learning Resources

- **HowToClojureDart**: https://github.com/D00mch/HowToClojureDart - Comprehensive introduction to ClojureDart development[12]
- **Calva User Guide (ClojureDart section)**: https://calva.io/clojuredart/[13]
- **Practical Flutter/ClojureDart Manual**: https://manuals.ryanfleck.ca/flutter/[14]
- **FXIS.ai Getting Started Guide**: https://fxis.ai/edu/getting-started-with-clojuredart-your-guide-to-creating-native-apps/[15]

### Standard Clojure Testing Documentation

- **Clojure.test API Reference**: https://clojure.github.io/clojure/clojure.test-api.html[5]
- **Practicalli Clojure - Unit Testing**: https://practical.li/clojure/testing/unit-testing/[1]
- **Practicalli - Test Runners**: https://practical.li/clojure/testing/test-runners/[16]
- **Practicalli - Configure Tests for deps.edn**: https://practical.li/clojure/testing/unit-testing/configure-projects-for-tests/[17]
- **ClojureDocs - Unit Testing Guide**: https://ericnormand.me/mini-guide/example-based-unit-testing-in-clojure[7]
- **ClojureDocs - Test Directory Organization**: https://ericnormand.me/mini-guide/clojure-test-directory[2]

### Example Projects

- **re-dash (ClojureDart framework)**: https://github.com/htihospitality/re-dash - Includes test setup examples[4]
- **ClojureDartTeaExample**: https://github.com/D00mch/ClojureDartTeaExample[18]
- **ryanapp**: https://github.com/dupuchba/ryanapp - Ray Wenderlich app in ClojureDart[19]

### Community Resources

- **Clojurians Slack #ClojureDart Channel**: Official community chat for ClojureDart questions[12]
- **YouTube - ClojureDart Tips**: https://www.youtube.com/watch?v=ziPIzvA60co[20]
- **YouTube - Clojure/Conj 2023 Talk**: Live coding session covering ClojureDart workflows[8]

### References

[1]: https://practical.li/clojure/testing/unit-testing/
[2]: https://ericnormand.me/mini-guide/clojure-test-directory
[3]: https://clojurescript.org/tools/testing
[4]: https://github.com/htihospitality/re-dash
[5]: https://clojure.github.io/clojure/clojure.test-api.html
[7]: https://ericnormand.me/mini-guide/example-based-unit-testing-in-clojure
[8]: https://github.com/Tensegritics/ClojureDart/blob/main/doc/quick-start.md
[9]: https://github.com/Tensegritics/ClojureDart
[10]: https://www.scribd.com/document/655663167/ClojureDart-Cheatsheet
[11]: https://github.com/Tensegritics/ClojureDart/wiki
[12]: https://github.com/D00mch/HowToClojureDart/blob/main/README.md
[13]: https://calva.io/clojuredart/
[14]: https://manuals.ryanfleck.ca/flutter/
[15]: https://fxis.ai/edu/getting-started-with-clojuredart-your-guide-to-creating-native-apps/
[16]: https://practical.li/clojure/testing/test-runners/
[17]: https://practical.li/clojure/testing/unit-testing/configure-projects-for-tests/
[18]: https://github.com/D00mch/ClojureDartTeaExample
[19]: https://github.com/dupuchba/ryanapp
[20]: https://www.youtube.com/watch?v=ziPIzvA60co
