# Essential Plugins

The set every UE 5.7 project should enable. Curated for the modern (Nanite + Lumen + WP) pipeline.

## Always on

| Plugin | Why |
| --- | --- |
| **Nanite** | Virtualized geometry — works out of the box |
| **Lumen** | Real-time GI / reflections |
| **Virtual Shadow Maps** | One unified shadow path |
| **Modeling Tools Editor Mode** | In-editor poly modeling |
| **Geometry Script** | Programmatic mesh authoring |
| **Common UI** | Modern UMG with controller / input support |
| **Enhanced Input** | The post-deprecation input system |
| **Python Editor Script Plugin** | Editor automation |
| **Editor Utility Widgets** | In-editor UMG tools |
| **PCG Framework** | Procedural content |
| **MetaSounds** | Modern audio authoring |

## Almost always

| Plugin | Why |
| --- | --- |
| **Sequencer** | Cinematics + non-trivial gameplay scripting |
| **Niagara** | All VFX |
| **glTF Importer** | Standard interchange |
| **OpenXR** | If targeting any VR/AR platform |
| **DLSS / Streamline** | Upscaling on PC builds |
| **Pixel Streaming** | If shipping to web at all |

## Per-project decisions

| Plugin | If you ship… |
| --- | --- |
| **GAS** | Anything with abilities / attributes / effects |
| **Online Subsystem Steam/EOS** | Multiplayer with platform features |
| **Replication Graph + Iris** | High-actor-count multiplayer |
| **Movie Render Queue** | Cinematics / trailers |
| **OpenColorIO** | Pipeline coloring matters (VFX/film) |

## Pitfalls

- Don't enable plugins you don't use — Plugin load time adds up.
- Some plugins (e.g. Niagara Fluids) carry significant startup cost.
- Verify Marketplace plugin licenses before shipping commercially.

See [Catalog](catalog.md) for the full taxonomy.
