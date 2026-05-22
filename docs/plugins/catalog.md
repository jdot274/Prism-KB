# Plugin Catalog

The full set of plugins worth knowing about for **UE 5.7**, grouped by purpose. Built-in plugins ship with the engine; Marketplace and community plugins must be downloaded.

## Legend

| Tag | Meaning |
| --- | --- |
| **B** | Built-in (Epic, ships with UE) |
| **M** | Marketplace (Fab / Epic Marketplace) |
| **C** | Community / open source |
| **★** | Recommended baseline for most projects |

---

## Rendering

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Nanite** | B ★ | Virtualized geometry — handles tens of millions of polys |
| **Lumen** | B ★ | Real-time GI + reflections |
| **Virtual Heightfield Mesh** | B | World-partition heightfield meshing |
| **Virtual Textures (SVT/RVT)** | B ★ | Sparse / runtime virtual textures |
| **Path Tracer** | B | Reference offline ray tracer for cinematics |
| **DLSS** | M ★ | NVIDIA AI upscaling (also exposes Reflex, Frame Gen, Ray Reconstruction) |
| **FSR3** | M | AMD upscaling alternative |
| **Streamline** | M ★ | NVIDIA's unified upscaler/Reflex/FG SDK wrapper |
| **NRD (NVIDIA Real-time Denoiser)** | C | Drop-in denoiser for custom RT passes |
| **Pixel Streaming** | B | Stream the UE viewport over WebRTC to browsers |
| **Movie Render Queue** | B ★ | Offline-quality renders for cinematics |
| **OpenColorIO** | B | Color management for VFX-quality pipelines |
| **Composure** | B | Real-time multi-layer compositing |
| **glTF Importer** | B ★ | Editor glTF import |
| **glTF Runtime** | M ★ | Runtime glTF loading from disk/URL |
| **USD Importer** | B | OpenUSD import / live stage |
| **Datasmith Runtime** | B | Runtime CAD/3D ingestion |
| **Niagara** | B ★ | GPU-driven VFX |
| **Niagara Fluids** | B | Real-time fluid simulations |

## Geometry

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Alembic Importer** | B ★ | Imports `.abc` into Static Mesh / Skeletal / Geometry Cache |
| **Geometry Script** | B ★ | Editor + runtime mesh authoring via BP/Python |
| **Modeling Tools Editor Mode** | B ★ | In-editor poly modeling, sculpting, retopo |
| **Mesh Modeling Toolset** | B | Lower-level toolkit consumed by Modeling Tools |
| **Procedural Content Generation Framework** | B ★ | PCG core |
| **PCG Examples** | B | Reference PCG graphs |
| **PCG Biomes** | B | Layered biome blending |
| **PCG Subdivision** | B | Recursive partitioning operators |
| **PCG Geometry Script Interop** | B | Generate / sample meshes from PCG |
| **OpenLand** | M | Runtime landscape (procedural worlds) |
| **Voxel Plugin Pro** | M | Voxel worlds, marching cubes, smooth terrain |

## Volumes & Atmosphere

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Volumetrics** | B | Heterogeneous Volumes, SparseVolumeTexture |
| **OpenVDB Importer** | B | Bring Houdini/Embergen `.vdb` into UE as SVTs |
| **Sky Atmosphere** | B | Physically-based sky |
| **Volumetric Clouds** | B | Raymarched real-time clouds |
| **Exponential Height Fog** | B | Atmospheric fog (not technically a volume but pairs) |

## Animation

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Animation Budget Allocator** | B | Crowd-scale animation budget control |
| **Animation Sharing** | B | Share evaluated poses across actors |
| **Control Rig** | B ★ | Procedural rigs, IK, retargeting |
| **IK Rig** | B ★ | Skeleton retargeting, runtime IK |
| **Motion Trail Editor** | B | Visualize anim curves in the viewport |
| **Sequencer Animation Tools** | B | Anim editing inside Sequencer |
| **Motion Matching** | B ★ | Pose-search-based locomotion (Lyra-style) |
| **Chooser** | B ★ | Data-driven anim/asset selection |
| **MetaHuman SDK** | B ★ | High-fidelity character creation |
| **MetaHuman Animator** | B | Facial mocap from iPhone footage |
| **Live Link** | B | External mocap / face tracking |
| **Live Link Face (iOS)** | B | Free Apple ARKit face capture |
| **Take Recorder** | B | Mocap take recording |
| **Cloth Asset (Dataflow)** | B | UE 5.4+ next-gen cloth |

