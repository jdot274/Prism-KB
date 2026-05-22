# Real-time Ray Tracing

Real-time DXR / Vulkan-RT effects in UE 5.7 that are *not* Lumen or Path Tracer. These are the standalone RT effects you may still enable for specific high-fidelity needs.

## Effects

| Effect | CVar | Status |
| --- | --- | --- |
| RT Shadows | `r.RayTracing.Shadows 1` | Production |
| RT Translucency | `r.RayTracing.Translucency 1` | Production |
| RT Skylight | `r.RayTracing.SkyLight 1` | Production |
| RT AO | `r.RayTracing.AmbientOcclusion 1` | Deprecated — prefer Lumen |
| RT Reflections (standalone) | `r.RayTracing.Reflections 1` | Replaced by Lumen Reflections |
| RT GI (standalone) | `r.RayTracing.GlobalIllumination 1` | Replaced by Lumen GI |

## Hardware requirements

- DX12 + DXR 1.1 (Win10 20H2+, Win11)
- NVIDIA RTX 2060+, AMD RX 6700+, Arc A series, PS5, Xbox Series X
- Vulkan with `VK_KHR_ray_tracing_pipeline`

## When to use which

| Need | Use |
| --- | --- |
| GI + reflections | **Lumen HW RT** |
| Sharp shadows from spot/directional lights | RT Shadows |
| Glass / water with refractions | RT Translucency |
| Skylight contact shadows + AO | RT Skylight |
| Reference frame | Path Tracer |

## Performance

| Lever | Effect |
| --- | --- |
| `r.RayTracing.Shadows.Denoiser 2` | NRD denoiser path |
| `r.RayTracing.Shadows.SortMaterials 1` | Sort hits by material for coherence |
| `r.RayTracing.Geometry.Landscape 0` | Skip landscape from BVH if not needed |
| `r.RayTracing.Geometry.NaniteProxies 1` | Use Nanite ray-traced proxies |

## Building the BVH

UE auto-builds a top-level AS (`TLAS`) every frame and bottom-level (`BLAS`) on geometry change. For large scenes turn on **`r.RayTracing.AsyncBuild 1`** to overlap BVH builds with the GPU.

## Links

- [UE — Real-Time Ray Tracing](https://docs.unrealengine.com/5.7/en-US/real-time-ray-tracing-in-unreal-engine/)
