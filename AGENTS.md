# Agent Instructions for Dotfiles Repository

## On Startup
Read `README.md` first to understand repo structure and available tools.

---

## General Work in This Repo

### Documentation
Update `README.md` when changes affect user setup or workflow. Keep it:
- Getting started focused (overview, not implementation details)
- Concise (details belong in code or component-specific docs)

### Installation
After adding features, run `./install.sh` to test installation. Keep install script idempotent.

Install should handle:
- Symlinking dotfiles to proper locations
- All executable scripts in `scripts/`
- Agent commands to `~/.claude/commands`
- Settings to appropriate config directories

### Testing Changes
When adding or modifying scripts:
1. Make scripts executable: `chmod +x scripts/script-name`
2. Run `./install.sh` to symlink to `~/.local/bin`
3. Test the script in a clean environment if possible

---

## Working on the Agent System (Meta-Agent Work)

When refining the agent system itself (prompts, workflow, documentation), follow these principles:

### System Principles

**Simplicity Wins** - If a prompt is too long, it's a bug.

**Test on Real Projects** - Theory is insufficient. Agent changes should be tested on actual work.

**Context is precious** - Keep prompts focused. Delegate verbose work to sub-agents.

**Documents are for future agents** - Write for the *next* agent. Delete completed tasks, history and obsolete info. REWRITE docs, don't append.

**Security First** - NEVER commit secrets (API keys, tokens, passwords) to the repository.
- **Check `.gitignore`**: Before creating files with secrets (e.g. `.env`), ensure they are ignored.
- **Use Env Vars**: Reference secrets via environment variables, never hardcode them.

### Agent System Structure

The agent system consists of:
- **Source files**: `agents/src/_core.md` (common) + `agents/src/_[role].md` (role-specific)
- **Generated commands**: `agents/commands/*.md` (for Claude Code, Cursor, Codex)
- **Gemini commands**: `gemini/commands/*.toml` (for Gemini CLI)

### Available Agents
- **Researcher**: Documents the current system. Truth-seeker.
- **Planner**: Designs features collaboratively. Architect.
- **Implementor**: Builds ONE task and verifies it. Builder.
- **Task Agent**: Executes specific one-off tasks. Ad-hoc builder.
- **Manager**: Orchestrates multiple implementors. Coordinator.

### Process for Updating Agent Prompts

1. **Identify Source**:
   - Common rules across all agents → `agents/src/_core.md`
   - Role-specific instructions → `agents/src/_[role].md`

2. **Edit**: Modify the source `_*.md` files in `agents/src/`

3. **Build & Sync**: Run `./build_prompts.sh` to:
   - Generate final `agents/commands/*.md` artifacts
   - Sync Gemini TOML files
   - This MUST be done before committing any prompt changes

4. **Verify**: Ensure the concatenated artifacts in `agents/commands/` are correct

5. **Test**: Test the updated agent on real work before committing

6. **Document**: Update `agents/meta/status.md` with refinement count and history

### Document Structure

| Path | Purpose | Owner |
|------|---------|-------|
| `agents/src/` | Source partials for prompts | Meta-agent |
| `agents/commands/` | Generated prompts (Claude/Cursor/Codex) | Generated |
| `gemini/commands/` | Generated prompts (Gemini) | Generated |
| `agents/meta/` | Meta-agent documentation | Meta-agent |

---

## Context Budget

Keep context usage reasonable. When approaching 40-50% context, wrap up. At 60%, hard stop and document state.
