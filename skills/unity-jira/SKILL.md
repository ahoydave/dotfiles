---
name: unity-jira
description: Manage Unity USTUDIO Jira issues using jira-cli. Use when asked to create, view, search, comment on, update, or manage Jira issues, tickets, epics, or sprints in the USTUDIO project.
allowed-tools: Bash(jira-cli *)
argument-hint: "[command] [issue-key] or [action]"
---

# Unity Jira CLI Skill

You have access to the `jira-cli` command-line tool for managing Jira issues in the Unity USTUDIO project. All operations use the unified `jira-cli` command.

## Important: Write Mode Safety

**Write operations require write mode to be enabled:**

```bash
# Check write mode status
jira-cli write-status

# Enable write mode (for create, update, comment, transition operations)
jira-cli enable-write

# Disable write mode when done (safe mode)
jira-cli disable-write
```

⚠️ **Always disable write mode after completing write operations** to prevent accidental modifications.

## Configuration & Status

```bash
# View configuration and auth status
jira-cli config

# Quick status check
jira-cli status

# Authenticate (requires browser cookies)
jira-cli auth
```

## Read Operations (No Write Mode Required)

### View Issues

```bash
# Get issue details
jira-cli issue USTUDIO-1234

# Get JSON output
jira-cli issue USTUDIO-1234 --json
```

### Search Issues

```bash
# Search with JQL
jira-cli search 'assignee = currentUser() AND status != Done'
jira-cli search 'project = USTUDIO AND priority = High'
jira-cli search 'labels = urgent AND created >= -7d'

# Limit results
jira-cli search 'project = USTUDIO' --max-results 20
```

### Epics

```bash
# List all epics
jira-cli epics

# Filter by status
jira-cli epics --status "In Progress"

# Get issues in an epic
jira-cli epic-issues USTUDIO-1223
```

### Sprints

```bash
# List all sprints
jira-cli sprints

# View active sprint
jira-cli sprint

# Check which sprints an issue is in
jira-cli issue-sprints USTUDIO-1234
```

### Comments

```bash
# List comments on an issue
jira-cli comments USTUDIO-1234

# Get as JSON
jira-cli comments USTUDIO-1234 --json
```

### Transitions

```bash
# List available transitions for an issue
jira-cli transitions USTUDIO-1234
```

### Metadata

```bash
# List available versions
jira-cli versions

# List available priorities
jira-cli priorities
```

## Write Operations (Require Write Mode)

### Create Issues

```bash
# Enable write mode first!
jira-cli enable-write

# Preview creation (dry run)
jira-cli create \
  --summary "Issue title" \
  --description "Issue details" \
  --epic USTUDIO-1223 \
  --labels frontend urgent \
  --priority High \
  --dry-run

# Create issue (with confirmation)
jira-cli create \
  --summary "FE: Implement new feature" \
  --description "Detailed description of the feature" \
  --epic USTUDIO-1223 \
  --labels frontend \
  --priority Medium

# Create with auto-confirmation (skip prompt)
jira-cli create \
  --summary "Issue title" \
  --description "Details" \
  --epic USTUDIO-1223 \
  --yes

# Create with assignee
jira-cli create \
  --summary "Issue title" \
  --description "Details" \
  --assignee username \
  --yes
```

### Add Comments

```bash
# Add comment with text
jira-cli add-comment USTUDIO-1234 "Comment text here" --yes

# Add comment from stdin
echo "Comment text" | jira-cli add-comment USTUDIO-1234

# Add comment with editor
jira-cli add-comment USTUDIO-1234 --editor
```

### Transition Issues

```bash
# Transition by name or ID
jira-cli transition USTUDIO-1234 "In Progress" --yes
jira-cli transition USTUDIO-1234 "Done" --yes
jira-cli transition USTUDIO-1234 "21" --yes
```

### Update Fields

```bash
# Set assignee
jira-cli set-assignee USTUDIO-1234 username --yes

# Unassign
jira-cli unassign USTUDIO-1234 --yes

# Set priority
jira-cli set-priority USTUDIO-1234 High --yes

# Set fix version
jira-cli set-version USTUDIO-1234 "v1.2.3" --yes

# Add labels
jira-cli add-label USTUDIO-1234 frontend backend --yes

# Remove labels
jira-cli remove-label USTUDIO-1234 backend --yes

# Update description
jira-cli set-description USTUDIO-1234 "New description text" --yes

# Update description from stdin
echo "New description" | jira-cli set-description USTUDIO-1234

# Update description via editor
jira-cli set-description USTUDIO-1234 --editor
```

