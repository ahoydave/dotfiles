# Looped Agent Workflow System

**Version**: 1.2
**Last Updated**: 2025-11-20

**Recent improvements**: Updated all documentation for 5-agent system (research, plan, implement, manager, meta-agent), corrected all cross-references, improved clarity and token efficiency

## What This Is

A system for using coding agent instances (Claude, GPT-5, Gemini, etc.) in loops to research, plan, and implement software projects. Five specialized agent prompts work together through shared documentation, with clean handoffs between sessions.

**The Problem**: Coding agents have finite context (e.g., 200k tokens for Claude Sonnet). Complex projects need multiple sessions with clean handoffs and minimal context bloat.

**The Solution**: Five specialized agents with clear document ownership, token-efficient status docs, and sub-agent delegation for verbose work.

---

## Agent Roles

### Researcher (`research.md`)
- **Purpose**: Investigates existing system OR verifies implementation
- **Owns**: `spec/current_system.md`, `spec/feature_tests.md`, `spec/research_status.md`
- **Uses**: Task agents for codebase exploration
- **When**: At project start, or after implementation to verify reality

### Planner (`plan.md`)
- **Purpose**: Designs specs for new work (WHAT to build, not HOW)
- **Owns**: `ongoing_changes/new_features.md`, `ongoing_changes/planning_status.md`, `ongoing_changes/questions.md`
- **Uses**: Task agents for feasibility research, questions.md for human collaboration
- **When**: After understanding current system, before implementation

### Implementor (`implement.md`)
- **Purpose**: Implements ONE atomic task per session, then STOPS
- **Owns**: `ongoing_changes/implementor_progress.md` (+ marks completions in new_features.md)
- **Uses**: Task agents for debugging, testing, exploration
- **When**: Repeatedly, one task at a time, until features complete

### Manager (`implementation-manager.md`)
- **Purpose**: Orchestrates multiple implementor sessions autonomously
- **Owns**: `ongoing_changes/manager_progress.md`
- **Uses**: Implementor agents for task execution
- **When**: For multi-task workflows where human oversight isn't needed per task

### Meta-Agent (`meta-agent.md`)
- **Purpose**: Refines the agent system itself (prompts, docs, workflow)
- **Owns**: `meta_status.md`, agent command files, workflow documentation
- **Uses**: Real project testing to validate refinements
- **When**: When agent behavior needs improvement or documentation needs updates

---

## The Development Cycle

Repeating cycle with flexibility to jump to any agent as needed:

```
1. Researcher    → Capture/verify system → spec/current_system.md
2. Planner       → Spec features        → ongoing_changes/new_features.md + questions.md
3. Implementor   → Build (repeat)       → ongoing_changes/implementor_progress.md
4. Researcher    → Verify reality       → Update spec/current_system.md
5. Back to step 2
```

**Key**: Agents don't assume who comes next. Each keeps their owned docs current for whoever needs them.

**Two-directory structure**:
- `spec/` - Permanent system knowledge (researcher territory)
- `ongoing_changes/` - Temporary work-in-progress (planner/implementor/manager territory)

---

## Document Structure

```
~/dotfiles/claude/
  commands/
    research.md                - Research agent (invoke: /research)
    plan.md                    - Planning agent (invoke: /plan)
    implement.md               - Implementor agent (invoke: /implement)
    implementation-manager.md  - Manager agent (invoke: /implementation-manager)
    meta-agent.md              - Meta-agent (invoke: /meta-agent)

  agent_workflow.md     - This file (user guide)
  meta_status.md        - System state and development history (meta-agent)
  ACE-FCA-COMPARISON.md - Lessons from similar systems

(In target projects - created by agents during usage)
spec/                           - Permanent system documentation
  current_system.md             - System understanding (researcher)
  feature_tests.md              - Feature verification registry (researcher)
  research_status.md            - Research progress (researcher)

ongoing_changes/                - Temporary work-in-progress documents
  new_features.md               - What to build (planner)
  planning_status.md            - Planning progress (planner)
  questions.md                  - Human Q&A (planner, temporary)
  implementor_progress.md       - Implementation state (implementor)
  manager_progress.md           - Task tracking (manager)
```

### Document Ownership

**spec/current_system.md** - System understanding (permanent)
- Created/updated by: Researcher
- Read by: Planner, Implementor
- Living doc: updated as system evolves
- Principle: "Behavior and integration points clear, implementation details minimal"
- For large systems (>800-1000 lines): Split into spec/system/ subdocs

**spec/feature_tests.md** - Feature verification registry (permanent)
- Created/updated by: Researcher (creates structure), Implementor (adds entries)
- Read by: All agents for verification
- Never deleted, continuously updated

**ongoing_changes/new_features.md** - Functional requirements (temporary)
- Created/updated by: Planner
- Read by: Implementor, Manager
- Marked complete by: Implementor
- Deleted when project phase complete

**ongoing_changes/implementor_progress.md** - Implementation state (temporary)
- Created/updated by: Implementor
- Read by: Next implementor, Manager
- Structure: "What's Done / What's Next / Dependencies"
- REWRITE each session (not append-only)

**ongoing_changes/questions.md** - Structured human Q&A (temporary)
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
/research                # Investigate or verify system
/plan                    # Design new features
/implement               # Build one task at a time
/implementation-manager  # Orchestrate multiple tasks
/meta-agent              # Refine agent system
```

**If using other agents or file references:**
```
Please act as the researcher agent from ~/dotfiles/claude/commands/research.md
Please act as the planner agent from ~/dotfiles/claude/commands/plan.md
Please act as the implementor agent from ~/dotfiles/claude/commands/implement.md
Please act as the manager agent from ~/dotfiles/claude/commands/implementation-manager.md
Please act as the meta-agent from ~/dotfiles/claude/commands/meta-agent.md
```

**Note**: Slash commands work with Claude Code CLI. Other agents (GPT-5, Gemini, etc.) may require different invocation methods.

### Continuing Work

Each agent reads their status docs and continues from where the previous agent left off. No need to explain history - they pick up context from the documents.

---

## Key Principles

### System Documentation Principle

**For spec/current_system.md**: "Behavior and integration points clear, implementation details minimal"

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
  current_system.md           - Overview + navigation (200-300 lines)
  system/
    architecture.md           - Components, data flows
    integration-points.md     - APIs, contracts, data formats
    constraints.md            - Technical debt, limitations
```

### Spec Documentation Principle

**For ongoing_changes/new_features.md**: "User experience clear, implementation flexible"

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
- `spec/current_system.md` - Researcher → Planner/Implementor
- `ongoing_changes/new_features.md` - Planner → Implementor/Manager
- `ongoing_changes/implementor_progress.md` - Implementor → Implementor

**For Agent Continuity (same role):**
- `spec/research_status.md` - Researcher → Researcher
- `ongoing_changes/planning_status.md` - Planner → Planner
- `ongoing_changes/manager_progress.md` - Manager → Manager

**For Human Interaction:**
- `ongoing_changes/questions.md` - Planner ↔ Human

**Key**: Agents only read handoff docs from previous role, not internal progress docs from other roles.

**Directory Structure**:
- `spec/` - Permanent docs (never deleted, continuously updated)
- `ongoing_changes/` - Temporary docs (deleted when project phase complete)

---

**Remember**: Agents need current state and next steps, not a story of how we got here.
