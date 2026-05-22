# NVIDIA RTX Stack — AAA without Unreal

DX12 + NVIDIA's middleware stack provides AAA-grade rendering without UE. Used by Cyberpunk 2077, Alan Wake 2, Forza, Avatar: Frontiers of Pandora, Doom Eternal, and most non-UE AAA shipping.

## Pipeline overview

| Layer | Tech |
| --- | --- |
| Graphics API | **DirectX 12 Ultimate** or **Vulkan 1.3** + extensions |
| Rendering framework | **NVIDIA Falcor** (open source) or **NVIDIA Donut** (lighter) |
| Upscaling / Frame Gen | **DLSS 3.7** + **Ray Reconstruction** (or **Streamline SDK**) |
| Ray tracing | **DXR 1.1** + **NVIDIA OptiX** (offline) + **RTXDI** (many-light) |
| Denoising | **NRD** (NVIDIA Real-time Denoiser) |
| Materials | **MDL** — used by Omniverse, Substance, Renderman |
| Latency | **NVIDIA Reflex** |
| Asset streaming | **DirectStorage 1.2** + **GDeflate** or **RTX IO** |
| Geometry | **Mesh Shaders** + **Work Graphs** (Nanite-class virtualized geo) |
| Path tracing | **RTX Path Tracing SDK** (reference, drop-in) |
| Texture compression | **NVTT 3** (BC7, ASTC, GDeflate) |

## Virtual textures

UE calls it "Virtual Texturing." Underlying mechanism: **DX12 Tiled Resources Tier 2** + **Sampler Feedback**. Reference samples:

- `microsoft/DirectX-Graphics-Samples` → `Samples/Desktop/D3D12SamplerFeedback`
- `NVIDIAGameWorks/Falcor` → `Source/Falcor/Rendering/VirtualTexture`

Workflow:

1. Create `ID3D12Device::CreateReservedResource(...)` — virtual texture, no memory yet
2. Allocate a tile pool (`ID3D12Heap`)
3. `UpdateTileMappings` to map/unmap 64KB tiles
4. Render with **Sampler Feedback** texture — GPU records which tiles were sampled
5. Read feedback, page in needed tiles via **DirectStorage**, page out cold ones
6. **GDeflate** decompresses on the GPU directly into the tile pool

## What "AAA-class" needs

| Feature | Where it lives |
| --- | --- |
| GI | Lumen → **RTXDI** + **NRD** |
| Reflections | Lumen → **DXR reflections + NRD** |
| Shadows | VSM → **DXR shadows + NRD** |
| Upscaling | TSR → **DLSS 3.7** |
| Frame generation | TSR Frame Gen → **DLSS 3 Frame Generation** |
| Anti-aliasing | TSR → **DLAA** |
| Geometry virtualization | Nanite → **Mesh Shaders + Work Graphs** |
| Texture virtualization | UE VT → **DX12 Tiled Resources + Sampler Feedback Streaming** |
| Material authoring | UE Material Editor → **MDL** + Substance |
| Volumetrics | Heterogeneous Volumes → **OpenVDB** + custom raymarch |
| Asset loading | UE I/O Store → **DirectStorage + GDeflate** |

## Where UE adds value (vs raw stack)

- Editor and tooling (Sequencer, Niagara, etc.)
- Gameplay framework (Actor / Component model, replication)
- Asset registry and import pipelines
- Blueprint visual scripting

If you only need the renderer, the NVIDIA stack matches. If you want a full content pipeline + scripting + assets, UE pays for itself fast.

## See also

- [Rendering → Virtual Textures](../rendering/virtual-textures.md)
- [Rendering → Path Tracing](../rendering/path-tracing.md)
- [Rendering → Ray Tracing](../rendering/ray-tracing.md)
