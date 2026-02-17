# 002: Custom ffmpeg.wasm Build from Source

## Status
Accepted

## Context
ffmpeg.wasm is the only viable option for in-browser FLAC-to-ALAC transcoding. However, the published npm packages (`@ffmpeg/core` up to 0.12.10, January 2025) have a default Emscripten stack size that is too small for certain audio codecs. This causes `RuntimeError: memory access out of bounds` after a few tracks.

A fix (`-sSTACK_SIZE=5MB`) was merged in [PR #824](https://github.com/ffmpegwasm/ffmpeg.wasm/pull/824) on April 5, 2025, but has not been included in any npm release as of February 2026.

## Alternatives Considered
- **`@ffmpeg/core@0.12.10`** (latest npm release): Same stack overflow after ~4 tracks.
- **`@ffmpeg/core-mt`** (multi-threaded): Loads successfully but hangs on `ffmpeg.exec()` — worker blob URLs don't communicate properly with the main thread.
- **Recreating the ffmpeg instance per album**: Avoids memory accumulation between albums but doesn't fix the per-track stack overflow within a single album.

## Decision
Clone the [ffmpeg.wasm repo](https://github.com/ffmpegwasm/ffmpeg.wasm) at HEAD (which includes the stack fix) and build `@ffmpeg/core` from source using Docker. The built `ffmpeg-core.js` and `ffmpeg-core.wasm` are placed in `public/ffmpeg/` and served as static assets.

A `build-ffmpeg.sh` script makes this reproducible.

## Consequences
- First build takes ~1 hour (subsequent builds are cached by Docker)
- Requires Docker 23.0+ with buildx
- The built wasm files (~30MB) are committed to `public/ffmpeg/` or regenerated as needed
- When a new `@ffmpeg/core` release includes the stack fix, we can switch back to the npm package
