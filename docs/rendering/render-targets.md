# Render Targets

A **render target** is a writable GPU texture you can draw into from the engine and sample from any material. They are the universal mechanism behind mirrors, portals, minimaps, GPU painting, dynamic decals, baking procedural textures, multi-pass post-FX, and headless rendering.

## Asset types

| Class | Dim | Common use |
| --- | --- | --- |
| `UTextureRenderTarget2D` | 2D | Mirrors, monitors, minimaps, paint surfaces |
| `UTextureRenderTargetCube` | Cubemap | Reflection probes, env captures |
| `UTextureRenderTarget2DArray` | 2D array | Volumetric LUTs, shadow maps, multi-pass FX |
| `UTextureRenderTargetVolume` | 3D | 3D LUTs, fluid sims, volumetric fog |
| `UCanvasRenderTarget2D` | 2D | Canvas/HUD-drawn dynamic textures |

Create from the Content Browser: right-click → **Materials & Textures → Render Target** (or Render Target Cube / Array / Volume).

## Property cheat-sheet

| Setting | What it controls |
| --- | --- |
| **Size X / Y** | Resolution. Keep powers of 2 for streaming. |
| **Render Target Format** | `RTF_RGBA8` (default), `RTF_RGBA16f` (HDR), `RTF_R8` (single channel), `RTF_R32f` (depth/data) |
| **Clear Color** | Color used when cleared each frame |
| **Auto Generate Mips** | Build mips after each render — needed for sampling with anisotropy |
| **Address X / Y** | Clamp / wrap |
| **Mips In UI** | Use mips when drawn in UMG |
| **Force Linear Gamma** | Disable sRGB encoding — required for normal/data textures |

## Writers — how content gets into a render target

### 1. SceneCaptureComponent2D — camera capture

The bread and butter. Attach to any actor:

```cpp
USceneCaptureComponent2D* Cap = CreateDefaultSubobject<USceneCaptureComponent2D>(TEXT("Capture"));
Cap->TextureTarget = RT;
Cap->CaptureSource = ESceneCaptureSource::SCS_FinalColorLDR;
Cap->bCaptureEveryFrame = true;
Cap->ShowOnlyActors.Add(SomeActor); // optional include list
```

**Capture sources:**

| Source | Output |
| --- | --- |
| `SCS_FinalColorLDR` | Tonemapped, post-processed |
| `SCS_FinalColorHDR` | Pre-tonemapping HDR |
| `SCS_SceneColorHDR` | Pre-bloom HDR |
| `SCS_SceneColorSceneDepth` | RGB color + A depth |
| `SCS_DeviceDepth` | Hardware depth (NDC) |
| `SCS_Normal` | World normal G-buffer |
| `SCS_BaseColor` | Base color G-buffer |

### 2. DrawMaterialToRenderTarget — GPU compute via materials

```cpp
UKismetRenderingLibrary::DrawMaterialToRenderTarget(World, RT, FullScreenMaterial);
```

The material's emissive output is rasterized onto a full-screen quad into the RT. This is the path for:

- Procedural texture baking (noise, gradients, heightmaps)
- GPU paint (brush material with prev-pass sample)
- Ping-pong simulations (fluid, wave equation)
- Distance-field generation
- Multi-pass filters

To ping-pong, allocate two RTs and swap which one is the source vs destination each tick.

### 3. CanvasRenderTarget2D — HUD-style drawing

Subclass `UCanvasRenderTarget2D`, bind `OnCanvasRenderTargetUpdate`:

```cpp
void UMyCanvasRT::ReceiveUpdate(UCanvas* Canvas, int32 W, int32 H)
{
    Canvas->K2_DrawText(MyFont, TEXT("HUD"), FVector2D(10,10), FVector2D(1,1), FLinearColor::White);
    Canvas->K2_DrawTexture(MyTex, FVector2D(0,0), FVector2D(W,H), FVector2D(0,0));
}
```

Call `UpdateResource()` to trigger redraw.

