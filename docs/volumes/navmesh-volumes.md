# NavMesh Bounds Volumes

`ANavMeshBoundsVolume` defines **where the navigation mesh is built**. Without one, no navmesh exists and AI pawns can't path.

## Setup

1. Place a `NavMeshBoundsVolume` covering the playable area.
2. Project Settings → **Navigation Mesh** — pick the agent radius / cell size.
3. The editor rebuilds the navmesh automatically on changes.
4. View it with `P` in the viewport (toggles `Show → Navigation`).

## Building strategies

| Strategy | When |
| --- | --- |
| **Static** | Pre-built at level save, lowest runtime cost |
| **Dynamic (auto-modifying)** | Rebuilds at runtime when actors with `bNavigationRelevant` move |
| **Tile-based with rebuild** | Rebuilds dirty tiles only — best for huge worlds |

`Project Settings → Navigation Mesh → Runtime Generation`:

- `Static`
- `Dynamic`
- `DynamicModifiersOnly` — re-runs only the modifier pass, not the geometry rasterization (fastest)

## Multiple agents

Configure agents (e.g. small humanoid, large vehicle) in **Project Settings → Navigation System → Supported Agents**. Each agent gets its own navmesh layer.

## Modifiers

`UNavModifierComponent` or `NavModifierVolume` can:

- Cost-modify regions ("avoid going through fire")
- Mark areas as impassable for specific agents
- Define jumpable links via `NavLinkProxy`

## Linked nav for long jumps / ledges

`NavLinkProxy` actors define point-to-point connections that the navmesh treats as edges. Used for ladders, drop-offs, teleporters.

## Performance

- Larger cell sizes = faster build, blockier paths.
- Limit your NavMeshBoundsVolume to the actual playable area; don't include the skybox.
- Dynamic rebuild on cell change can spike the main thread — profile with `stat NavSystem`.

## Gotchas

- A NavMesh Bounds Volume that's too thin in Z misses geometry. Cover at least 2 m vertically beyond your tallest walkable surface.
- For **World Partition** maps, navmesh streams per cell — make sure each WP cell has bounds coverage.
- AI uses the **first matching** Supported Agent — order matters in the project settings list.
