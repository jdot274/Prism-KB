# RPC — Remote Procedure Calls

One-shot replicated function calls. Three kinds:

| RPC | Caller | Executed on |
| --- | --- | --- |
| **Server** | Client | Server |
| **Client** | Server | Owning client |
| **NetMulticast** | Server | All clients (and server) |

## Declaration (C++)

```cpp
UFUNCTION(Server, Reliable, WithValidation)
void Server_Fire(FVector AimDirection);
void Server_Fire_Implementation(FVector AimDirection);
bool Server_Fire_Validate(FVector AimDirection);

UFUNCTION(Client, Reliable)
void Client_ShowKillFeed(FString Killer, FString Killed);

UFUNCTION(NetMulticast, Unreliable)
void NetMulticast_PlayHitFX(FVector_NetQuantize Loc);
```

| Specifier | Meaning |
| --- | --- |
| **Reliable** | Resend until ACK; bandwidth cost |
| **Unreliable** | Best-effort; lost packets dropped |
| **WithValidation** | Adds `_Validate` overload — server kicks client if returns false |

## Reliable vs Unreliable

- **Reliable** for game-state-critical events (kill, score, ability cast).
- **Unreliable** for cosmetic events (footstep, particle).
- **NetMulticast must be unreliable in most cases** — reliable multicast costs N × bandwidth.

## Calling pattern

```cpp
void AMyChar::OnFireButtonPressed()
{
    if (HasAuthority())
        Server_Fire_Implementation(AimDir);  // local server call
    else
        Server_Fire(AimDir);                 // RPC to server
}
```

## Validation

`_Validate` is your anti-cheat hook. Sanity-check inputs:

```cpp
bool AMyChar::Server_Fire_Validate(FVector Dir)
{
    return Dir.IsNormalized() && AmmoCount > 0;
}
```

Returning false kicks the client.

## NetMulticast best practice

Prefer **replicated property + OnRep** over multicast for state. Use multicast for transient events that need to fire on all clients (e.g. one-shot VFX).

## See also

- [Replication](replication.md)
