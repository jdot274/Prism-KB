# Running UE inside three.js

UE doesn't compile to WebGL/WASM, so you can't run the engine *in* the browser process. But you can stream its rendered frames into a three.js scene as a live texture, with full bidirectional input.

## Architecture

```
UE 5.7 (GPU host)  --WebRTC video + input data channel-->  Browser
   |                                                          |
   v                                                          v
Pixel Streaming plugin                       three.js VideoTexture on a mesh
```

Latency: ~30–80 ms LAN, ~100 ms internet. Resolution: 4K/60 possible.

## UE side

1. Enable **Pixel Streaming** + **Pixel Streaming Player** plugins
2. Clone `EpicGames/PixelStreamingInfrastructure` for the signalling server
3. Start the signalling server: `./Start_SignallingServer.ps1`
4. Launch UE with `-PixelStreamingURL=ws://localhost:8888 -RenderOffScreen -AudioMixer`

## three.js side

```html
<script type="module">
import * as THREE from 'three';
import { PixelStreaming, Config } from '@epicgames-ps/lib-pixelstreamingfrontend-ue5.5';

const ps = new PixelStreaming(new Config({
  initialSettings: { ss: 'ws://localhost:80', AutoConnect: true }
}));

const video = ps.videoElementParent.querySelector('video');
const tex = new THREE.VideoTexture(video);
tex.colorSpace = THREE.SRGBColorSpace;

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setSize(innerWidth, innerHeight);
document.body.appendChild(renderer.domElement);

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(60, innerWidth/innerHeight, 0.1, 100);
camera.position.set(0, 0, 3);

const mesh = new THREE.Mesh(
  new THREE.PlaneGeometry(16/9, 1),
  new THREE.MeshBasicMaterial({ map: tex })
);
scene.add(mesh);

renderer.setAnimationLoop(() => renderer.render(scene, camera));
</script>
```

The exposed `<video>` element wraps a `THREE.VideoTexture` — `MeshBasicMaterial` + the texture renders the live UE feed on any geometry.

## Input forwarding

```js
function onPointer(e) {
  const uv = getRaycastUV(e); // standard three.js raycaster against the mesh
  if (uv) ps.emitUIInteraction({ type: 'click', x: uv.x, y: uv.y });
}
renderer.domElement.addEventListener('pointerdown', onPointer);
```

On the UE side, bind `Pixel Streaming Input Component → OnPixelStreamingInputEvent` in any actor BP.

## Managed alternatives

If you don't want to host the signalling server / GPU box:

- **PureWeb Reality** — managed Pixel Streaming SaaS
- **Eagle 3D Streaming** — managed (popular for archviz)
- **AWS GameLift Streams** — bring-your-own UE container
- **Vagon Streams** — quick deploy, decent free tier

## Multi-instance

- Multiple `PixelStreaming` instances → multiple `VideoTexture`s → multi-screen mosaic
- Each UE instance is a separate GPU process; budget accordingly
- SFU (Selective Forwarding Unit) for broadcast (one-to-many view-only)

## Audio

The `<video>` element gets audio over WebRTC automatically. Pipe it into Web Audio API for spatialization, EQ, mixing.

## Gotchas

- HTTPS required in production for `getUserMedia` and modern browser security
- NVENC encoder strongly recommended on UE side — software encoding is slow
- Latency depends on encoder + network — STUN/TURN for NAT traversal in some setups

## See also

- [Pixel Streaming](../rendering/pixel-streaming.md)
- [three.js in UE](three-js-in-ue.md) — the reverse direction
