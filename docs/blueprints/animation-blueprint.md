# Animation Blueprint

A subclass of `UAnimInstance` that drives a skeletal mesh's pose each frame via an **AnimGraph**.

## Tabs

| Tab | Purpose |
| --- | --- |
| **AnimGraph** | The pose pipeline — state machines, blends, IK, output pose |
| **Event Graph** | Cosmetic logic, variable updates, blueprint events |
| **Pose Snapshot** | Save/restore poses |
| **Anim Notify** | Handler stubs for `AnimNotify_*` events |

## AnimGraph anatomy

```
Sequence / Cache → State Machine → Layered Blend Per Bone → IK → Output Pose
```

| Node type | Examples |
| --- | --- |
| **Pose sources** | Play Sequence, Apply Mesh Space Additive, Sequence Player |
| **State machines** | Locomotion, Combat, Hit Reactions |
| **Blends** | Blend by Bool/Int/Enum, Blend Per Bone, Layered Blend |
| **Modify** | Two Bone IK, Full Body IK, Control Rig |
| **Output** | The mandatory `Output Pose` |

## State machines

Each state holds an AnimGraph subgraph (typically a Sequence Player). Transitions between states have:

- Bool / int / float conditions
- Duration (cross-blend time)
- Notifies (state enter/exit events)

## Motion Matching

UE 5.4+ — replaces traditional state machines for locomotion with a pose-search approach. See [Animation → Motion Matching](../animation/motion-matching.md).

## Chooser

UE 5.4+ — data-driven asset selection. See [Animation → Chooser](../animation/chooser.md).

## Performance

| Lever | Effect |
| --- | --- |
| **Update Rate Optimization (URO)** | Skip evaluation when far from camera |
| **LOD Threshold** on AnimGraph nodes | Disable expensive nodes at distance |
| **Animation Budget Allocator** | Crowd-scale budgeting |
| **Animation Sharing** | Share evaluated pose across N actors |

## See also

- [Control Rig](../animation/control-rig.md)
- [MetaHuman](../animation/metahuman.md)
