# Cull Distance, Lightmass, PVS, HLOD Volumes

A grab-bag of optimization volumes.

## CullDistanceVolume {: #cull }

Per-region maximum draw distance keyed by mesh size. Tiny meshes get culled early, big meshes draw further.

| Property | Effect |
| --- | --- |
| **Cull Distances** | Array of (Size, Distance) pairs |
| **Enabled** | Master toggle |

For a typical scene:

```
Size 10 → Distance 1000
Size 50 → Distance 5000
Size 200 → Distance 20000
Size 1000 → Distance 100000
```

The "size" measure is the actor's bounding box max dimension. Any static mesh inside the volume gets the matching distance interpolated.

Per-actor override: `Cull Distance` on `StaticMeshComponent`. Volume only applies if the per-actor value is 0.

## LightmassImportanceVolume {: #lightmass }

For projects still using **Lightmass static lighting** (not Lumen), this volume restricts photon distribution to the region inside. Bakes faster, higher quality where you care.

Lumen-only projects can ignore this — no Lightmass means no bake.

## PrecomputedVisibilityVolume {: #pvs }

Static **potentially-visible-set** computation. Used on mobile / older hardware where dynamic occlusion is too expensive.

1. Project Settings → **Precompute Visibility** = true
2. Place a `PrecomputedVisibilityVolume` covering player-reachable areas
3. Build lighting — the visibility data is baked alongside lightmaps

Skips draw calls for actors known to be invisible from inside any sample point.

## HLOD / Mesh Merging Volumes {: #hlod }

Within a **MeshMergingVolume**, static meshes auto-merge for HLOD generation (Hierarchical LOD — proxy meshes used at distance in World Partition).

- Project Settings → **World Settings → HLOD Setup** drives the proxy strategy.
- For World Partition, use `HLOD Layer` data assets to declare which actors merge into which proxy.

## Combining

These volumes don't interfere with each other or with PostProcess / Trigger / Physics volumes — they all evaluate independently per-actor.
