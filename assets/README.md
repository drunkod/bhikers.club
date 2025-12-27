# Map Assets Setup

This directory contains the offline map data required by `agus_maps_flutter`.

## Required Files

You need to obtain the following files from the [agus-maps-flutter example](https://github.com/bangonkali/agus-maps-flutter/tree/main/example/assets):

### Map Files (`assets/maps/`)
- `World.mwm` - Base world map
- `WorldCoasts.mwm` - World coastlines
- `icudt75l.dat` - ICU data for transliteration

### CoMaps Data (`assets/comaps_data/`)
- `fonts/` - Font files for map rendering
- `categories-strings/` - Category localization strings
- `countries-strings/` - Country name localization
- `symbols/` - Map symbols and icons
- `styles/` - Map style definitions

## How to Obtain

1. Clone the agus-maps-flutter repository:
   ```bash
   git clone https://github.com/bangonkali/agus-maps-flutter.git
   ```

2. Copy the required files:
   ```bash
   cp -r agus-maps-flutter/example/assets/maps/* assets/maps/
   cp -r agus-maps-flutter/example/assets/comaps_data/* assets/comaps_data/
   ```

3. Verify the files are in place:
   ```bash
   ls -la assets/maps/
   ls -la assets/comaps_data/
   ```

## Note

These files are large (World.mwm is ~50MB) and are not included in the repository.
You must download them separately before building the application.
