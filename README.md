# iPod Transcode & Folder Sync

Browser-based tool to sync a music library to an iPod/target folder, optimizing for a 4th-gen grayscale iPod running Rockbox along the way.

Functionality is purposefully limited for my specific use case: I've got a folder of music, and want to selectively send some of it in FLAC[^1] to my 4th Gen Grayscale iPod!

[^1]: Previously, I thought ALAC was the most efficient for this device, but I recently learned that all decoding on this gen iPod happens in software! So it's best to just keep it FLAC, but downsampled to match what the DAC can output: 44.1/16.

## Details

- FLAC gets resampled to 44.1kHz/16-bit if needed
- Embedded cover art on FLAC,MP3,MP4 is rescaled to 128px jpg if needed to help the iPod CPU
- Sidecar images are treated similarly
- Everything else passes through untouched

## Setup

```sh
pnpm install
pnpm dev
```

## Building ffmpeg.wasm from source

The app needs a custom ffmpeg.wasm build, otherwise larger inputs cause it to crash. See [./decisions/002-ffmpeg-wasm-from-source.md]()

```sh
./build-ffmpeg.sh
```

NOTE: this requires Docker (I used `colima`). It failed with only 8GB of RAM when compiling. It was successful with 16GB.

## Disclaimer

Just FYI, the code in this repo is mostly AI-generated.