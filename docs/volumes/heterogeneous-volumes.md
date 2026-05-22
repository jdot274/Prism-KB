# Heterogeneous Volumes & Sparse Volume Textures

UE 5.3+ introduced **Sparse Volume Textures (SVT)** and the `HeterogeneousVolume` actor — real-time volumetric rendering for clouds, smoke, fluid sims, nebulae. The plumbing that finally makes OpenVDB content first-class in UE.

## Components

| Asset / Actor | Purpose |
| --- | --- |
| **SparseVolumeTexture** | 3D voxel asset; can be loaded from `.vdb` |
| **HeterogeneousVolume actor** | Places an SVT in the world; provides bounds + material |
| **Volumetric materials** | Material Domain = Volume |

## Importing OpenVDB

1. Enable **OpenVDB Importer** plugin
2. Drag a `.vdb` from Houdini/Embergen/EmberGen/SideFX Solaris into the Content Browser
3. Choose Sparse Volume Texture during import
4. UE compresses grids into BCn-style volume textures

## Sequence (animated SVT)

OpenVDB files can be sequences — UE imports them as a `SparseVolumeTextureFrame` array. Set the **Frame Number** on the HeterogeneousVolume to animate, or hook into Sequencer for keyframed playback.

## Materials

Material Domain = **Volume**. Inputs:

- Albedo (volumetric color)
- Extinction (density × extinction coefficient)
- Emissive
- AmbientOcclusion

Sample the SVT via `Volume Texture Sample`. The renderer ray-marches the volume against the scene.

## Performance

| Lever | Effect |
| --- | --- |
| Voxel resolution | Linear cost |
| Step count (CVar `r.HeterogeneousVolumes.MaxStepCount`) | Sample density along rays |
| **Sparse mode** | Only allocates voxels with content |
| **Mip levels** | LOD across distance |

## Lighting

HeterogeneousVolumes are lit by:

- **Lumen** (real-time, approximate)
- **Path Tracer** (offline, accurate scattering)
- Directional lights cast self-shadows automatically

## Gotchas

- **Lumen reflections** off heterogeneous volumes look correct in HW RT, fuzzy in SW.
- **Translucent post-process** ordering matters — set `r.HeterogeneousVolumes.RenderBeforeTransparent` if blending issues appear.
- **Editor playback** of animated VDB can be expensive — reduce voxel grid resolution or set a smaller bounding box.

## Use cases

- Real-time cloudscapes (combined with VolumetricCloud)
- Smoke plumes
- Magical fog / energy fields
- Holographic projections (low-density emissive volumes)

## Links

- [UE — Heterogeneous Volumes](https://docs.unrealengine.com/5.7/en-US/heterogeneous-volumes-in-unreal-engine/)
- [OpenVDB](https://www.openvdb.org/)
