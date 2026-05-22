# Virtual Textures

Two distinct systems, often confused:

| System | Purpose |
| --- | --- |
| **Streaming Virtual Textures (SVT)** | Stream huge textures (e.g. 16K terrain albedo) tile-by-tile based on what the camera sees |
| **Runtime Virtual Textures (RVT)** | Compose multiple materials into a cached tile that's sampled by other materials — e.g. blend N landscape layers + decals + footprints into a single virtual landscape texture sampled by foliage |

Both share an underlying **page table** + **physical tile cache** GPU mechanism (DX12 Tiled Resources / Vulkan Sparse).

## Streaming Virtual Textures

### Enable

Project Settings → Rendering → **Enable virtual texture support**. Restart.

### Mark a texture as VT

Texture Editor → **Virtual Texture Streaming = true**. Recompresses to tile-based BCn at import.

### Sample in materials

`TextureSample` automatically uses the VT page table when the source texture is marked. No shader change — but the sampler is a **VT Sampler**, which has slightly different mip selection rules.

### Tuning CVars

| CVar | Effect |
| --- | --- |
| `r.VT.MaxAnisotropy 8` | Anisotropic level cap |
| `r.VT.PoolSizeInMegabyte 512` | Physical tile pool size |
| `r.VT.RVTDirectCompress 1` | Compress RVT pages with BC during update |
| `r.VT.Borders 1` | Bilinear filtering across tile borders |

### Gotchas

- VT requires **2-pass material binding** — the first pass reads page IDs, the second samples. Cost adds ~0.3 ms on typical scenes.
- **Lightmaps** can also be VT; reduces editor build sizes dramatically.

## Runtime Virtual Textures

### Use case

You have a landscape with 8 paint layers, dynamic decals (footprints, blood), and you want a single texture to sample from your grass shader instead of repeating the entire layer blend.

### Setup

1. Create an **RVT Asset** (right-click → Materials → Runtime Virtual Texture)
2. Place a **RuntimeVirtualTextureVolume** actor — defines bounds in worldspace
3. Add a **Virtual Texture Output node** to your landscape material — writes into the RVT
4. In any other material, use **Runtime Virtual Texture Sample** — reads from it

### Performance

- RVTs cache once per visible page — sampling is free at the cost of one indirection.
- A scene with N decals + landscape layers becomes a single sample for everything reading the RVT.

## Implementing VT outside Unreal

If you're using Falcor / a custom engine, see [Workflows → NVIDIA RTX Stack](../workflows/nvidia-rtx-stack.md#virtual-textures) for the DirectX 12 Sampler Feedback Streaming approach Unreal's VT is built on.

## Links

- [UE — Streaming Virtual Texturing](https://docs.unrealengine.com/5.7/en-US/streaming-virtual-texturing-in-unreal-engine/)
- [UE — Runtime Virtual Texturing](https://docs.unrealengine.com/5.7/en-US/runtime-virtual-texturing-in-unreal-engine/)
- [`microsoft/DirectX-Graphics-Samples` — D3D12SamplerFeedback](https://github.com/microsoft/DirectX-Graphics-Samples/tree/master/Samples/Desktop/D3D12SamplerFeedback)
