# AnimGraph

The AnimGraph in an Animation Blueprint evaluates each frame to produce the skeletal mesh's pose.

## Topology

```
Sources → Modifiers → Output Pose
```

| Family | Nodes |
| --- | --- |
| **Sources** | Sequence, Sequence Player, Blend Space, Pose Snapshot, Skeletal Control Anim |
| **State Machines** | Locomotion, combat, weapon poses |
| **Blends** | Blend by Bool/Int/Enum, Layered Blend Per Bone, Apply Mesh Space Additive |
| **IK / Modify** | Two Bone IK, Full Body IK (FBIK), Control Rig node |
| **Cache** | Cached Pose (reuse identical pose downstream without re-evaluation) |
| **Output** | `Output Pose` (required) |

## State machines

Each state is a sub-graph (usually a Sequence Player). Transitions evaluate per frame; first true wins.

| Transition setting | Effect |
| --- | --- |
| **Duration** | Crossblend time |
| **Bind to Notify** | Trigger on anim notify |
| **Crossfade Mode** | Linear / Cubic / Constant |
| **Priority** | Wins when multiple transitions are active |

## Cached Pose

Computing the same pose twice is wasteful. Cache once:

```
Locomotion → New Save Cached Pose ("Locomotion")
... downstream ...
Use Cached Pose ("Locomotion") → Blend with Hit Reaction → Output
```

## Update vs Evaluate

- **Update** (`OnUpdateAnimation`) — runs in any tick group; for variable reads & condition logic
- **Evaluate** — runs on the animation thread, builds the actual pose; only access thread-safe data

Use `UAnimInstance::NativeUpdateAnimation` in C++ to update from `OwningActor` state safely.

## Threading

UE 5.x runs `Evaluate` on the **animation worker thread**. Variables read in the AnimGraph must be `BlueprintThreadSafeUpdateAnimation` or set in `Update`.

## Performance

- Use **State Caching** on identical subgraphs.
- Limit **Two Bone IK / FBIK** depth — these are CPU-heavy.
- Profile with `stat AnimationParallelEvaluation`.

## See also

- [Motion Matching](motion-matching.md) — the modern alternative for locomotion
- [Control Rig](control-rig.md) — procedural deformation inside AnimGraph
