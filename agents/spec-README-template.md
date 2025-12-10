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

### Explaining vs. Listing
- **Don't just list components**—explain how they interact and why the design exists
- A table of names with 3-word descriptions is an index, not documentation
- For relationships (service dependencies, data flows), write prose that explains the *why* and *how*
- **Show concrete data examples**—actual JSON/object structures with realistic values help more than abstract descriptions
- When documenting data models, show what the serialized data looks like, not just the class hierarchy

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

### Diagram Content
Boxes with just names are labels, not documentation. Every diagram element should convey meaning:
- **C4 diagrams**: Use the description parameter—`Component(id, "Name", "Tech", "What it does")`
- **Flowcharts**: Include brief descriptions in node labels—`service["<b>ServiceName</b><br>What it does"]`
- **Show real values**: When illustrating data flow, use concrete examples (actual field names, realistic values) not abstract placeholders

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

**Shorter is better.** Don't fill space—stop when you've covered the essentials. Split early to keep files focused.

| Level | Where | Max Size |
|-------|-------|----------|
| Context + Containers + Components overview | `current-system.md` | 300 lines ideal, 500 hard limit |
| Component details | `system/components/*.md` | 150-250 lines each |
| Complex flows | `system/flows/*.md` | As needed |
| Domain models | `system/domain/*.md` | As needed |

When a section grows past ~100 lines, consider splitting it to a detail file rather than expanding inline.

## Document Standards

- **Filenames**: Lowercase with hyphens (`current-system.md`)
- **YAML frontmatter**: Include metadata (date, git_commit, status)
- **Navigation**: Cross-link between overview and detail docs
- **Style**: Concise, technical, clear. Use the format that best explains the concept—tables for discrete facts (file locations, API endpoints), prose for relationships and reasoning, bullets for simple lists.

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