### 4. Slate / UMG widget into RT

```cpp
WidgetComponent->SetDrawSize(FVector2D(1024,1024));
WidgetComponent->SetRenderTarget(RT);
```

Or use `UWidgetRenderer::DrawWidget` for one-off captures from C++.

## Readers — using the RT

Any material with a `Texture Sample` referencing the RT:

```hlsl
// HLSL equivalent: texture2D RT; sampler RTSampler;
float4 c = Texture2DSample(RT, RTSampler, UV);
```

In a `MaterialInstanceDynamic`:

```cpp
UMaterialInstanceDynamic* MID = MeshComp->CreateAndSetMaterialInstanceDynamic(0);
MID->SetTextureParameterValue(TEXT("ScreenTexture"), RT);
```

## Cookbook

### Mirror

1. Create `RT_Mirror_1024.uasset` (RGBA8, 1024×1024)
2. On the mirror actor: `USceneCaptureComponent2D` at the mirror plane
3. Set Capture Source = `SCS_FinalColorLDR`
4. Material: `Unlit` with a `SceneTexture` that uses `ScreenPosition.xy / ScreenPosition.w` as UV — gives a screen-space lookup
5. Mirror the capture component's transform across the surface plane on Tick

### Portal

Same as mirror except the capture sits at the *destination* portal facing the right way. Use `SceneCapture2D`'s `CustomNearClippingPlane` to clip behind the portal surface.

### Minimap

1. Top-down `SceneCaptureComponent2D` above the level
2. `CaptureSource = SCS_FinalColorLDR`, `ProjectionType = Orthographic`
3. OrthoWidth = world units to cover
4. Drop the RT into a UMG `Image` widget on the HUD

### GPU paint

Two RTs (`A`, `B`):

1. Read brush position from CPU into a material parameter
2. `DrawMaterialToRenderTarget(B, BrushMaterial)` where BrushMaterial samples `A` for previous state and writes new state
3. Swap A↔B next tick
4. Use the active RT as the paint texture on the world surface

### Headless screenshot at arbitrary resolution

```python
import unreal
rt = unreal.SystemLibrary.create_render_target_2d(8192, 8192)
unreal.SystemLibrary.draw_material_to_render_target(world, rt, screenshot_material)
unreal.RenderingLibrary.export_render_target(world, rt, "C:/out", "shot.png")
```

## Performance

| Lever | Effect |
| --- | --- |
| **Format** | RGBA8 < RGBA16f < RGBA32f in bandwidth |
| **Auto Generate Mips** | Adds a downsample pass each frame — turn off if not sampling with mip bias |
| **Capture Every Frame** | Off for static views (mirrors only when moving) |
| **Hidden show flags** | Disable Bloom/AA on SceneCapture if you don't need them |
| **bAlwaysPersistRenderingState** | Stops the renderer from rebuilding state every tick |

A 1080p RGBA16f RT captured every frame at the same cost as the main scene — that's effectively a second renderer pass. Use SceneCapture's `ShowOnlyActors` / `HiddenActors` lists to render only what you need.

## Gotchas

- **Auto-exposure** runs independently in each SceneCapture — you may need to override exposure to match the main camera.
- **Volumetric fog** is disabled by default in captures; enable via Post Process settings on the capture.
- **Lumen reflections** in captures cost extra; turn off `Show Flag → Lumen` if unnecessary.
- **Render target memory** is GPU memory — at 4K RGBA16f that's 64MB per RT.
- **Editor preview** of an RT can lock the asset and prevent the renderer from writing — close the asset window during play.

## Related

- [SceneCaptureComponent details](https://docs.unrealengine.com/5.7/en-US/scene-capture-actors-in-unreal-engine/)
- [Post Process Materials](post-process.md) — same RT writing/reading patterns inside the post-process pipeline
- [Pixel Streaming](pixel-streaming.md) — feeds RTs into WebRTC for browser delivery
- [Composure](../workflows/streaming-pipelines.md#composure) — composite many RT layers together
