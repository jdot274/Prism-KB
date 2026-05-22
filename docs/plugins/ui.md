# UI Plugins

| Plugin | Type | Purpose |
| --- | --- | --- |
| **UMG (Unreal Motion Graphics)** | Built-in ★ | The default UI |
| **Common UI** | Built-in ★ | Input routing, focus, controller-friendly stack |
| **Slate** | Built-in | Low-level UI framework (UMG sits on it) |
| **Web Browser** | Built-in | CEF browser widget |
| **Web Browser Widget** | Built-in | UMG wrapper for above |
| **WebUI** | Community ★ | Modern CEF — render-to-material, HTML/CSS/JS UI |
| **Ultralight UE** | Community | Lightweight HTML/JS UI (low memory) |
| **Coherent Gameface** | Marketplace | AAA HTML/CSS/JS UI |
| **UI Toolkit (legacy)** | — | Replaced by UMG; ignore |

## Choosing the web layer

| Choice | Pros | Cons |
| --- | --- | --- |
| Built-in Web Browser | Free, easy | Older CEF; no render-to-material |
| WebUI | Free, modern, render-to-material | Community-maintained |
| Ultralight | Low RAM | License cost; limited WebGL |
| Coherent Gameface | AAA-grade | Enterprise pricing |

See [Widget Blueprint](../blueprints/widget-blueprint.md) and [Workflows → three.js](../workflows/three-js-in-ue.md).
