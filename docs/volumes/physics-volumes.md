# Physics Volumes

`APhysicsVolume` overrides physics properties for any actor inside. Common subclasses: `KillZVolume`, `PainCausingVolume`, `WaterVolume` (community).

## Properties

| Property | Effect |
| --- | --- |
| **Fluid Friction** | Damping for actors inside (used for water-like volumes) |
| **Terminal Velocity** | Cap falling speed |
| **Priority** | Higher priority wins on overlap |
| **Water Volume** | Marks as fluid; gameplay code can check `Pawn->PhysicsVolume->bWaterVolume` |
| **Gravity Override** | Custom gravity scalar — set to negative for inverted, 0 for zero-G |

## Default volume

Every level has an implicit **DefaultPhysicsVolume** (gravity from `WorldSettings → Default Gravity Z`, default -980 cm/s²). PhysicsVolume actors override per-region.

## Water-volume pattern

```cpp
void AMyCharacter::Tick(float DeltaTime)
{
    Super::Tick(DeltaTime);
    if (GetPawnPhysicsVolume()->bWaterVolume)
    {
        GetCharacterMovement()->SetMovementMode(MOVE_Swimming);
    }
}
```

## Zero-G volume

Set **Gravity Override = 0** and **Terminal Velocity = 99999** for floating-in-space gameplay zones.

## Combining with PostProcess

A physics volume usually pairs with a PostProcess volume covering the same region (underwater filter, color grading, audio reverb). Place both with matching bounds and matching priorities.

## Gotchas

- Static physics volumes don't tick — actors check `PhysicsVolume` once on overlap entry.
- Replication of physics volume membership is handled by character movement; custom pawn classes need to forward the check explicitly.
- Multiple overlapping volumes resolve by priority but only one wins per actor.
