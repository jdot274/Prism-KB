# Landscape

UE's terrain system. Heightmap-based, layer-painted, scalable to huge worlds with World Partition.

## Authoring

1. **Modes → Landscape**
2. Set Size (e.g. 8129×8129) and component count (impacts LOD streaming)
3. **Sculpt tools**: raise, lower, smooth, flatten, ramp, retopologize
4. **Paint tools**: weight-paint material layers
5. **Manage**: edit Landscape components, add subsections

## Materials

Layered material with `LandscapeLayerBlend` node:

```hlsl
finalAlbedo = LandscapeLayerBlend(grass, rock, sand, snow, ...)
```

Each weight is a per-layer painted texture. Use `LandscapeLayerCoords` for per-layer UV tiling.

## Performance

| Setting | Effect |
| --- | --- |
| **Component Size** | Smaller = more flexible LOD, more draw calls |
| **Number of Subsections** | Per-component subdivision |
| **LOD Distribution** | Falloff curve |
| **LOD Streaming Threshold** | Distance at which LODs drop |

## Nanite Landscape (5.4+ experimental)

`r.Nanite.Landscape 1` — landscape rendered as Nanite. Per-pixel detail, no per-component triangulation. Still experimental in 5.7; watch CVars.

## World Partition + Landscape

Landscape integrates with WP — automatic per-cell streaming. Author normally, WP cuts it up.

## Modern alternatives

| Tool | When |
| --- | --- |
| **Landscape** | Heightmap terrain — most projects |
| **Voxel Plugin Pro** | Voxel terrain with overhangs |
| **OpenLand** | Runtime-modifiable landscape |
| **Mesh terrain via PCG** | Stylized / non-heightmap |

## See also

- [PCG + World Partition](../pcg/world-partition.md)
- [Tools → World Partition](world-partition.md)
