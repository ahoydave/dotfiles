# Looped Agent Workflow System

**Version**: 1.1
**Last Updated**: 2025-11-09

A system for using coding agents (Claude, GPT-5, Gemini, etc.) in loops to research, plan, and implement software projects through specialized agent prompts and shared documentation.

## Quick Start

**With Claude Code CLI:**
```
/research     # Investigate and document existing system
/plan         # Design specifications for new work
/implement    # Build features one task at a time
```

**With other agents:**
Reference the command files directly:
```
Please act as the researcher agent from ~/dotfiles/claude/commands/research.md
```

## What's In This Directory

### Commands (`commands/`)
- **research.md** - Research agent prompt (investigates systems, verifies implementations)
- **plan.md** - Planning agent prompt (designs specs collaboratively with humans)
- **implement.md** - Implementor agent prompt (builds one atomic task per session)
- **implementation-manager.md** - Manager agent prompt (autonomous multi-task orchestration)
- **meta-agent.md** - Meta-agent prompt (for refining the system itself)

### Documentation
- **agent_workflow.md** - User guide: how to use the system
- **meta_status.md** - System state, development history, what's working/failing
- **ACE-FCA-COMPARISON.md** - Analysis comparing with similar systems

### Configuration
- **settings.json** - Claude Code settings
- **statusline-command.sh** - Custom statusline script

## Core Principles

1. **Three agent types** with clear document ownership
2. **ONE task per session** (implementor) - clean boundaries prevent drift
3. **Context management** - 40-50% wrap up, 60% hard stop
4. **Sub-agent delegation** - keep verbose work out of main context
5. **Documentation is not history** - rewrite, don't append
6. **Proof-required testing** - paste actual terminal output
7. **Agent-agnostic** - works with any coding agent

## Document Structure (Per Project)

```
spec/
  CURRENT_SYSTEM.md    - How system works (researcher owns)
  RESEARCH_STATUS.md   - Research progress (researcher owns)
  NEW_FEATURES.md      - What to build (planner owns)
  PLANNING_STATUS.md   - Planning progress (planner owns)
  QUESTIONS.md         - Human Q&A (planner only)
  PROGRESS.md          - Implementation state (implementor owns)
```

## Development Cycle

```
1. Researcher    → Understand system     → spec/CURRENT_SYSTEM.md
2. Planner       → Spec features         → spec/NEW_FEATURES.md
3. Implementor   → Build (one task)      → spec/PROGRESS.md
4. Implementor   → Build (next task)     → spec/PROGRESS.md
5. Researcher    → Verify reality        → Update spec/CURRENT_SYSTEM.md
6. Back to step 2
```

## Key Features

✅ **31 refinements** through iterative testing on real projects
✅ **Visual documentation** with PlantUML diagrams
✅ **YAML frontmatter** for traceability and metadata
✅ **Context optimization** aligned with proven thresholds (40-60%)
✅ **Multi-file system docs** for large codebases (>800-1000 lines)
✅ **No documentation sprawl** - explicit allowed lists
✅ **Slash command integration** - convenient invocation in Claude Code

## Links

- **Full guide**: See `agent_workflow.md`
- **System status**: See `meta_status.md`
- **Meta-agent prompt**: See `commands/meta-agent.md`
- **Comparison study**: See `ACE-FCA-COMPARISON.md`

## Deployment

This directory is symlinked to `~/.claude/`:
- `~/.claude/commands` → `~/dotfiles/claude/commands`
- `~/.claude/settings.json` → `~/dotfiles/claude/settings.json`

No install script needed - just symlink and use.
