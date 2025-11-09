# Looped Agent Workflow System

**Version**: 1.1
**Last Updated**: 2025-11-09

**Recent improvements**: UML/PlantUML diagram integration, YAML frontmatter metadata, optimized context thresholds (40-60%)

## What This Is

A system for using coding agent instances (Claude, GPT-5, Gemini, etc.) in loops to research, plan, and implement software projects. Three specialized agent prompts work together through shared documentation, with clean handoffs between sessions.

**The Problem**: Coding agents have finite context (e.g., 200k tokens for Claude Sonnet). Complex projects need multiple sessions with clean handoffs and minimal context bloat.

**The Solution**: Three agent types with clear document ownership, token-efficient status docs, and sub-agent delegation for verbose work.

---

## Three Agent Roles

### Researcher (`researcher.md`)
- **Purpose**: Investigates existing system OR verifies implementation
- **Owns**: `spec/CURRENT_SYSTEM.md`, `spec/RESEARCH_STATUS.md`
- **Uses**: Task agents for codebase exploration
- **When**: At project start, or after implementation to verify reality

### Planner (`planner.md`)
- **Purpose**: Designs specs for new work (WHAT to build, not HOW)
- **Owns**: `spec/NEW_FEATURES.md`, `spec/PLANNING_STATUS.md`, `spec/QUESTIONS.md`
- **Uses**: Task agents for feasibility research, QUESTIONS.md for human collaboration
- **When**: After understanding current system, before implementation

### Implementor (`implementor.md`)
- **Purpose**: Implements ONE atomic task per session, then STOPS
- **Owns**: `spec/PROGRESS.md` (+ marks completions in NEW_FEATURES.md)
- **Uses**: Task agents for debugging, testing, exploration
- **When**: Repeatedly, one task at a time, until features complete

---

## The Development Cycle

Repeating cycle with flexibility to jump to any agent as needed:

```
1. Researcher    → Capture/verify system → CURRENT_SYSTEM.md
2. Planner       → Spec features        → NEW_FEATURES.md + QUESTIONS.md
3. Implementor   → Build (repeat)       → PROGRESS.md
4. Researcher    → Verify reality       → Update CURRENT_SYSTEM.md
5. Back to step 2
```

**Key**: Agents don't assume who comes next. Each keeps their owned docs current for whoever needs them.

---

## Document Structure

```
~/dotfiles/claude/commands/
  research.md         - Research agent prompt (invoke with /research)
  plan.md             - Planning agent prompt (invoke with /plan)
  implement.md        - Implementor agent prompt (invoke with /implement)

agent_workflow.md     - This file (how to use the system)
meta-agent.md         - Meta-development context

spec/
  CURRENT_SYSTEM.md    - How system works (researcher owns)
  RESEARCH_STATUS.md   - Research progress (researcher owns)
  NEW_FEATURES.md      - What to build (planner owns)
  PLANNING_STATUS.md   - Planning progress (planner owns)
  QUESTIONS.md         - Human Q&A (planner only)
  PROGRESS.md          - Implementation state (implementor owns)
```

### Document Ownership

**CURRENT_SYSTEM.md** - System understanding
- Created/updated by: Researcher
- Read by: Planner, Implementor
- Living doc: updated as system evolves
- Principle: "Behavior and integration points clear, implementation details minimal"
- For large systems (>800-1000 lines): Split into spec/system/ subdocs

**NEW_FEATURES.md** - Functional requirements
- Created/updated by: Planner
- Read by: Implementor
- Marked complete by: Implementor

**PROGRESS.md** - Current implementation state
- Created/updated by: Implementor
- Read by: Next implementor
- Structure: "What's Done / What's Next / Dependencies"
- REWRITE each session (not append-only)

**QUESTIONS.md** - Structured human Q&A
- Created/updated by: Planner (ONLY)
- Read by: Human, then planner
- Format: Context, options, recommendation, HUMAN RESPONSE placeholder
- Delete answered questions immediately (not archive)

