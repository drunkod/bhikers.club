# Test Generation in ClojureDart

This document explains how test generation works in the Bhikers Club ClojureDart project.

## Overview

Your ClojureDart project uses a **two-step compilation process** for tests:

1. **Write tests in ClojureDart** (`.cljd` files)
2. **Compile to Dart** (`.dart` files) 
3. **Execute with Dart test runner**

## File Structure

### Source Files (ClojureDart)
```
test/club/bhikers/lib/pois_test.cljd    ← Your test code
test/club/bhikers/lib/utils_test.cljd   ← Your test code
test/club/bhikers/lib/http_test.cljd    ← Your test code
```

### Generated Dart Files (Compiled)
```
test/cljd-out/club/bhikers/lib/pois-test_test.dart    ← Generated from .cljd
test/cljd-out/club/bhikers/lib/utils-test_test.dart  ← Generated from .cljd  
test/cljd-out/club/bhikers/lib/http-test_test.dart    ← Generated from .cljd
```

## How It Works

### 1. Compilation Process
```bash
clj -M:test:cljd test
```

This command:
- Compiles your `.cljd` test files to `.dart` files in `test/cljd-out/`
- Uses the ClojureDart compiler to translate Clojure syntax to Dart code
- Handles all the Clojure-to-Dart interop automatically

### 2. Test Execution
The generated Dart files are then executed using Dart's built-in test framework, which provides:
- Rich test reporting
- Async test support
- Widget testing integration
- CI/CD compatibility

## Configuration

### deps.edn Setup
```clojure
:aliases {:cljd {:main-opts ["-m" "cljd.build"]}
           :test {:extra-paths ["test"]}           ; Adds test directory to classpath
           :test-widgets {:extra-paths ["test"]     ; For widget tests only
                          :cljd/opts {:dart-test-args ["-t" "widget"]}}}
```

### Makefile Integration
```makefile
test: ## Run tests
	clj -M:test:cljd test
```

## Key Benefits

### 1. **Clojure Syntax**
Write tests using familiar Clojure syntax and patterns:
```clojure
(deftest my-test
  (testing "some behavior"
    (is (= 4 (+ 2 2)))))
```

### 2. **Dart Ecosystem**
Leverage Dart's mature testing infrastructure:
- Rich assertion libraries
- Flutter widget testing
- Performance profiling
- IDE integration

### 3. **Flutter Integration**
Seamless testing of Flutter components:
```clojure
(deftest widget-test
  :tags [:widget]
  :runner (ft/testWidgets [tester])
  (ft/expect (ft/find.text "Hello") ft/findsOneWidget))
```

## Generated Code Example

### Input (pois_test.cljd)
```clojure
(deftest fetch-pois-by-type-test
  (testing "returns mapped POIs for nodes"
    (let [mock-data [{"type" "node" "id" 123}]
          result (await (pois/fetch-pois-by-type api "node" 0.0 0.0 [] 1000 "cafe"))]
      (is (= 1 (count result))))))
```

### Output (pois-test_test.dart)
The generated Dart file contains:
- Translated test logic
- Proper Dart imports
- Flutter test framework integration
- Async/await handling

## Important Notes

### File Locations
- **Source**: `test/**/*.cljd` (tracked in git)
- **Generated**: `test/cljd-out/**/*.dart` (gitignored)

### Compilation Order
1. ClojureDart compiler processes `.cljd` files
2. Generates pure Dart code in `test/cljd-out/`
3. Dart test runner executes the generated files

### Debugging
- Test failures show in both Dart and Clojure contexts
- Generated Dart files can be inspected for debugging
- Stack traces reference original `.cljd` source locations

## Best Practices

1. **Keep tests in `.cljd` files** - don't edit generated `.dart` files
2. **Use Clojure testing patterns** - `deftest`, `testing`, `is`
3. **Leverage Dart test features** - tags, runners, async support
4. **Run via Makefile** - ensures proper compilation and execution

## Troubleshooting

### Common Issues
- **Compilation errors**: Check Clojure syntax in `.cljd` files
- **Import issues**: Ensure proper namespace declarations
- **Async problems**: Use `await` correctly in test contexts

### Debug Steps
1. Check compilation output for syntax errors
2. Inspect generated `.dart` files if needed
3. Run specific tests: `clj -M:test:cljd test -- -n "test-name"`

This hybrid approach gives you the best of both worlds: Clojure's expressive syntax with Dart's robust testing ecosystem.
