# Post Process Pipeline

Per-camera / per-volume image effects applied after the main render and before tonemapping. Authored via **Post Process Volumes** or directly on a Camera component.

## Built-in effects (in order)

1. **Auto Exposure** (eye adaptation, histogram-based)
2. **Bloom** (FFT or convolution)
3. **Lens Flares**
4. **Vignette**
5. **Chromatic Aberration**
6. **Depth of Field** (Gaussian, Bokeh, Cinematic)
7. **Motion Blur** (per-object + camera)
8. **Color Grading** (ACES / Filmic, LUTs)
9. **Film Grain**
10. **Local Exposure** (UE 5.x — per-region tonemapping)
11. **Tonemapper** (ACES default, custom curves)

## Custom Post Process Materials

Material Domain = **Post Process**, then add it in a Post Process Volume's Blendable list.

Example — vignette with screen-space UV:

```hlsl
// Inside the post-process material's emissive output
float2 uv = ScreenAlignedUV;
float d = length(uv - 0.5);
return lerp(SceneTexture(0, uv).rgb, float3(0,0,0), saturate(d * 2 - 0.5));
```

Blendable Location options:

- `Before Tonemapping` — operates on HDR scene color
- `After Tonemapping` — operates on tonemapped LDR
- `Replacing the Tonemapper` — full takeover
- `Scene Color Before DOF` — early in chain
- `Scene Color After DOF` — late in chain

## Stencil + custom buffers

Custom Stencil = a per-pixel ID buffer. Use it to mask post-process effects to specific actors:

1. On an actor's mesh component: **Render Custom Depth Pass = true**, **Custom Stencil = 50**
2. In a Post Process material: `SceneTexture: CustomStencil` returns the ID
3. Branch on the ID to apply outline / highlight / x-ray

## CVars

| CVar | Effect |
| --- | --- |
| `r.Tonemapper.Quality 5` | Tonemapper quality |
| `r.BloomQuality 5` | Bloom convolution quality |
| `r.MotionBlurQuality 4` | Motion blur sample count |
| `r.DepthOfFieldQuality 4` | DOF sample budget |
| `r.SceneColorFormat 4` | RGBA16f default; 3=RGB10A2 |

## Performance

- Bloom and DOF dominate post-process cost. Halve internal resolution with `r.Bloom.HalfResolutionFFT 1`.
- Stack many small Post Process Materials → group into one custom material that does multiple effects in one pass.
- For shipping at scale, profile with `ProfileGPU` and look for the `PostProcessing` block.

## See also

- [Render Targets](render-targets.md) — post-process materials read/write the same RT system
- [Pixel Streaming](pixel-streaming.md) — final post-process output is what gets encoded
