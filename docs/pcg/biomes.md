# PCG Biomes

The **PCG Biomes** plugin layers multiple PCG graphs by density. Each biome contributes a weight; the system picks per-point which biome owns that spot, eliminating hard transitions.

## Concept

```
Point → climate sample → biome weights → pick highest → run that biome's subgraph
```

## Setup

1. Enable **PCG Biomes** + **PCG**
2. Create a `BiomeSet` data asset with N biome entries (Forest, Desert, Tundra…)
3. Each biome references a PCG Graph that scatters its own assets
4. Place a `BiomeGraph` actor; assign the `BiomeSet`

## Drivers

Biome weights can come from:

- **Texture mask** painted in landscape (one channel per biome)
- **Climate sampler** (PCG node) — derives temperature / humidity from altitude + noise
- **Per-cell attribute** for World Partition cells
- **Distance from a spline** (e.g. "river → forest near it")

## Blend behavior

Biomes don't blend visually — they *win or lose per point*. To soften transitions, increase point density in the boundary regions or use multiple smaller biomes whose distributions overlap.

## Performance

- Each biome runs **only on the points it owns** — sparse biomes are nearly free.
- Cache biome weight textures in an RVT so they're cheap to sample per point.

## See also

- [PCG Graph Basics](graph-basics.md)
- [PCG World Partition](world-partition.md)
