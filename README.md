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

## Wiki

The wiki at https://github.com/jdot274/Prism-KB/wiki is **mirrored** from `wiki-content/`.

**One-time wiki bootstrap:** GitHub's `.wiki.git` repo doesn't exist until you create a page through the UI. Visit https://github.com/jdot274/Prism-KB/wiki, click "Create the first page", save anything, then run:

```powershell
./scripts/push-wiki.ps1
```

This will overwrite the wiki with the contents of `wiki-content/`.

## Project board

A roadmap project board is suggested but requires extra OAuth scopes. To create it via CLI:

```bash
gh auth refresh -s project,read:project
gh project create --owner jdot274 --title "Prism-KB Roadmap"
```

Or create it manually at https://github.com/users/jdot274/projects/new. Milestones (v0.2 – v0.6) are already pre-created in the repo.

## Contributing

PRs welcome — see [CONTRIBUTING.md](CONTRIBUTING.md). Any addition to `docs/` auto-deploys to Pages on merge to `main`.

## License

MIT. See [LICENSE](LICENSE).
