# Sound Cues

Legacy graph-based audio source. Still works in UE 5.7; useful for simple variations + branching, less expressive than MetaSounds.

## Node families

| Family | Nodes |
| --- | --- |
| **Sources** | Wave Player, Looping Wave Player |
| **Selection** | Random, Sequence, Switch, Branch |
| **Modulation** | Modulator (volume/pitch), Continuous Modulator |
| **Mixing** | Mixer |
| **Spatialization** | Attenuation, Concatenator |
| **Output** | Output (auto-attached) |

## When to use

- Simple random selection between N waves
- Pitch/volume modulation
- Bridge from legacy projects

For new audio work, prefer MetaSounds.

## Properties

| Property | Effect |
| --- | --- |
| **Sound Class** | Routes to a SoundClass |
| **Attenuation** | 3D playback settings |
| **Concurrency** | Voice limiting |
| **Modulation** | Per-instance pitch/volume |

## Replacement guidance

Most SoundCues can be ported to MetaSounds in under an hour. The exception is the `Sound Cue Branch` based on `Sound Mix` snapshots — that flow has no direct MetaSound equivalent.

## See also

- [MetaSounds](metasounds.md)