---

## Viewing UML Diagrams in Documentation

**Agents include PlantUML diagrams** in system and planning documentation to visualize architecture, data flows, and changes. These diagrams make reviewing and understanding complex systems dramatically easier.

### Where You'll Find Diagrams

**CURRENT_SYSTEM.md** (from Researcher):
- Component diagrams showing system architecture
- Sequence diagrams for critical data flows
- Interface diagrams for key contracts

**NEW_FEATURES.md** (from Planner):
- Component diagrams highlighting what's changing
  - Modified components (blue)
  - New components (green)
  - Removed components (red)
- Sequence diagrams showing new feature flows

### How to Render PlantUML Diagrams

**VSCode** (recommended):
1. Install "PlantUML" extension
2. Open any .md file with diagrams
3. Press `Alt+D` (Windows/Linux) or `Option+D` (Mac) to preview
4. Or right-click → "Preview Current Diagram"

**Online** (no installation):
- Copy diagram code (between ` ```plantuml` markers)
- Paste into:
  - plantuml.com
  - planttext.com
  - plantuml-editor.kkeisuke.com
- View rendered diagram

**Command Line**:
```bash
# Install PlantUML
brew install plantuml  # Mac
apt-get install plantuml  # Linux

# Render diagrams in markdown file
plantuml spec/CURRENT_SYSTEM.md
# Generates PNG images
```

**Browser Extensions**:
- Some GitHub/GitLab browser extensions render PlantUML inline
- Check your repository hosting platform docs

### Why Diagrams Matter

**For reviewing specs**:
- Instantly see which components are affected
- Spot missing integration points
- Understand data flows at a glance
- Identify scope creep or over-complexity

**For collaboration**:
- Share rendered diagrams with team
- Point to specific diagram elements in discussions
- Much faster than reading prose descriptions

**Example**: Instead of reading "The API Server connects to the Email Service via AMQP, which then integrates with SendGrid using their REST API...", you see a clear component diagram with connections labeled.

---

## How to Use This System

### Starting an Agent

**If using Claude Code with slash commands:**
```
/research
/plan [provide requirements or context]
/implement
```

**If using other agents or file references:**
```
Please act as the researcher agent from ~/dotfiles/claude/commands/research.md
Please act as the planner agent from ~/dotfiles/claude/commands/plan.md
Please act as the implementor agent from ~/dotfiles/claude/commands/implement.md
```

**Note**: Slash commands work with Claude Code CLI. Other agents (GPT-5, Gemini, etc.) may require different invocation methods.

### Continuing Work

Each agent reads their status docs and continues from where the previous agent left off. No need to explain history - they pick up context from the documents.

---

## Key Principles

### System Documentation Principle

**For CURRENT_SYSTEM.md**: "Behavior and integration points clear, implementation details minimal"

Document WHAT the system does and HOW components connect - enough to plan changes without surprises, not enough to implement without reading code.

**Include**:
- Component responsibilities and data flows
- Integration points (APIs, external systems, data formats)
- Key constraints (technical limits, dependencies)
- User-facing behavior and workflows

**Exclude**:
- Implementation algorithms (unless critical constraints)
- Full class hierarchies and method signatures
- Line-by-line code walkthroughs
- Historical decisions (unless they constrain future work)

**Multi-file strategy for large systems** (>800-1000 lines):
```
spec/
  CURRENT_SYSTEM.md           - Overview + navigation (200-300 lines)
  system/
    architecture.md           - Components, data flows
    integration-points.md     - APIs, contracts, data formats
    constraints.md            - Technical debt, limitations
```

### Spec Documentation Principle

**For NEW_FEATURES.md**: "User experience clear, implementation flexible"

Two implementors should produce systems that behave identically from user perspective, but could have different internals.

### Documentation is NOT History

Documents are for FUTURE AGENTS, not historical record.

**DELETE**:
- Completed tasks
- Old problems that were solved
- Session narratives
- "What we tried"

**KEEP**:
- Current state
- Active decisions
- Next steps
- Blockers

**REWRITE sections** when info changes (don't append).

### Token Efficiency

- **60-70% usage**: Wrap up, write docs, exit
- **80% usage**: HARD STOP - document state immediately
- Delegate verbose work to Task sub-agents
- Read all docs completely (no summaries)

### Quality Standards

**Planner specs**:
- Focus on interfaces, behavior, workflows
- 2-3 phases max (not 5+)
- Two implementors = same user behavior, different internals

**Implementor code**:
- Simple > clever, Clear > DRY, Less is better
- ONE task per session, then STOP
- Mandatory end-to-end user testing with evidence
- "Replace X" means replace X (not create X_v2)

---

## QUESTIONS.md Workflow

**Critical for async human-agent collaboration**:

1. **Planner adds question** with structure:
   - Context, options with tradeoffs, recommendation
   - **HUMAN RESPONSE:** placeholder

2. **Human edits file** with decision (can be brief: "Option A")

3. **Next planner session**:
   - Reads responses, updates specs
   - **Deletes answered questions** (don't archive)

**Why this works**:
- Numbered questions easy to reference (Q1, Q2, etc.)
- Human reviews all questions holistically
- Better than conversational back-and-forth
- Async-friendly

---

## Running Checkpoint Reviews

**After 2-3 implementation sessions**, or when documentation feels stale:

```
/research
Task: Verify specs match implementation reality, check for regressions
```

**What they check**:
- Does `spec/CURRENT_SYSTEM.md` match actual code?
- Are features marked "ENABLED" actually working?
- Did recent changes break previous features?
- Are there contradictions between docs?

**Cost**: ~30-40% context per checkpoint
**Benefit**: Catches drift before it compounds

---

## When Things Go Wrong

**Symptoms of drift:**
- Docs claim feature works but it doesn't
- Tests passing but feature broken
- Multiple versions of "current state" in different files
- Implementors confused about what exists

**Action**: Stop implementation, run checkpoint researcher to reset shared understanding.

---

## Common Pitfalls

### Historical Accumulation
Agents treat docs like append-only logs.
→ **Solution**: REWRITE, don't append. Delete obsolete info.

### Multi-Task Creep
Implementors continue to next task when they have context.
→ **Solution**: ONE TASK PER SESSION rule. STOP after one task.

### Fake Verification
Agents claim "works" without testing.
→ **Solution**: Mandatory end-to-end testing with evidence (commands + output).

### Spec Reinterpretation
Agents create _v2 files when spec says "replace".
→ **Solution**: Follow spec literally. If unclear, ask.

### Code-Heavy Specs
Planner dumps implementation code instead of requirements.
→ **Solution**: Focus on interfaces and behavior, not code dumps.

---

## Tips for Success

1. **Start with researcher** to understand existing system
2. **Use planner for feature design** with human collaboration via QUESTIONS.md
3. **Run implementor in loops**, one atomic task per session
4. **Run checkpoint reviews** every 2-3 implementations
5. **Keep specs simple**: 2-3 phases max
6. **Delete obsolete info**: Docs are for future, not history
7. **Verify everything**: End-to-end testing is mandatory

---

## Document Purposes Quick Reference

**For Users:**
- `README.md` - End user usage guide (NO phases, NO implementation details)

**For Agent Handoffs:**
- `spec/CURRENT_SYSTEM.md` - Researcher → Planner/Implementor
- `spec/NEW_FEATURES.md` - Planner → Implementor
- `spec/PROGRESS.md` - Implementor → Implementor

**For Agent Continuity (same role):**
- `spec/RESEARCH_STATUS.md` - Researcher → Researcher
- `spec/PLANNING_STATUS.md` - Planner → Planner

**For Human Interaction:**
- `spec/QUESTIONS.md` - Planner ↔ Human

**Key**: Agents only read handoff docs from previous role, not internal progress docs from other roles.

---

**Remember**: Agents need current state and next steps, not a story of how we got here.
