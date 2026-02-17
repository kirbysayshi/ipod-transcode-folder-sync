# iPod Transcode & Folder Sync

Browser-based tool to sync a music library to an iPod/target folder, transcoding FLAC to ALAC[^1] along the way.

[^1]: ALAC is hardware-decoded on older iPods, making it significantly more battery efficient than FLAC which requires software decoding.

Functionality is purposefully limited for my specific use case: I've got a folder of music, and want to selectively send some of it in ALAC to my 4th Gen Ipod!

## Setup

```
pnpm install
pnpm dev
```

Open http://localhost:5173 in Chrome (requires File System Access API).

## Building ffmpeg.wasm from source

The app needs a custom ffmpeg.wasm build with a 5MB stack size fix (not yet released to npm). Requires Docker 23.0+:

```
./build-ffmpeg.sh
```

Output goes to `public/ffmpeg/`.
