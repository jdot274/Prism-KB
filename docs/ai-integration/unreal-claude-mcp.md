# UnrealClaudeMCP — Full Reference

A UE editor plugin exposing **64 native C++ MCP handlers + 4 bridge-side synthetic tools** (68 total). Drive the editor from any MCP-compliant client over a local TCP socket.

## Tool catalog

### Python execution (5)

| Tool | Purpose |
| --- | --- |
| `execute_unreal_python` | Run arbitrary `unreal.*` Python on the game thread |
| `run_python_file` | Execute a `.py` file from disk |
| `apply_python_to_selection` | Run a snippet with the editor selection bound |
| `exec_python_persistent` | Persistent session — globals survive |
| `reset_python_state` | Wipe the persistent session |

### Project / asset registry (8)

| Tool | Purpose |
| --- | --- |
| `get_project_summary` | Project + engine version + plugins + asset count |
| `find_assets` | Query by class + path + name |
| `inspect_asset` | Class, tags, deps, referencers, on-disk size |
| `move_asset` | Move + redirector |
| `rename_asset` | Rename leaf + redirector |
| `duplicate_asset` | Copy to new path |
| `delete_asset` | Delete (refuses if referenced unless `force=true`) |
| `fix_up_redirectors` | Resolve redirectors in a folder |

### Blueprint / Widget / Animation introspection (14)

| Tool | Purpose |
| --- | --- |
| `inspect_blueprint` | Variables, function graphs, parent class |
| `compile_blueprint` | Recompile + report errors |
| `inspect_widget_tree` | Read UWidgetBlueprint / EUW widget hierarchy |
| `inspect_widget_blueprint` | Animations, bindings, palette, slots |
| `edit_widget_tree` | Mutate the tree: set_root / add_child / set_property |
| `inspect_anim_blueprint` | Vars + state machines |
| `inspect_anim_montage` | Sections, slots, notify tracks |
| `inspect_static_mesh` | LODs, materials, collision, bounds |
| `inspect_skeletal_mesh` | LODs, materials, sockets, skeleton |
| `inspect_physics_asset` | Bodies, constraints, profiles |
| `inspect_niagara_system` | Emitters + user parameters |
| `inspect_landscape` | Components, layers, material |
| `inspect_data_table` | RowStruct + sorted rows + per-prop type |
| `inspect_curve` | UCurveBase channel layout + ranges |

### Materials (4)

| Tool | Purpose |
| --- | --- |
| `create_material_instance` | Create UMaterialInstanceConstant |
| `set_mi_parameter` | Override scalar / vector / texture |
| `inspect_material` | List declared parameters |
| `inspect_material_instance` | Parent + overridden params |

### Textures (3)

| Tool | Purpose |
| --- | --- |
| `import_texture` | Import PNG/JPG/EXR/TGA/BMP/HDR as UTexture2D |
| `configure_texture` | SRGB / compression / LOD group / filter |
| `inspect_texture` | Class, dims, sRGB, compression, mips, VT flags |

### Level Sequences (3)

| Tool | Purpose |
| --- | --- |
| `inspect_sequence` | Tracks, sections, bindings, FR, playback range |
| `create_sequence` | Create empty Level Sequence asset |
| `bind_actor_to_sequence` | Add actor as possessable binding |

### Level / Actor authoring (12)

| Tool | Purpose |
| --- | --- |
| `get_actors_in_level` | Name / class / transform, optional filter |
| `spawn_actor` | Create at location with rotation, label, initial props |
| `set_actor_transform` | Absolute / relative move |
| `delete_actor` | Remove by name |
| `set_actor_property` | Mutate any UPROPERTY |
| `add_component` | Attach a component to an actor |
| `focus_actor` | Select + frame viewport |
| `load_level_by_path` | Open level by package path |
| `find_actors_by_class` | (bridge synthetic) class-filtered list |
| `bulk_focus_actors` | (synthetic) frame each + optional screenshot |
| `bulk_screenshot_actors` | (synthetic) focus + screenshot each |
| `bulk_set_actor_property` | (synthetic) many assignments in one call |

### Viewport / screenshots (3)

| Tool | Purpose |
| --- | --- |
| `get_viewport_screenshot` | Active viewport → base64 PNG inline |
| `take_high_res_screenshot` | UE HighResShot console command |
| `render_camera_to_png` | Synchronous render of viewport or SceneCapture2D — works headless |

### Console / logs (5)

| Tool | Purpose |
| --- | --- |
| `get_log_lines` | Read recent Output Log, filter by category + verbosity |
| `execute_console_command` | Run a console command + capture output |
| `get_console_variable` | Read a CVar |
| `set_console_variable` | Write a CVar |
| `find_console_variables` | Enumerate by pattern |

### Long-running tasks (4)

| Tool | Purpose |
| --- | --- |
| `start_sleep_task` | Reference long-running task — sleeps N seconds |
| `poll_task` | Read state / result |
| `cancel_task` | Cancel in-flight task |
| `list_tasks` | Enumerate tracked tasks |

### Event push / subscriptions (5)

| Tool | Purpose |
| --- | --- |
| `poll_events` | Drain editor events (spawn/delete/asset/save/map) |
| `wait_for_events` | (synthetic) block until matching events arrive |
| `register_subscription` | Open per-client filtered event channel |
| `poll_subscription` | Drain that subscription |
| `unsubscribe` | Close it |

### Audio (3)

| Tool | Purpose |
| --- | --- |
| `inspect_sound_cue` | USoundCue duration, attenuation, graph node list |
| `inspect_sound_wave` | USoundWave SR, channels, frame count, duration, compression |
| `inspect_sound_attenuation` | USoundAttenuation 3D playback rules |

### Camera (3 — synthetic)

| Tool | Purpose |
| --- | --- |
| `get_camera_transform` | Read level-editor viewport camera |
| `set_camera_transform` | Set viewport camera location/rotation |
| `screenshot_actor` | Frame on actor + capture focused PNG |

### Self-introspection (1)

| Tool | Purpose |
| --- | --- |
| `list_tools` | Names of every registered method |

## Wire format

Length-prefixed JSON-RPC over TCP `127.0.0.1:18888`. The bridge speaks stdio MCP to clients and JSON-RPC to UE.

## Installation

See [Plugins → UnrealClaudeMCP](../plugins/unreal-claude-mcp.md) for the drop-into-project flow.

## Adding a 65th handler

One `Handler_*.cpp` in `Source/UnrealClaudeMCP/Private/MCP/Handlers/`, one extern declaration in `UnrealClaudeMCPModule.cpp`, one `Reg.Register(Make_Handler_*())` line.

## Links

- [UnrealClaudeMCP source on GitHub](https://github.com/Donchitos/UnrealClaudeMCP)
- [Unreal AI Connection](unreal-ai-connection.md) — 105-tool variant