### Sprint Management

```bash
# Move issue to sprint
jira-cli move-to-sprint USTUDIO-1234 38476
# (Note: Will prompt for confirmation unless piped with 'y')

# Move with auto-confirmation
echo "y" | jira-cli move-to-sprint USTUDIO-1234 38476
```

## Common Workflows

### Creating a New Task in an Epic

1. Enable write mode: `jira-cli enable-write`
2. Find the epic: `jira-cli epics --status "In Progress"`
3. Create the issue:
   ```bash
   jira-cli create \
     --summary "Task title" \
     --description "Task details" \
     --epic USTUDIO-1223 \
     --labels your-label \
     --yes
   ```
4. Disable write mode: `jira-cli disable-write`

### Moving an Issue Through Workflow

1. Check current status: `jira-cli issue USTUDIO-1234`
2. View available transitions: `jira-cli transitions USTUDIO-1234`
3. Enable write mode: `jira-cli enable-write`
4. Transition: `jira-cli transition USTUDIO-1234 "In Progress" --yes`
5. Disable write mode: `jira-cli disable-write`

### Finding and Updating Issues

1. Search for issues:
   ```bash
   jira-cli search 'assignee = currentUser() AND status = "In Progress"'
   ```
2. Update issue:
   ```bash
   jira-cli enable-write
   jira-cli set-priority USTUDIO-1234 High --yes
   jira-cli add-comment USTUDIO-1234 "Updated priority" --yes
   jira-cli disable-write
   ```

### Sprint Planning

1. List sprints: `jira-cli sprints`
2. Find sprint ID from the list or board URL
3. Enable write mode: `jira-cli enable-write`
4. Move issue: `echo "y" | jira-cli move-to-sprint USTUDIO-1234 38476`
5. Verify: `jira-cli issue-sprints USTUDIO-1234`
6. Disable write mode: `jira-cli disable-write`

## Issue Description Structure

This Jira instance uses **Jira wiki markup**, not Markdown. All issues must use this three-section structure:

```
+*Overview*+

One paragraph explaining what this is and why it matters.

+*Acceptance Criteria / Definition of Done*+

* Specific, testable condition 1
* Specific, testable condition 2

+*Details*+

Any additional context, implementation notes, sub-tasks, open questions,
or coordination required with other teams.
```

**Jira wiki markup reference:**
- `+*Text*+` = underlined bold (use for section headings)
- `* item` = bullet point (NOT `-` which is markdown)
- `# item` = numbered list item
- `*bold*` = bold inline text
- `_italic_` = italic
- `{{code}}` = monospace/inline code
- Do NOT use `##`, `**`, `-`, or `- [ ]` — these are Markdown and render as literal text in Jira

**Rules:**
- Always use the three-section structure: Overview, Acceptance Criteria / Definition of Done, Details
- Details section is optional but should capture anything a developer needs without asking questions

## Best Practices

1. **Always check write mode status** before attempting write operations
2. **Enable write mode only when needed** and disable it immediately after
3. **Verify issue keys** before operations (format: USTUDIO-####)
4. **Use `--yes` flag** for automated operations to skip confirmation prompts
5. **Use `--dry-run`** when creating issues to preview before creating
6. **Search before creating** to avoid duplicate issues
7. **Add descriptive comments** when making significant changes
8. **Link issues to epics** for better project organization
9. **Disable write mode** when done to prevent accidental modifications

## Troubleshooting

### Authentication Issues

If you get 401 errors, the cookies may have expired:

1. Clear browser cookies for jira.unity3d.com
2. Re-login to Jira in browser
3. Run: `jira-cli auth`
4. Paste fresh JSESSIONID and seraph.rememberme.cookie values

### Write Mode Errors

If write operations fail:

```bash
# Check status
jira-cli write-status

# Enable if needed
jira-cli enable-write

# Retry operation

# Disable when done
jira-cli disable-write
```

## Project Configuration

All commands are automatically scoped to the USTUDIO project. Configuration is stored in:

- Config: `~/.jira-cli/config.json`
- Credentials: `~/.jira-cli/credentials.json`
- Write mode state: `~/.jira-cli/write_mode.json`

Default settings:
- Jira URL: https://jira.unity3d.com
- Board ID: 8637
- Project: USTUDIO
