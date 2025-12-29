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

Run the install script from the repository root:
```bash
./install.sh
```

This will automatically:
- Symlink agent commands to `~/.claude/commands` (Claude Code)
- Convert and symlink agent commands to `~/.gemini/commands` (Gemini CLI)
- Set up vim/neovim configurations
- Install vim-plug

**Manual setup for other tools:**

For Cursor or other AI coding tools, symlink `commands/` to their respective config locations:
```bash
# Example for Cursor (adjust path as needed)
ln -sf "$(pwd)/agents/commands" ~/.cursor/commands
```

## Usage

Invoke agents with slash commands: `/research`, `/planning-agent`, `/implement`, `/implementation-manager`, `/meta-agent`

## Updating Agent Prompts

**For Gemini CLI users:** If you modify agent prompts in `agents/commands/*.md`, run `./sync_gemini_commands.sh` from the repository root to regenerate the `.toml` files. This is only needed when you update the prompts, not during initial setup (install.sh handles this automatically).

## Documentation

- `workflow.md` - How to use the agent workflow
- `spec-folder-spec.md` - Conventions for project `spec/` folders (copy to projects as `spec/README.md`)
