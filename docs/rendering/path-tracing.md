# Path Tracer

UE's **reference path tracer** for cinematic-quality offline renders. Not a real-time mode. Targets Movie Render Queue and high-end stills.

## Enable

`r.PathTracing 1` in the viewport (set as Real-Time Path Tracing in View Mode) or as a setting per shot in Movie Render Queue.

Requires a DXR-capable GPU and `r.RayTracing 1`.

## Capabilities

| Feature | Status |
| --- | --- |
| Multi-bounce diffuse / specular | ★ |
| Refraction / caustics | ★ |
| Volumetric scattering | ★ |
| Subsurface scattering | ★ |
| Hair / Strand rendering | ★ |
| Path-traced GI denoiser | OIDN / OptiX |
| Motion blur | ★ (accurate, ground-truth) |
| DoF | ★ |
| Material override (white furnace) | ★ |

## Workflow with Movie Render Queue

1. Add a **Movie Render Queue** job
2. Render Settings → **+ Path Tracer**
3. Set **Reference Motion Blur** and **Sample Count** (256–1024 for production)
4. Enable **OIDN Denoiser** in the Anti-Aliasing settings
5. Use **Console Variables** preset to push quality CVars

## Quality CVars

| CVar | Effect |
| --- | --- |
| `r.PathTracing.MaxBounces 16` | Bounce limit |
| `r.PathTracing.SamplesPerPixel 1024` | Convergence budget |
| `r.PathTracing.UseDLSSDenoiser 1` | DLSS Ray Reconstruction denoise |
| `r.PathTracing.AdaptiveSampling 1` | Sample where noise lives |
| `r.PathTracing.MaxPathIntensity 50` | Firefly clamp |

## When to use

- Final-frame cinematics, key art, marketing renders.
- Reference baseline to evaluate Lumen quality against.
- Light-baking workflows when Lightmass is too noisy.

## When not to use

- Any real-time application.
- Animated characters with rapidly-changing topology (cache misses dominate).

## Links

- [UE — Path Tracer](https://docs.unrealengine.com/5.7/en-US/path-tracer-in-unreal-engine/)
