# Samplers and Spawners

The two ends of every PCG graph: produce points, then turn points into content.

## Samplers

| Node | Source | Use |
| --- | --- | --- |
| **Surface Sampler** | Landscape / mesh surface | Scatter on terrain |
| **Spline Sampler** | A `USplineComponent` actor | Place along roads, paths |
| **Volume Sampler** | A PCGVolume bounds | Random within a region |
| **Point Sampler** | Existing point set | Subsample / resample |
| **Density Sampler** | Texture mask | Use a painted mask as density |
| **Attribute Sampler** | A data asset table | Drive content by data |
| **Static Mesh Sampler** | Mesh's vertices/triangles | Sample on an existing mesh |
| **Difference / Intersection / Union** | Other point sets | Boolean composition |

## Surface Sampler — common pattern

```
Surface Sampler (Landscape)
  → Density = (1 - steepness)        # bias to flat ground
  → Density × Texture Mask (RVT)     # mix with painted exclusion
  → Density Filter (> 0.3)            # cull
  → Static Mesh Spawner              # place trees
```

## Spawners

| Node | Output |
| --- | --- |
| **Static Mesh Spawner** | Individual `StaticMeshActor`s — flexibility, higher cost |
| **Static Mesh Spawner (Hierarchical)** | HISM component — fast, supports LOD per instance |
| **Mesh-to-Points** | Points sampled on a mesh — combine for cluster placement |
| **Actor Spawner** | Full Blueprint actors with logic |
| **Niagara Spawner** | Spawn particles bound to points |
| **Spline Mesh Spawner** | Deform a static mesh along a sampled spline |

## Mesh selection strategies

- **Weighted Random** — pick from N meshes by weight
- **Mesh by Density** — bigger meshes at high density
- **Mesh by Attribute** — drive by a `species` attribute set per point
- **Choose by Distance from Spline** — different meshes near vs far

## Density-driven scale + rotation

```
For each point:
  scale = lerp(0.7, 1.2, point.density)
  rotation.Yaw = random(0, 360)
  rotation.Pitch = lerp(0, 5, jitter_attribute)
```

## Performance tips

- One HISM per **(mesh, material LOD set)** combination.
- Set the Hierarchical spawner's **Cull Distance** explicitly.
- For >100k instances, split your PCG into multiple components / volumes so World Partition can stream cells independently.
