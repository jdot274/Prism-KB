# Foliage

UE's per-instance mesh scatterer. Paint grass, trees, debris on any surface.

## Setup

1. **Modes → Foliage**
2. Drag mesh assets into the foliage list
3. Set per-asset density, scale, randomization
4. Paint on landscape or static meshes

Each painted instance lives in an `InstancedFoliageActor` with one `HierarchicalISMComponent` per mesh — fast to render thousands of instances.

## When to use PCG instead

| Concern | Foliage | PCG |
| --- | --- | --- |
| Manual painting feel | ★ | No |
| Re-runnable rules | No | ★ |
| Slope / mask filtering | Possible per-asset | Trivial |
| World Partition streaming | Per-cell automatic | Per-cell automatic |
| Designer-friendly | ★ | Steeper curve |

For modern UE 5.7 projects, **PCG is the recommended path** for procedural cover. Foliage is still the right tool for hand-curated dressing.

## Procedural Foliage Volume (legacy)

Pre-PCG procedural scatterer. Drop a volume, configure foliage types, run "Resimulate". Replaced by PCG in 5.2+ but still works.

## Performance

- HISM instances batch into one draw call per (mesh, material LOD set).
- Set **Cull Distance** per type — kills distant instances.
- Use **Foliage Type → Move to Foliage** to convert hand-placed actors back to instances.

## Common pitfalls

- Foliage on landscape: cast shadow setting per-instance is expensive — disable for grass.
- Foliage Type's **Affect Distance Field Lighting** affects Lumen software path; enable for trees, disable for grass.
- Hand-paint after PCG generation: easy to get into conflict with re-runnable graphs. Use PCG-baked-to-foliage if you need to spot-edit.
