# Agent System

Shared agent prompts for iterative software development. Works with Claude Code, Gemini CLI, Cursor, or any AI coding tool.

## Structure

```
agents/
├── commands/              # Agent prompts (symlinked to ~/.claude/commands, etc.)
│   ├── research.md        # Investigate and document current system
│   ├── planning-agent.md  # Design specs collaboratively
│   ├── implement.md       # Build one atomic task per session
│   ├── implementation-manager.md  # Autonomous multi-task orchestration
│   └── meta-agent.md      # Refine the agent system itself
│
├── workflow.md            # User-facing workflow documentation
├── spec-folder-spec.md    # Template for project spec/ folder conventions
│
└── meta/                  # Meta-agent development files
    ├── status.md          # Current system state and progress
    ├── history.md         # Archived refinements
    └── ace-fca-comparison.md  # Comparison with similar systems
```

## Setup

**Claude Code:**
```bash
ln -sf ~/dotfiles/agents/commands ~/.claude/commands
```

**Gemini CLI / Cursor:** Link `commands/` to their respective config locations.

## Usage

Invoke agents with slash commands: `/research`, `/planning-agent`, `/implement`, `/implementation-manager`, `/meta-agent`

## Documentation

- `workflow.md` - How to use the agent workflow
- `spec-folder-spec.md` - Conventions for project `spec/` folders (copy to projects as `spec/README.md`)
