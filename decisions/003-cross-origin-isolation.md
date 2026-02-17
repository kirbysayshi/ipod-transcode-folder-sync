# 003: Cross-Origin Isolation Headers

## Status
Accepted

## Context
ffmpeg.wasm requires `SharedArrayBuffer`, which browsers only expose when the page is cross-origin isolated. This requires two HTTP headers:

- `Cross-Origin-Opener-Policy: same-origin`
- `Cross-Origin-Embedder-Policy: require-corp`

## Decision
Configure these headers in `vite.config.js` for the dev server. Any production static host must also set these headers.

## Consequences
- All cross-origin resources must be loaded with CORS or converted to same-origin (e.g. blob URLs)
- The ffmpeg core files are served from `public/ffmpeg/` (same-origin) to avoid COEP blocking
- The static host used for production deployment must support custom headers
