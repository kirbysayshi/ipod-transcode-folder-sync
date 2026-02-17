# iPod Transcode & Folder Sync

Browser-based tool to sync a music library to an iPod/target folder, transcoding FLAC to ALAC[^1] along the way.

[^1]: ALAC is hardware-decoded on older iPods, making it significantly more battery efficient.

Functionality is purposefully limited for my specific use case: I've got a folder of music, and want to selectively send some of it in ALAC to my 4th Gen Ipod!

## Setup

```
pnpm install
pnpm dev
```

## Building ffmpeg.wasm from source

The app needs a custom ffmpeg.wasm build, otherwise larger inputs cause it to crash. See [./decisions/002-ffmpeg-wasm-from-source.md]()

```
./build-ffmpeg.sh
```
