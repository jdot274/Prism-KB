# One File Per Actor (OFPA)

In World Partition maps, each actor is saved as its **own `.uasset` file** under `<Map>/__ExternalActors__/`. The map itself is a tiny stub.

## Why

- **Merge-friendly** — two artists editing different actors don't conflict in source control
- **Streaming-friendly** — load only the actors needed for a cell
- **Editor scalability** — open a 100k-actor world without loading all of it

## File layout

```
<Project>/Content/Maps/MyWorld.umap                     # the tiny map stub
<Project>/Content/Maps/__ExternalActors__/MyWorld/
  0/B5/D9/2F3C-...-MyActor_01.uasset
  ...
<Project>/Content/Maps/__ExternalObjects__/MyWorld/
  0/B5/D9/2F3C-...-MyComponent.uasset
```

Filenames are content-addressed hashes — git-friendly, no rename conflicts.

## Source control

| VCS | Behavior |
| --- | --- |
| **Git LFS** | Each actor is a tiny binary file — fast clones |
| **Perforce** | Per-actor exclusive checkout — no more locking the entire map |
| **Plastic** | Item-level merge support |

## Reverting / debugging

The **External Actor** files can be diffed individually via the UE diff tool. The Levels window shows which actors are loaded (highlighted) vs unloaded (greyed).

## Common pitfalls

- Submitting a map without the matching `__ExternalActors__/` files breaks the build.
- Renaming a map: also rename the matching external actor folder.
- Non-WP maps: OFPA isn't used — actors live inside the `.umap`.

## See also

- [World Partition](world-partition.md)
- [Data Layers](data-layers.md)
