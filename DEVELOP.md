# Development Setup

## Prerequisites
Ensure you have [Nix](https://nixos.org/download.html) installed on your system.

## Setting Up the Development Environment

1. **Install Nix** (if not already installed):
   ```sh
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. **Enable Nix flakes** by adding to `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`:
   ```sh
   experimental-features = nix-command flakes
   ```

3. **Enter the development shell**:
   ```sh
   nix develop --impure
   ```

4. **View available commands**:
   ```sh
   make help
   ```

## Building the Android App

1. **Check Flutter setup**:
   ```sh
   flutter doctor
   ```
   Ensure there are no errors.

2. **Compile CLJD code**:
   ```sh
   make compile
   ```

3. **Build the APK for release**:
   ```sh
   make apk-release
   ```

This will generate the final APK in the `build/app/outputs/flutter-apk/` directory.

## Launching Android Emulator

1. Open Android Studio:
   ```sh
   android-studio
   ```

2. Create an emulator and verify with `flutter doctor`

3. Run the app:
   ```sh
   clj -M:cljd flutter -d emulator-5554
   ```

---

## Release Setup (One-time)

Before creating releases, you need to set up code signing.

### Prerequisites

- [GitHub CLI](https://cli.github.com/) installed
- Authenticated with GitHub: `gh auth login`

### 1. Generate Release Keystore

```sh
make keystore-generate
```

This creates `bhikers-release.jks`. **Keep this file safe and never commit it to git!**

### 2. Upload Secrets to GitHub

```sh
make secrets-upload
```

This uploads:
- `KEYSTORE_JKS` - Base64 encoded keystore
- `KEYSTORE_PASSWORD` - Keystore password

### 3. Verify Secrets

```sh
make secrets-list
```

Should show:
```
KEYSTORE_JKS        Updated ...
KEYSTORE_PASSWORD   Updated ...
```

### Backup Your Keystore

⚠️ **Important**: If you lose your keystore, you cannot update your app on Google Play!

Store `bhikers-release.jks` securely:
- Password manager
- Encrypted backup
- Secure cloud storage

---

## Creating Releases

### Create a Release

```sh
make release VERSION=1.0.1
```

This will:
1. Create a git tag `v1.0.1`
2. Push the tag to GitHub
3. Trigger the CI/CD workflow
4. Build and sign the APK
5. Create a GitHub Release with the APK attached

### Check Build Status

```sh
# Open in browser
open https://github.com/parasitid/bhikers.club/actions
```

### List All Releases

```sh
make release-list
```

### Delete a Release (if needed)

```sh
make release-delete VERSION=1.0.1
```

---

## Makefile Commands Reference

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make compile` | Compile ClojureDart code |
| `make test` | Run tests |
| `make apk` | Build debug APK |
| `make apk-release` | Build release APK |
| `make clean` | Clean ClojureDart code |
| `make clean-full` | Full clean (ClojureDart + Flutter) |
| `make format` | Format ClojureDart code |
| `make upgrade` | Upgrade dependencies |
| `make keystore-generate` | Generate release keystore |
| `make secrets-upload` | Upload secrets to GitHub |
| `make secrets-list` | List GitHub secrets |
| `make secrets-delete` | Delete GitHub secrets |
| `make release VERSION=x.x.x` | Create and push release tag |
| `make release-list` | List all release tags |
| `make release-delete VERSION=x.x.x` | Delete a release tag |
