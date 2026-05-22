# Modeling Tools

In-editor poly modeling toolkit. Enable the **Modeling Tools Editor Mode** plugin and pick **Modeling** in the Modes panel.

## Tool categories

| Category | Tools |
| --- | --- |
| **Create** | Box, Cylinder, Sphere, Disk, Stairs, Lathe, Sweep |
| **Transform** | Edit Pivot, Align, Bake Transform |
| **Polymodel** | Cube Grid, PolyEdit, Extrude, Inset, Bevel, Loop Cut |
| **MeshOps** | Boolean (CSG), Plane Cut, Mirror, Mesh Inspector |
| **Deform** | Smooth, Sculpt, Flatten, Sticky Editing |
| **UVs** | UV Layout, Unwrap, UV Editor |
| **Voxel** | Voxel Merge, Voxel Solidify, Voxel Offset |
| **Bake** | Bake to Mesh, Bake Vertex Colors, Bake Materials |
| **LOD** | Generate LOD chain, Bake Nanite |

## Workflow examples

### Blocking a level

1. Modeling Mode → **Create → Cube Grid**
2. Snap to a 1 m grid, lay out rooms
3. **Boolean Subtract** doors / windows
4. **Plane Cut** for floors

### Cleaning a high-poly mesh for Nanite

1. **Mesh Inspector** for non-manifold edges
2. **Auto Repair** to fix holes / inverted normals
3. **Generate LOD** with target tri count if you need a fallback for non-Nanite hardware

### Retopology

1. **PolyDeform → AutoRetopo** for organic models
2. **TriangulateUV** then **PolyGroups** to define hard edges
3. **Bake** normal map from source to retopo mesh

## Scripting

Modeling Tools expose **Geometry Script** as their underlying engine, so any operation can be scripted from BP / Python. See [Geometry Script](geometry-script.md).

## Gotchas

- All modeling output is a Static Mesh asset by default — pick a folder during the operation.
- **Undo** works per tool but not per click — commit each operation deliberately.
- The mesh inspector's "Errors" panel surfaces issues Nanite cares about (non-manifold, zero-area triangles).
