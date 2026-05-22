# Data Layers

Toggle subsets of actors on/off. Used for day/night variants, mission states, debug overlays, optional content.

## Setup

1. **Window → World Partition → Data Layers** (in a WP map)
2. Create a **Data Layer Asset** (`UDataLayerAsset`)
3. Assign actors → Data Layer in their **Actor → Data Layers** array
4. Toggle the layer in the editor or via API

## Runtime API

```cpp
UDataLayerSubsystem* DLS = GetWorld()->GetSubsystem<UDataLayerSubsystem>();
DLS->SetDataLayerInstanceRuntimeState(NightLayerAsset, EDataLayerRuntimeState::Activated);
```

## Common patterns

| Pattern | Layers |
| --- | --- |
| Day/Night | `Day`, `Night` — exclusive activation |
| Mission states | `Mission_01_Active`, `Mission_01_Complete` |
| Debug overlays | `Debug_NavmeshVis` |
| Platform-specific | `Mobile_LowDetail`, `PC_HighDetail` |
| Faction variants | `Faction_Red`, `Faction_Blue` |

## Editor vs runtime layers

- **Editor only** — affect what artists see, no runtime cost.
- **Loaded** — actor exists but invisible; can be toggled
- **Activated** — actor exists and visible

## Replication

`Data Layer` activation is server-replicated automatically. Clients see the same activation state.

## Limitations

- Activating a layer with thousands of actors is expensive — stagger or pre-load.
- Layered actors and PCG don't always coordinate; PCG bounds checks consider all actors, not layer state.
- Editor: avoid editing actors in unloaded layers — they don't load just for editing.

## See also

- [World Partition](world-partition.md)
- [One File Per Actor](one-file-per-actor.md)
