# Render Targets Cookbook

Quick recipes. Full reference at [rendering/render-targets](https://jdot274.github.io/Prism-KB/rendering/render-targets/).

## Mirror

```
RT_Mirror_1024 (RGBA8 1024×1024)
+ SceneCaptureComponent2D at mirror plane
+ Capture Source: SCS_FinalColorLDR
+ Capture Every Frame: true
+ Material: ScreenPosition.xy / w → sample RT
```

## Portal

Same as mirror but capture is at the destination portal facing through. Set `CustomNearClippingPlane` to clip behind the portal surface.

## Minimap

```
Top-down SceneCaptureComponent2D above level
Projection: Orthographic
OrthoWidth: world units
RT → UMG Image widget on HUD
```

## GPU paint

Two RTs A, B. Each tick:

```
DrawMaterialToRenderTarget(B, BrushMaterial)
  where BrushMaterial samples A for previous state
Swap A ↔ B
Use active RT as the paint texture on the world surface
```

## Headless screenshot

```python
import unreal
rt = unreal.SystemLibrary.create_render_target_2d(8192, 8192)
unreal.SystemLibrary.draw_material_to_render_target(world, rt, mat)
unreal.RenderingLibrary.export_render_target(world, rt, "C:/out", "shot.png")
```

## Performance levers

- Format: RGBA8 < RGBA16f < RGBA32f in bandwidth
- AutoGenerateMips off if not using mip bias
- Capture Every Frame off for static views
- ShowOnlyActors / HiddenActors lists to render only what you need

## Reading in materials

`Texture Sample` referencing the RT. Or in BP:

```cpp
MID->SetTextureParameterValue(TEXT("ScreenTexture"), RT);
```
