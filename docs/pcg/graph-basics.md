# PCG Graph Basics

A **PCG Graph** is a uasset containing a node graph. Place a `PCGComponent` (or `PCGVolume`) in the level, assign the graph, click **Generate**.

## Anatomy

```
Input → [Samplers] → [Filters] → [Transforms] → [Spawners] → Output
```

| Stage | Nodes |
| --- | --- |
| **Input** | World references (Landscape, Splines, Static Meshes), parameters |
| **Samplers** | Generate point clouds: Surface, Spline, Volume, Density, Grid |
| **Filters** | Cull points by attribute, density, distance |
| **Transforms** | Move, rotate, scale, jitter, project to surface |
| **Spawners** | Static Mesh Spawner, Hierarchical ISM, Actor Spawner, Niagara Spawner |
| **Output** | The generated content |

## Points

Every PCG operation moves **points** between nodes. A point has:

| Field | Type |
| --- | --- |
| Transform | FTransform |
| Density | float (0–1, often used as a filter) |
| BoundsMin / BoundsMax | FVector (for HISM packing) |
| Color | FVector4 |
| Steepness | float (slope) |
| Seed | int32 (deterministic random) |
| **Attributes** | Arbitrary user-named values |

## Determinism

PCG graphs are **deterministic** by seed. Two runs with the same seed produce identical output — critical for World Partition cell streaming where neighboring cells must match.

## Subgraphs and reusability

- Right-click → **Collapse to Subgraph** to wrap a node group as a reusable subgraph asset.
- Subgraphs expose inputs and outputs like regular nodes.
- The PCG Examples plugin ships many subgraphs you can copy.

## Generation modes

| Mode | When it runs |
| --- | --- |
| **Editor on-demand** | Click "Generate" in the PCG Component / Volume |
| **Editor on edit** | Re-runs on any property change (toggle in PCGComponent settings) |
| **Runtime per-cell** | World Partition triggers per cell as the player approaches |
| **Runtime on-actor-spawn** | Component's `Begin Play` |

## Parameters

Expose inputs on the graph as **`Property Input`** nodes. The PCG Component's Details panel shows them — change per instance without duplicating the graph.

## Debugging

- **Node-by-node preview** with the "D" key — visualizes point clouds in the viewport
- **PCG Debug Viewer** — separate window with point inspection
- `pcg.LogEnabled 1` — verbose logs in Output Log

## Performance

- Generation time scales with point count × spawned mesh count.
- Use **Density Filter** early to drop unnecessary points before spawning.
- Prefer **Hierarchical ISM Spawner** over `Static Mesh Spawner` for thousands of instances.
- Bake the generated content to a Static Mesh Actor with `Bake to ISM/HISM` if it never changes.

## Links

- [UE — PCG Framework](https://docs.unrealengine.com/5.7/en-US/procedural-content-generation-overview/)
