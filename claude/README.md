# Looped Agent Workflow System

Agent prompts for iterative software development using Claude Code or other coding agents.

## Quick Start

**Claude Code CLI:**
```
/research                # Investigate system, document current state
/plan                    # Design features (collaborative with human)
/implement               # Build one task, verify, stop
/implementation-manager  # Autonomous multi-task orchestration
/meta-agent              # Refine the agent system itself
```

**Other agents:** Reference command files: `~/dotfiles/claude/commands/research.md`

## Contents

**Agent Prompts** (`commands/`):
- `research.md` - Investigate and verify system
- `plan.md` - Design specs with human collaboration
- `implement.md` - Build one atomic task per session
- `implementation-manager.md` - Multi-task autonomous orchestration
- `meta-agent.md` - Refine the system itself

**Documentation:**
- `agent_workflow.md` - User guide
- `meta_status.md` - System development history (for meta-agent)
- `ACE-FCA-COMPARISON.md` - Lessons from similar systems

**Config:** `settings.json`, `statusline-command.sh`

## Principles

1. **Specialized agents** with document ownership (researcher owns `spec/`, planner owns `ongoing_changes/new_features.md`, implementor owns `ongoing_changes/implementor_progress.md`)
2. **ONE task per session** (implementor) - atomic boundaries prevent drift
3. **Context budget** - 40-50% wrap up, 60% hard stop
4. **Sub-agent delegation** - verbose exploration kept out of main context
5. **Docs for future agents** - rewrite current state, delete obsolete info
6. **Proof-required testing** - paste actual terminal output showing tests pass
7. **Agent-agnostic** - works with Claude Code, GPT, Gemini, etc.

## Document Structure

```
spec/
  current_system.md         - System understanding (researcher)
  feature_tests.md          - Feature verification registry (researcher)
  research_status.md        - Research progress (researcher)
ongoing_changes/
  new_features.md           - What to build (planner)
  planning_status.md        - Planning progress (planner)
  questions.md              - Human Q&A (planner, temporary)
  implementor_progress.md   - What's done/next (implementor)
  manager_progress.md       - Task tracking (manager)
```

## Cycle

```
1. Researcher    → Document system     → spec/current_system.md
2. Planner       → Design features     → ongoing_changes/new_features.md
3. Implementor   → Build one task      → ongoing_changes/implementor_progress.md
4. Implementor   → Build next task     → (repeat)
5. Researcher    → Verify changes      → Update spec/
6. Loop
```

## Features

- **Progressive disclosure** - C4-inspired docs (Levels 1→2→3) for token efficiency
- **PlantUML diagrams** - Visual architecture with SVG generation
- **YAML frontmatter** - Traceability (git commits, dates, status)
- **Context thresholds** - 40-50% wrap up, 60% hard stop
- **Repeatable testing** - Scripts, automated tests, agent-interactive procedures
- **Multi-file split** - Large system docs split at ~500 lines
- **Authorized file cleanup** - Agents delete unauthorized docs

**Learn more:** `agent_workflow.md`, `meta_status.md`, `ACE-FCA-COMPARISON.md`

## Deployment

Symlink to `~/.claude/`:
```bash
ln -sf ~/dotfiles/claude/commands ~/.claude/commands
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
```
