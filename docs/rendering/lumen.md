# Lumen

Lumen is UE 5's dynamic global illumination and reflections system. Replaces baked Lightmass + Screen-Space Reflections for most projects.

## Two backends

| Backend | Strengths | Weaknesses |
| --- | --- | --- |
| **Software RT** (signed-distance-field tracing) | Works on any DX12 GPU; cheaper | Lower-detail GI, simplified mesh representation |
| **Hardware RT** (DXR / VRT) | Higher fidelity; mirror-perfect reflections; supports translucency | Needs RT-capable GPU; more expensive |

Toggle with `r.Lumen.HardwareRayTracing 0|1`.

## What it does in one pass

- **Screen Traces** first (cheap)
- Falls back to **Surface Cache** sampling for off-screen GI (SW path) or **mesh BVH** rays (HW path)
- Reflections use the same machinery — Lumen Reflections are coherent with GI
- Final composite uses **TSR** to denoise and stabilize

## Quality knobs (CVars)

| CVar | Effect |
| --- | --- |
| `r.Lumen.DiffuseIndirect.Allow 1` | Master switch |
| `r.LumenScene.SurfaceCache.AtlasSize 8192` | Surface cache resolution |
| `r.Lumen.ScreenProbeGather.RadianceCache 1` | Far-field caching |
| `r.Lumen.Reflections.Allow 1` | Reflections master |
| `r.Lumen.Reflections.MaxRoughnessToTrace 0.4` | Limit reflection rays to glossy surfaces |
| `r.Lumen.HardwareRayTracing.LightingMode 2` | 0=SurfaceCache 1=Hit 2=Hit+SurfaceCache |

## When Lumen struggles

- **Highly mirror-reflective surfaces in software mode** — switch to HW RT for clean mirror reflections.
- **Indoor scenes with small bright lights** — increase `r.Lumen.ScreenProbeGather.AdaptiveProbeMinDownsampleFactor`.
- **Small thin geometry** — Surface Cache can't represent it; bake static lighting for that region or use HW RT.
- **Translucent GI** — HW RT only.

## Lumen vs static lighting

| Concern | Lumen | Lightmass (baked) |
| --- | --- | --- |
| Dynamic time-of-day | ★ | No |
| Build times | None | Hours |
| Storage | Negligible | Lightmaps can be GB |
| Quality of bounce | Good | Reference |
| Mobile / low-end | No | Yes |

## Debugging

```
r.Lumen.Visualize 1
Show → Advanced → Lumen Scene
stat Lumen
ProfileGPU                  (capture one frame, see Lumen passes)
```

## Links

- [UE — Lumen Global Illumination and Reflections](https://docs.unrealengine.com/5.7/en-US/lumen-global-illumination-and-reflections-in-unreal-engine/)
- Krzysztof Narkowicz, "Lumen Architecture" (SIGGRAPH 2022)
