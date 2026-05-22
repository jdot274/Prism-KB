# Full Class Catalog

A reference flattening of UE's primary blueprint-relevant classes. Use this when you can't remember what a class is for.

## Game framework

| Class | Role |
| --- | --- |
| `UGameInstance` | Persists across levels; per-process singleton |
| `AGameModeBase` | Server-side game rules; not replicated |
| `AGameStateBase` | Replicated game state visible to all clients |
| `APlayerState` | Per-player replicated state (score, name) |
| `APlayerController` | Per-player local input + camera authority |
| `AAIController` | NPC controller |
| `AHUD` | Per-player UI root |
| `APawn` / `ACharacter` | Possess-able actors |
| `ULevelScriptActor` | Per-level Blueprint logic |

## Actors

| Class | Role |
| --- | --- |
| `AActor` | Base placeable |
| `AStaticMeshActor` | Wrapped `UStaticMeshComponent` |
| `ASkeletalMeshActor` | Wrapped `USkeletalMeshComponent` |
| `ABrush` | CSG / volume base |
| `AVolume` | Bounded region |
| `ATriggerVolume`, `APostProcessVolume`, `AAudioVolume`, … | Specific volumes (see [Volumes](../volumes/index.md)) |
| `ACameraActor` / `ACineCameraActor` | Placed cameras |
| `ADecalActor` | Decals |
| `AEmitter` (legacy) / `ANiagaraActor` | FX |

## Components (selected)

| Class | Role |
| --- | --- |
| `UStaticMeshComponent` | Static mesh rendering + collision |
| `USkeletalMeshComponent` | Skinned mesh |
| `UInstancedStaticMeshComponent` | Many identical meshes, one draw call |
| `UHierarchicalInstancedStaticMeshComponent` | ISM + LOD per instance |
| `UCharacterMovementComponent` | Pawn locomotion |
| `UAbilitySystemComponent` | GAS hub |
| `USceneCaptureComponent2D` | Camera into RT |
| `UWidgetComponent` | UMG in 3D |
| `UNiagaraComponent` | FX instance |
| `UAudioComponent` | Sound instance |
| `UCameraComponent` | POV |
| `USpringArmComponent` | Third-person follow boom |

## UI

| Class | Role |
| --- | --- |
| `UWidget` | Base |
| `UUserWidget` | Composite (your Widget Blueprints) |
| `UCommonActivatableWidget` | Common UI stack member |
| `UCommonButtonBase` | Common UI button |
| `UWidgetComponent` | 3D-placed widget |

## Animation

| Class | Role |
| --- | --- |
| `USkeletalMeshComponent` | Renders + ticks an AnimInstance |
| `UAnimInstance` | Anim Blueprint runtime |
| `UAnimSequence` | A baked clip |
| `UAnimMontage` | Sectioned playback for combos / cinematics |
| `UAnimBlueprint` | Authoring asset for `UAnimInstance` |
| `UControlRig` | Procedural rigging |
| `UIKRig` | Skeleton retargeting / IK |
| `UPoseAsset` | Library of named poses |
| `UAnimDataModel` | Internal anim authoring model |

## Data

| Class | Role |
| --- | --- |
| `UDataAsset` / `UPrimaryDataAsset` | Data containers |
| `UDataTable` | Tabular data |
| `UCurveBase` / `UCurveFloat` / `UCurveVector` | Time-based curves |
| `UCompositeDataTable` | Layered data tables |
| `UGameplayTagsManager` | Tag registry |

## AI

| Class | Role |
| --- | --- |
| `UBehaviorTree` | The BT asset |
| `UBlackboard` | Keyed data store for BTs |
| `UBTService` / `UBTTask` / `UBTDecorator` | BT node types |
| `UEnvQueryTest` / `UEnvQuery` | EQS spatial queries |
| `UAIPerceptionComponent` | Sight / hearing |
| `AAIController` | The NPC's controller |
| `UNavigationSystem` | Project-wide nav |

## Audio

| Class | Role |
| --- | --- |
| `USoundCue` | Legacy DSP-light authoring |
| `UMetaSoundSource` | Modern DSP graph |
| `USoundClass` | Bus-style grouping |
| `USoundSubmix` | Output routing |
| `USoundAttenuation` | 3D playback rules |
| `UReverbEffect` | Reverb preset |
| `USoundWave` | Audio file asset |

## Render

| Class | Role |
| --- | --- |
| `UTexture2D` | Standard 2D texture |
| `UTextureRenderTarget2D` | Writable RT |
| `UMaterial` | Master material |
| `UMaterialInstance{Constant,Dynamic}` | Static / runtime instance |
| `UStaticMesh` / `USkeletalMesh` | Source meshes |
| `UWorld` | The level container |
| `UPostProcessSettings` | Post-process struct (used in volumes / cameras) |

## Subsystems

| Class | Role |
| --- | --- |
| `UEngineSubsystem` | Per-process |
| `UGameInstanceSubsystem` | Per `UGameInstance` |
| `UWorldSubsystem` | Per `UWorld` (level) |
| `ULocalPlayerSubsystem` | Per `ULocalPlayer` |

Subsystems are the modern replacement for singletons — `UMySubsystem* S = GetGameInstance()->GetSubsystem<UMySubsystem>();`.

## Use this page

When you're sketching a system, glance here to find the right starting class. From there, the per-page deep dives explain how to use them.
