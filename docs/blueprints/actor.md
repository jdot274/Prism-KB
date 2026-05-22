# Actor

`AActor` — the base class for everything placeable in a level.

## Lifecycle

```
Spawn / Load
  ↓ PostInitializeComponents()
  ↓ BeginPlay()
  ↓ Tick() repeatedly
  ↓ EndPlay()
  ↓ Destroy()
```

Equivalent BP events:

| Event | When |
| --- | --- |
| `Construction Script` | At spawn / editor change |
| `Begin Play` | Game starts or actor spawns at runtime |
| `End Play` | Destroyed, level transition, game over |
| `Tick` | Every frame (if `Actor Tick Enabled`) |
| `Actor Begin Overlap` / `Actor End Overlap` | Collision events |

## Required components on a spawnable actor

- A **RootComponent** (any `USceneComponent`). Without one, the actor has no transform.
- Optional: `UStaticMeshComponent`, `UBoxComponent` (collision), `UAudioComponent`, etc.

## Replication

Set **Replicates = true** in the Class Defaults. Then per-property: mark with `Replicated` (BP) or `UPROPERTY(Replicated)` (C++) and override `GetLifetimeReplicatedProps`.

```cpp
void AMyActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& Out) const
{
    Super::GetLifetimeReplicatedProps(Out);
    DOREPLIFETIME(AMyActor, Health);
}
```

## Levels

Every actor belongs to a level. The level's **Level Blueprint** (`ALevelScriptActor`) has access to all actors in that level.

In World Partition maps, actors are stored as **One File Per Actor (OFPA)** — each actor is a separate `.uasset` file. See [Tools → One File Per Actor](../tools/one-file-per-actor.md).

## Common derived classes

| Class | Use |
| --- | --- |
| **APawn** | Possess-able by a Controller |
| **ACharacter** | Pawn + CharacterMovementComponent + Capsule + SkeletalMesh |
| **AVolume** | Bounded region — see [Volumes](../volumes/index.md) |
| **APlayerCameraManager** | Owns the camera POV for a player |
| **AGameModeBase** | Server-side game rules; not replicated |
| **AGameStateBase** | Replicated server state |

## See also

- [Components](components.md)
- [Volumes](../volumes/index.md)
- [Networking → Replication](../networking/replication.md)
