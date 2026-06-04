# 005: FLAC Conformance Policy (was ALAC)

## Status
Accepted (supersedes the ALAC transcode target from the original design)

## Context
Target device: 4th-gen grayscale iPod (160×128 display) running Rockbox, which
software-decodes audio. FLAC is cheaper to decode than ALAC on these PortalPlayer
CPUs, so ALAC's only advantage — hardware decode on the stock firmware — does not
apply here.

## Decision
Target codec is FLAC, not ALAC. Files are made conformant for the device:

- **Audio**: FLAC is resampled to 44.1 kHz when higher and reduced to 16-bit when
  deeper. Already-conformant FLAC audio is stream-copied (bit-exact); non-FLAC
  audio is never transcoded.
- **Embedded art** (any format): downscaled to ≤128 px on the longest side, kept
  in color.
- **Sidecar cover** (a cover/folder/front/`<album>` image in the album folder):
  downscaled to ≤128 px and written as `cover.jpg`, the name Rockbox looks for.
  Previously sidecar images were dropped — the scan only collected audio.

Routing is decided per-file in JS from bytes already read for copying, so
conformant art-less files skip the transcoder entirely and are copied verbatim.
ffmpeg handles audio and embedded art; the browser canvas handles sidecar images.

## Alternatives Considered
- **Grayscale art**: the display is grayscale, but downscaling to 128 px already
  makes the iPod's decode trivial, and the JPEG encoder won't emit a true
  1-component image (it pads grayscale back to three components). So it buys no
  measurable CPU — art is left in color.
- **ffmpeg/ffprobe for detection**: rejected. ffprobe isn't exposed by the
  wrapper, and scraping ffmpeg's log is brittle (bit depth especially) and forces
  every file through the transcoder, killing the byte-copy fast path. Parsing the
  bytes in JS adds no extra I/O.
- **Route everything through ffmpeg, no JS art detection**: simpler, but remuxes
  every art-less non-FLAC file. Kept the JS scanners for the fast path.

## Consequences
- No ffmpeg rebuild — the required codecs and filters are in the current build.
- Per-format art detection is the maintenance cost; the container formats are stable.
- An art-marker false positive causes a needless remux, never a wrong output.

