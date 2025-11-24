# Meta-Agent System Status

---
last_updated: 2025-11-24
git_commit: 911ff2945bc63c3d69dd102521865ad4d25dfad1
refinement_count: 55
status: production-ready
recent_focus: autonomous_research_delegation
agent_count: 5
---

## Current State (2025-11-24)

### Status: Production-Ready with Autonomous Implementation Manager and Research Delegation

**Agent prompts**: 55 refinements applied through iterative testing
**Deployment**: Prompts in ~/dotfiles/claude/commands/ (invoked via `/research`, `/plan`, `/implement`, `/implementation-manager` in any project)
**Testing**: All agents tested on real projects, failures documented and addressed
**Documentation**: Complete workflow documentation split (agent_workflow.md for users, commands/meta-agent.md for meta-development)
**Recent focus**: Project-specific agent rules (`.agent-rules/` directory for accumulating project learnings)

### What's Working

✅ **Researcher**: Clean handoffs, scales to massive codebases via aggressive sub-agent delegation, comprehensive system documentation with UML diagrams (separate .puml files + auto-generated SVGs), test suite verification, documentor role (facts, not recommendations), verification mindset (trust code over claims), no documentation history meta-commentary
✅ **Planner**: Interactive collaboration via questions.md, visual planning with change-highlighted diagrams, verification strategy in specs, absolute no-code rule (user experience clear, implementation flexible)
✅ **Implementor**: Clear task boundaries, repeatable test creation requirements, end-to-end verification focus
✅ **Implementation Manager**: Autonomous multi-task orchestration via sub-agents (Refinement #32)
  - Eliminates human friction between tasks
  - Minimal context (stays <30% throughout)
  - Continues until done, blocked, or context limit
  - Manager-worker pattern: delegates to `/implement` sub-agents
  - Graceful restart handling via manager_progress.md
✅ **Sub-agent delegation**: Only results return to context (not exploration process)
✅ **Document structure**: Clear ownership, no sprawl (explicit allowed lists)
✅ **Token efficiency**: Optimized to 40-60% (aligned with ACE-FCA proven thresholds)
✅ **Agent-agnostic**: Works with Claude, GPT-5, Gemini, etc.
✅ **System documentation**: Multi-file strategy for large systems (>800-1000 lines), C4-inspired progressive disclosure
✅ **Repeatable test suites**: Tests as first-class deliverables (scripts/automated/documented procedures)
✅ **Test suite verification**: Researcher runs tests to verify system state, not just reads code
✅ **End-to-end testing**: Tests verify user experience, not just "code exists"
✅ **Proof-required testing**: Implementors must paste actual terminal output as verification
✅ **Visual architecture**: PlantUML diagrams for components, sequences, and interfaces
✅ **Metadata tracking**: YAML frontmatter for traceability (git SHA, dates, status)
✅ **Format migration**: Automatic updates to latest document format standards
✅ **Permissions**: settings.json controls approvals - agents run dev commands without friction

### Known Challenges (Monitored)

⚠️ **Multi-session handoffs**: Risky with complex specs (5+ phases)
- Solution: Recommend 2-3 phase specs (built into planner prompt)

⚠️ **Agent discipline**: Requires strict adherence to rules
- One task per session (implementor) - addressed with prominent reminders
- Delete obsolete info (all agents) - addressed with "Documentation is Not History" sections
- Follow spec literally (implementor) - addressed with explicit examples
- No documentation sprawl - addressed with explicit allowed lists and DELETE rules
- Documentor not critic (researcher) - addressed with "Role Clarity" section

⚠️ **Testing honesty**: Agents claim they tested when they didn't
- Solution: ABSOLUTE RULE requiring actual terminal output pasted as proof
- Examples showing acceptable vs unacceptable verification
- "If you say you tested it, paste the output" - no exceptions

## Development History

### Foundational Refinements 1-40 (2025-11-01 to 2025-11-10)

**See `meta_history.md` for detailed archive of refinements 1-40.**

**Key patterns established:**
- Documentation discipline (REWRITE not append, delete obsolete info, docs for future agents)
- Testing discipline (paste output, create repeatable tests, end-to-end verification, regression checks)
- Context management (40-50% wrap up, 60% hard stop, sub-agent delegation, progressive disclosure)
- Agent boundaries (ONE task per implementor, clear document ownership, follow spec literally)
- System integration (slash commands, settings.json permissions, Implementation Manager, YAML frontmatter)
### Recent Refinements 41-53 (2025-11-10 to 2025-11-21)

41. **C4-inspired progressive disclosure** - Three-level documentation structure (Context, Containers, Components). Levels 1+2 in current_system.md (<500 lines), Level 3 split to components/flows. 60-75% token savings for typical tasks.

42. **Role clarity: Documentor, not critic** - Researcher documents WHAT EXISTS (facts), planner identifies WHAT SHOULD BE (improvements). Prevents recommendation docs (IMPROVEMENTS.md, etc.).

43. **Coding standards: Clarity, simplicity, complexity budget** - Simple > Complex, Clear > Clever, Delete > Keep. Comments only for WHY (not WHAT), complexity as precious resource, code deletion is beautiful.

44. **Prompt verbosity reduction** - ~759 lines removed across 4 prompts (~24% reduction). Consolidated repetitive sections while keeping critical teaching examples.

45. **Directory structure clarification** - Two-directory structure: `ongoing_changes/` (temporary WIP) + `spec/` (permanent docs). Prevents sprawl, clear ownership boundaries.

46. **Meta-agent reads actual prompts** - Always read all four agent prompts directly, not secondhand from meta_status.md. Prompt length becomes observable signal.

47. **Diagram ownership boundaries** - Planner diagrams in `ongoing_changes/diagrams/` (planned changes), researcher diagrams in `spec/diagrams/` (current system).

48. **Verification mindset and no documentation history** - Trust code, not claims. Never document the history of documentation itself (git tracks that).

49. **Aggressive sub-agent delegation for scale** - Explicit thresholds by codebase size. >100k LOC: 5-10 parallel sub-agents. Enables handling any codebase size while staying <50% context.

50. **No implementation code in specs** - ABSOLUTE RULE with no escape hatches. Specs define WHAT to build and HOW IT BEHAVES, not HOW TO BUILD IT. Prevents code dumps.

51. **Comment accuracy after code changes** - Delete/update comments that reference removed code. Avoid comparative phrases ("less/more/better than..."). Comments state WHAT code does NOW, not WHAT CHANGED.

52. **Instruction consolidation (meta-agent)** - Archived refinements 1-40 to meta_history.md (~400 lines saved). Compressed ACE-FCA comparison to summary with link (~120 lines saved). Consolidated "Known Issues to Monitor" from 109 questions to 30 organized by refinement group (~80 lines saved). Total ~600 lines removed from meta_status.md.

53. **README.md ownership (researcher)** - Researcher now owns and maintains project README.md alongside current_system.md. Problem: Researchers create comprehensive system docs but never update the user-facing README, causing it to become stale. Solution: Added README.md to researcher's allowed file list and document ownership. Added explicit section in Process step 3 requiring README.md updates aligned with current_system.md findings. Updated implementor prompt to clarify researcher owns overall README structure, implementor only updates for feature-specific usage changes. Prevents "project front door" from becoming outdated while internal docs stay current.

54. **Project-specific agent rules** - Added `.agent-rules/` directory concept for accumulating project-specific learnings. Problem: Every project has unique workflows, gotchas, and constraints that agents must learn repeatedly (e.g., "reload Unity domain after file changes", "never allocate ports 9000-9010"). Without persistent rules, agents ask same questions every session or make same mistakes. Solution: Created `.agent-rules/{implementation,research,planning}.md` files that agents read during entry point and can APPEND to when human says "add this as a rule". Format: Context, Rule, How, Why, Added. Rules use absolute language ("ALWAYS", "NEVER", "MUST"). Only added when human explicitly requests. APPEND-ONLY to accumulate knowledge. Inspired by Geoffrey Huntley's "stdlib" concept but simplified for our agent-agnostic workflow (no XML, no auto-execution, just markdown rules agents read and apply). Benefits: (1) Permanent project knowledge, (2) Reduces repeated clarifications, (3) Captures tool-specific workflows, (4) Accumulates like feature_tests.md. Each agent reads its own rules file plus planner reads implementation rules to understand constraints. Addresses real user need: Unity project requiring specific MCP server calls after file changes.

55. **Planner spawns researcher sub-agents** - Planner can now autonomously spawn researcher sub-agents to fill factual gaps about current system. Problem: During planning, planner discovers gaps in system understanding ("How does auth work?", "What's the DB schema?"). Previously required human to manually invoke /research, update spec, then re-invoke /plan - friction in the workflow. Solution: Added "Spawning Research Sub-Agents for Factual Gaps" section to planner prompt (~120 lines). Clear boundary: spawn researcher for FACTUAL gaps (how system works), ask human in questions.md for DECISIONAL matters (what to build, priorities, business rules). Planner uses Task tool to spawn researcher with specific question. Researcher investigates, updates spec/current_system.md (spec remains source of truth), returns RESEARCH SUMMARY (brief answer + spec pointers + key constraints). Planner reads brief answer to continue, or reads referenced spec sections for deeper detail. Added "Sub-Agent Mode" section to researcher prompt (~100 lines) defining RESEARCH SUMMARY format and targeted research behavior. Pattern consistent with Implementation Manager (manager spawns implementors, planner spawns researchers). Benefits: (1) Autonomous factual research - no human friction for "how does it work" questions, (2) Better specs - complete understanding before planning, (3) Spec always updated - permanent benefit for all agents, (4) Progressive detail - planner controls depth via summary vs full spec sections. Example: Planner asks "How does auth middleware work?" → researcher investigates → updates spec with auth flow + diagram → returns summary → planner continues with complete understanding. Reduces "I think it works like X" → later discovery it's Y. Human focuses on design decisions, researcher handles facts about current system.

**See git history for full chronological details.**

## Convergent Evolution: ACE-FCA (2025-11-09)

We independently converged on ~80-85% the same solution as HumanLayer's "Advanced Context Engineering for Coding Agents" (ACE-FCA). **Strong validation that we're solving the problem correctly.**

**Key insight**: The bottleneck in AI coding is context management, not model capability.

**What we adopted from them**: Context thresholds (40-50% wrap up, 60% hard stop), YAML frontmatter, PlantUML diagrams.

**Our unique strengths**: Implementation Manager (autonomous flow via sub-agents), comprehensive current_system.md (works on unfamiliar codebases), explicit "paste output" rule (we discovered agents fake testing), agent-agnostic design.

**Philosophical difference**: They optimize for flow (expert devs on own codebases), we optimize for reliability (any codebase, proof-required verification).

**Full analysis**: See `ACE-FCA-COMPARISON.md`. Their system: https://github.com/humanlayer/advanced-context-engineering-for-coding-agents

**Meta-agent guidance**: When evaluating changes, ask: (1) Aligns with our principles? (2) Did ACE-FCA do this? (3) Evidence from real usage? (4) Compromises our strengths?

## Common Failure Patterns & Solutions

### Problem: Researcher too trusting, documenting documentation history
**Issue 1**: Researcher accepts claims without verification
- Takes user/comment/naming at face value without reading code
- User says "two purposes" but they're the same - researcher doesn't question
- Comments say X but code does Y - researcher trusts comment
- Function names suggest X but implementation shows Y - researcher trusts naming

**Issue 2**: Researcher documents the history of documentation itself
- "Previously this spec documented X, but now it's Y"
- "We originally thought component did X, now we know it does Y"
- Meta-commentary about spec evolution instead of current system
→ **Solution (Refinement #48)**:
- New "Verification Mindset: Trust Code, Not Claims" section with concrete examples
- Process: claim → read code → question if mismatch → trust code
- Enhanced "Documentation is Not History" with explicit rule against doc history meta-commentary
- Clear distinction: system history OK only if it explains current constraints

### Problem: Comments that compare to removed code
Implementors change code but add comments that describe *what changed* rather than *current state*.
- Comment says "less likely to clash" - **LESS THAN WHAT?** (old ports are gone from code)
- Comparative phrases ("more/less/better/improved/now uses") reference invisible previous state
- Comments age like milk: meaningless without knowing code history
- Example: "Using 37000+ (less likely to clash)" after changing 3000 → 37000 - comparison context deleted
- Pattern: Describing the *change* instead of the *result*
→ **Solution (Refinement #51)**: "CRITICAL: When you change code, DELETE OR UPDATE comments that reference the old code" section. Explicit warning: "Especially dangerous: Comments that make comparisons to removed code". Red flag phrases listed ("less/more/better/fewer than...", "now uses...", "changed to...", "improved...", "instead of..."). Concrete FindAvailablePort example showing **"LESS THAN WHAT?"** problem. Key distinction: Good comments state WHAT code does NOW, not WHAT CHANGED. Three solution alternatives showing current facts without comparisons.

### Problem: Complex, hard-to-understand code
Implementors produce code with unnecessary abstraction, clever one-liners, and comments explaining changes.
→ **Solution (Refinement #43)**: "Coding Standards - ABSOLUTE RULES" section in implementor prompt. Simple > Complex, Clear > Clever, comments only for WHY (not WHAT), complexity budget principle, concrete examples showing good vs bad.

### Problem: Historical accumulation
Agents treat docs like append-only logs.
→ **Solution**: "Documentation is Not History" section in all prompts. REWRITE, don't append.

### Problem: Researcher as critic
Researcher spends tokens analyzing what "should" be improved instead of documenting what exists.
→ **Solution (Refinement #42)**: "Role Clarity: Documentor, Not Critic" section. Document facts objectively, trust planner to identify improvements. No recommendation files (IMPROVEMENTS.md, REDUNDANT_API_CALLS.md, etc.).

### Problem: Code-heavy specs (planner dumps implementation)
Planner includes implementation code, algorithms, and pseudocode in specs instead of clear requirements.
- Escape hatches like "when code is OK to illustrate" get abused
- Agents rationalize: "This algorithm IS tricky, so I'll include the implementation"
- Specs become hard to review (20+ lines of code vs 5 lines of requirements)
- Implementors copy-paste code instead of thinking through implementation
- No room for better solutions when algorithm already specified
- Indicates lazy planning (dumping code easier than clarifying requirements)
→ **Solution (Refinement #50)**: "ABSOLUTE RULE: NO IMPLEMENTATION CODE IN SPECS" section at top of Spec Detail Level. Core principle "User experience clear, implementation flexible" made prominent. Removed all escape hatches. Single narrow exception: only if multiple valid interpretations produce different user-facing behavior (rare). Concrete before/after examples showing code dump (BAD) vs requirement (GOOD). Focus on WHAT to build and HOW IT BEHAVES, not HOW TO BUILD IT.

### Problem: Multi-task creep
Implementors continue to next task when they have context.
→ **Solution**: "ONE TASK PER SESSION" rule with prominent reminders. STOP after one task.

### Problem: Fake verification (CRITICAL) - NOW SOLVED AT ROOT CAUSE
**The deeper issue**: Agents tested once and pasted output, but didn't create REPEATABLE tests
- "Code exists" ≠ "Feature works from user perspective"
- Testing in isolation ≠ End-to-end user experience
- No test suite = Researcher can't verify implementations
- One-off manual checks = Can't verify feature still works later

→ **Solution (Refinement #36)**:
- Tests are now FIRST-CLASS DELIVERABLES (not just verification evidence)
- Implementor CREATES repeatable tests: scripts/automated tests/documented procedures
- Tests verify END-TO-END user experience, not just "code exists"
- Implementor RUNS new tests + existing test suite (regression check)
- Researcher RUNS test suite to verify system state (not just reads code)
- Planner includes verification strategy in specs (HOW to test repeatably)
- "Can another agent run this test?" "Does it test user experience?" = key questions
- STILL REQUIRED: Paste actual terminal output as proof of running tests

### Problem: Spec reinterpretation
Agents create _v2 files when spec says "replace".
→ **Solution**: "Follow spec literally" rule. If unclear, ask in questions.md (planner) or directly (implementor).

### Problem: Code-heavy specs
Planner dumps implementation code instead of requirements.
→ **Solution**: "Spec Detail Level" guidelines. Focus on interfaces and behavior, not code dumps.

### Problem: questions.md bloat
Planner doesn't delete answered questions.
→ **Solution**: Explicit cleanup requirement. Delete answered questions immediately.

### Problem: Component replacement without capability check
Implementor replaces component but loses features.
→ **Solution**: "Check what you're replacing" step. List capabilities before replacing.

### Problem: Context overflow
Agents read too much into their context.
→ **Solution**: Token budget monitoring (40-50% wrap up, 60% hard stop) + sub-agent delegation + progressive disclosure (C4 levels).

### Problem: Documentation sprawl
Agents invent new docs (SESSION_SUMMARY.md, NOTES.md, etc.) instead of using existing structure.
→ **Solution (Refinement #45)**: Two-directory structure with clear boundaries
- Only two valid locations: `ongoing_changes/` (temporary) and `spec/` (permanent)
- "No Documentation Sprawl" section in all prompts with explicit allowed lists
- DELETE unauthorized docs outside these directories

### Problem: Researcher cleanup overreach
Researcher told to "aggressively delete" docs, but unclear boundaries - could delete other agents' docs.
→ **Solution (Refinement #38, enhanced by #45)**: Explicit scope boundaries in researcher prompt.
- Cleanup authority LIMITED to `spec/` folder only (researcher's territory)
- Complete allowed list for spec/ (all researcher-owned docs)
- Explicit "NEVER touch" rule: `ongoing_changes/` directory (planner/implementor/manager territory)
- Two-directory structure (Refinement #45) makes ownership boundaries crystal clear

## Design Principles

### Core Philosophy
- **Documents are for future agents, not history** - Delete obsolete info aggressively
- **No documentation sprawl** - Use existing structure, never invent new docs
- **One task per session** - Clean boundaries, easier debugging
- **Simple > complex** - 2-3 phase specs beat 5+ phase specs
- **Tests are first-class deliverables** - Create repeatable tests that verify user experience
- **Test suite accumulation** - Each feature adds to test suite, researchers verify by running tests
- **Token efficiency** - Delegate verbose work to sub-agents, progressive disclosure
- **Code clarity over cleverness** - Simple, obvious code > clever abstractions; comments only for WHY
- **Complexity budget** - Treat complexity like precious resource; default to simple

### Document Structure

**Directory structure** (in target project, not dotfiles):
- **`ongoing_changes/`** - Temporary work-in-progress documents (deleted when work complete)
- **`spec/`** - Permanent system documentation (continuously updated, never deleted)

**Agent document ownership**:
- **Researcher** owns:
  - `spec/current_system.md` (+ `spec/system/components/*.md`, `spec/system/flows/*.md` if split)
  - `spec/diagrams/*.puml` + `*.svg` (current system diagrams)
  - `spec/feature_tests.md` (maintains/verifies)
  - `spec/research_status.md`
  - `README.md` (project root - user-facing overview, kept aligned with current_system.md)
- **Planner** owns:
  - `ongoing_changes/new_features.md`
  - `ongoing_changes/planning_status.md`
  - `ongoing_changes/questions.md`
  - `ongoing_changes/diagrams/*.puml` + `*.svg` (planned changes diagrams)
  - (reads `spec/feature_tests.md`)
- **Implementor** owns:
  - `ongoing_changes/implementor_progress.md`
  - `spec/feature_tests.md` (creates entries)
  - `README.md` (updates for user-facing feature changes only - researcher owns structure)
  - (updates `ongoing_changes/new_features.md` with completions)
- **Implementation Manager** owns:
  - `ongoing_changes/manager_progress.md`
- **Meta-Agent** owns:
  - `meta_status.md` (in dotfiles repo, not target projects)
  - All agent prompts in `~/dotfiles/claude/commands/`

### System Documentation Principle
**For current_system.md**: "Behavior and integration points clear, implementation details minimal"

Document WHAT the system does and HOW components connect - enough to plan changes without surprises, not enough to implement without reading code.

**Progressive disclosure (C4-inspired)**:
- **Level 1**: System Context (100-200 lines)
- **Level 2**: Containers/Components Overview (200-400 lines)
- **Threshold**: Keep Levels 1+2 under 500 lines in current_system.md
- **Level 3**: Component Details (split to spec/system/components/<name>.md when >150 lines)
- **Flows**: Critical multi-component flows (split to spec/system/flows/<name>.md)

**Multi-file strategy** (when Level 2 exceeds ~150 lines for any component):
- `spec/current_system.md`: Levels 1+2 overview + navigation (under 500 lines)
- `spec/system/components/<name>.md`: Level 3 component details
- `spec/system/flows/<name>.md`: Critical flow documentation
- `spec/diagrams/*.puml` + `.svg`: Visual architecture at all levels

**Analogous to planner specs**:
- Planner: "User experience clear, implementation flexible"
- Researcher: "System behavior clear, implementation minimal"

### Handoff Pattern
Agents read handoff docs from previous role:
- Planner reads `spec/current_system.md` (from researcher)
- Implementor reads `ongoing_changes/new_features.md` (from planner) + `spec/current_system.md` + `ongoing_changes/implementor_progress.md`
- Implementation Manager reads `ongoing_changes/new_features.md` (from planner) + `ongoing_changes/manager_progress.md`
- Next implementor reads `ongoing_changes/implementor_progress.md` (from previous implementor)
- Meta-agent reads `meta_status.md` (from previous meta-agent, in dotfiles)

But agents DON'T read internal progress docs from other roles:
- Planner doesn't read `spec/research_status.md`, `ongoing_changes/implementor_progress.md`, or `ongoing_changes/manager_progress.md`
- Implementor doesn't read `spec/research_status.md`, `ongoing_changes/planning_status.md`, or `ongoing_changes/manager_progress.md`
- Implementation Manager doesn't read `spec/current_system.md`, `spec/research_status.md`, `ongoing_changes/planning_status.md`, or `ongoing_changes/implementor_progress.md`
- Researcher doesn't read `ongoing_changes/implementor_progress.md`, `ongoing_changes/manager_progress.md`, or `ongoing_changes/planning_status.md`
- Meta-agent reads all for system development purposes

## Testing Approach

### Real-World Validation
All prompts tested on actual project (this looped agent system):
- Researcher explored and documented system
- Planner designed features with human collaboration
- Implementor built features incrementally
- Failures captured and fed back into prompt improvements

### Verification Process
1. Run agent with prompt
2. Observe behavior and outputs
3. Identify deviations from desired behavior
4. Update prompt with stronger guidance/examples
5. Test again
6. Iterate until behavior reliable

### Key Metrics
- Context usage (target: <50% for clean exits, hard stop at 60%)
- Document size growth (should shrink/stabilize, not grow indefinitely)
- Handoff success (next agent can pick up cleanly)
- Verification completeness (evidence provided, not just claims)

## Where to Continue

### If Refining Prompts Further
- Monitor whether agents follow documentation cleanup rules in practice
- Check if progress.md stays clean across multiple sessions
- Test implementor with various spec complexities (2-3 phases vs 5+ phases)
- Verify checkpoint reviews catch drift effectively
- Test with different coding agents (GPT-5, Gemini) if available
- Monitor researcher role adherence (documentor vs critic)

### If Using on New Projects
- Start with researcher to capture current system
- Use planner for next feature set
- Run implementor in loops for each atomic task
- Return to researcher after 2-3 implementations to verify
- Follow the cycle documented in agent_workflow.md

### If Stuck or Confused
- **agent_workflow.md** - How to use the system (user-facing)
- **meta_status.md** - This file (system state and history)
- **commands/meta-agent.md** - Meta-agent instructions
- Each agent prompt is self-contained with full instructions
- questions.md is for planner-human Q&A only

## Active Development Areas

### Recently Completed (2025-11-24)

✅ **Planner spawns researcher sub-agents** (Refinement #55) - JUST ADDED
  - Planner can autonomously spawn /research sub-agents for factual gaps
  - Clear boundary: factual questions (spawn researcher) vs design decisions (ask human)
  - Researcher updates spec/current_system.md, returns RESEARCH SUMMARY
  - RESEARCH SUMMARY format: brief answer + spec pointers + key constraints
  - Pattern: manager spawns implementors, planner spawns researchers
  - Reduces workflow friction: no human mediation for "how does it work?" questions
  - Better specs: complete system understanding before planning
  - Progressive detail: planner reads summary or drills into spec sections
  - Sub-agent mode added to researcher prompt (targeted vs comprehensive research)

✅ **Project-specific agent rules** (Refinement #54)
  - Added `.agent-rules/` directory for accumulating project-specific learnings
  - Three files: implementation.md, research.md, planning.md (agents read during entry point)
  - Agents APPEND rules when human says "add this as a rule"
  - Format: Context, Rule, How, Why, Added (simple markdown, not XML)
  - Only added when explicitly requested by human (not proactive)
  - Addresses repeated questions/mistakes on project-specific workflows
  - Example use case: Unity projects requiring domain reload after file changes via MCP
  - Inspired by Geoffrey Huntley's "stdlib" but simplified for agent-agnostic workflow
  - Benefits: Permanent project knowledge, reduces friction, captures tool workflows
  - Planner reads implementation rules to understand constraints when planning

✅ **README.md ownership** (Refinement #53)
  - Researcher now owns and must keep README.md current alongside current_system.md
  - Problem: README becomes stale while internal docs (current_system.md) stay fresh
  - Added README.md to researcher's allowed files and document ownership
  - Process step 3 now requires updating both current_system.md AND README.md
  - README.md guidance: user-facing project overview, major features, install/setup, usage, aligned with discoveries
  - Implementor role clarified: updates README for feature-specific usage, researcher owns overall structure
  - Key insight: README is "project's front door" - can't let it become outdated
  - Prevents disconnect between what's documented internally and what users see

✅ **Comment accuracy after code changes** (Refinement #51)
  - Implementor prompt strengthened to prevent comments that compare to removed code
  - Key issue: Comments describing *what changed* rather than *current state* ("less likely" - LESS THAN WHAT?)
  - Added "CRITICAL: When you change code, DELETE OR UPDATE comments that reference the old code" section
  - Explicit warning: "Especially dangerous: Comments that make comparisons to removed code"
  - Concrete bad example: "Using 37000+ (less likely to clash)" - comparison context (3000) deleted from code
  - Red flag phrases: "less/more/better/fewer than...", "now uses...", "changed to...", "improved...", "instead of..."
  - Three solution alternatives showing current facts without comparisons (not "less than", but "uses ephemeral range")
  - Key distinction: Good comments state WHAT code does NOW, not WHAT CHANGED
  - Added 4th question to comment checklist: "Does any existing comment reference what I'm changing?"
  - Prevents comments that "age like milk" - meaningless without code history
  - Forces agents to think "what does this DO" not "what did I CHANGE"

✅ **No implementation code in specs** (Refinement #50)
  - Planner prompt tightened to prevent code dumping in specifications
  - Added "ABSOLUTE RULE: NO IMPLEMENTATION CODE IN SPECS" at top of Spec Detail Level section
  - Core principle "User experience clear, implementation flexible" made prominent
  - Removed all escape hatches: no "when code is OK" section, no "key algorithms" inclusion
  - Single narrow exception: only if multiple valid interpretations produce different user-facing behavior (rare: 1 in 10 specs)
  - Concrete before/after examples: password validation, search ranking (shows BAD vs GOOD)
  - Strengthened exclusion list: NO code, NO pseudocode, NO "illustrative" examples, NO algorithms
  - Emphasis on WHAT to build and HOW IT BEHAVES, not HOW TO BUILD IT
  - Forces planner to clarify requirements instead of jumping to implementation
  - Prevents lazy planning (code dumps are easier than clear requirements)
  - Aligns with coding standards (simple > complex, clear > clever)

### Previously Completed (2025-11-20)
✅ **Verification mindset and no documentation history** (Refinement #48)
  - Researcher now has "Verification Mindset: Trust Code, Not Claims" section
  - Concrete examples of healthy skepticism (comments vs code, naming vs implementation, user claims)
  - Process: verify claims against code, ask questions when mismatch, trust code over claims
  - Enhanced "Documentation is Not History" with explicit rule: never document doc history itself
  - Clear distinction: system history OK only if it explains current constraints
  - Prevents meta-commentary about spec evolution (that's what git is for)
✅ **Diagram ownership boundaries** (Refinement #47)
  - Planner diagrams now go in `ongoing_changes/diagrams/` (temporary, shows planned changes)
  - Researcher diagrams remain in `spec/diagrams/` (permanent, shows current system)
  - Fixes violation of ownership boundaries (planner was putting diagrams in researcher's spec/ folder)
  - Temporal clarity: planned changes vs actual current state kept separate
  - Clean handoff: planner diagrams deleted after implementation, researcher documents actual result
  - Updated all references in plan.md from spec/diagrams/ to ongoing_changes/diagrams/
✅ **Aggressive sub-agent delegation for scale** (Refinement #49)
  - Researcher now has prominent "Scale Strategy" section with absolute rules for sub-agent use
  - Explicit thresholds: >5k LOC launch Explore agents, >20k LOC parallel agents, >100k LOC 5-10 agents
  - Concrete before/after examples showing context burn (bad) vs sub-agent delegation (good)
  - Parallel exploration emphasized: launch 3-5+ agents simultaneously
  - Clarified "read completely" applies to handoff docs (spec/), NOT codebase exploration
  - Updated Process section with specific guidance by codebase size
  - Default mindset: "Orchestrate research via sub-agents" not "read files yourself"
  - Enables handling codebases of ANY size while staying under 50% context

### Previously Completed (2025-11-14)
✅ **Meta-agent reads actual prompts** (Refinement #46)
  - Meta-agent now reads all four agent prompts directly (research.md, plan.md, implement.md, implementation-manager.md)
  - Never relies on secondhand information from meta_status.md descriptions
  - Prompt length becomes observable signal (if too long to read, that's a problem to fix)
  - Firsthand knowledge enables better refinement decisions
  - Can identify inconsistencies between prompts
  - Meta_status.md focuses on history/patterns, not mirroring prompt content
✅ **Directory structure clarification** (Refinement #45)
  - Two-directory structure: `ongoing_changes/` (temporary) + `spec/` (permanent)
  - Prevents documentation sprawl by limiting valid locations
  - Clear separation: work-in-progress vs permanent system knowledge
  - Planner/implementor/manager docs → `ongoing_changes/`
  - Researcher docs → `spec/`
  - Easy cleanup: delete entire `ongoing_changes/` when project phase complete
  - Clarifies that prompts in ~/dotfiles/claude/commands/ work on ANY project

### Previously Completed (2025-11-11)
✅ **Prompt verbosity reduction** (Refinement #44)
  - Consolidated "Documentation is Not History" sections (40-50 lines → 15 lines)
  - Simplified format migration instructions (40+ lines → 5 lines)
  - Condensed allowed/forbidden file lists (removed excessive symbols/explanations)
  - Removed git permissions sections (settings.json handles this)
  - ~759 lines removed across 4 prompts (~24% reduction)
  - Kept all critical teaching examples (coding standards, verification, C4)
  - Faster human review, clearer signal-to-noise for agents

### Previously Completed (2025-11-10)
✅ **Coding standards: Clarity, simplicity, complexity budget** (Refinement #43)
  - Explicit "Coding Standards - ABSOLUTE RULES" section in implementor prompt
  - Comment discipline: ONLY for non-obvious WHY, NOT for WHAT or change descriptions
  - Simplicity over cleverness: obvious structure, clear names, explicit flow
  - Complexity budget: treat like precious resource, default to simple
  - Code deletion is beautiful: every line is a liability, less is more
  - Concrete examples showing bad (clever/complex) vs good (simple/clear)
  - Aligns with atomic tasks and agent reasoning capabilities
✅ **Role clarity: Documentor, not critic** (Refinement #42)
  - Clear role boundary: researcher documents WHAT EXISTS, planner identifies WHAT SHOULD BE
  - Prevents token waste on analysis (document facts, not recommendations)
  - Prevents documentation sprawl (no IMPROVEMENTS.md, REDUNDANT_API_CALLS.md, etc.)
  - Added "Role Clarity: Documentor, Not Critic" section to research prompt
  - Example guidance: "Component X makes 3 API calls" (fact) NOT "should be refactored" (recommendation)
  - Inspired by ACE-FCA's emphasis on researcher as documentor
  - Cleaner handoff: objective facts → thoughtful design
✅ **C4-inspired progressive disclosure** (Refinement #41)
  - Systematic three-level documentation structure (Context, Containers, Components)
  - Keeps current_system.md under 500 lines (Levels 1+2), splits to component/flow docs as needed
  - 60-75% token savings: agents read only relevant detail levels
  - Completely rewrote Research agent documentation sections (cohesive, not patchwork)
  - Added efficient reading strategies to Plan and Implement agents
  - Addresses real user pain point: "docs dived in haphazardly"
  - Human comprehension benefit: gradual detail disclosure
✅ **Token usage reporting** (Refinement #40)
  - All agents now report current token usage percentage at each interaction
  - Added clear instruction to Token Budget section in all four agent prompts
  - Improves self-monitoring, user visibility, and accountability to thresholds
  - Helps users understand context consumption and make informed stopping decisions
✅ **Lowercase document filenames** (Refinement #39)
  - All documentation filenames migrated to lowercase (current_system.md, new_features.md, etc.)
  - Agent prompts updated with lowercase references
  - Migration instructions added for automatic UPPERCASE → lowercase conversion
  - Follows standard markdown file naming conventions
✅ **Researcher cleanup scope boundaries** (Refinement #38)
  - Explicit boundaries: cleanup authority LIMITED to spec/ folder only
  - Complete allowed list for spec/ (includes planner-owned docs like new_features.md)
  - Explicit "NEVER delete" list: implementor_progress.md, manager_progress.md, docs outside spec/
  - Prevents cross-agent document conflicts
  - Clarifies document ownership boundaries

### Older Completions (2025-11-05 and earlier)
✅ **Feature test registry (feature_tests.md)** - (Refinement #37)
✅ **Repeatable test suite framework** - (Refinement #36)
✅ **Diagram files with SVG generation**
✅ **Context usage tracking**
✅ **Settings.json permissions**
✅ **Implementation Manager (autonomous multi-task orchestration)**
✅ **Slash command integration** - Claude Code CLI integration via dotfiles
✅ **Context threshold optimization** - Aligned with ACE-FCA proven thresholds
✅ **UML/PlantUML diagram integration** - Visual architecture documentation
✅ **YAML frontmatter metadata** - Traceability and status tracking
✅ **Document format migration rule** - Automatic updates to latest standards
✅ Agent-agnostic terminology (supports Claude, GPT-5, Gemini, etc.)
✅ Split workflow docs (agent_workflow.md for users, commands/meta-agent.md for meta-development)
✅ No documentation sprawl rules (explicit allowed lists, DELETE unauthorized docs)
✅ System documentation principles (behavior/integration focus, multi-file strategy for large systems)
✅ Proof-required testing (paste actual terminal output, no claims without evidence)
✅ Comprehensive system doc guidelines for researchers (when to split, what to include/exclude)

### Current Status
**System is stable and production-ready.** Enhanced with autonomous Implementation Manager for multi-task orchestration, visual documentation, metadata tracking, and slash command integration. Prompts now live in `~/dotfiles/claude/commands/` for easy deployment. Continue monitoring agent behavior in real usage. Document new failure patterns as they emerge.

**Major workflow improvement**: Implementation Manager eliminates human friction between tasks while maintaining our paranoid testing requirements.

**Deployment**: No install script needed. Prompts are in dotfiles and automatically available via `~/.claude/commands` symlink.

### Known Issues to Monitor

**Recent Refinements (41-55):**
- Ref #55 (Planner spawns researchers): Does planner spawn researcher for factual gaps vs ask human for decisions? Does planner use Task tool correctly with RESEARCH SUMMARY prompt? Does researcher return proper RESEARCH SUMMARY format (question, answer, spec updates with line numbers, key constraints)? Does researcher update spec/current_system.md before returning summary? Does planner read summary and continue, or read referenced spec sections for detail? Does this reduce friction for factual questions? Do planners still ask humans for design decisions?
- Ref #54 (Project rules): Do agents read `.agent-rules/` during entry point? Do they APPEND (not rewrite)? Only add when human explicitly requests? Do rules use absolute language? Does planner read implementation rules to understand constraints? Do rules accumulate properly across sessions?
- Ref #53 (README ownership): Does researcher keep README.md current alongside current_system.md? Is README user-facing and aligned with discoveries? Does implementor respect researcher's overall structure?
- Ref #51 (Comment accuracy): Do comments avoid comparisons to removed code ("less/more than...")? State current facts, not what changed?
- Ref #50 (No code in specs): Do planners avoid dumping implementation code? Focus on WHAT/HOW IT BEHAVES vs HOW TO BUILD?
- Ref #49 (Sub-agent delegation): Does researcher use sub-agents aggressively? Launch 5-10 parallel agents for >100k LOC codebases? Stay <50% context?
- Ref #48 (Verification mindset): Does researcher trust code over claims? Avoid documenting documentation history?
- Ref #47 (Diagram ownership): Planners use `ongoing_changes/diagrams/`, researchers use `spec/diagrams/`?
- Ref #46 (Meta reads prompts): Does meta-agent read all four prompts directly?
- Ref #45 (Directory structure): Do agents respect `ongoing_changes/` (temporary) vs `spec/` (permanent) boundaries? No unauthorized docs elsewhere?
- Ref #44 (Prompt verbosity): Are prompts more efficient? Did reduction harm anything?
- Ref #43 (Coding standards): Do implementors follow Simple > Complex, Clear > Clever? Comments only for WHY? Treat complexity as precious?
- Ref #42 (Documentor role): Does researcher stay in documentor role (facts) vs critic role (recommendations)? No IMPROVEMENTS.md files?
- Ref #41 (C4 progressive disclosure): Do researchers keep Levels 1+2 <500 lines? Split to Level 3 appropriately? Do agents read only relevant levels? 60-75% token savings achieved?

**Core System (Refinements 28-40):**
- Token usage reporting: Do agents report context % at each interaction?
- Repeatable tests (Ref #36): Do implementors CREATE repeatable tests (not just test once)? Verify end-to-end user experience? Run regression checks?
- Feature test registry (Ref #37): Do implementors add to feature_tests.md? Do researchers use it as test checklist?
- Paste output rule: Do agents paste actual terminal output (not just claim they tested)?
- PlantUML diagrams: Do agents create separate .puml files and generate SVGs correctly?
- YAML frontmatter: Do agents update metadata each session?
- Document cleanup: Do researchers only delete in spec/ folder (not implementor_progress.md, manager_progress.md)?
- Implementation Manager: Does manager delegate properly? Maintain minimal context (<30%)? Handle restarts gracefully?
- Context usage tracking: Do implementors report final context? Does manager aggregate data? Does planner use historical data to calibrate tasks?

**Fundamental Patterns (Refinements 1-27):**
- ONE task per implementor session: Do implementors STOP after one task?
- Follow spec literally: Do implementors ask when unclear vs reinterpreting?
- Documentation is not history: Do agents REWRITE (not append)? Delete obsolete info?
- Documentation sprawl: Do agents create unauthorized docs, or stick to allowed lists?
- questions.md cleanup: Does planner delete answered questions immediately?

### Future Considerations
- Additional agent types (e.g., reviewer, tester)?
- Cross-project learnings (how to share patterns between projects)?
- Better context usage analytics?
- Automated drift detection?
- Testing framework for agent behavior validation?
- Hybrid modes (careful vs flow)?
