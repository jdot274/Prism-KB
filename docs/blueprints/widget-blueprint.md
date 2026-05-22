# Widget Blueprint (UMG)

UMG (Unreal Motion Graphics) is UE's UI framework. A **Widget Blueprint** is a subclass of `UUserWidget` authored in the Widget Editor.

## Hierarchy

`UWidget` (base)
- `UVisual` → `UPanelWidget` → `UCanvasPanel` / `UHorizontalBox` / `UVerticalBox` / `UGridPanel` / `UScrollBox` / `USizeBox` / `UOverlay`
- `UContentWidget` → `UButton` / `UBorder` / `UCheckBox`
- `ULeafWidget` → `UTextBlock` / `UImage` / `UProgressBar`
- `UUserWidget` — composite widgets you author

## Authoring

Create via Content Browser → User Interface → Widget Blueprint. The editor has two tabs:

- **Designer** — visual layout, drag widgets, set anchors
- **Graph** — event handlers, data binding, custom logic

## Adding to viewport

```cpp
UMyWidget* W = CreateWidget<UMyWidget>(PlayerController, MyWidgetClass);
W->AddToViewport();
```

## Common UI plugin

For projects that target controllers + keyboard + touch, enable **Common UI**. It adds:

- `UCommonActivatableWidget` — push/pop screen stack
- `UCommonInputSubsystem` — input mode tracking
- Style assets for consistent theming
- Built-in nav controllers

The Lyra Starter Game uses Common UI throughout — read its source for reference patterns.

## 3D UMG

A `UWidgetComponent` on any actor renders UMG as a quad in the world:

```cpp
WidgetComp->SetWidgetClass(MyWidgetClass);
WidgetComp->SetDrawSize(FVector2D(1024,1024));
WidgetComp->SetWidgetSpace(EWidgetSpace::World);
```

The widget renders into an internal render target — see [Render Targets](../rendering/render-targets.md).

## Data binding

Two paths:

1. **Direct property binding** — drag a variable onto a widget's text — auto-rebinds on tick (cheap but slow)
2. **Event-driven** — set the widget's properties from C++/BP when state changes (recommended)

## Performance

- UMG is software-rasterized via **Slate**; performance scales with widget count + invalidation frequency.
- Enable **Invalidation Box** around static portions — only re-renders on change.
- Avoid **bind on tick** for high-frequency UI (e.g. world-space health bars on many enemies) — push from gameplay code instead.

## See also

- [Common UI](../plugins/ui.md)
- [Pixel Streaming](../rendering/pixel-streaming.md) — UMG renders the same way for streamed clients
