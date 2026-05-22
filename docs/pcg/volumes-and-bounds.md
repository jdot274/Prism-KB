# PCG Volumes and Bounds

A PCG graph needs a **bounded region** to operate over. Three ways to define one:

## 1. PCGVolume actor

Place via the Place Actors panel. A `PCGVolume` is an `AVolume` subclass with a `PCGComponent`. Configure on the actor:

| Property | Effect |
| --- | --- |
| **Graph Instance** | The PCG Graph to run |
| **Generate On Load** | Auto-generate when the level loads |
| **Regenerate In Editor** | Re-run on edit |
| **Parametrize Bounds From Brush** | Use the volume's brush as bounds |

## 2. PCGComponent on any actor

Attach `UPCGComponent` to any AActor. The component's **bounds source** can be:

- The actor's `Root Component` bounds
- A specified `USceneComponent` bounds
- A manually-set `FBox`

Use case: drop a PCG on a custom shop building blueprint to dress its interior procedurally each instance.

## 3. World Partition cell

In a World Partition map, each loaded cell triggers generation for any PCG Graph marked **`Generation Trigger = GenerateAtRuntime`**. Cells regenerate as the player moves; cells stream out and drop their content.

## Bounds interactions

| Interaction | Behavior |
| --- | --- |
| **Two overlapping PCGVolumes** | Both run; can use `Difference` node to deduplicate |
| **PCG inside a building's interior bounds** | Use a custom volume rather than a global PCG |
| **PCG over a Landscape** | Surface Sampler automatically clips to landscape extents |

## Coordinate space

All points are in **world space**. If you need local coordinates (e.g. "spawn relative to the building"), use the **Transform Points** node with the actor's transform.

## Determinism across cells

When World Partition splits a map into cells, neighboring cells must produce **matching content** at the seams. PCG's seed is **deterministic by world position**, so two cells sampling the same coordinate produce the same point — preventing visible seams.

## Common pitfall

A PCGVolume that's too tight against the landscape can miss surface samples due to brush precision. Inflate the box by 100 cm on all axes or use a Surface Sampler with a separate bounds reference.
