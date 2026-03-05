# Sync Claude Code Rules to Cursor

Sync rules and project instructions from `.claude/` to `.cursor/rules/` in the current repository, so both Claude Code and Cursor have the same instructions.

## Steps

1. Ensure `.cursor/rules/` exists. Create it if not.

2. **Sync CLAUDE.md (project instructions):** If `.claude/CLAUDE.md` exists:
   - Read its content.
   - Check if `.cursor/rules/project-instructions.mdc` already exists.
     - If it does: reuse its existing frontmatter (`description` and `alwaysApply` values).
     - If it doesn't: use `alwaysApply: true` and write a one-sentence description summarising the file.
   - Write `.cursor/rules/project-instructions.mdc` with the frontmatter followed by the full CLAUDE.md content unchanged.

3. **Sync rules files:** List all `*.md` files in `.claude/rules/`. For each `.claude/rules/{name}.md`:
   - Read the file content.
   - Check if a corresponding `.cursor/rules/{name}.mdc` already exists.
     - If it does: extract its existing frontmatter (`description` and `alwaysApply` values) to reuse.
     - If it doesn't: derive a `description` from the file's H1 heading and opening sentence. Set `alwaysApply: false` unless the rule content clearly indicates it should always apply.
   - Write `.cursor/rules/{name}.mdc` with this format:
     ```
     ---
     description: "{description}"
     alwaysApply: {true|false}
     ---

     {full content of the .claude/rules/{name}.md file, unchanged}
     ```

4. Report what was created or updated, and flag any `.cursor/rules/*.mdc` files that have no corresponding source (orphans that may need manual cleanup). Note: `project-instructions.mdc` corresponds to `.claude/CLAUDE.md`.

## Notes

- The canonical sources are `.claude/CLAUDE.md` and `.claude/rules/`. Never edit `.cursor/rules/` files directly — run this command instead.
- Frontmatter is the only difference between the source and Cursor versions. The content itself is identical.
- If you're unsure about the right `description` for a new rule, make it a one-sentence summary of when the rule applies and what it governs.
- CLAUDE.md maps to `project-instructions.mdc` with `alwaysApply: true` because it is always loaded by Claude Code and should be always-apply in Cursor.
