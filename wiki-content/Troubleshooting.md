# Troubleshooting

Common UE 5.7 issues and their fixes.

## Editor

| Symptom | Cause / Fix |
| --- | --- |
| Editor takes 5+ minutes to open | Asset Manager scanning huge folders. Tighten scan directories. |
| Stuck on shader compilation | Wait it out the first time. Subsequent opens use the DDC. |
| "Failed to load module" on launch | Plugin DLL not built; rebuild Development Editor target. |
| Black viewport | `r.Lumen.DiffuseIndirect.Allow 1`. Check the post-process volume exposure. |

## Rendering

| Symptom | Cause / Fix |
| --- | --- |
| Nanite mesh disappears | WPO threshold; raise `r.Nanite.WPO.Threshold` or disable WPO in LOD0. |
| Lumen reflections look smeary | Software RT — switch to `r.Lumen.HardwareRayTracing 1` on RT GPUs. |
| Heterogeneous Volume invisible | Material Domain must be `Volume`. Check step count CVar. |
| Geometry Cache scrubs slowly | Disable editor preview on the component while editing other things. |

## Performance

| Symptom | Cause / Fix |
| --- | --- |
| Sudden FPS drop in editor | `stat unit` → check Game vs Draw vs GPU. Likely Lumen probe gather or Nanite streaming. |
| Hitches when cells stream | World Partition cell loading on main thread. Pre-warm via streaming sources. |
| GPU memory full | Reduce `r.Nanite.Streaming.StreamingPoolSize` or `r.VT.PoolSizeInMegabyte`. |

## Networking

| Symptom | Cause / Fix |
| --- | --- |
| Property not replicating | Missing `DOREPLIFETIME`. Check `bReplicates = true` on actor. |
| OnRep_X not firing | Property didn't actually change on server. Set the value, then mark dirty (if Push Model). |
| Character movement desync | Verify `bReplicateMovement = true` and matching server/client CMC settings. |
| RPC dropped | Unreliable; or actor not yet replicated to that client. |

## Plugins

| Symptom | Cause / Fix |
| --- | --- |
| Web Browser widget blank | CEF process crashed. Check `WebBrowser.log`. Try `-AudioMixer` flag. |
| Pixel Streaming connects but no video | Signalling server reached but WebRTC peer connection failing — STUN/TURN config. |
| UnrealClaudeMCP "Listening on 127.0.0.1:18888" but no response | Bridge script not running, or wrong path in MCP client config. |

## Build

| Symptom | Cause / Fix |
| --- | --- |
| `UnrealBuildTool` fails on `.uplugin` | JSON syntax error in the plugin manifest. |
| Server target won't build | Need source UE (binary engines can't build Server targets). |
| Cooked build crashes on startup but editor works | Asset references not packaged — check `Project Settings → Packaging → Asset Manager`. |
