# World Partition

The UE 5.x large-world streaming system. Replaces the legacy "level streaming" pattern for open worlds.

## How it works

A WP map auto-partitions actors into a **2D grid of cells** (default 25,600 cm). At runtime, cells stream in/out based on the player's **Streaming Source**.

Each actor in a WP map is stored as **One File Per Actor (OFPA)** — see [OFPA](one-file-per-actor.md) — making the map itself a tiny file pointing to the actor files.

## Enabling

`World Settings → World Partition → Enable World Partition`. New projects from "Open World" template have this on.

## Streaming sources

By default, the player pawn is a streaming source. Add custom sources:

```cpp
WorldPartitionSubsystem->RegisterStreamingSource(this, MyTransform, MyShape);
```

Examples:

- Drone cameras (stream where the drone is, not the player)
- Cinematic cameras (stream around active camera during cinematic)
- AI commanders (stream their patrol area)

## Editor workflow

| Action | How |
| --- | --- |
| Edit a region | **Loaded Regions** panel — load cells you're working on |
| Force-load all | "Load All" (slow, only for small maps) |
| HLOD generation | World Partition window → **Generate HLOD** |
| Visualize cells | Top-down view + cell overlay |

## HLOD layers

`HLOD Layer` data assets define proxy strategies per actor type:

- **Instancing** — combine many copies into HISM
- **Simplified Mesh** — auto-generate proxy mesh at distance
- **Disabled** — don't show at distance

## World Partition + PCG

PCG can generate **per-cell** at runtime — see [PCG → World Partition](../pcg/world-partition.md).

## Streaming policy

| Policy | When |
| --- | --- |
| **Standard** | Most cases |
| **Blocking** | Synchronous loads on critical cells (hitches but safe) |
| **High Priority** | Important cells preempt others |

## Data layers

`Data Layers` toggle subsets of actors on/off — Day/Night layers, Mission-specific actors, etc. See [Data Layers](data-layers.md).

## Performance budgets

- ~5–10 ms per cell streaming load on typical SSD.
- HLOD generation can take hours on large worlds — run on CI.
- Memory: aim for ≤8 streaming cells loaded at any time on consoles.

## Gotchas

- Level Blueprint references in WP are awkward — prefer World Subsystems.
- Some legacy plugins assume monolithic levels — verify WP compatibility before adopting.
- Editor preview vs runtime cell behavior can differ — use **Simulate World Partition** in PIE.
