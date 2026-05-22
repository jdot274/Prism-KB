# Blueprints

Unreal's visual scripting + class system. Every "Blueprint" is a subclass of some native C++ `UObject` — the BP system simply lets you author classes and graphs visually.

## Top-level class hierarchy

```
UObject
├── UActorComponent
│   └── USceneComponent
│       ├── UStaticMeshComponent
│       ├── USkeletalMeshComponent
│       ├── UWidgetComponent
│       ├── USceneCaptureComponent2D
│       └── ...
├── AActor
│   ├── APawn
│   │   └── ACharacter
│   ├── AController
│   │   ├── APlayerController
│   │   └── AAIController
│   ├── AGameModeBase
│   ├── AGameStateBase
│   ├── APlayerState
│   ├── ALevelScriptActor
│   ├── AHUD
│   ├── AVolume
│   └── ...
├── UWidget (UMG)
│   └── UUserWidget
├── UAnimInstance
├── UDataAsset
├── UBlueprintFunctionLibrary
├── USaveGame
└── UInterface
```

## Page index

| Topic | Page |
| --- | --- |
| AActor — base game object | [→](actor.md) |
| APawn / ACharacter — player/AI controlled | [→](pawn-character.md) |
| UActorComponent / USceneComponent | [→](components.md) |
| UMG / UUserWidget | [→](widget-blueprint.md) |
| UAnimInstance | [→](animation-blueprint.md) |
| UDataAsset / Primary Data Asset | [→](data-asset.md) |
| Gameplay Ability System (GAS) | [→](gameplay-ability.md) |
| Full catalog | [→](full-class-catalog.md) |

## Blueprint asset types

| Asset | Backing class | Use |
| --- | --- | --- |
| **Blueprint Class** | Any UObject | Author a new subclass |
| **Widget Blueprint** | `UUserWidget` | UMG screens |
| **Animation Blueprint** | `UAnimInstance` | Skeletal animation logic |
| **Blueprint Function Library** | `UBlueprintFunctionLibrary` | Static helper functions |
| **Blueprint Macro Library** | (special) | Reusable subgraphs |
| **Blueprint Interface** | `UInterface` | Cross-class contracts |
| **Editor Utility Blueprint** | `UEditorUtilityObject` | Editor-time scripting |
| **Editor Utility Widget** | `UEditorUtilityWidget` | In-editor UMG tools |
| **Primary Data Asset** | `UPrimaryDataAsset` | Data-driven content |
| **Data Asset** | `UDataAsset` | Simple data containers |
| **Game Instance** | `UGameInstance` | Persists across levels |
| **Game Mode** | `AGameModeBase` | Server rules |
| **Game State** | `AGameStateBase` | Replicated server state |
| **Player Controller** | `APlayerController` | Per-player input |
| **HUD** | `AHUD` | Per-player UI root |

## Pure vs Impure nodes

- **Pure** (green): no execution pin; idempotent; safe to call multiple times
- **Impure** (blue): execution pins; side effects

## Blueprint vs C++

| Concern | Blueprint | C++ |
| --- | --- | --- |
| Iteration speed | ★ | Recompile required |
| Performance | ~10× slower per call | Native speed |
| Refactoring | Painful for large graphs | IDE-supported |
| Designer-friendly | ★ | No |
| Multi-frame logic / latent nodes | First-class | Manual state machine |

Rule of thumb: **C++ for systems and hot paths, Blueprint for content and gameplay assembly.**

## See also

- [Common UI](../plugins/ui.md) — modern UMG patterns
- [Gameplay Ability System](gameplay-ability.md) — typed gameplay logic
