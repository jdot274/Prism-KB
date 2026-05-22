# Iris

Iris is UE 5.x's new replication system, designed to replace the original `UNetDriver` plumbing for high-scale multiplayer. Optional, must be opted into per project.

## Status (UE 5.7)

- **Production**: Yes, Epic uses it for Fortnite
- **Default for new projects**: No — old system still ships
- **API stability**: Improving, still some moving pieces

## What it changes

| Feature | Old | Iris |
| --- | --- | --- |
| Property replication path | Per-property check each tick | Push Model first-class |
| Subobject replication | Manual | First-class via `IrisObjectReplicationBridge` |
| Relevancy | Per-actor `IsRelevant` | Replication Graph + Iris filter chains |
| Dirty tracking | Per-property compare | Dirty-bit driven |
| Bandwidth | OK | Significantly lower |
| Authoring | UPROPERTY + DOREPLIFETIME | UPROPERTY + Push Model |

## Enable

`DefaultEngine.ini`:

```
[/Script/IrisCore.ReplicationSystem]
bIsEnabled=true
```

Then per-actor:

```cpp
AMyActor::AMyActor()
{
    bReplicates = true;
    bReplicateUsingRegisteredSubObjectList = true;
}
```

## When to use

- **Yes**: 10k+ replicated actors, MMO-scale, large-world multiplayer
- **Maybe**: 100–10k actors, want best bandwidth
- **No**: Small multiplayer, simple twitch games — original system is fine

## Migration considerations

- Auto-detected for most projects, but custom `NetDriver` subclasses need updates.
- Replication Graph integration is the recommended scaling layer on top of Iris.

## See also

- [Replication](replication.md)
- [UE — Iris](https://docs.unrealengine.com/5.7/en-US/iris-replication-in-unreal-engine/)
