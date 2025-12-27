# Building with Custom Agus Maps Flutter

This guide explains how to build and run the Bhikers Club app using the custom `agus_maps_flutter` plugin configuration.

## 1. Dependency Configuration (`pubspec.yaml`)

Ensure your `pubspec.yaml` points to the correct git repository and version tag.

```yaml
dependencies:
  agus_maps_flutter:
    git:
      url: https://github.com/bangonkali/agus-maps-flutter
      ref: v0.0.35  # Must match LIBS_VERSION
```

## 2. Environment Setup (`LIBS_VERSION`)

The `agus_maps_flutter` plugin build script requires the `LIBS_VERSION` environment variable to download the correct prebuilt native binaries (CoMaps).

**Required Version:** `v0.0.35`

## 3. How to Run

### Option A: Using Makefile (Recommended)

The `Makefile` has been updated to automatically handle the environment variable.

*   **Run on device:**
    ```bash
    make run
    ```

*   **Build APK:**
    ```bash
    make apk
    ```

### Option B: Manual Execution

If you prefer running commands manually, you **MUST** set the environment variable first.

*   **Using ClojureDart wrapper:**
    ```bash
    export LIBS_VERSION=v0.0.35
    clj -M:cljd flutter run
    ```

*   **Using raw Flutter:**
    ```bash
    export LIBS_VERSION=v0.0.35
    flutter run
    ```

## 4. Architecture Notes

*   **Supported ABIs:** `arm64-v8a`, `armeabi-v7a`, `x86_64`.
*   **x86 Support:** The build includes a workaround for `x86` (common in some emulators). It uses a dummy library to allow compilation, but map functionality may not work fully on `x86` emulators. Use a physical device or an `arm64` emulator for best results.

## 5. Troubleshooting build issues

If you encounter linker errors or "undefined symbol" errors:

1.  **Clean the cache:**
    ```bash
    rm -rf ~/.pub-cache/git/agus-maps-flutter-*
    ```
2.  **Clean the project:**
    ```bash
    flutter clean
    ```
3.  **Re-run with the environment variable:**
    ```bash
    make run
    ```

## 6. How to Modify the Plugin (Advanced)

If you need to modify the `agus_maps_flutter` source code or update the library version, follow these steps.

### A. Updating the Library Version
To use a newer version of the prebuilt libraries (e.g., `v0.0.36`):

1.  Update `pubspec.yaml`: Change `ref: v0.0.35` to `ref: v0.0.36`.
2.  Update Makefile: Change `LIBS_VERSION=v0.0.35` to `LIBS_VERSION=v0.0.36`.
3.  Clean and run: `make clean-full && make run`.

### B. Modifying Plugin Source (Local Clone)
If you want to edit the Dart or C++ wrapper code:

1.  **Clone the repository locally:**
    ```bash
    git clone https://github.com/bangonkali/agus-maps-flutter.git
    cd agus-maps-flutter
    git checkout v0.0.35
    ```

2.  **Update `pubspec.yaml`** to use a local path:
    ```yaml
    dependencies:
      agus_maps_flutter:
        path: /path/to/your/local/agus-maps-flutter
    ```

3.  **Apply the CMake Fix (Crucial):**
    The official `v0.0.35` tag has a bug in `src/CMakeLists.txt` that causes linker errors when using prebuilts. You must modify your local `src/CMakeLists.txt`:
    
    *Find the block:*
    ```cmake
    if(USE_PREBUILT_COMAPS AND ANDROID)
      # ...
    else()
       # ...
    endif()
    ```
    
    *Ensure that inside the `if(USE_PREBUILT_COMAPS...)` block, you DO NOT call `add_library(... src/agus_ogl.cpp ...)`.*
    The prebuilt library already contains these compiled symbols. You should only use `add_library(... IMPORTED GLOBAL)` to link the `.so` file.
