# Spec Folder

*Agents do not modify this file* - This is a documentation standard. If you need different conventions for a specific project, ask the human to update this template.

This file belongs in `spec/README.md` in your project.

The `spec/` folder contains **permanent system documentation** - the source of truth for how the system works.

## Purpose

Enable anyone (human or AI agent) to understand the current system quickly and accurately. Optimized for:
- **Agent consumption**: Token-efficient, structured, factual
- **Human review**: Scannable, visual diagrams, clear navigation
- **Collaboration**: Shared understanding across team members and tools

Diagrams are **inline** using Mermaid syntax - no separate diagram files needed.

## C4 Model

Documentation follows the [C4 model](https://c4model.com/) - four levels of abstraction for describing software architecture. **Skip any level that adds no information.**

### Level 1: System Context
**What**: The system as a black box, showing users and external systems it interacts with.
**Include when**: External dependencies or multiple user types exist.
**Skip when**: No external systems and one obvious user type.
**Mermaid**: `C4Context` with `Person()`, `System()`, `System_Ext()`, `Rel()`

### Level 2: Containers
**What**: Major deployable units - web apps, APIs, databases, message queues, etc.
**Include when**: Multiple containers that communicate.
**Skip when**: Single container (monolith, CLI tool, single service).
**Mermaid**: `C4Container` with `Container()`, `ContainerDb()`, `Container_Boundary()`

### Level 3: Components
**What**: Major building blocks within a container - services, controllers, repositories.
**Include when**: Container internals are complex enough to need explanation.
**Location**: `current-system.md` for overview, `system/components/<name>.md` for details.
**Mermaid**: `C4Component` with `Component()`, `ComponentDb()`

### Level 4: Code
**What**: Class diagrams, data models, detailed interfaces.
**Include when**: Important domain models, complex class relationships, extension points not covered at higher levels.
**Location**: `system/domain/<area>.md` or within component docs.
**Mermaid**: `classDiagram`

## What to Document

### Include
- Component responsibilities (what each major piece does)
- Data flows (how information moves through the system)
- Integration points (external services, APIs, data contracts)
- Key constraints (technical limitations, must-preserve behaviors)
- Configuration (what's configurable, where, critical settings)
- File references (`file_path:line_number` for key code locations)

### Exclude
- Implementation algorithms (unless they're critical constraints)
- Full class hierarchies (list major classes, not every method)
- Code walkthroughs ("first X, then Y, then Z")
- Historical decisions (unless they constrain future work)

### The Test
**"Could someone plan a new feature without missing critical constraints or breaking existing behavior?"**
- If yes → documentation is complete enough
- If no → missing critical integration points or constraints

## Additional Diagrams

Beyond C4 levels, include these when they add value:

| Type | Include When | Mermaid |
|------|--------------|---------|
| Class/Data Model | Important domain entities, complex relationships | `classDiagram` |
| Sequence/Flow | Multi-step interactions not obvious from structure | `sequenceDiagram` |
| State | Entity has meaningful lifecycle states | `stateDiagram-v2` |

**The rule**: Include a diagram if it adds information. Skip if empty or redundant.

Docs: [C4 model](https://c4model.com/) | [Mermaid C4 syntax](https://mermaid.js.org/syntax/c4.html) | [Mermaid docs](https://mermaid.js.org/)

## File Structure

```
spec/
  README.md                      # This file - documentation standards
  current-system.md              # System overview (<500 lines)

  system/                        # Detailed docs (when needed)
    components/
      <component-name>.md        # Deep dive on specific component
    flows/
      <flow-name>.md             # Critical multi-component flows
    domain/
      <area>.md                  # Domain entities and relationships
```

## Progressive Disclosure

Keep `current-system.md` under 500 lines. Split to detail files when any section needs more than ~150 lines:

| Level | Where | Target Size |
|-------|-------|-------------|
| Context + Containers + Components overview | `current-system.md` | 300-500 lines |
| Component details | `system/components/*.md` | 200-400 lines each |
| Complex flows | `system/flows/*.md` | As needed |
| Domain models | `system/domain/*.md` | As needed |

## Document Standards

- **Filenames**: Lowercase with hyphens (`current-system.md`)
- **YAML frontmatter**: Include metadata (date, git_commit, status)
- **Navigation**: Cross-link between overview and detail docs
- **Style**: Concise, technical, scannable. Bullet points over prose.

## What Does NOT Belong Here

| Don't Put | Why | Where Instead |
|-----------|-----|---------------|
| Work-in-progress | Spec is for current truth | Separate WIP folder |
| Recommendations | Document facts, not opinions | Design docs/tickets |
| Change history | Git tracks this | Git log |
| Session notes | Transient, not permanent | Delete after use |

## Key Principles

1. **Right-sized documentation** - Match detail to system complexity, skip empty diagrams
2. **Current state only** - Document what IS, not what WAS or SHOULD BE
3. **Rewrite, don't append** - Keep docs current, not historical
4. **Delete aggressively** - If it's outdated or redundant, remove it
