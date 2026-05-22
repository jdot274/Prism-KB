# Chooser

Data-driven selection: given a struct of inputs (character state, context tags), return one of N assets to use. The asset can be an `AnimSequence`, `PoseSearchDatabase`, `Niagara System`, anything.

## When to use

Anywhere you'd otherwise write a `switch` over enums to pick an animation/asset. Examples:

- **Walk cycle by weapon held** — rifle, pistol, unarmed, two-handed sword
- **Reaction by damage type** — fire, electric, blunt → different montages
- **VFX by surface type** — metal, wood, flesh → impact effects
- **UI per platform** — keyboard, gamepad, touch

## Asset

`UChooser` — a table with:

- A **context struct** (inputs)
- Rows of `(if conditions, then asset)`
- A fallback asset

Conditions can be:

- Bool equals
- Enum equals
- Tag matches (FGameplayTag)
- Float range
- Gameplay attribute compare

## Example

```cpp
USTRUCT() struct FMyChooserCtx {
    UPROPERTY() FGameplayTag Stance;       // Crouched / Standing
    UPROPERTY() FGameplayTag Weapon;        // Rifle / Pistol / None
    UPROPERTY() bool         bMoving;
};
```

Table:

| Stance | Weapon | bMoving | Result |
| --- | --- | --- | --- |
| Standing | Rifle | true | Rifle_Run_DB |
| Standing | Rifle | false | Rifle_Idle |
| Crouched | * | * | Crouched_DB |
| * | * | * | Default_DB (fallback) |

In the AnimGraph: `Choose Asset (Chooser)` node, feed the chooser asset and context struct.

## Combining with Motion Matching

The most common pattern in modern UE games:

```
Chooser(weapon, stance, …) → PoseSearchDatabase → MotionMatching node
```

The Chooser swaps databases; Motion Matching does pose-level interpolation inside the selected DB.

## Performance

- Chooser lookups are near-free (it's a hash lookup).
- Choosers can be evaluated on any thread.
- Author chooser tables in the dedicated **Chooser Editor** for visual tuning.

## See also

- [Motion Matching](motion-matching.md)
- [UE — Chooser](https://docs.unrealengine.com/5.7/en-US/chooser-in-unreal-engine/)
