# Nanite Geometry

Authoring guidance specific to Nanite-enabled meshes. For pipeline / runtime details see [Rendering → Nanite](../rendering/nanite.md).

## Authoring rules

- **Don't pre-LOD.** Ship the full-density mesh. Nanite picks LOD per pixel.
- **Triangulate before export.** Quads / n-gons are tessellated automatically but unevenly.
- **Avoid masked materials** — opaque is significantly cheaper in Nanite's two-pass shading model.
- **Single material when possible.** Each material adds an indirect dispatch in the material pass.
- **Avoid heavy WPO on LOD0.** Foliage with wind WPO falls out of Nanite below `r.Nanite.WPO.Threshold` (default 200 cm) and rasterizes traditionally.

## Skeletal Nanite

Enabled per-mesh in the Skeletal Mesh Editor → **Build Settings → Enable Nanite**. Limitations:

- Cloth simulation falls back to non-Nanite for the cloth sections.
- Per-section materials still each add cost.
- LODs are still authored — Nanite kicks in at LOD0 only on most setups.

## Foliage

- Use the **Static Mesh Foliage Type** with Nanite enabled.
- Wind via WPO: set `Disable Animation on Nanite Below Distance` to 10–30 m.

## Landscape

`r.Nanite.Landscape 1` — experimental in 5.7. Provides per-pixel detail across the landscape mesh without traditional tessellation.

## Displacement

`Nanite Displacement Maps` (UE 5.4+): a height texture that drives true geometric displacement at Nanite quality. Use as an alternative to old tessellation workflows.

## Diagnostics

- `NaniteStats` — runtime stats
- `Show → Nanite Visualization → Overdraw` — find hotspots
- `r.Nanite.Visualize 1` — visualization buffer

## Gotchas

- Lightmap UVs are unused for Nanite + Lumen. Don't pay the cost of authoring them.
- **Two-sided rendering** is supported but doubles material pass work.
- **Custom Depth Pass** for Nanite meshes is supported but slower than non-Nanite — only enable on a few highlighted actors.
