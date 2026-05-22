# Quartz

Sample-accurate audio scheduling. Trigger sounds on bar/beat boundaries instead of frame ticks — required for adaptive music, rhythm games, and any tempo-sync gameplay.

## Concept

A **Quartz Clock** ticks at a defined BPM. Sounds and gameplay code can subscribe — events fire on **musical boundaries** (beats, bars, 8 bars).

## Setup

```cpp
UQuartzSubsystem* QSS = GetWorld()->GetSubsystem<UQuartzSubsystem>();
FQuartzClockSettings Settings;
Settings.TimeSignature = FQuartzTimeSignature(4, 4);
Settings.SourceTimeSignature = Settings.TimeSignature;
UQuartzClockHandle* Clock = QSS->CreateNewClock(this, TEXT("MainClock"), Settings);
Clock->SetBeatsPerMinute(120.0f);
Clock->StartClock(this, Clock);
```

## Playing a sound on the next beat

```cpp
FQuartzQuantizationBoundary Boundary;
Boundary.Quantization = EQuartzCommandQuantization::Bar;
Boundary.Multiplier = 1;
Boundary.CountingReferencePoint = EQuarztQuantizationReference::CurrentTimeRelative;

UGameplayStatics::SpawnSound2D(World, MyMetaSound);
// or with MetaSound subscription:
MetaSoundSource->SubscribeToClock(this, FName("MainClock"));
```

## Use cases

- Adaptive music — layers fade in on bar boundaries
- Rhythm games — input judged against clock
- Procedural drum patterns
- Synced cinematic events

## Combine with MetaSounds

MetaSounds can subscribe to a Quartz clock — all triggers inside the MetaSound graph snap to the clock's grid.

## Gotchas

- BPM changes during playback take effect on the *next boundary*, not immediately.
- Sample-accurate scheduling requires sources to be MetaSounds or SoundWaves; some legacy SoundCue paths fall back to frame ticks.
- Clocks are per-world; don't outlive level transitions.

## See also

- [MetaSounds](metasounds.md)
- [UE — Quartz](https://docs.unrealengine.com/5.7/en-US/quartz-sample-accurate-audio-scheduling-in-unreal-engine/)
