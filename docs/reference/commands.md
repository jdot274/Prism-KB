# Console Commands

Useful console commands. Type `~` (tilde) in the editor or in a running game to open the console.

## Performance

| Command | Effect |
| --- | --- |
| `stat fps` | FPS overlay |
| `stat unit` | Frame breakdown (GPU/CPU/Game/Draw) |
| `stat game` | Game thread stat |
| `stat scenerendering` | Renderer stats |
| `stat gpu` | GPU pass breakdown |
| `stat memory` | Memory usage |
| `stat namedevents` | Show named events in stats |
| `ProfileGPU` | One-frame GPU capture |
| `stat dumpframe -ms=1.0` | Dump high-cost frame events |

## Rendering

| Command | Effect |
| --- | --- |
| `r.ScreenPercentage 50` | Internal resolution scale |
| `r.AntiAliasingMethod 4` | 0=off 1=FXAA 2=TAA 3=MSAA 4=TSR |
| `r.MotionBlurQuality 0` | Disable motion blur |
| `r.BloomQuality 0` | Disable bloom |
| `r.LumenScene.SurfaceCache.AtlasSize 8192` | Lumen surface cache resolution |
| `r.Nanite.MaxPixelsPerEdge 1` | Max Nanite detail |
| `r.PathTracing 1` | Switch to path tracer |
| `r.Shadow.Virtual.Enable 1` | Virtual Shadow Maps |
| `r.DLSS.Quality 0` | DLSS quality (Performance / Balanced / Quality / Ultra Quality) |

## Visualization

| Command | Effect |
| --- | --- |
| `viewmode lit / unlit / wireframe / lightingonly / detaillighting` | View mode |
| `show collision` | Toggle collision wireframe |
| `show navigation` | Toggle navmesh |
| `r.Lumen.Visualize 1` | Lumen probes |
| `r.Nanite.Visualize 1` | Nanite buffer |

## Gameplay

| Command | Effect |
| --- | --- |
| `slomo 0.1` | Time dilation |
| `pause` | Toggle pause |
| `god` | Invincible (when properly hooked) |
| `fly` | Free camera |
| `ghost` | Fly + no collision |
| `walk` | Back to walking |
| `summon /Script/MyGame.MyActor` | Spawn an actor in front of camera |

## Networking

| Command | Effect |
| --- | --- |
| `net.UseAdaptiveNetUpdateFrequency 1` | Throttle update frequency by relevancy |
| `net.PackageMap.LongLoadThreshhold 0.02` | Warn on long package loads |
| `p.NetCorrectionLifetime 5` | How long client correction renders persist |
| `open 127.0.0.1` | Connect to local listen server |

## Audio

| Command | Effect |
| --- | --- |
| `stat audio` | Audio stats |
| `au.3dVisualize.Enabled 1` | Attenuation visualization |
| `au.SubmixUtilityDisplayInfo 1` | Submix routing graph |
| `au.LogPlayingSounds 1` | Log voices |

## Pixel Streaming

| Command | Effect |
| --- | --- |
| `PixelStreaming.WebRTC.MaxBitrate 8000000` | Cap bitrate |
| `PixelStreaming.Encoder.MinQP 20` | Quality floor |
| `PixelStreaming.Encoder.MaxQP 40` | Quality ceiling |

## Editor / debug

| Command | Effect |
| --- | --- |
| `debugcamera` | Detached debug camera (PIE only) |
| `t.maxfps 60` | Frame rate cap |
| `pause` | Pause gameplay |
| `togglecinematic` | Cinematic camera |
| `bugitgo X Y Z` | Teleport to coordinates |
