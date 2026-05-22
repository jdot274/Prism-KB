# UnrealJS

Embeds the **V8** JavaScript engine inside UE. Lets you script UE in JavaScript.

Repo: [ncsoft/Unreal.js](https://github.com/ncsoft/Unreal.js)

## What it is

A C++ plugin that:

- Bridges UE's reflection system to V8
- Lets you write Blueprints in JS (`.uobject.js`)
- Hot-reloads JS without restarting the editor
- Auto-generates TypeScript typings for UE APIs

## What it isn't

- **Not a WebGL / three.js renderer.** UnrealJS has no DOM, no canvas. It can't render web content.
- **Not the same as MCP.** UnrealJS is for scripting UE in JS; MCP is for external LLMs driving UE.

## Use cases

- Script UE without C++ recompiles
- Game scripting for designers familiar with JS / TS
- Editor automation scripts in JS instead of Python

## When to prefer over Python

| Concern | Python | UnrealJS |
| --- | --- | --- |
| Editor scripting | Built-in, mature | Add-on |
| Game scripting | Limited | Better |
| Typings | Minimal | Full TS generation |
| Hot reload | Editor only | Yes |
| Community size | Larger | Smaller |

## Caveats

- Maintenance is community-driven; UE version compatibility lags
- Building V8 from source is involved; use prebuilt plugin if possible
- Performance is JS-engine-bound (~5–10× slower than C++)

## Links

- [Repo](https://github.com/ncsoft/Unreal.js)
- [Documentation](https://github.com/ncsoft/Unreal.js/wiki)
