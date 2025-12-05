
## 🔧 TODO: Next Refactoring Steps

### Priority 1: Code Quality Issues

| # | Task | File(s) | Notes |
|---|------|---------|-------|
| 1 | **Use `reset!` instead of `swap! (constantly ...)`** | All files | `(reset! atom value)` is cleaner than `(swap! atom (constantly value))` |
| 2 | **Remove commented code** | `lib/map.cljd` | FloatingActionButton block ~L160 |
| 3 | **Fix inconsistent lifecycle naming** | Various | Standardize on `init!`/`dispose!` or `start!/stop!` |

### Priority 2: Split Large Modules

| # | Task | File | Proposed Split |
|---|------|------|----------------|
| 4 | **Split `lib/utils.cljd`** | `lib/utils.cljd` | → `lib/i18n.cljd` (l10n-str)<br>→ `lib/http.cljd` (dio, cache)<br>→ `lib/uuid.cljd`<br>→ `lib/io.cljd` (log-file-dir) |
| 5 | **Split `lib/map.cljd`** | `lib/map.cljd` (~170 lines) | → `lib/map/state.cljd` (new-state, state-streams protocol)<br>→ `lib/map/widgets.cljd` (msg, control-buttons) |
| 6 | **Split `lib/position.cljd`** | `lib/position.cljd` (~140 lines) | → `lib/position/settings.cljd`<br>→ `lib/position/streams.cljd` |

### Priority 3: Configuration Cleanup

| # | Task | File | Notes |
|---|------|------|-------|
| 7 | **Separate constants from runtime state** | `lib/config.cljd` | Create `lib/state.cljd` for atoms, keep `config.cljd` for constants only |
| 8 | **Move POI OSM tags to config** | `lib/pois.cljd` | `poi-types->osm-tags` is config data |
| 9 | **Extract icon mappings** | `lib/pois/ui.cljd` | `osm-tags->icons` (~40 lines) → `resources/` or separate config |

### Priority 4: Dependency Fixes

| # | Task | Issue | Fix |
|---|------|-------|-----|
| 10 | **Move `log-file-dir` to logging** | `utils.cljd` → `logging.cljd` | Avoid cross-cutting concern in utils |
| 11 | **Fix `notifications` direct reference** | `common/appbar.cljd` | Uses both `:get [:notifications]` AND direct `notifications` atom reference in watch |

### Priority 5: Testing & Documentation

| # | Task | Notes |
|---|------|-------|
| 12 | **Add docstrings** | Public functions in lib/ lack documentation |
| 13 | **Add unit tests for lib functions** | Current tests are integration/widget only |
| 14 | **Test POI query logic** | `dynamic-map-pois` is complex, needs tests |
| 15 | **Test position stream logic** | `new-position-stream-controller` is critical |

### Priority 6: Future Improvements

| # | Task | Notes |
|---|------|-------|
| 16 | **Standardize error handling** | Add consistent try/catch patterns or error boundary |
| 17 | **Extract magic numbers** | `100000` (lat/lon precision), `40` (marker size), etc. |
| 18 | **Consider replacing atom watches** | `add-watch` chains can be hard to debug; consider reactive patterns |

---

## 📁 Suggested Final Structure

```
lib/
├── config.cljd          # Constants only (no atoms)
├── state.cljd           # Runtime atoms
├── app.cljd             # Initialization
├── i18n.cljd            # l10n-str
├── http.cljd            # dio, cache utilities  
├── logging.cljd         # (move log-file-dir here)
├── notifications.cljd
├── permissions.cljd
├── map/
│   ├── state.cljd       # new-state, ->state-streams
│   └── widgets.cljd     # msg, control-buttons
├── position/
│   ├── settings.cljd    # location settings per platform
│   └── streams.cljd     # stream controllers
├── pois/
│   ├── core.cljd        # poi-types->osm-tags, query logic
│   ├── ui.cljd          # widgets
│   └── icons.cljd       # osm-tags->icons mapping
└── overpassapi.cljd

screens/
├── common/
│   ├── appbar.cljd
│   └── drawer.cljd
├── aroundme/
│   ├── core.cljd        # main screen
│   ├── layers.cljd
│   └── ui.cljd
├── settings/
│   ├── core.cljd
│   └── ui.cljd
└── ...
```