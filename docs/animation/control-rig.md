# Control Rig

Procedural rigging system. Build IK solvers, secondary motion, dynamic pose modifications inside a node graph. Editor-first authoring + runtime evaluation.

## Roles

| Role | Use |
| --- | --- |
| **Animator-friendly rig** | In-editor manipulators for posing in Sequencer |
| **Runtime IK** | Foot planting, hand-on-object, look-at |
| **Retargeting** | Convert animation between skeletons |
| **Procedural FX** | Dragon tail wagging, antenna swaying |
| **Backwards solving** | Inverse-control bipeds (Mannequin-style controls) |

## Authoring

1. Create a **Control Rig Blueprint** from a skeleton
2. Open the Rig Hierarchy panel — add **Controls** (manipulators)
3. In the Forward Solve graph, drive bones from controls
4. In the Backwards Solve graph, derive controls from bones (for retargeting)

## In AnimGraph

Drop a **Control Rig** node — feeds the current pose into the rig, lets it modify, outputs the modified pose. Use cases:

- **Foot IK** — trace down from foot bone, plant on geometry
- **Aim look-at** — orient head/spine toward a target
- **Weapon hold** — IK both hands onto a weapon socket

## In Sequencer

Animators can pose the rig directly in Sequencer using controls. The Cinematic team uses Control Rig for hand-posed cinematics layered over mocap.

## Modular Control Rig (5.4+)

A library of pre-built rig modules (Biped, Quadruped, Bird) you compose. Reduces authoring time for new characters.

## IK Rig vs Control Rig

| Topic | IK Rig | Control Rig |
| --- | --- | --- |
| Primary use | Retargeting | Procedural deformation |
| Authoring complexity | Lower | Higher |
| Runtime cost | Lower | Higher |
| Sequencer authoring | No | Yes |

Use IK Rig for retargeting between skeletons; Control Rig for procedural pose modification.

## Performance

- Control Rig graph evaluation is per-instance — heavy rigs can dominate animation cost.
- Optimize with **LOD Threshold** on the AnimGraph node.
- Profile with `stat AnimationParallelEvaluation`.

## See also

- [IK Rig](animgraph.md#ik-rig) (covered in AnimGraph context)
- [UE — Control Rig](https://docs.unrealengine.com/5.7/en-US/control-rig-in-unreal-engine/)
