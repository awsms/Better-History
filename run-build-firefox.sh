#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHROME_BUILD_DIR="$ROOT_DIR/build"
FIREFOX_BUILD_DIR="$ROOT_DIR/build-firefox"
FIREFOX_MANIFEST="$ROOT_DIR/firefox/manifest.json"
FIREFOX_BACKGROUND="$ROOT_DIR/firefox/background.js"
WEB_EXT_ARTIFACTS_DIR="$FIREFOX_BUILD_DIR/web-ext-artifacts"

"$ROOT_DIR/run-build.sh"

rm -rf "$FIREFOX_BUILD_DIR"
mkdir -p "$FIREFOX_BUILD_DIR"
cp -a "$CHROME_BUILD_DIR"/. "$FIREFOX_BUILD_DIR"/
cp "$FIREFOX_MANIFEST" "$FIREFOX_BUILD_DIR/manifest.json"
cp "$FIREFOX_BACKGROUND" "$FIREFOX_BUILD_DIR/background.js"

echo "Wrote Firefox build: $FIREFOX_BUILD_DIR"

if command -v web-ext >/dev/null 2>&1; then
  web-ext build --source-dir "$FIREFOX_BUILD_DIR" --artifacts-dir "$WEB_EXT_ARTIFACTS_DIR"
  echo "Wrote Firefox package(s): $WEB_EXT_ARTIFACTS_DIR"
else
  echo "Skipped Firefox packaging: web-ext not found"
fi
