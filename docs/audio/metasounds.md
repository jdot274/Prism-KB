# MetaSounds

Procedural audio source. A DSP graph that generates audio per-sample, replacing `SoundCue` for new authoring.

## Two asset types

| Asset | Purpose |
| --- | --- |
| `UMetaSoundSource` | Playable source (the thing you call `Play Sound at Location` on) |
| `UMetaSoundPatch` | Reusable subgraph |

## Authoring

The MetaSound editor is a node graph:

```
Inputs → Generators / Players → Filters / Mixers → Output
```

| Node family | Examples |
| --- | --- |
| **Generators** | Oscillator, Noise, Sample Player, Wave Player |
| **Filters** | LPF, HPF, BPF, EQ |
| **Modulation** | LFO, Envelope, Random |
| **Math** | Add, Multiply, Lerp |
| **Time** | Delay, Triggers, BPM |
| **Output** | Audio Out (mono / stereo / 5.1) |

## Inputs (parameters)

Expose inputs on the graph — they become **gameplay-tweakable** parameters:

```cpp
UAudioComponent* AC = UGameplayStatics::SpawnSound2D(World, MyMetaSound);
AC->SetFloatParameter(FName("Pitch"), 1.2f);
AC->SetIntParameter(FName("Layer"), 3);
```

## Compared to SoundCue

| SoundCue | MetaSound |
| --- | --- |
| Pre-rendered samples + simple ops | Per-sample DSP graph |
| Random/sequence/branch nodes only | Full DSP toolkit |
| Limited modulation | Full LFO/envelope/MIDI |
| Stable, well-understood | Modern, still evolving |

## Quartz integration

For sample-accurate timing — see [Quartz](quartz.md). MetaSounds can be **subscribed to a Quartz clock**, with all triggers locked to bar/beat boundaries.

## Custom DSP nodes (C++)

Implement `Metasound::INode` to add custom DSP. Niche but powerful — used by audio middleware integrations.

## Gotchas

- MetaSounds execute on the **audio render thread** — variable reads must be thread-safe.
- Very deep graphs add CPU per voice. Profile with `au.metasound.LogVoiceCount 1`.
- Some legacy systems (e.g. Sequencer Sound Track) don't fully support MetaSound parameters yet.

## See also

- [Audio Plugins](../plugins/audio.md)
- [UE — MetaSounds](https://docs.unrealengine.com/5.7/en-US/metasounds-in-unreal-engine/)
