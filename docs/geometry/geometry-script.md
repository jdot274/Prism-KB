# Geometry Script

Scriptable mesh authoring — same engine that drives Modeling Tools. Callable from Blueprint, Python, and C++. Use it to build assets procedurally at editor time or at runtime.

## Enable

`Geometry Script` plugin → restart.

## Two modes

| Mode | Asset | Use |
| --- | --- | --- |
| **Editor scripting** | Static Mesh asset | Build content offline, save to disk |
| **Dynamic Mesh Actor** | `ADynamicMeshActor` | Runtime mesh built into the scene |

## Editor-time example (Python)

```python
import unreal
import unreal.GeometryScriptLibrary_MeshPrimitiveFunctions as P

mesh = unreal.DynamicMesh()
P.append_box(mesh, unreal.GeometryScriptPrimitiveOptions(), unreal.Transform(), 200, 200, 200)
P.append_sphere(mesh, unreal.GeometryScriptPrimitiveOptions(), unreal.Transform(unreal.Vector(0, 0, 200)), 100)

# Save to a static mesh asset
unreal.GeometryScriptEditor.create_new_static_mesh_asset_from_mesh(
    '/Game/Generated', 'MyMesh', mesh
)
```

## Runtime example (Blueprint nodes)

Place a `DynamicMeshActor` → on `BeginPlay`:

1. `Get Dynamic Mesh Component → Get Dynamic Mesh`
2. `Append Box` → modify in place
3. `Apply Material` → assign at runtime

## Node families

| Family | Notable nodes |
| --- | --- |
| **Primitives** | AppendBox, AppendSphere, AppendCylinder, AppendDisc, AppendTorus |
| **Booleans** | ApplyMeshBoolean (Union/Subtract/Intersect) |
| **Edit** | InsetFaces, ExtrudeFaces, BevelEdges, SmoothMesh |
| **Generate** | GenerateConvexHull, GenerateSphericalHarmonics |
| **UVs** | RecomputeUVs, RepackUVs, ProjectUVs |
| **Sample** | SampleMeshOnPoints, SampleMeshOnSpline |
| **Output** | StaticMeshFromDynamicMesh, BakeNaniteSettings |

## When to use

- **PCG output** — convert sample points into bespoke meshes
- **Procedural levels** — generate rooms, dungeons, terrain features
- **Asset variation** — bake N variations of a mesh from one template
- **Live editor tools** — Editor Utility Widgets that build geometry on click

## See also

- [PCG Geometry Script Interop](../pcg/index.md)
- [Procedural Meshes](procedural-meshes.md)
- [UE — Geometry Script](https://docs.unrealengine.com/5.7/en-US/geometry-script-in-unreal-engine/)
