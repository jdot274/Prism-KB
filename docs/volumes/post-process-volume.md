# Post Process Volume

`APostProcessVolume` — applies a post process chain to anything inside its bounds, blending with the global default and other volumes by priority + blend weight.

## Key properties

| Property | Effect |
| --- | --- |
| **Unbound** | Affect the whole world regardless of bounds |
| **Priority** | Higher priority wins where volumes overlap |
| **Blend Weight** | 0–1 — partial application |
| **Blend Radius** | Soft falloff at the boundary (cm) |
| **Settings → ...** | Hundreds of per-effect properties |

## Setting categories

| Category | Notable settings |
| --- | --- |
| Lens / Camera | Aperture, ISO, Shutter Speed, FocalDistance |
| Color Grading | Saturation, Contrast, Gain, Offset, Slope (ASC CDL) |
| Bloom | Intensity, Threshold, ConvolutionKernel |
| Auto Exposure | MinBrightness, MaxBrightness, SpeedUp/Down |
| Lumen | LumenSceneLightingQuality, LumenReflectionQuality |
| Path Tracing | MaxBounces, SamplesPerPixel |
| Anti-Aliasing | TSR / DLSS / FSR settings |
| Local Exposure | HighlightContrastScale, ShadowContrastScale |
| Film Grain | Intensity, Response, Texel Size |

## Layering

Use multiple volumes for "zones" — e.g.

- Global default volume (Unbound, Priority 0) — base look
- Cave volume (Priority 10, BlendRadius 200) — darker, warmer
- Boss arena volume (Priority 20) — red color grading, motion blur

## Blendable materials

The **Blendables** array accepts:

- Post Process Materials (Material Domain = Post Process)
- LUT textures
- Asset User Data subclasses for custom blends

Stack many small effects — each material runs as one full-screen pass; profile under `ProfileGPU → PostProcessing`.

## Per-camera override

Camera Components have **PostProcessBlendWeight** and full PostProcessSettings of their own — used for player cameras, ironsights, photo mode.

## Console parity

`r.*` CVars can override volume settings entirely. Useful in shipping for adjusting quality per-platform:

```
r.MotionBlurQuality 0
r.BloomQuality 3
r.Tonemapper.Quality 5
```

## Gotchas

- **Auto Exposure** is per-camera + per-volume — they multiply. Set Min=Max to force a fixed exposure.
- **Lumen settings** only apply if Lumen is enabled project-wide.
- A `Blend Radius = 0` causes a hard cut, which is sometimes desirable (e.g. portal effect).
- The **Color Grading > Misc** section has a `Scene Color Tint` that affects everything — easy to forget.

## Linked pages

- [Render Targets](../rendering/render-targets.md) — Post Process materials and Render Targets share infrastructure
- [Post Process Pipeline](../rendering/post-process.md) — what each effect does
