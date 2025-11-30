.PHONY: test
GIT_COMMIT := $(shell git rev-parse --short HEAD)
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
REPO_URL := "https://github.com/drunkod/bhikers.club"
# Extract owner and repo name
repo_path := $(shell echo $(REPO_URL) | sed -E 's|https://github.com/([^/]+)/([^/]+).*|\1/\2|')
# Build GitHub API URL for latest release
LATEST_RELEASE_API := https://api.github.com/repos/$(repo_path)/releases/latest
# These would be passed via GitHub Actions ENV or defined manually for local testing
BUILD_NAME ?= $(shell grep 'version:' pubspec.yaml | cut -d '+' -f1 | sed 's/version: //')
BUILD_NUMBER ?= $(shell grep 'version:' pubspec.yaml | cut -d '+' -f2)
BUILD_ID := $(BUILD_NAME)+$(BUILD_NUMBER)

# Keystore configuration
KEYSTORE_FILE ?= drunkod-release.jks
KEYSTORE_ALIAS ?= github-drunkod
KEYSTORE_VALIDITY ?= 10000
KEYSTORE_DNAME ?= "CN=drunkod.club, OU=Dev, O=Bhikers, L=City, ST=State, C=US"

##
# Bhikers Club
#
# @file
# @version 0.1

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

locale-gen: ## Generate dart code for locale files
	flutter pub run easy_localization:generate -S src/resources/langs/

test: ## Run tests
	clj -M:test:cljd test

compile: ## Compile ClojureDart code
	clj -M:cljd compile

apk: compile ## Build debug APK
	flutter build apk \
             --debug --pub --suppress-analytics

apk-release: compile ## Build release APK
	@echo "Building APK with:"
	@echo "  GIT_COMMIT:          $(GIT_COMMIT)"
	@echo "  GIT_BRANCH:          $(GIT_BRANCH)"
	@echo "  BUILD_NAME:          $(BUILD_NAME)"
	@echo "  BUILD_NUMBER:        $(BUILD_NUMBER)"
	@echo "  BUILD_ID:            $(BUILD_ID)"
	@echo "  REPO_URL:            $(REPO_URL)"
	@echo "  LATEST_RELEASE_API:  $(LATEST_RELEASE_API)"
	flutter build apk \
		--dart-define=GIT_COMMIT=$(GIT_COMMIT) \
		--dart-define=GIT_BRANCH=$(GIT_BRANCH) \
		--dart-define=REPO_URL=$(REPO_URL) \
		--dart-define=LATEST_RELEASE_API=$(LATEST_RELEASE_API) \
		--build-number "$(BUILD_NUMBER)" \
		--build-name "$(BUILD_NAME)" \
		--release --no-pub --suppress-analytics

clean: ## Clean ClojureDart code
	clj -M:cljd clean

clean-full: clean ## Full clean (ClojureDart + Flutter)
	flutter clean

upgrade: ## Upgrade dependencies
	clj -M:cljd upgrade
	flutter pub upgrade

format: ## Format ClojureDart code
	cljfmt fix --file-pattern '\.cljd' src/club/bhikers/

precompile-svg: ## Precompile SVG icons
	flutter pub run vector_graphics_compiler --libpathops $(FLUTTER_HOME)/bin/cache/artifacts/engine/linux-x64/libpath_ops.so --input-dir ./src/resources/icons/symbols/

# =============================================================================
# Release & Signing
# =============================================================================

keystore-generate: ## Generate a new release keystore
	@if [ -f "$(KEYSTORE_FILE)" ]; then \
		echo "Error: $(KEYSTORE_FILE) already exists. Remove it first or use a different name."; \
		exit 1; \
	fi
	@read -p "Enter keystore password: " -s KEYSTORE_PASSWORD; echo; \
	keytool -genkey -v -keystore $(KEYSTORE_FILE) \
		-keyalg RSA -keysize 2048 -validity $(KEYSTORE_VALIDITY) \
		-alias $(KEYSTORE_ALIAS) \
		-storepass $$KEYSTORE_PASSWORD \
		-keypass $$KEYSTORE_PASSWORD \
		-dname $(KEYSTORE_DNAME)
	@echo ""
	@echo "✅ Keystore generated: $(KEYSTORE_FILE)"
	@echo "⚠️  Keep this file safe and never commit it to git!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Run 'make secrets-upload' to upload secrets to GitHub"
	@echo "  2. Backup $(KEYSTORE_FILE) securely"

secrets-upload: ## Upload keystore and password to GitHub secrets
	@if [ ! -f "$(KEYSTORE_FILE)" ]; then \
		echo "Error: $(KEYSTORE_FILE) not found. Run 'make keystore-generate' first."; \
		exit 1; \
	fi
	@command -v gh >/dev/null 2>&1 || { echo "Error: GitHub CLI (gh) is required. Install from https://cli.github.com/"; exit 1; }
	@echo "Checking GitHub CLI authentication..."
	@gh auth status || { echo "Run 'gh auth login' first"; exit 1; }
	@echo ""
	@read -p "Enter keystore password: " -s KEYSTORE_PASSWORD; echo; \
	echo "Uploading KEYSTORE_JKS..."; \
	base64 -w 0 $(KEYSTORE_FILE) | gh secret set KEYSTORE_JKS; \
	echo "Uploading KEYSTORE_PASSWORD..."; \
	echo "$$KEYSTORE_PASSWORD" | gh secret set KEYSTORE_PASSWORD
	@echo ""
	@echo "✅ Secrets uploaded successfully!"
	@echo ""
	@echo "Verify with: make secrets-list"

secrets-list: ## List configured GitHub secrets
	@command -v gh >/dev/null 2>&1 || { echo "Error: GitHub CLI (gh) is required."; exit 1; }
	gh secret list

secrets-delete: ## Delete GitHub secrets (use with caution)
	@command -v gh >/dev/null 2>&1 || { echo "Error: GitHub CLI (gh) is required."; exit 1; }
	@read -p "Are you sure you want to delete secrets? [y/N] " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		gh secret delete KEYSTORE_JKS || true; \
		gh secret delete KEYSTORE_PASSWORD || true; \
		echo "✅ Secrets deleted"; \
	else \
		echo "Cancelled"; \
	fi

# =============================================================================
# Release Tags
# =============================================================================

release: ## Create and push a release tag (usage: make release VERSION=1.0.1)
	@if [ -z "$(VERSION)" ]; then \
		echo "Error: VERSION is required. Usage: make release VERSION=1.0.1"; \
		exit 1; \
	fi
	@echo "Creating release v$(VERSION)..."
	git tag v$(VERSION)
	git push origin v$(VERSION)
	@echo ""
	@echo "✅ Release v$(VERSION) created!"
	@echo "Check build status: https://github.com/$(repo_path)/actions"

release-list: ## List all release tags
	git tag -l 'v*' | sort -V

release-delete: ## Delete a release tag (usage: make release-delete VERSION=1.0.1)
	@if [ -z "$(VERSION)" ]; then \
		echo "Error: VERSION is required. Usage: make release-delete VERSION=1.0.1"; \
		exit 1; \
	fi
	@read -p "Are you sure you want to delete v$(VERSION)? [y/N] " confirm; \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		git tag -d v$(VERSION) || true; \
		git push origin :refs/tags/v$(VERSION) || true; \
		echo "✅ Tag v$(VERSION) deleted"; \
	else \
		echo "Cancelled"; \
	fi
