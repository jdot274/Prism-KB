# CVar Index

A curated index of the most commonly tuned CVars in UE 5.7.

## Lumen

| CVar | Default | Effect |
| --- | --- | --- |
| `r.Lumen.DiffuseIndirect.Allow` | 1 | Master GI |
| `r.Lumen.Reflections.Allow` | 1 | Master reflections |
| `r.Lumen.HardwareRayTracing` | 0 | Switch to HW RT |
| `r.LumenScene.SurfaceCache.AtlasSize` | 4096 | Surface cache resolution |
| `r.Lumen.HardwareRayTracing.LightingMode` | 0 | 0=SurfaceCache 1=Hit 2=Hit+SurfaceCache |
| `r.Lumen.ScreenProbeGather.RadianceCache` | 1 | Far-field GI cache |

## Nanite

| CVar | Default | Effect |
| --- | --- | --- |
| `r.Nanite` | 1 | Master |
| `r.Nanite.MaxPixelsPerEdge` | 1 | Max LOD detail |
| `r.Nanite.Streaming.StreamingPoolSize` | 512 | MB pool |
| `r.Nanite.WPO.Threshold` | 200 | Distance below which WPO causes fallback |
| `r.Nanite.AsyncRasterization` | 1 | Overlap with main render |

## Shadows

| CVar | Default | Effect |
| --- | --- | --- |
| `r.Shadow.Virtual.Enable` | 1 | VSMs |
| `r.Shadow.Virtual.MaxPhysicalPages` | 4096 | VSM page pool |
| `r.Shadow.Virtual.ResolutionLodBiasDirectional` | -1.5 | Sharpness bias |

## Anti-aliasing / upscaling

| CVar | Default | Effect |
| --- | --- | --- |
| `r.AntiAliasingMethod` | 4 | 0=off 1=FXAA 2=TAA 3=MSAA 4=TSR |
| `r.TSR.ShadingRejection.SampleCount` | 2 | TSR quality |
| `r.ScreenPercentage` | 100 | Internal res % |
| `r.DLSS.Enable` | 0 | DLSS toggle (with plugin) |
| `r.NGX.DLSS.Quality` | 0 | DLSS mode (0=Performance, …, 3=Ultra Quality) |

## Ray Tracing

| CVar | Default | Effect |
| --- | --- | --- |
| `r.RayTracing` | 0 | Master RT |
| `r.RayTracing.Shadows` | 0 | RT shadows |
| `r.RayTracing.Reflections` | 0 | Standalone RT reflections (replaced by Lumen) |
| `r.RayTracing.Translucency` | 0 | Refraction-correct translucency |

## Streaming

| CVar | Default | Effect |
| --- | --- | --- |
| `r.Streaming.PoolSize` | 1000 | Texture pool MB |
| `r.Streaming.MaxTempMemoryAllowed` | 50 | Temp streaming buffer MB |
| `s.AsyncLoadingThreadEnabled` | 1 | Async asset loading |
| `wp.Runtime.HLOD.LoadingRange` | 25600 | WP HLOD load range cm |

## Virtual textures

| CVar | Default | Effect |
| --- | --- | --- |
| `r.VT.MaxAnisotropy` | 8 | Anisotropic filter cap |
| `r.VT.PoolSizeInMegabyte` | 512 | Physical tile pool |
| `r.VT.Borders` | 1 | Bilinear across tile borders |

## Path tracer

| CVar | Default | Effect |
| --- | --- | --- |
| `r.PathTracing` | 0 | Enable PT mode |
| `r.PathTracing.MaxBounces` | 16 | Bounce limit |
| `r.PathTracing.SamplesPerPixel` | 1024 | Convergence budget |
| `r.PathTracing.UseDLSSDenoiser` | 0 | DLSS Ray Reconstruction denoise |

## Audio

| CVar | Default | Effect |
| --- | --- | --- |
| `au.audiothread.usagetreshold` | 95 | Audio thread overload warning |
| `au.metasound.LogVoiceCount` | 0 | Log voice counts |
| `au.3dVisualize.Enabled` | 0 | Attenuation visualization |

## Pixel Streaming

| CVar | Default | Effect |
| --- | --- | --- |
| `PixelStreaming.WebRTC.MaxBitrate` | 20000000 | Max bitrate bps |
| `PixelStreaming.Encoder.TargetBitrate` | 5000000 | Target bitrate |
| `PixelStreaming.Encoder.MinQP` | 20 | Quality floor |
| `PixelStreaming.Encoder.MaxQP` | 40 | Quality ceiling |

## Profiling toggles

| CVar | Default | Effect |
| --- | --- | --- |
| `stat fps` | — | FPS overlay |
| `stat unit` | — | Frame breakdown |
| `r.GPUStatsEnabled` | 1 | GPU stats |

## Where to set them

| Where | Lifetime |
| --- | --- |
| Console (`~`) | This session only |
| `DefaultEngine.ini` `[ConsoleVariables]` | Per-project |
| `DefaultDeviceProfiles.ini` | Per-platform |
| `cvarini` files | Hot-loaded at runtime |
| **Console Variables Editor** plugin | Editor UI |

For shipping builds, lock CVars by setting them readonly in `DefaultEngine.ini`:

```
[ConsoleVariables]
r.MotionBlurQuality=0
```
