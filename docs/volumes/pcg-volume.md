# PCG Volume

`APCGVolume` — bounding region that runs a PCG Graph inside. See [PCG → Volumes and Bounds](../pcg/volumes-and-bounds.md) for the full details.

## TL;DR

| Property | Effect |
| --- | --- |
| **Graph Instance** | The PCG Graph asset |
| **Generation Trigger** | OnLoad / OnDemand / GenerateAtRuntime |
| **Regenerate In Editor** | Auto-rerun on property changes |
| **Hierarchical Generation** | Coarse + fine passes for WP |
| **Seed** | Per-volume override of randomness |

## When to prefer PCGVolume over PCGComponent

- You want a **distinct bounded region** in the level (e.g. forest, town, dungeon clearing)
- You want artists to **drag corners** to reshape the region
- You want to **see the bounds** in the viewport without an explicit actor

Use a `PCGComponent` instead when the bounds derive from another actor (e.g. a building blueprint that procedurally dresses its own interior).

## Linked pages

- [PCG Graph Basics](../pcg/graph-basics.md)
- [PCG + World Partition](../pcg/world-partition.md)
