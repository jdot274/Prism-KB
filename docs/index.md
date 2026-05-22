# Prism ◈

> An exhaustive Unreal Engine 5.7 knowledge base. Plugins, blueprints, render targets, PCG, geometry cache, volumes, AI tooling, and AAA-grade rendering pipelines — without making you read the official docs three times.

---

## Start here

| If you want to… | Go to |
| --- | --- |
| Understand the **rendering stack** (Nanite, Lumen, VT, RT) | [Rendering](rendering/index.md) |
| Use **render targets** for mirrors, portals, GPU paint | [Render Targets](rendering/render-targets.md) |
| Drive content with **PCG** | [PCG](pcg/index.md) |
| Use the right **volume actor** for the job | [Volumes](volumes/index.md) |
| Bake an **Alembic** sim into the engine | [Geometry Cache](geometry/geometry-cache.md) |
| Find the **best plugin** for X | [Plugins catalog](plugins/catalog.md) |
| Drive UE from **Claude / Cursor / any MCP client** | [AI Integration](ai-integration/index.md) |
| Run **three.js inside UE** or **UE inside three.js** | [Workflows](workflows/index.md) |

## Why this exists

Unreal's official documentation is excellent but spread across dozens of pages, three eras of UE versions, and a labyrinth of feature deprecations. Prism is a single linear knowledge base focused on **UE 5.7** that answers concrete questions:

- "Which volume actor does X?"
- "What's the right plugin for embedding web content on a 3D surface?"
- "How do I use sampler feedback streaming without Unreal's VT system?"
- "What's the cleanest pipeline from Houdini → UE for cached animation?"
- "How do I drive UE from a JSON-RPC client over a local socket?"

Every page links out to authoritative UE source where applicable.

## Reading paths

**You're new to UE 5.7:**

1. [Volumes overview](volumes/index.md) → know the actor catalog
2. [Blueprints overview](blueprints/index.md) → the class hierarchy
3. [Plugins catalog](plugins/catalog.md) → what's available
4. [Rendering overview](rendering/index.md) → modern renderer concepts

**You're an engine programmer:**

1. [Nanite](rendering/nanite.md) + [Virtual Textures](rendering/virtual-textures.md)
2. [NVIDIA RTX Stack](workflows/nvidia-rtx-stack.md)
3. [Iris replication](networking/iris.md)

**You're an AI / tooling engineer:**

1. [AI Integration overview](ai-integration/index.md)
2. [UnrealClaudeMCP](ai-integration/unreal-claude-mcp.md)
3. [Unreal AI Connection](ai-integration/unreal-ai-connection.md)
4. [Streaming pipelines](workflows/streaming-pipelines.md)

## Versions

Pages target **UE 5.7** unless otherwise noted. Older API behavior is called out inline.

## Contributing

PRs welcome — see [CONTRIBUTING](https://github.com/jdot274/Prism/blob/main/CONTRIBUTING.md).