## Audio

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **MetaSounds** | B ★ | DSP graph for procedural sound |
| **Audio Synesthesia** | B | Audio analysis (NRT/realtime) |
| **Audio Modulation** | B | Modulation routing, mixing |
| **Soundscape** | B | Procedural ambient audio |
| **Quartz** | B | Sample-accurate scheduling for music |
| **Resonance Audio** | B | Spatial audio |
| **Convolution Reverb** | B | Impulse-response reverb |
| **Wwise** | M | Audiokinetic middleware integration |
| **FMOD** | M | FMOD middleware integration |

## UI

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **UMG** | B ★ | The default UI framework |
| **Common UI** | B ★ | Input routing, focus, controller-friendly |
| **Web Browser** | B | CEF-based browser widget |
| **Web Browser Widget** | B | UMG wrapper for above |
| **WebUI (tracerinteractive)** | C ★ | Modern CEF alternative with render-to-material |
| **Ultralight UE** | C | Lightweight HTML/JS UI |
| **Coherent Gameface** | M | AAA HTML/CSS/JS UI |
| **Slate** | B | Low-level UI framework (UMG sits on top) |

## Networking

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Online Subsystem Steam / EOS** | B ★ | Platform networking |
| **Iris** | B | New replication system in UE 5.x |
| **WebSocket** | B | Native WebSocket client/server |
| **SocketIO Client** | C | Socket.IO bidirectional messaging |
| **VaRest** | C | REST/HTTP/JSON helpers in BP |
| **Pixel Streaming** | B | WebRTC video out of the editor/runtime |
| **Replication Graph** | B | Scale replication to many actors |
| **Push Model** | B | Dirty-bit replication driver |

## Editor & Tools

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Python Editor Script Plugin** | B ★ | Editor-time Python |
| **Editor Utility Widgets** | B ★ | In-editor UMG panels |
| **Asset Manager** | B | Streaming/identity for runtime asset loading |
| **Data Validation** | B | Asset linting |
| **Visual Logger** | B | Spatial event log |
| **Gauntlet** | B | Automation test harness |
| **Functional Testing** | B | Authored gameplay tests |
| **Replays (Demo Net Driver)** | B | Match recording |

## AI Tools (LLM integration)

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **UnrealClaudeMCP** | C ★ | MCP server in UE — drive editor from Claude/Cursor/any MCP client |
| **Unreal AI Connection** | C | Sister/fork repo with 105 tools |
| **UnrealJS (ncsoft)** | C | V8 inside UE — script in JavaScript |
| **Claude Code Game Studios** | C | Claude Code template (49 agents + 72 skills) — not a UE plugin but pairs with one |

## Web & Streaming

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Pixel Streaming** | B ★ | Stream UE to browser |
| **WebRTC** | B | Underlying WebRTC stack |
| **Media Framework** | B ★ | MediaPlayer + MediaTexture for video sources |
| **NDI IO** | M ★ | NewTek NDI in/out as MediaTexture |
| **Spout** | C | Windows texture sharing |
| **Aja** / **Blackmagic** | B | SDI capture cards |
| **Live Streaming Tools** | M | OBS/RTMP bridges |

## VR / AR / XR

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **OpenXR** | B ★ | Cross-vendor XR runtime |
| **OpenXR Eye Tracker** | B | Foveation, gaze input |
| **OpenXR Hand Tracking** | B | Hand pose |
| **Pixel Streaming for XR** | M | Cloud-stream to headsets |
| **AR Core** | B | Android AR |
| **AR Kit** | B | iOS AR |

## AAA / Cinematic

| Plugin | Tag | Purpose |
| --- | --- | --- |
| **Sequencer** | B ★ | Cinematic editor |
| **Movie Render Queue** | B ★ | Cinematic-grade render |
| **Take Recorder** | B | Multi-source mocap recording |
| **NDisplay** | B | Multi-display / LED-wall rendering |
| **In-Camera VFX** | B | Virtual production for ICVFX |
| **Switchboard** | B | Multi-machine cinematic coordination |
| **DMX** | B | Stage lighting integration |
| **Live Link** | B | External feed source |

---

## Curation philosophy

- **Always enable:** Modeling Tools, Geometry Script, Python Editor Scripting, Common UI, PCG (★ entries).
- **Enable when needed:** Pixel Streaming, Composure, OpenXR — heavy, only enable if you use them.
- **Avoid mixing:** DLSS + FSR + XeSS — use **Streamline** as the unified wrapper instead.
- **For shipping:** verify each Marketplace plugin's licensing and platform support before depending on it.

See per-category deep-dive pages in the sidebar.
