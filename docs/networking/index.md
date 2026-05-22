# Networking

UE's networking stack is **client-server, server-authoritative**. The server runs the truth; clients receive replicated state and request actions via RPCs.

## Pages

- [Replication](replication.md) — actor / property / component
- [RPC](rpc.md) — Server / Client / Multicast functions
- [Iris](iris.md) — new replication system in UE 5.x
- [Pixel Streaming](pixel-streaming.md) — WebRTC video out
- [Dedicated Server](dedicated-server.md) — building & deploying

## Hosting modes

| Mode | Server | Client |
| --- | --- | --- |
| **Standalone** | Same as client | — |
| **Listen Server** | One client also hosts | Other clients connect |
| **Dedicated Server** | Headless, no rendering | All clients connect |

For shipping multiplayer at scale, use Dedicated Server.

## Replication overview

- **Actor must replicate** (`bReplicates = true`).
- **Properties** are replicated by marking `UPROPERTY(Replicated)` and overriding `GetLifetimeReplicatedProps`.
- **RPCs** (Server / Client / NetMulticast) carry one-shot events.

See [Replication](replication.md) and [RPC](rpc.md) for details.

## Relevancy

Actors only replicate to clients that need them. `IsNetRelevantFor()` controls visibility. **Replication Graph** + **Push Model** + **Iris** push relevancy + replication scalability further.

## Online subsystems

| OSS | Use |
| --- | --- |
| **Steam** | Steam matchmaking, P2P relay |
| **EOS** | Epic Online Services — cross-platform |
| **Null** | Local dev / LAN |
| **PSN / Xbox Live / Switch** | Console platform services |

Configure in `DefaultEngine.ini`:

```
[OnlineSubsystem]
DefaultPlatformService=Steam
```

## CVars

| CVar | Effect |
| --- | --- |
| `net.PackageMap.LongLoadThreshhold 0.02` | Warn on long package loads |
| `net.UseAdaptiveNetUpdateFrequency 1` | Throttle relevant actor updates |
| `net.IrisEnabled 1` | Toggle Iris |
| `p.NetEnableMoveCombining 1` | Combine character moves before send |
