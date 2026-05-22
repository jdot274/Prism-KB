# Dedicated Server

A headless UE build with no rendering, audio, or input. Production multiplayer hosting target.

## Building

1. Install source UE via GitHub (binary engines can't build server targets)
2. Generate project files; create `<Project>Server.Target.cs`:
   ```cs
   public class MyGameServerTarget : TargetRules
   {
       public MyGameServerTarget(TargetInfo Target) : base(Target)
       {
           Type = TargetType.Server;
           DefaultBuildSettings = BuildSettingsVersion.V5;
           ExtraModuleNames.AddRange(new[] { "MyGame" });
       }
   }
   ```
3. Build target `MyGameServer Development Server | Linux` (or Win64)

## Launching

```bash
./MyGameServer.exe MyMap?Listen -log -port=7777
```

| Flag | Effect |
| --- | --- |
| `-log` | Print log to stdout |
| `-port=7777` | Game port |
| `-NoSound` | Disable audio mixer |
| `-NoSplash` | Skip splash |
| `MyMap?Listen` | Initial map + listen mode (or open as standalone) |

## Container / cloud deployment

| Platform | Approach |
| --- | --- |
| **GameLift** | AWS-managed UE dedicated server hosting |
| **Agones (Kubernetes)** | Open source; runs your container |
| **Containerd / Docker** | Roll your own |
| **Hathora** | Managed game server hosting |
| **PlayFab Multiplayer Servers** | Microsoft-managed |

The server's Docker image needs the cooked content + the executable; no GPU driver required.

## Common pitfalls

- Server is **Type = Server**, not **Game**. The `.Target.cs` defines this; mistakes cause client code to be compiled into the server.
- Audio / UI subsystems must compile out under `WITH_SERVER_CODE` macros if you reference them.
- Save game / replay support — verify these paths still work without rendering.

## Replays

`Demo Net Driver` records gameplay on the server, replays on clients. Useful for tournaments and bug repros. Enable in `DefaultEngine.ini`:

```
[/Script/Engine.GameNetworkManager]
ReplayLengthLimit=1800
```
