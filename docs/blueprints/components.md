# Components

Components are reusable pieces of functionality you attach to actors. The two roots:

| Base | Has transform? | Examples |
| --- | --- | --- |
| `UActorComponent` | No | `UMovementComponent`, `UAbilitySystemComponent`, audio non-spatial |
| `USceneComponent` | Yes | `UStaticMeshComponent`, `UCameraComponent`, `UWidgetComponent` |

## Categories

### Rendering

- `UStaticMeshComponent`
- `USkeletalMeshComponent`
- `UInstancedStaticMeshComponent` / `UHierarchicalInstancedStaticMeshComponent` (ISM/HISM)
- `UDecalComponent`
- `UWidgetComponent` — UMG in 3D space
- `USceneCaptureComponent2D` / `Cube`
- `UPostProcessComponent`
- `UNiagaraComponent`

### Collision / Physics

- `UBoxComponent`, `USphereComponent`, `UCapsuleComponent`
- `UPrimitiveComponent` (base for collide-able shapes)
- `URigidBodyComponent` / `UPhysicsConstraintComponent`

### Movement

- `UMovementComponent` (base)
- `UCharacterMovementComponent`
- `UProjectileMovementComponent`
- `UFloatingPawnMovement`
- `UChaosVehicleMovementComponent`

### Audio

- `UAudioComponent`
- `UAmbientSoundComponent`

### AI

- `UBlackboardComponent`
- `UBehaviorTreeComponent`
- `UAIPerceptionComponent`
- `UPathFollowingComponent`

### Camera

- `UCameraComponent`
- `UCineCameraComponent`
- `USpringArmComponent`

### Gameplay

- `UAbilitySystemComponent` (GAS)
- `UHealthComponent` (custom pattern)
- `UInventoryComponent` (custom pattern)

### Special

- `UTextRenderComponent` — 3D text
- `UArrowComponent` — editor visualization
- `UBillboardComponent` — facing-camera sprite

## Attachment

`SceneComponent` has a parent → child tree. Attach with:

```cpp
ChildComp->AttachToComponent(ParentComp, FAttachmentTransformRules::KeepRelativeTransform);
```

Or `AttachToSocketName` for skeletal mesh sockets.

## Replication

Components don't automatically replicate. Mark `bReplicates = true` on the component, and the owning Actor must also be replicated.

## Creating in C++

```cpp
UStaticMeshComponent* Mesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("Mesh"));
SetRootComponent(Mesh);
```

## Creating from Blueprint

`+ Component` in the BP editor. Choose any registered component class.

## Custom components

```cpp
UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class MYGAME_API UHealthComponent : public UActorComponent
{
    GENERATED_BODY()
public:
    UPROPERTY(EditAnywhere, BlueprintReadWrite) float Max = 100.f;
    UPROPERTY(BlueprintReadOnly, ReplicatedUsing=OnRep_Current) float Current = 100.f;
    UFUNCTION() void OnRep_Current();
};
```

## Performance

- Each ticking component costs main-thread time. Disable Tick on components that don't need it.
- ISM/HISM consolidates thousands of meshes into one draw call — huge win for PCG-spawned content.
- WidgetComponent in 3D space rasterizes UMG to a render target every frame it changes — pin it to manual redraws if static.
