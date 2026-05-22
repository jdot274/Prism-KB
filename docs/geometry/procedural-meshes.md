# Procedural Meshes

Runtime-built meshes for gameplay — destructibles, marching cubes, generated planets, custom mesh streaming.

## Two choices

| Component | When to use |
| --- | --- |
| **ProceduralMeshComponent** | Original system; easy CPU-side authoring; limited |
| **DynamicMeshComponent** | UE 5.x; full Geometry Script integration; recommended |
| **RuntimeMeshComponent (community plugin)** | Higher-performance third-party alternative |

## Dynamic Mesh quickstart

```cpp
#include "DynamicMeshActor.h"
#include "DynamicMesh/DynamicMesh3.h"
#include "GeometryScript/MeshPrimitiveFunctions.h"

ADynamicMeshActor* Actor = World->SpawnActor<ADynamicMeshActor>();
UDynamicMesh* Mesh = Actor->GetDynamicMeshComponent()->GetDynamicMesh();

FGeometryScriptPrimitiveOptions Options;
UGeometryScriptLibrary_MeshPrimitiveFunctions::AppendBox(
    Mesh, Options, FTransform::Identity, 100, 100, 100);
```

## Performance

- **Tris under ~10k**: free
- **10k–100k**: prefer batched updates; avoid per-frame rebuilds
- **100k+**: convert to Static Mesh at edit time or use Nanite

## Collision

- `DynamicMeshComponent::SetCollisionEnabled` and `EnableComplexAsSimpleCollision`
- For destructibles, use **Chaos Destruction** instead — built for this

## Gotchas

- Procedural meshes don't participate in Nanite. For Nanite participation, bake to a Static Mesh asset and re-spawn.
- Lumen sees procedural meshes via signed-distance-field generation — slow for frequently-changing geo.
- UV channels and tangents must be manually set if you need normal-mapped materials.

## See also

- [Geometry Script](geometry-script.md)
- [PCG](../pcg/index.md)
