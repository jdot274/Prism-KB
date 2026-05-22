# Data Assets

A **Data Asset** is a UObject asset that holds only data — no logic. Use it to encode tunable values, configurations, item definitions, etc.

## Three flavors

| Class | When to use |
| --- | --- |
| `UDataAsset` | Simple data container |
| `UPrimaryDataAsset` | Identified by `FPrimaryAssetId`; loadable via **Asset Manager** |
| `UDataTable` | Tabular data, importable from CSV / JSON |

## UDataAsset

```cpp
UCLASS(BlueprintType)
class MYGAME_API UItemData : public UDataAsset
{
    GENERATED_BODY()
public:
    UPROPERTY(EditAnywhere) FText DisplayName;
    UPROPERTY(EditAnywhere) UTexture2D* Icon;
    UPROPERTY(EditAnywhere) int32 MaxStack = 1;
};
```

Create instances via right-click → Miscellaneous → Data Asset → choose your class.

## UPrimaryDataAsset

Identifies an asset by ID across the project — used by Asset Manager for async loading.

```cpp
UCLASS(BlueprintType)
class MYGAME_API UItemDefinition : public UPrimaryDataAsset
{
    GENERATED_BODY()
public:
    virtual FPrimaryAssetId GetPrimaryAssetId() const override
    {
        return FPrimaryAssetId(TEXT("Item"), GetFName());
    }
};
```

Register the type in `Project Settings → Asset Manager → PrimaryAssetTypesToScan`:

```
Primary Asset Type: Item
Asset Base Class:   /Script/MyGame.ItemDefinition
Directories:        /Game/Items
```

Then async-load by ID:

```cpp
TArray<FPrimaryAssetId> Ids = { FPrimaryAssetId(TEXT("Item.Sword_01")) };
UAssetManager::Get().LoadPrimaryAssets(Ids, {}, FStreamableDelegate::CreateUObject(this, &Mine::OnLoaded));
```

## UDataTable

Tabular. Author rows in CSV/JSON, import as a table:

```cpp
USTRUCT(BlueprintType)
struct FEnemyStats : public FTableRowBase
{
    GENERATED_BODY()
    UPROPERTY(EditAnywhere) FName Id;
    UPROPERTY(EditAnywhere) int32 Health;
    UPROPERTY(EditAnywhere) float Speed;
};
```

Import → choose `FEnemyStats` as the row struct → rows show in the table editor.

Access:

```cpp
FEnemyStats* Row = MyTable->FindRow<FEnemyStats>(TEXT("Goblin"), TEXT(""));
```

## When to use which

| Need | Use |
| --- | --- |
| One-off config | `UDataAsset` |
| Many instances, async-loaded by ID | `UPrimaryDataAsset` + Asset Manager |
| Spreadsheet-shaped data | `UDataTable` |
| Designer-friendly editing of arrays | `UPrimaryDataAsset` with `TArray` properties |
| Hot-reload from CSV during dev | `UDataTable` |

## Gotchas

- Data Assets cannot have BP-only properties without packaging quirks; declare in C++.
- Asset Manager scans happen at startup — large projects can take 5–10 s; set scan directories tightly.
- DataTables are not great for hierarchical data; nest with structs but expect editor friction.
