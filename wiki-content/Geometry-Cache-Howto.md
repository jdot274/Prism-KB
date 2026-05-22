# Geometry Cache Howto

Full docs at [geometry/geometry-cache](https://jdot274.github.io/Prism/geometry/geometry-cache/).

## Pipeline (Houdini → UE)

1. Houdini ROP_Alembic1:
   - Build Hierarchy From Attribute: `path`
   - Pack Transform: World Space
   - Format: Ogawa
   - Frame Range: timeline
2. Drag `.abc` into UE Content Browser
3. Import as **Geometry Cache** (not Static or Skeletal)
4. Drag asset into level — creates `AGeometryCacheActor`

## Playback in BP

```cpp
GeometryCacheComp->SetGeometryCache(MyCache);
GeometryCacheComp->SetStartTimeOffset(0.f);
GeometryCacheComp->SetLooping(true);
GeometryCacheComp->Play();
```

## Sequencer integration

- Add the actor
- `+ Track → Geometry Cache`
- Keyframe StartTimeOffset or scrub the section

## Performance levers

| Lever | Effect |
| --- | --- |
| Compression (Zlib) | Smaller disk, CPU decode |
| Force Single Mesh | One draw per frame |
| Motion Vectors | Required for TSR/TAA |
| Stream from Disk | Off-load memory |

## Limitations

- No lightmaps (use Lumen)
- Topology change disables GPU skinning
- Niagara can't read cache vertex data; bake to VAT
- Collision = bounds-only

## Modern alternatives

| Need | Use |
| --- | --- |
| Real-time cloth | Cloth Asset (Dataflow) |
| Real-time fluids | Niagara Fluids |
| Real-time destruction | Chaos Destruction |
| Film-grade scenes | USD with `UsdStageActor` |
| Particle attachment | Vertex Animation Texture |
