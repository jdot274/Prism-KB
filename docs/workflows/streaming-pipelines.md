# Streaming Pipelines

Getting pixels (and audio) into and out of UE in real time.

## Outputs (UE → elsewhere)

| Path | Plugin | Use |
| --- | --- | --- |
| **WebRTC video to browser** | Pixel Streaming | Web clients, mobile |
| **NDI broadcast** | NDI IO | LAN broadcast, multi-machine |
| **Spout shared texture** | Spout (community) | Same-machine GPU share |
| **SDI capture-card out** | Aja / Blackmagic | Broadcast / ICVFX |
| **OBS RTMP** | OBS + game capture | Twitch / YouTube |
| **File capture** | Movie Render Queue | Pre-rendered cinematics |
| **HLS / DASH** | Media Framework + external relay | Wide-audience streaming |

## Inputs (elsewhere → UE)

| Path | Plugin | Use |
| --- | --- | --- |
| **NDI receive** | NDI IO | Live external feeds as `MediaTexture` |
| **Spout receive** | Spout (community) | Same-machine GPU input |
| **SDI capture** | Aja / Blackmagic | Live broadcast input |
| **HLS / DASH playback** | Electra Media Player | Streamed video sources |
| **Video file playback** | Media Framework | Mp4 / WebM / etc. |
| **Web feed via CEF** | Web Browser | Embed any browser content |
| **Camera USB / DirectShow** | Media Framework | Webcam, virtual cameras |

## Compositing

**Composure** (built-in) stacks layers in real time:

- CG layer (UE render)
- Live action plate (from SDI / NDI)
- Garbage matte
- Pre-comp FX
- Final color grade

Used for ICVFX (LED-wall virtual production), AR / mixed reality, broadcast graphics.

## Latency budget

| Hop | Typical |
| --- | --- |
| UE render + tonemap | 8–16 ms |
| NVENC encode | 2–4 ms |
| WebRTC packetize + network | 10–40 ms |
| Browser decode | 5–15 ms |
| three.js render | 1–3 ms |
| **Total UE → browser** | ~30–80 ms |
| NDI same-machine | ~16 ms (one frame) |
| Spout same-machine | <16 ms (sub-frame) |
| SDI hardware loop | <8 ms |

For interactive uses, every hop matters. Spout/SDI for prosumer / pro production; Pixel Streaming for web reach.

## See also

- [Pixel Streaming](../rendering/pixel-streaming.md)
- [UE in three.js](ue-in-three-js.md)
- [three.js in UE](three-js-in-ue.md)
- [NVIDIA RTX Stack](nvidia-rtx-stack.md)
