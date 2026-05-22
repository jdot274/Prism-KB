# Claude Code Game Studios (CCGS)

Not a UE plugin. A **Claude Code template** that gives a single Claude Code session the structure of a real game studio.

Repo: [Donchitos/Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)

## What's inside

| Category | Count |
| --- | --- |
| **Agents** | 49 specialized subagents (Creative Director, Lead Programmer, Game Designer, …) |
| **Skills** | 72 slash commands (`/start`, `/dev-story`, `/team-combat`, `/release-checklist`, …) |
| **Hooks** | 12 — auto-run on commit / push / asset change / session lifecycle |
| **Rules** | 11 path-scoped coding standards |
| **Templates** | 41 (GDDs, ADRs, sprint plans, HUD design, …) |

## How agents organize

Three-tier studio model:

```
Tier 1 — Directors (Opus)
  creative-director    technical-director    producer

Tier 2 — Department Leads (Sonnet)
  game-designer        lead-programmer       art-director
  audio-director       narrative-director    qa-lead
  release-manager      localization-lead

Tier 3 — Specialists (Sonnet/Haiku)
  gameplay-programmer  engine-programmer     ai-programmer
  network-programmer   tools-programmer      ui-programmer
  systems-designer     level-designer        economy-designer
  technical-artist     sound-designer        writer
  world-builder        ux-designer           prototyper
  performance-analyst  devops-engineer       analytics-engineer
  security-engineer    qa-tester             accessibility-specialist
  live-ops-designer    community-manager
```

Engine specialists for **Godot**, **Unity**, and **Unreal**:

- `unreal-specialist` + `ue-blueprint-specialist`, `ue-gas-specialist`, `ue-replication-specialist`, `ue-umg-specialist`

## Setup

```bash
git clone https://github.com/Donchitos/Claude-Code-Game-Studios.git my-game
cd my-game
claude
/start
```

## Pairs with UnrealClaudeMCP

CCGS is the **workflow / coordination layer**. UnrealClaudeMCP is the **editor-driving layer**. Run them together:

1. CCGS gives you agents that *plan* the game work
2. UnrealClaudeMCP gives those agents *the editor* to actually build it

## When CCGS helps

- Solo dev who wants studio-like rigor
- Small team using Claude for design + code
- Production discipline (sprints, milestones, retrospectives) for AI-assisted work

## When it's overkill

- Quick prototypes
- Pure technical experiments
- Single-system explorations

## Links

- [Repo](https://github.com/Donchitos/Claude-Code-Game-Studios)
- [UnrealClaudeMCP pairing](unreal-claude-mcp.md)
