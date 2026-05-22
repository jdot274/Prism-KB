# Audio Volumes (in audio context)

This page mirrors [Volumes → Audio Volumes](../volumes/audio-volumes.md) from the audio perspective.

## Quick reference

| Setting | Effect |
| --- | --- |
| **Reverb Effect** | `UReverbEffect` preset for the region |
| **Reverb Volume** | Wet level |
| **Reverb Fade Time** | Crossfade duration when listener enters/exits |
| **Submix Sends** | Per-submix routing override |
| **Interior / Exterior LPF + Volume** | Door/wall effect on sources |
| **Ambient Zone** | Source filter for `AmbientSound` actors |

## Listener vs source perspective

Audio Volumes have **interior** and **exterior** properties:

- **Listener inside the volume**: interior settings apply to *external* sources (muffled music through a wall).
- **Listener outside the volume**: exterior settings apply to *interior* sources.

This is what makes "you hear muffled music from the next room" work.

## Reverb presets

| Preset | Use |
| --- | --- |
| Bathroom | Tile rooms, small reflective spaces |
| Stone Room | Caves, dungeons |
| Auditorium | Large halls |
| Forest | Open natural |
| Underwater | Submerged scenes |
| Carpeted Hall | Dampened indoor |

Or author custom `UReverbEffect` assets — the editor lets you blend impulse responses.

## See also

- [Audio Volumes (Volumes section)](../volumes/audio-volumes.md)
- [Quartz](quartz.md)
