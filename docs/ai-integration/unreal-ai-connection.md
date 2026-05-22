# Unreal AI Connection

A fork / sibling of UnrealClaudeMCP that ships **105 tools** (72 native C++ + 33 bridge-side synthetic). Same architecture, broader surface area.

Repo: [NAJEMWEHBE/unreal-ai-connection](https://github.com/NAJEMWEHBE/unreal-ai-connection)

## Additional tools vs UnrealClaudeMCP

Highlights of what's added on the bridge side:

| Category | New tools |
| --- | --- |
| **Bulk asset ops** | `bulk_delete_assets`, `bulk_move_assets`, `bulk_rename_assets`, `bulk_duplicate_assets`, `bulk_inspect_assets` |
| **Audio inspectors** | `inspect_sound_class`, `inspect_sound_submix`, `inspect_audio_bus`, `inspect_metasound`, `inspect_material_function` |
| **Asset analytics** | `find_unused_assets`, `get_reference_chain`, `compare_assets`, `inspect_dependency_graph` |
| **Blueprint** | `bulk_compile_blueprints`, `audit_blueprint_compile_status` |
| **Camera / viewport** | `bulk_set_console_variables`, `bulk_fix_redirectors` |
| **Marketplace** | `marketplace_search`, `marketplace_import` |
| **HDRI** | `convert_hdri_to_cubemap` |
| **Sequencer** | `sequencer_add_transform_keyframe` |
| **Modding** | `compile_mod_pak`, `compile_mod_pak_direct` (shell out to RunUAT / UnrealPak) |

## Same install path

Drop the plugin folder into `<Project>/Plugins/`, build editor, configure MCP client to point at `bridge/unreal_ai_connection_bridge.py`.

## Which to use

| Concern | UnrealClaudeMCP | Unreal AI Connection |
| --- | --- | --- |
| Stability | Battle-tested in production | Newer, more in flux |
| Tool count | 68 | 105 |
| Bulk ops | Limited | Comprehensive |
| Modding workflows | Bring your own | First-class (`compile_mod_pak`) |
| Marketplace ops | No | Yes |
| Active development | Slower | Faster |

For most projects either works. Use `unreal-ai-connection` if you need the bulk asset operations or modding tools.

## Links

- [GitHub repo](https://github.com/NAJEMWEHBE/unreal-ai-connection)
- [UnrealClaudeMCP comparison](unreal-claude-mcp.md)
