# Sound Classes & Submixes

The bus/category routing system. Classes group sources; Submixes are the output endpoints.

## SoundClass

A `USoundClass` is a category (Music, SFX, Dialogue, UI). Sources reference their class; properties propagate down a class hierarchy.

| Property | Effect |
| --- | --- |
| **Volume** | Per-class master volume |
| **Pitch** | Per-class pitch scalar |
| **Parent Class** | Inherit settings |
| **Stereo Bleed** | Cross-channel bleed for stereo sources |
| **LFE Bleed** | Low-frequency channel mix |
| **Low Pass Filter Frequency** | Per-class LPF |

## SoundMix

A snapshot of `(SoundClass → Volume/Pitch/LPF)` overrides. Push at runtime to duck music during dialogue:

```cpp
UGameplayStatics::PushSoundMixModifier(World, DialogueMix);
// later
UGameplayStatics::PopSoundMixModifier(World, DialogueMix);
```

## Submix

`USoundSubmix` is the audio output bus. Sources go through a chain of submixes (e.g. `SFX_Submix → Master_Submix`). Submixes can have **submix effects**:

- Compressor
- EQ
- Convolution Reverb
- Multiband Compressor
- Submix Delay
- Custom MetaSound submix patch

## Routing example

```
Footstep Sound → SFX_Class → SFX_Submix → Master_Submix → Output
Music_Stream → Music_Class → Music_Submix (Compressor) → Master_Submix
```

## Console commands

```
au.SubmixUtilityDisplayInfo 1     # show submix graph
au.LogPlayingSounds 1              # log every voice
au.3dVisualize.Enabled 1           # visualize attenuation cones
```

## See also

- [Audio Volumes](../volumes/audio-volumes.md)
