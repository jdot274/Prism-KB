# Pixel Streaming

Stream the UE viewport over **WebRTC** to a browser, mobile, or any client that speaks WebRTC. Bidirectional — input flows back to UE over a data channel.

## Architecture

```mermaid
graph LR
  UE[UE 5.7 + Pixel Streaming plugin] -->|WebRTC video + audio| SS[Signalling Server]
  SS --> B[Browser frontend]
  B -->|input events| SS
  SS -->|data channel| UE
```

## Components

| Piece | Where |
| --- | --- |
| **Pixel Streaming plugin** | Built into UE — enable + restart |
| **Signalling Web Server** | Node.js, runs on port 80/443; ships in `PixelStreamingInfrastructure` |
| **Matchmaker** (optional) | Routes to least-loaded UE instance |
| **SFU** (optional, scaling) | Many-to-many distribution |
| **Frontend library** | `@epicgames-ps/lib-pixelstreamingfrontend-ue5.5` on npm |

## Launch flags (UE side)

```
MyGame.exe -PixelStreamingURL=ws://localhost:8888 -RenderOffScreen -AudioMixer -ForceRes -ResX=1920 -ResY=1080
```

| Flag | Purpose |
| --- | --- |
| `-PixelStreamingURL` | Where to find the signalling server |
| `-RenderOffScreen` | No on-screen window |
| `-AudioMixer` | Required for audio over WebRTC |
| `-ForceRes -ResX -ResY` | Fixed resolution to avoid resize churn |

## Signalling server

```bash
git clone https://github.com/EpicGames/PixelStreamingInfrastructure
cd PixelStreamingInfrastructure/SignallingWebServer
./platform_scripts/cmd/Start_SignallingServer.ps1
```

The frontend page at `http://localhost` shows a video and connects to your UE process.

## Browser embedding

```html
<script type="module">
import { PixelStreaming, Config } from '@epicgames-ps/lib-pixelstreamingfrontend-ue5.5';
const ps = new PixelStreaming(new Config({
  initialSettings: { ss: 'ws://localhost:80', AutoConnect: true, StartVideoMuted: false }
}));
document.body.appendChild(ps.videoElementParent);
</script>
```

The exposed `<video>` element can be wrapped by any rendering layer (e.g. [`workflows/ue-in-three-js`](../workflows/ue-in-three-js.md) puts it on a `THREE.VideoTexture`).

## Input forwarding

Mouse, keyboard, gamepad, touch are auto-handled. Custom UI events via:

```js
ps.emitUIInteraction({ type: 'spawn', payload: { x: 12, y: 0, z: 5 }});
```

UE side: in any actor, listen for `Pixel Streaming Input Component → OnPixelStreamingInputEvent`.

## Quality CVars

| CVar | Effect |
| --- | --- |
| `PixelStreaming.WebRTC.MaxBitrate 8000000` | Cap upstream bandwidth |
| `PixelStreaming.WebRTC.MinBitrate 1000000` | Floor |
| `PixelStreaming.Encoder.RateControlMode CBR` | CBR / VBR |
| `PixelStreaming.Encoder.TargetBitrate 5000000` | Encoder target |
| `PixelStreaming.Encoder.MinQP 20` | Quality floor (low = sharper) |
| `PixelStreaming.Encoder.MaxQP 40` | Quality ceiling |

## Scaling

- One UE instance per client for interactive use cases. Each instance needs a GPU.
- For broadcast (one-to-many view-only): use the **SFU** (Selective Forwarding Unit) included in PixelStreamingInfrastructure.
- Managed alternatives: PureWeb Reality, Eagle 3D Streaming, AWS GameLift Streams, Vagon.

## Gotchas

- WebRTC requires HTTPS in production. Use `mkcert` for local dev or a reverse proxy with TLS.
- Latency depends on encoder; NVENC (H.264) on RTX = ~20–40 ms; software fallback = much higher.
- The browser frontend's React app is overkill for embedded use — instantiate `PixelStreaming` directly.

## Links

- [UE — Pixel Streaming](https://docs.unrealengine.com/5.7/en-US/pixel-streaming-in-unreal-engine/)
- [EpicGames/PixelStreamingInfrastructure](https://github.com/EpicGames/PixelStreamingInfrastructure)
- [`workflows/ue-in-three-js`](../workflows/ue-in-three-js.md)
