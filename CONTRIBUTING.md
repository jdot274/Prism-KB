# Contributing to Prism

Thank you for considering a contribution.

## Quick guidelines

1. **Open an issue first** for new pages or large rewrites so the structure can be agreed.
2. **One topic per PR.** Smaller PRs land faster.
3. **Test the site locally** before opening a PR:
   ```bash
   pip install -r requirements.txt
   mkdocs serve --strict
   ```
   `--strict` fails on broken links and config errors.
4. **Style:**
   - Use sentence case for headings (`## Render targets`, not `## Render Targets`).
   - Code blocks must have a language tag.
   - Refer to UE versions explicitly (`UE 5.7`) rather than "latest".
   - Link to UE source on GitHub when citing engine internals.
5. **Wiki vs docs:** quick reference + cheatsheets go in `wiki-content/`. Full prose pages go in `docs/`.
6. **Gists:** add new code snippets in `gists/` and they'll be syndicated as standalone GitHub Gists.

## Sections and ownership

If your page touches a section already covered by another page, add a cross-link rather than duplicating.

## Adding a plugin entry

Plugin pages follow this template:

```markdown
# <Plugin Name>

**Type:** built-in / Marketplace / community
**Status:** stable / experimental / deprecated
**UE version:** 5.7+

## What it does
One paragraph.

## When to use
Bullet list of use cases.

## How to enable
Steps with exact menu paths.

## Key classes / actors / nodes
Table.

## Gotchas
Bullet list.

## Links
References to UE docs, source, community guides.
```

## License

By contributing, you agree your contributions are licensed under the MIT License.
