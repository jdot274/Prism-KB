# Modeling Mode

See [Geometry → Modeling Tools](../geometry/modeling-tools.md) for the full reference.

This page exists as a quick-jump from the Tools section.

## When to use

- Blocking out levels without leaving UE
- Quick mesh repair / cleanup
- Bake LODs and Nanite settings in one place
- Generate UVs, project decals, retopo organic models

## Quick recipe — block out a room

1. Modeling Mode → **Cube Grid** at 100×100×100 cm
2. Lay out floor, walls
3. **Boolean Subtract** for doors / windows
4. **Generate LODs** for non-Nanite hardware fallback
5. Save as Static Mesh — drop back in level
