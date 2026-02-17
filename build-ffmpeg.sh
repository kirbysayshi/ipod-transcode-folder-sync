#!/bin/bash
# Build ffmpeg.wasm from source with the 5MB stack size fix.
# Requires Docker 23.0+ with buildx.
# Output: public/ffmpeg/ffmpeg-core.{js,wasm}

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/ffmpeg-build"
OUT_DIR="$SCRIPT_DIR/public/ffmpeg"

if [ ! -d "$BUILD_DIR" ]; then
  echo "Cloning ffmpeg.wasm..."
  git clone --depth 1 https://github.com/ffmpegwasm/ffmpeg.wasm.git "$BUILD_DIR"
fi

echo "Building single-threaded production @ffmpeg/core (this takes ~1 hour on first run)..."
cd "$BUILD_DIR"
make prd

echo "Copying build output..."
mkdir -p "$OUT_DIR"
cp "$BUILD_DIR/packages/core/dist/esm/ffmpeg-core.js" "$OUT_DIR/"
cp "$BUILD_DIR/packages/core/dist/esm/ffmpeg-core.wasm" "$OUT_DIR/"

echo "Done! Files in $OUT_DIR:"
ls -lh "$OUT_DIR"/ffmpeg-core.*
