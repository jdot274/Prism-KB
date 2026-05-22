# Audio Volumes

`AAudioVolume` defines an acoustic region — reverb, occlusion, ambient zone settings. Crucial for indoor/outdoor transitions.

## Settings groups

| Group | Properties |
| --- | --- |
| **Reverb** | ReverbEffect asset, Volume, FadeTime |
| **Submix Send** | Per-submix routing & gain |
| **Interior** | Interior/Exterior LPF + Volume scales |
| **Occlusion** | Plugin (Steam Audio / built-in), trace channel |
| **Ambient Zone** | Source filter for `AmbientSound` actors |

## Priority

Higher-priority volumes override lower when overlapping. Use case: a small reverb-heavy room inside a larger building — set the room volume to higher priority.

## Interior / Exterior model

Audio Volumes have **interior** and **exterior** modifier knobs. As the listener crosses the boundary, the audio engine cross-fades:

- Sources *inside* the volume get the interior settings when the listener is *outside*
- Sources *outside* get the exterior settings when the listener is *inside*

This is what makes "you can hear muffled music through the door" work naturally.

## Reverb Effect assets

`UReverbEffect` — choose presets:

| Preset | Use |
| --- | --- |
| Bathroom | Tile rooms |
| Stone Room | Caves |
| Auditorium | Large halls |
| Forest | Open outdoor |
| Underwater | Submerged |

Or author custom IRs with the **Convolution Reverb** plugin.

## Replication

Audio Volume membership is local — not replicated. Each client computes its own listener.

## See also

- [MetaSounds](../audio/metasounds.md) — the modern source path
- [Audio Plugins](../plugins/audio.md)
