# Spec Folder

*Agents do not modify this file* - This is a documentation standard. If you need different conventions for a specific project, ask the human to update this template.

This file belongs in `spec/README.md` in your project.

The `spec/` folder contains **permanent system documentation** - the source of truth for how the system works.

## Purpose

Enable anyone (human or AI agent) to understand the current system quickly and accurately. Optimized for:
- **Agent consumption**: Token-efficient, structured, factual
- **Human review**: Scannable, confident navigation without fear of missing something
- **Collaboration**: Shared understanding across team members and tools

## Core Principle: Summary + Link

**Every complex topic gets a short summary in the parent doc, with a link to details.**

This lets readers:
- Scan the overview confidently, knowing important points are surfaced
- Drill down only when needed
- Never miss something critical buried in a sub-document

**Pattern in `current-system.md`:**
```markdown
### Authentication

Handles user login via OAuth2 with JWT tokens. Sessions stored in Redis with 24h TTL.
Rate-limited to 5 attempts per minute per IP.

→ Details: [system/components/auth.md](system/components/auth.md)
```

The summary must contain enough that a reader knows whether they need the detail doc. If something in the detail doc would surprise someone who only read the summary, the summary is incomplete.

## File Structure

```
spec/
  README.md                      # This file - documentation standards
  current-system.md              # System overview (300 lines ideal, 500 max)

  system/                        # Detail docs (split when overview gets crowded)
    components/
      <component-name>.md        # Deep dive on specific component (150-250 lines)
    flows/
      <flow-name>.md             # Critical multi-component flows
    domain/
      <area>.md                  # Domain entities and relationships
```

**When to split**: When a section in `current-system.md` grows past ~100 lines, extract it to a detail file and leave a summary + link.

## C4 Model

Documentation follows the [C4 model](https://c4model.com/) - four levels of abstraction. **Skip any level that adds no information.**

| Level | What | Include When | Skip When |
|-------|------|--------------|-----------|
| 1: Context | System + external dependencies | External systems or multiple user types | No external systems, one obvious user |
| 2: Containers | Deployable units (apps, DBs, queues) | Multiple containers that communicate | Single container (monolith, CLI) |
| 3: Components | Building blocks within containers | Internals complex enough to explain | Simple internal structure |
| 4: Code | Class diagrams, data models | Important domain models, complex relationships | Covered adequately at higher levels |

Diagrams use **Mermaid syntax inline** - no separate diagram files.

Docs: [C4 model](https://c4model.com/) | [Mermaid C4 syntax](https://mermaid.js.org/syntax/c4.html) | [Mermaid docs](https://mermaid.js.org/)

## What to Document

### Include
- Component responsibilities and how they interact
- Data flows (how information moves through the system)
- Integration points (external services, APIs, data contracts)
- Key constraints (technical limitations, must-preserve behaviors)
- File references (`file_path:line_number` for key code locations)
- Concrete data examples (actual JSON/object structures with realistic values)

### Exclude
- Implementation algorithms (unless they're critical constraints)
- Full class hierarchies (list major classes, not every method)
- Code walkthroughs ("first X, then Y, then Z")
- Historical decisions (unless they constrain future work)

### The Test
**"Could someone plan a new feature without missing critical constraints or breaking existing behavior?"**

## Diagram Guidelines

Include diagrams when they add information not obvious from text. Skip empty or redundant diagrams.

| Type | Include When | Mermaid |
|------|--------------|---------|
| Class/Data Model | Important domain entities, complex relationships | `classDiagram` |
| Sequence/Flow | Multi-step interactions not obvious from structure | `sequenceDiagram` |
| State | Entity has meaningful lifecycle states | `stateDiagram-v2` |

**Content matters**: Boxes with just names are labels, not documentation.
- **Nodes**: Include role/purpose, not just name—`Component(id, "Name", "Tech", "What it does")`
- **Arrows**: Label what flows or happens, not that a relationship exists. Ask: "What does A get from B?" Bad: `A --> B`. Good: `A -->|fetch user by ID| B`

**The test**: Could someone unfamiliar with the codebase understand the data/control flow from the diagram alone?

## Document Standards

- **Filenames**: Lowercase with hyphens (`current-system.md`)
- **YAML frontmatter**: Include metadata (date, git_commit, status)
- **Style**: Concise, technical, clear. Tables for discrete facts, prose for relationships, bullets for simple lists.

## What Does NOT Belong Here

| Don't Put | Why | Where Instead |
|-----------|-----|---------------|
| Work-in-progress | Spec is for current truth | Separate WIP folder |
| Recommendations | Document facts, not opinions | Design docs/tickets |
| Change history | Git tracks this | Git log |
| Session notes | Transient, not permanent | Delete after use |

## Key Principles

1. **Summary + link** - Surface important points in parent docs, link to details
2. **Current state only** - Document what IS, not what WAS or SHOULD BE
3. **Rewrite, don't append** - Keep docs current, not historical
4. **Delete aggressively** - If it's outdated or redundant, remove it
