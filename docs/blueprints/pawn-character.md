# Pawn and Character

Possess-able actor classes. A **Controller** (`APlayerController` or `AAIController`) possesses a Pawn to drive it.

## APawn

Minimal possess-able actor. Has no built-in movement, mesh, or input — bring your own.

| When to use | Vehicles, spaceships, custom physics-driven actors |

## ACharacter

`ACharacter` extends `APawn` with:

- **CapsuleComponent** (root, collision)
- **CharacterMovementComponent** (CMC) — full kinematic locomotion with `Walking / Falling / Swimming / Flying / Custom` modes
- **SkeletalMeshComponent** (visual)
- Network-replicated movement with prediction + server reconciliation

| When to use | Bipeds, animals, anything that walks/runs/jumps |

## CharacterMovementComponent

Properties worth knowing:

| Property | Effect |
| --- | --- |
| **MaxWalkSpeed / MaxAcceleration** | Ground locomotion |
| **JumpZVelocity** | Jump impulse |
| **GravityScale** | 1.0 default; physics volume can override |
| **AirControl** | 0–1 lateral control while falling |
| **bUseControllerDesiredRotation / bOrientRotationToMovement** | Character faces input vs faces controller |
| **CrouchedHalfHeight** | Capsule size while crouched |
| **MaxStepHeight** | Auto-step-up threshold |
| **WalkableFloorAngle** | Steep slope cutoff |
| **NavAgentProps** | Used by AI nav system |

## Input wiring (Enhanced Input)

```cpp
void AMyChar::SetupPlayerInputComponent(UInputComponent* Input)
{
    UEnhancedInputComponent* EI = Cast<UEnhancedInputComponent>(Input);
    EI->BindAction(MoveAction, ETriggerEvent::Triggered, this, &AMyChar::HandleMove);
    EI->BindAction(JumpAction, ETriggerEvent::Started, this, &ACharacter::Jump);
}
```

## Controllers

| Controller | Use |
| --- | --- |
| `APlayerController` | Local + remote players; per-player UI, input, camera |
| `AAIController` | NPCs; usually wraps a `UBlackboardComponent` + `UBehaviorTreeComponent` |

Possession: `PlayerController->Possess(MyPawn)`.

## Network movement

Character movement is **client-predicted with server reconciliation** out of the box. The client simulates locally and sends moves to the server; the server validates and corrects.

- Set `Replicates = true` on the Character
- Set `Replicate Movement = true`
- Custom velocity changes that aren't via the CMC must be replicated manually

## Common subclasses

- **Player Characters** — extend ACharacter, add cameras, abilities, inventory
- **AI Characters** — extend ACharacter + AAIController + BehaviorTree
- **Vehicles** — extend APawn + `UChaosVehicleMovementComponent`
- **Spectators** — use `ASpectatorPawn`

## Gotchas

- Capsule radius must clear navmesh agent radius or AI can't path to the same spots as the player.
- Crouching changes the capsule height which can pop the camera — bind the camera to a `SpringArmComponent` to smooth it.
- Replicated movement requires the server's Character to have `bReplicates = true` AND `bReplicateMovement = true`.
