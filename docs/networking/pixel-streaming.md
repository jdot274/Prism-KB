# Pixel Streaming (Networking)

This page mirrors [Rendering → Pixel Streaming](../rendering/pixel-streaming.md) from the networking perspective.

## Wire format

| Direction | Protocol |
| --- | --- |
| UE → Browser | WebRTC video + audio (H.264 / VP8 / VP9) |
| Browser → UE | WebRTC data channel (text / binary) |
| Signalling | WebSocket via the signalling server |

## STUN / TURN

For LAN-only deployment, default settings work. For internet deployment:

- **STUN** servers (Google's public ones, or your own) for NAT discovery
- **TURN** servers as fallback for restrictive NATs — required for ~10% of users

Configure in `Pixel Streaming Settings`:

```
PixelStreaming.WebRTC.StunServers=stun:stun.l.google.com:19302
PixelStreaming.WebRTC.TurnServers=turn:your-turn.example.com:3478?transport=udp
PixelStreaming.WebRTC.TurnUsername=...
PixelStreaming.WebRTC.TurnPassword=...
```

## Frame Generation source

Pixel Streaming uses **NVENC** by default on NVIDIA GPUs. AMF on AMD. Software fallback otherwise. Set:

```
PixelStreaming.Encoder.Codec H264
PixelStreaming.Encoder.RateControlMode CBR
PixelStreaming.Encoder.TargetBitrate 5000000
```

## Concurrent clients

One UE instance per interactive client. For broadcast (one-to-many view-only) use the **SFU** in PixelStreamingInfrastructure.

## See also

- [Rendering → Pixel Streaming](../rendering/pixel-streaming.md)
- [Workflows → UE in three.js](../workflows/ue-in-three-js.md)
