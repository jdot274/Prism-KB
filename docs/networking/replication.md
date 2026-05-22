# Replication

Properties (state) and actors (entities) are kept in sync from server to clients automatically when configured correctly.

## Actor replication

```cpp
AMyActor::AMyActor()
{
    bReplicates = true;
    bReplicateMovement = true;
    NetUpdateFrequency = 30.f;
    MinNetUpdateFrequency = 5.f;
}
```

The server decides which clients see the actor (relevancy).

## Property replication

```cpp
UPROPERTY(ReplicatedUsing=OnRep_Health)
float Health = 100.f;

UFUNCTION()
void OnRep_Health(float OldHealth);

void AMyActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& Out) const
{
    Super::GetLifetimeReplicatedProps(Out);
    DOREPLIFETIME(AMyActor, Health);
    DOREPLIFETIME_CONDITION(AMyActor, Ammo, COND_OwnerOnly);
}
```

- `ReplicatedUsing` calls `OnRep_<Name>` on clients whenever the value changes.
- `COND_OwnerOnly` / `COND_SkipOwner` filter who receives the update.
- `COND_Custom` lets you toggle replication dynamically.

## Push Model

Default replication checks each property each tick. **Push Model** flips it: properties only replicate when explicitly marked dirty.

```cpp
SetReplicatedProperty(Health, NewHealth);
MARK_PROPERTY_DIRTY_FROM_NAME(AMyActor, Health, this);
```

Enable in `Project Settings → Networking → Use Network Push Model`. Order-of-magnitude reduction in CPU for high-actor-count games.

## Subobject replication

Replicate components on a replicated actor: set `bReplicates = true` on the component. For arrays of subobjects:

```cpp
void AMyActor::PreReplication(IRepChangedPropertyTracker& Changer)
{
    Super::PreReplication(Changer);
    for (UMyComp* C : Components) AddReplicatedSubObject(C);
}
```

## Network role

| Role | Where |
| --- | --- |
| `ROLE_Authority` | The server's instance of the actor |
| `ROLE_AutonomousProxy` | The local owner's replicated copy (e.g. own pawn) |
| `ROLE_SimulatedProxy` | A replicated copy of an actor owned by someone else |

Most authority checks: `if (HasAuthority()) { ... }`.

## Tick groups + replication order

Replication happens in `TG_LastDemotable`. Avoid setting replicated state in client BeginPlay — set it server-side; the client will receive via OnRep.

## Common pitfalls

- Forgetting `DOREPLIFETIME` after declaring a `Replicated` property.
- Calling RPCs on actors that haven't replicated yet (early in spawn).
- Assuming `BeginPlay` order is consistent across server/client — order can differ.
- Replicating large structs every frame — use Push Model or split into smaller properties.

## See also

- [RPC](rpc.md)
- [Iris](iris.md)
