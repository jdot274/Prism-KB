# PCG Recipes

Quick patterns. Full docs at [pcg/](https://jdot274.github.io/Prism/pcg/).

## Scatter trees on slopes < 30°

```
Surface Sampler (Landscape)
  Density = 1 - steepness
  Density Filter (> 0.7)
  Random Selection (3 tree meshes)
  Hierarchical ISM Spawner
  Cull Distance 20000
```

## No-spawn zone via spline

```
... pipeline above ...
  Difference (Surface points, Spline Sampler(Road, 500cm width))
... continue ...
```

## Density-driven scale

```
Static Mesh Spawner
  Scale = lerp(0.7, 1.3, point.density)
  Yaw = random(0, 360)
  Pitch = lerp(0, 5, jitter_attr)
```

## Per-cell determinism

PCG seed is `world_seed XOR cell_coord`. Two cells sampling the same point produce the same output → no seam mismatch.

## Mesh-by-density

```
Static Mesh Spawner with Mesh Entries:
  density 0.0–0.3 → SaplingMesh
  density 0.3–0.7 → MediumMesh
  density 0.7–1.0 → LargeMesh
```

## PCG + World Partition

```
PCG Component / Volume
  Generation Trigger: GenerateAtRuntime
  Use Hierarchical Generation: true
  Grid Size: matches WP cell size (25,600 cm)
```

Generates per-cell as player approaches; disposes when cell streams out.

## Common pitfalls

- Surface Sampler clipping mesh edges → expand bounds by 100 cm
- Hand-painted Foliage + PCG output → conflicts; use PCG `Bake to Foliage` then spot-edit
- Forgetting to set Cull Distance → all instances render forever
