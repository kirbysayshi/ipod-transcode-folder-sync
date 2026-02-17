# 001: Browser-Only, No Server

## Status
Accepted

## Context
We need a tool to sync a music folder to an iPod, transcoding FLAC to ALAC. This could be a CLI tool, an Electron app, or a web app.

## Decision
Static single-page web app with no server component. All file access via the File System Access API, all transcoding via ffmpeg.wasm in the browser.

## Consequences
- No install required beyond a static file server
- Restricted to Chrome/Edge (File System Access API is not available in Firefox/Safari)
- Transcoding is slower than native ffmpeg but acceptable for personal use
- Can be hosted on any static hosting provider
