# Sequencer

UE's non-linear cinematic editor. Keyframe anything: actor transforms, properties, materials, audio, anim, cameras, Niagara, post-process.

## Anatomy

- **Level Sequence** — the asset
- **Master Sequence** — sequence containing shot sub-sequences
- **Track** — one row in the timeline (Transform, Anim, Audio, Event)
- **Section** — one segment of a track
- **Subscene** — nested sequence

## Common tracks

| Track | Use |
| --- | --- |
| Transform | Animate actor location/rotation/scale |
| Skeletal Animation | Play AnimSequences / Montages |
| Audio | Schedule sound |
| Camera Cuts | Switch cameras across shots |
| Event | Trigger BP / C++ events |
| Material Parameter Collection | Animate global material params |
| Niagara | Trigger / parameterize VFX |
| Geometry Cache | Scrub baked sims |

## Game vs cinematic

Sequencer drives both:

- **Cinematics** — Movie Render Queue, locked timeline
- **Gameplay sequences** — fire from BP `Play Sequence`, branch on conditions

## Movie Render Queue

`Window → Cinematics → Movie Render Queue` — production-grade renderer:

- Reference Motion Blur (more accurate than realtime)
- Anti-Aliasing settings (spatial samples + temporal samples)
- OIDN / DLSS Ray Reconstruction denoise
- Console variables override
- Path Tracer integration

## Custom sections

Implement `UMovieSceneSection` + `UMovieSceneTrack` for custom track types — niche but possible.

## Sequencer keyframing best practices

- Animate via **Cine Camera Actor**, not regular Camera, for film-grade focus / aperture
- Use **Camera Anim Sequence** for reusable shakes
- Bake to **Anim Sequence** for retargetable cinematics
- For game-driven sequences, mark sections **Take Aspect Ratio Constraint** off

## Links

- [UE — Sequencer](https://docs.unrealengine.com/5.7/en-US/sequencer-overview/)
- [UE — Movie Render Queue](https://docs.unrealengine.com/5.7/en-US/movie-render-queue-in-unreal-engine/)
