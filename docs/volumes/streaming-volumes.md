# Level Streaming Volumes

`ALevelStreamingVolume` controls sublevel load/unload. Legacy pattern compared to **World Partition**, but still used for tight per-region streaming control.

## Setup

1. Level → **Levels** window → add sublevels as Always Loaded / Streaming
2. Place a `LevelStreamingVolume` over the area that should trigger streaming
3. In the Levels window, right-click each streaming sublevel → **Stream In When Player Inside Volume** → assign the volume

## Properties

| Property | Effect |
| --- | --- |
| **Editor Pre-Vis Only** | Volume affects editor view only, not runtime |
| **Streaming Levels** | Array of sublevels this volume controls |
| **Use Blocking** | Block the player's view until loaded |
| **Disabled** | Soft-disable the volume |

## Block-on-Load gotchas

If `bShouldBlockOnLoad` is true on the streaming level, the load happens synchronously — frame hitch on entry. Set false for async streaming with a fade-in.

## When to use vs World Partition

| Approach | When |
| --- | --- |
| **Level Streaming Volumes** | Legacy or specific transition-style maps; tight artist control over what loads when |
| **World Partition** | New projects, large open worlds; automatic per-cell streaming |

You can use both in the same project — e.g. World Partition for the main world, traditional sublevels for instanced dungeons that LS volumes load.

## Streaming API

Programmatic alternative — call from any actor:

```cpp
ULevelStreaming* Lvl = UGameplayStatics::GetStreamingLevel(this, TEXT("MyDungeon_01"));
Lvl->SetShouldBeLoaded(true);
Lvl->SetShouldBeVisible(true);
```

## Gotchas

- Volumes only trigger for the **PlayerController's PlayerCameraManager**, not arbitrary actors.
- Sublevels with persistent navigation must rebuild navmesh on load — expect a one-frame nav recalc.
- For multiplayer, the **server** decides streaming; client sublevels follow.
