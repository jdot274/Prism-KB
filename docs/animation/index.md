# Animation

UE 5.7's animation stack has shifted significantly from the 4.x days. The modern recipe:

- **Skeletal Mesh** with **IK Rig** for retargeting
- **Motion Matching** or **Anim Blueprint** for locomotion
- **Control Rig** for procedural deformation
- **Chooser** for data-driven asset selection
- **MetaHuman Animator** for facial mocap

## Pages

- [AnimGraph](animgraph.md)
- [Motion Matching](motion-matching.md)
- [Chooser](chooser.md)
- [Control Rig](control-rig.md)
- [MetaHuman](metahuman.md)

## Core assets

| Asset | Purpose |
| --- | --- |
| `USkeletalMesh` | Skinned geometry |
| `USkeleton` | Bone hierarchy + retargeting metadata |
| `UAnimSequence` | Single clip |
| `UAnimMontage` | Sectioned multi-track playback |
| `UBlendSpace` / `UBlendSpace1D` | Continuous blend across parameters |
| `UAimOffset` (BlendSpace subtype) | Aim-targeted blend |
| `UControlRig` | Procedural rig asset |
| `UIKRig` | Retargeting + runtime IK |
| `UPoseSearchDatabase` | Motion Matching database |
| `UChooser` | Data-driven asset chooser |
| `UAnimBlueprint` | Authored `UAnimInstance` |

## Performance

- Enable **Update Rate Optimization** to skip distant characters' animation.
- Use **Animation Sharing** for crowds — one evaluation, many actors.
- **Compress** sequences with `ACL` (Animation Compression Library) for huge libraries.
