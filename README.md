# Prism ◈

> An exhaustive Unreal Engine 5.7 knowledge base — plugins, blueprints, volumes, PCG, geometry cache, render targets, AI tooling, and AAA-grade rendering pipelines.

[![Pages](https://github.com/jdot274/Prism-KB/actions/workflows/deploy-docs.yml/badge.svg)](https://github.com/jdot274/Prism-KB/actions/workflows/deploy-docs.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Site:** https://jdot274.github.io/Prism-KB/

---

## What's inside

| Section | Covers |
| --- | --- |
| **Rendering** | Nanite, Lumen, Virtual Textures, Render Targets, Path/Ray Tracing, Pixel Streaming, Post Process |
| **Geometry** | Geometry Cache, Nanite, Modeling Tools, Geometry Script, Procedural Meshes |
| **PCG** | Graphs, Samplers, Spawners, Volumes, Biomes, World Partition integration |
| **Volumes** | The full taxonomy — PostProcess, Trigger, Physics, Audio, NavMesh, Cull, Streaming, Heterogeneous |
| **Blueprints** | Actor, Pawn, Character, Components, Widget, Animation, Data Asset, Gameplay Ability |
| **Plugins** | Catalog + deep-dives for every category (essential, rendering, audio, UI, anim, net, AI, web) |
| **Animation** | AnimGraph, Motion Matching, Chooser, Control Rig, MetaHuman |
| **Audio** | MetaSounds, Sound Cues, Classes, Audio Volumes, Quartz |
| **Networking** | Replication, RPCs, Iris, Pixel Streaming, Dedicated Servers |
| **Tools** | Modeling, Landscape, Foliage, Sequencer, World Partition, Data Layers, One-File-Per-Actor |
| **AI Integration** | UnrealClaudeMCP, Unreal AI Connection, Claude Code Game Studios, UnrealJS |
| **Workflows** | three.js ↔ UE, NVIDIA RTX stack, streaming pipelines |
| **Reference** | Glossary, console commands, CVars |

## Quick start (local docs preview)

```bash
pip install -r requirements.txt
mkdocs serve
```

Open http://127.0.0.1:8000

## Repo layout

```
docs/                MkDocs source (deployed to Pages)
wiki-content/        Mirrored on the GitHub wiki
gists/               Standalone code snippets (also pushed as Gists)
projects/            Project board specs
.github/workflows/   CI: build + deploy MkDocs to gh-pages
mkdocs.yml           Site config
```

## Contributing

PRs welcome — see [CONTRIBUTING.md](CONTRIBUTING.md). Any addition to `docs/` auto-deploys to Pages on merge to `main`.

## License

MIT. See [LICENSE](LICENSE).
