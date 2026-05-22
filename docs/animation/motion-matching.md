# Motion Matching

Locomotion via **pose search**: given the character's current pose + future trajectory, search a database of pose samples for the closest match and play from there. Eliminates the hand-authored state machines that dominated 4.x locomotion.

Used in Lyra, The Matrix Awakens demo, and Epic's reference projects.

## Required plugins

- **Motion Trajectory**
- **Pose Search**
- **Chooser** (often paired)

## Assets

| Asset | Role |
| --- | --- |
| `UPoseSearchDatabase` | The searchable library of pose samples |
| `UPoseSearchSchema` | Defines what features to match (root velocity, foot position, etc.) |
| `UMotionTrajectoryComponent` | Produces predicted trajectory each frame |
| Animation sequences | Indexed into the database |

## Pipeline

1. Author / record animation sequences
2. Create a Pose Search Database, add sequences as searchable
3. Define a Pose Search Schema — typically:
   - Trajectory (1 s history + 1 s prediction)
   - Velocity
   - Foot bone position
   - Bone velocity
4. In the AnimGraph: `Motion Matching` node samples the database and outputs the matched pose

## Tuning

| Knob | Effect |
| --- | --- |
| **Sample Rate** | DB sample density (30 Hz typical) |
| **Schema weights** | Trade trajectory match vs body pose match |
| **Continuation Bias** | Prefer the currently-playing animation if equally good |
| **Mirror** | Auto-mirror left/right matches |

## Strengths

- Smooth transitions automatically (no hand-tuned crossfades)
- Natural foot planting
- Compact authoring — add new animations to expand the move set
- Scales to large move sets (1000+ clips)

## Weaknesses

- DB build time grows with sample count
- Tuning weights is non-obvious
- Doesn't replace combat / hit reaction state machines — pair with traditional anim

## Use cases

- Player locomotion
- NPC walks / runs / strafes
- Mounts / animals

## Combine with Chooser

[Chooser](chooser.md) selects which Pose Search Database to use based on character state (weapon, stance, health). Effectively a 2D lookup: state → DB, then DB matches by pose.

## Links

- [UE — Motion Matching](https://docs.unrealengine.com/5.7/en-US/motion-matching-in-unreal-engine/)
- Lyra's `B_PlayerCharacter` AnimGraph uses MM + Chooser
