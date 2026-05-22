# Volumes Cheatsheet

| Volume | What it does | Common props |
| --- | --- | --- |
| **PostProcessVolume** | Per-region post FX, exposure, bloom, color grading | Priority, BlendWeight, BlendRadius, Settings.* |
| **TriggerVolume / TriggerBox** | Gameplay overlap triggers | Collision Profile, Generate Overlap Events |
| **BlockingVolume** | Invisible collision | Collision Preset |
| **PhysicsVolume** | Override gravity / damping / fluid | FluidFriction, TerminalVelocity, GravityOverride |
| **AudioVolume** | Reverb + interior/exterior + occlusion | ReverbEffect, Interior/Exterior LPF/Volume |
| **NavMeshBoundsVolume** | Where navmesh is built | (no per-volume settings — global in Project Settings) |
| **CullDistanceVolume** | Per-region cull distances by mesh size | CullDistances[] |
| **LightmassImportanceVolume** | Restrict GI bake | (lighting-only) |
| **PrecomputedVisibilityVolume** | Bake static visibility | (mobile-focused) |
| **LevelStreamingVolume** | Stream sublevels in/out | StreamingLevels[], bShouldBlockOnLoad |
| **PCGVolume** | Bounds for PCG generation | GraphInstance, GenerationTrigger |
| **HeterogeneousVolume** | 3D voxel volumes, OpenVDB clouds/smoke | SVT asset, Step Count |
| **KillZVolume** | Instantly destroy actors | (subclass of PainCausing) |
| **PainCausingVolume** | Damage actors over time | DamagePerSec, DamageType |
| **MeshMergingVolume** | Auto-merge meshes for HLOD | (HLOD-only) |

## Quick rules

- **Higher priority wins** when volumes overlap.
- **BlendRadius** softens entry/exit.
- **Unbound** PostProcess affects the whole world.
- **NavMesh** rebuilds when the volume changes; expect editor pauses.
- **PCG** + WP cells generate per-cell with hierarchical seeds.

Full docs at [volumes/](https://jdot274.github.io/Prism-KB/volumes/).
