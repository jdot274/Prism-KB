# Nanite

Virtualized micropolygon geometry. Renders meshes as a cluster hierarchy streamed and rasterized at one-pixel granularity, eliminating LOD authoring for most assets.

## What it does

- Streams **clusters** (128 triangles each) on demand from disk.
- Selects the LOD per-pixel via a **GPU-driven persistent cluster culling** pipeline.
- Rasterizes via **software rasterization** for sub-pixel-sized triangles (cheaper than hardware), hardware for larger ones.
- Writes into a **Visibility Buffer** that holds cluster + triangle IDs; material shading happens later in a single pass per material.

## What's supported in UE 5.7

| Feature | Status |
| --- | --- |
| Static meshes | ★ Production |
| Skeletal meshes | Production (limited mask support) |
| Foliage | Production (no wind on heavy LOD0) |
| Landscape | Experimental (`r.Nanite.Landscape`) |
| Spline meshes | Experimental |
| World Position Offset (WPO) | Production with caveats — disables Nanite below `r.Nanite.WPO.Threshold` distance |
| Two-sided | Production |
| Translucent materials | **Not supported** — use traditional mesh path |
| Decals | Yes, with caveats around `Receives Decals` |

## Enabling

Per-mesh: import settings → **Build Nanite**. Or right-click any Static Mesh → **Nanite → Enable**.

Project-wide: `Project Settings → Rendering → Nanite → Enable`.

## Authoring guidance

- Author **at the polygon density you actually want** — don't pre-reduce. Nanite picks LOD per pixel.
- **One material per mesh** is ideal; many materials add per-pixel branch cost in the material pass.
- **Avoid WPO in LOD0** on dense Nanite meshes — it forces fallback rasterization.
- Use the **Imposter** path for very distant meshes if `r.Nanite.MaxPixelsPerEdge` doesn't compress enough.

## Debug

| Command | View |
| --- | --- |
| `NaniteStats` | Per-frame triangle / cluster counts |
| `r.Nanite.Visualize 1` followed by `r.Nanite.Visualize.OverdrawScale 1` | Visualization buffer view |
| `Show → Advanced → Nanite` | Editor view modes (Overdraw, Clusters, Triangles, Material complexity) |

## Performance notes

- Nanite cost scales with **screen pixels**, not source triangle count.
- A 50M-poly model and a 500k-poly model render in the same time if they cover the same screen area.
- **GPU memory** is the streaming pool, set by `r.Nanite.Streaming.StreamingPoolSize` (default ~512 MB).

## Limitations

- No tessellation / displacement on Nanite meshes (UE 5.4+ has experimental **Nanite Displacement Maps**).
- No vertex animation other than WPO with caveats.
- Translucent / masked alpha materials are **slower** than opaque due to the visibility-buffer two-pass model.

## Links

- [UE — Nanite Virtualized Geometry](https://docs.unrealengine.com/5.7/en-US/nanite-virtualized-geometry-in-unreal-engine/)
- Brian Karis, "Nanite — A Deep Dive" (SIGGRAPH 2021)
