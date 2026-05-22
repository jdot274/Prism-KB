# Trigger / Blocking / Painful Volumes

Gameplay-affecting region volumes.

## TriggerVolume / TriggerBox

`ATriggerVolume` and the simpler `ATriggerBox` fire BP / C++ events when actors overlap.

### Events

| Event | When |
| --- | --- |
| `OnActorBeginOverlap` | Actor enters |
| `OnActorEndOverlap` | Actor leaves |
| `OnActorHit` | Actor collides (only if collision is Block, not Overlap) |

### Setup

1. Drop a TriggerBox in the level
2. Right-click → **Add Event → On Actor Begin Overlap → Level Blueprint**
3. Filter the overlapping actor by `Cast To <ClassName>` in the BP

### Generates Overlap Events

The actor entering must have `Generate Overlap Events = true` on its collision component. Pawn / Character defaults to true; static meshes default to false.

### Collision channel

By default TriggerVolume collision profile is **Trigger** — overlaps Pawn, ignores everything else. Change in the Details panel to react to projectiles, vehicles, etc.

## Blocking Volume

`ABlockingVolume` is invisible collision geometry. Standard usage:

- Block players from going off the map
- Invisible walls for safety in cinematics
- Custom hitbox shapes for static actors

Set the **Collision Preset** to choose what blocks against it (e.g. `BlockAllDynamic` blocks pawns and vehicles but not visibility queries).

## Painful Volumes

`APainCausingVolume` (subclass of `PhysicsVolume`) applies damage to actors inside.

| Property | Effect |
| --- | --- |
| **Pain Causing** | Master enable |
| **Damage Per Sec** | Damage rate |
| **Damage Type** | DamageType class — drives reactions |
| **Pain Interval** | How often the tick fires |
| **Entry Pain** | One-shot damage on entry |

Used for lava, acid, radiation zones. Combine with `KillZVolume` (which instantly kills) for boundary safety.

## KillZVolume

Instantly destroys any actor inside. Common usage: a vast box under the map to clean up pawns that fall out of bounds.

## Gotchas

- A trigger volume in a streamed sublevel only fires when that sublevel is loaded.
- `OnActorBeginOverlap` fires once per overlap *event*, not per overlapping component — count carefully if you have multiple colliders.
- Painful volumes apply damage on **PainTimer** tick, not per frame — for instant kills, use entry pain.

## Linked pages

- [Physics Volumes](physics-volumes.md)
