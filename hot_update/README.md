## Hot Update Package for Bhikers.club

This is the hot update package for the bhikers.club app. It contains the code that will be compiled to EVC (Evalable Virtual Code) and loaded at runtime via code push.

### How Code Push Works

1. The main app uses `HotSwapLoader` to load an EVC file at startup
2. When a `HotSwap` widget is rendered, it checks if there's a corresponding `@RuntimeOverride` function in the loaded EVC
3. If found, the override function is executed instead of the default content
4. If not found, the default `childBuilder` content is rendered

### HotSwap IDs

| ID | Screen | Description |
|----|--------|-------------|
| `#bhikers_around_me` | around-me | Main map/POI screen |
| `#bhikers_settings` | settings | App settings screen |
| `#bhikers_enhance_gpx` | enhance-gpx | GPX enhancement screen |
| `#bhikers_fall_detector` | fall-detector | Fall detection screen |

### Compilation

To compile this package to an EVC file:

```bash
# Navigate to the hot_update directory
cd hot_update

# Install dependencies
flutter pub get

# Compile to EVC using dart_eval CLI
dart run dart_eval compile

# Copy the resulting EVC file to assets
cp build/hot_update.evc ../assets/hot_update.evc
```

### Deployment

1. Make changes to `lib/hot_update.dart`
2. Compile the package using the commands above
3. Deploy the EVC file to your update server or include it in assets
4. The app will load the new EVC on next startup (or immediately if using `immediate` strategy)

### Development vs Production

- **Development**: Use `asset://assets/hot_update.evc` URI for local testing
- **Production**: Use `https://your-server.com/updates/hot_update.evc` for remote updates
