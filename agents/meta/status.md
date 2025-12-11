# Meta-Agent System Status

---
last_updated: 2025-12-10
git_commit: 076fc9f
refinement_count: 62
status: production-ready
recent_focus: documentation_navigation_and_diagrams
agent_count: 5
---

## Current State (2025-12-10)

### Status: Production-Ready with Optimized Prompt Efficiency

**Agent prompts**: 62 refinements applied through iterative testing
**Deployment**: Prompts in ~/dotfiles/agents/commands/ (invoked via `/research`, `/planning-agent`, `/implement`, `/implementation-manager` in any project)
**Testing**: All agents tested on real projects, failures documented and addressed
**Documentation**: Complete workflow documentation split (agent_workflow.md for users, commands/meta-agent.md for meta-development)
**Recent focus**: Documentation efficiency - only document non-obvious information

### What's Working

✅ **Researcher**: Clean handoffs, scales to massive codebases via aggressive sub-agent delegation, comprehensive system documentation with inline Mermaid diagrams, test suite verification, documentor role (facts, not recommendations), verification mindset (trust code over claims), no documentation history meta-commentary, optional doc quality verification
✅ **Planner**: Interactive collaboration via questions.md, visual planning with change-highlighted diagrams, verification strategy in specs, absolute no-code rule (user experience clear, implementation flexible)
✅ **Implementor**: Clear task boundaries, repeatable test creation requirements, end-to-end verification focus
✅ **Implementation Manager**: Autonomous multi-task orchestration via sub-agents (Refinement #32)
  - Eliminates human friction between tasks
  - Minimal context (stays <30% throughout)
  - Continues until done, blocked, or context limit
  - Manager-worker pattern: delegates to `/implement` sub-agents
  - Graceful restart handling via manager-progress.md
✅ **Sub-agent delegation**: Only results return to context (not exploration process)
✅ **Document structure**: Clear ownership, no sprawl (explicit allowed lists)
✅ **Token efficiency**: Optimized to 40-60% (aligned with ACE-FCA proven thresholds)
✅ **Agent-agnostic**: Works with Claude, GPT-5, Gemini, etc.
✅ **System documentation**: C4 model with "skip empty diagrams" principle, multi-file strategy for large systems
✅ **Repeatable test suites**: Tests as first-class deliverables (scripts/automated/documented procedures)
✅ **Test suite verification**: Researcher runs tests to verify system state, not just reads code
✅ **End-to-end testing**: Tests verify user experience, not just "code exists"
✅ **Proof-required testing**: Implementors must paste actual terminal output as verification
✅ **Visual architecture**: Inline Mermaid diagrams for components, sequences, and interfaces
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

**See `meta-history.md` for detailed archive of refinements 1-40.**

**Key patterns established:**
- Documentation discipline (REWRITE not append, delete obsolete info, docs for future agents)
- Testing discipline (paste output, create repeatable tests, end-to-end verification, regression checks)
- Context management (40-50% wrap up, 60% hard stop, sub-agent delegation, progressive disclosure)
- Agent boundaries (ONE task per implementor, clear document ownership, follow spec literally)
- System integration (slash commands, settings.json permissions, Implementation Manager, YAML frontmatter)
### Recent Refinements 41-53 (2025-11-10 to 2025-11-21)

41. **Progressive disclosure** - Multi-level documentation structure. Overview in current-system.md (<500 lines), details split to components/flows. 60-75% token savings for typical tasks. (Enhanced with full C4 model in Refinement #59.)

42. **Role clarity: Documentor, not critic** - Researcher documents WHAT EXISTS (facts), planner identifies WHAT SHOULD BE (improvements). Prevents recommendation docs (IMPROVEMENTS.md, etc.).

43. **Coding standards: Clarity, simplicity, complexity budget** - Simple > Complex, Clear > Clever, Delete > Keep. Comments only for WHY (not WHAT), complexity as precious resource, code deletion is beautiful.

44. **Prompt verbosity reduction** - ~759 lines removed across 4 prompts (~24% reduction). Consolidated repetitive sections while keeping critical teaching examples.

45. **Directory structure clarification** - Two-directory structure: `ongoing-changes/` (temporary WIP) + `spec/` (permanent docs). Prevents sprawl, clear ownership boundaries.

46. **Meta-agent reads actual prompts** - Always read all four agent prompts directly, not secondhand from meta-status.md. Prompt length becomes observable signal.

47. **Diagram ownership boundaries** - Planner diagrams in `ongoing-changes/diagrams/` (planned changes), researcher diagrams in `spec/diagrams/` (current system).

48. **Verification mindset and no documentation history** - Trust code, not claims. Never document the history of documentation itself (git tracks that).

49. **Aggressive sub-agent delegation for scale** - Explicit thresholds by codebase size. >100k LOC: 5-10 parallel sub-agents. Enables handling any codebase size while staying <50% context.

50. **No implementation code in specs** - ABSOLUTE RULE with no escape hatches. Specs define WHAT to build and HOW IT BEHAVES, not HOW TO BUILD IT. Prevents code dumps.

51. **Comment accuracy after code changes** - Delete/update comments that reference removed code. Avoid comparative phrases ("less/more/better than..."). Comments state WHAT code does NOW, not WHAT CHANGED.

52. **Instruction consolidation (meta-agent)** - Archived refinements 1-40 to meta-history.md (~400 lines saved). Compressed ACE-FCA comparison to summary with link (~120 lines saved). Consolidated "Known Issues to Monitor" from 109 questions to 30 organized by refinement group (~80 lines saved). Total ~600 lines removed from meta-status.md.

53. **README.md ownership (researcher)** - Researcher now owns and maintains project README.md alongside current-system.md. Problem: Researchers create comprehensive system docs but never update the user-facing README, causing it to become stale. Solution: Added README.md to researcher's allowed file list and document ownership. Added explicit section in Process step 3 requiring README.md updates aligned with current-system.md findings. Updated implementor prompt to clarify researcher owns overall README structure, implementor only updates for feature-specific usage changes. Prevents "project front door" from becoming outdated while internal docs stay current.

54. **Project-specific agent rules** - Added `.agent-rules/` directory concept for accumulating project-specific learnings. Problem: Every project has unique workflows, gotchas, and constraints that agents must learn repeatedly (e.g., "reload Unity domain after file changes", "never allocate ports 9000-9010"). Without persistent rules, agents ask same questions every session or make same mistakes. Solution: Created `.agent-rules/{implementation,research,planning}.md` files that agents read during entry point and can APPEND to when human says "add this as a rule". Format: Context, Rule, How, Why, Added. Rules use absolute language ("ALWAYS", "NEVER", "MUST"). Only added when human explicitly requests. APPEND-ONLY to accumulate knowledge. Inspired by Geoffrey Huntley's "stdlib" concept but simplified for our agent-agnostic workflow (no XML, no auto-execution, just markdown rules agents read and apply). Benefits: (1) Permanent project knowledge, (2) Reduces repeated clarifications, (3) Captures tool-specific workflows, (4) Accumulates like feature-tests.md. Each agent reads its own rules file plus planner reads implementation rules to understand constraints. Addresses real user need: Unity project requiring specific MCP server calls after file changes.

55. **Planner spawns researcher sub-agents** - Planner can now autonomously spawn researcher sub-agents to fill factual gaps about current system. Problem: During planning, planner discovers gaps in system understanding ("How does auth work?", "What's the DB schema?"). Previously required human to manually invoke /research, update spec, then re-invoke /plan - friction in the workflow. Solution: Added "Spawning Research Sub-Agents for Factual Gaps" section to planner prompt (~120 lines). Clear boundary: spawn researcher for FACTUAL gaps (how system works), ask human in questions.md for DECISIONAL matters (what to build, priorities, business rules). Planner uses Task tool to spawn researcher with specific question. Researcher investigates, updates spec/current-system.md (spec remains source of truth), returns RESEARCH SUMMARY (brief answer + spec pointers + key constraints). Planner reads brief answer to continue, or reads referenced spec sections for deeper detail. Added "Sub-Agent Mode" section to researcher prompt (~100 lines) defining RESEARCH SUMMARY format and targeted research behavior. Pattern consistent with Implementation Manager (manager spawns implementors, planner spawns researchers). Benefits: (1) Autonomous factual research - no human friction for "how does it work" questions, (2) Better specs - complete understanding before planning, (3) Spec always updated - permanent benefit for all agents, (4) Progressive detail - planner controls depth via summary vs full spec sections. Example: Planner asks "How does auth middleware work?" → researcher investigates → updates spec with auth flow + diagram → returns summary → planner continues with complete understanding. Reduces "I think it works like X" → later discovery it's Y. Human focuses on design decisions, researcher handles facts about current system.

56. **Prompt verbosity reduction (round 2)** - Removed verbose teaching content while preserving critical behavioral rules. Problem: Prompts approaching 1000+ lines fighting base model training on documentation-as-history. User feedback: agents still miss "don't keep history" despite heavy instruction, PlantUML syntax examples not needed (added by previous meta-agent, not battle-tested). Solution: Removed ~335 lines total: (1) PlantUML syntax examples from research.md and plan.md (~230 lines) - replaced with brief workflow + link to plantuml.com, kept instructions to USE diagrams and generate SVGs. (2) Compressed verbose "bad example" demonstrations in project rules sections (~50 lines) - kept teaching contrast but made more concise. (3) Streamlined repetitive sections (~55 lines). **Kept "Documentation is Not History" sections LOUD and prominent** - this fights base model training so cannot be diluted. Results: research.md 1366→1144 lines (16% reduction), plan.md 1024→915 lines (11% reduction), implement.md 1116→1102 lines (1% reduction), implementation-manager.md unchanged at 388 lines (already tight). Total: ~345 lines removed while strengthening anti-history guidance and preserving all critical behavioral instructions (coding standards examples, verification requirements, absolute rules).

57. **Comments: last resort, not default** - Compressed and reframed comment guidance. Problem: (1) Implementor wrote `"not in Assets"` - negation that only makes sense knowing old code. (2) Previous guidance was 140 lines of examples, fighting verbosity with verbosity. Solution: Rewrote entire comment section to ~30 lines. New framing: "A comment is an admission that the code isn't clear enough." Comments are last resort after trying to make code self-explanatory. Three rules: (1) comments must stand alone, (2) no comparatives/negations, (3) check existing comments when changing code. One concrete example (the Unity case). One valid use case (external constraints). Removed all redundant examples. Key philosophy shift: comments aren't just "for WHY not WHAT" - they're a failure to write clear code.

58. **spec/README.md ownership clarification** - Made clear that only the meta-agent owns `spec/README.md`. Problem: Agents might modify the spec/README.md documentation standards file during their work, corrupting the template. Solution: (1) Added "NEVER modify `spec/README.md`" to researcher's allowed files section with explanation that meta-agent owns it. (2) Added "(READ ONLY - do not modify)" to entry point instructions in research.md, plan.md, and implement.md. (3) Added warning header to spec-README-template.md: "⚠️ DO NOT MODIFY THIS FILE". (4) Added spec/README.md ownership section to workflow.md document ownership table. Key principle: spec/README.md is a standards template that travels with projects - if conventions need changing, update the source template in dotfiles, not individual project copies.

59. **C4 with "skip empty diagrams" principle** - Adopted full C4 model with explicit guidance on when to skip levels. Problem: Previous "C4-inspired" framing was vague - agents didn't know when to include/skip diagram levels. Solution: (1) New core principle: "Document the system efficiently. Skip diagrams that add no information." (2) Full C4 levels explained (Context, Containers, Components, Code) with explicit "Include when" and "Skip when" for each. (3) Additional diagram types (class, sequence, state) with clear inclusion criteria. (4) Summary table showing when to include vs skip each diagram type. (5) Key insight: A container diagram with one container wastes tokens, but simple apps still need documentation - just appropriately sized. Right-size documentation to match system complexity.

60. **Remove feature-tests.md** - Removed underspecified feature test registry. Problem: feature-tests.md was underspecified and duplicated what test suites already do. Projects with automated tests don't need a separate registry - the test files ARE the registry. Running `pytest` or `npm test` is the verification. The concept wasn't battle-tested and agents weren't reliably using it. Solution: (1) Removed feature-tests.md from spec-README-template.md file structure. (2) Removed from researcher's owned files, entry point, and test verification section. (3) Removed from planner's read files and verification strategy examples. (4) Removed from implementor's owned files and "Step E" documentation section. (5) Updated meta/status.md document ownership. Key insight: Testing discipline (Ref #36) remains - implementors still create repeatable tests and paste output as proof. We just removed the separate registry file that was redundant with actual test suites. May revisit feature/test documentation in future with clearer specification.

61. **Documentation quality verification** - Added optional verification step for comprehensive research sessions. Problem: How do you know if documentation is actually good? Docs might capture facts but miss conceptual understanding planners need. Solution: Added "Optional: Documentation Quality Verification" section to researcher prompt (~35 lines). Process: (1) Fresh agent poses 3-5 questions about system behavior/architecture. (2) Answers from docs only, written to `spec/doc-verification.md`. (3) Verifies each answer against code. (4) Evaluates using 2x2 matrix: gap type (low-level vs conceptual) × fill difficulty (easy vs hard). (5) Updates docs based on findings. Success criteria: gaps are low-level AND easy to fill from code - this means docs captured conceptual understanding, leaving implementation details to code (which is correct). Added `spec/doc-verification.md` to researcher's allowed files. Key insight from user experiment: Testing "can you fill gaps from code" validates that docs focus on architecture/intent/mental models while letting code be source of truth for implementation. Not mandatory - use after comprehensive research, not targeted queries.

62. **Summary + link navigation and diagram arrows** - Restructured spec-README-template.md to emphasize progressive disclosure through linked documents. Problem: (1) Readers skim overview docs and risk missing important details buried in sub-documents. (2) Diagram arrows often just show "relationship exists" without explaining what flows. Solution: (1) Added "Core Principle: Summary + Link" section with concrete example showing pattern. Key insight: "If something in the detail doc would surprise someone who only read the summary, the summary is incomplete." (2) Enhanced diagram guidance to cover arrows, not just nodes: label what flows/happens, not that a relationship exists. Added test: "Could someone unfamiliar with the codebase understand the flow from the diagram alone?" (3) Consolidated C4 section from 4 subsections to single table, merged Progressive Disclosure into file structure. Result: Template went from 145 to 126 lines while adding new guidance. Benefits: Confident scanning without fear of missing something, meaningful diagrams that explain the system.

**See git history for full chronological details.**

## Convergent Evolution: ACE-FCA (2025-11-09)

We independently converged on ~80-85% the same solution as HumanLayer's "Advanced Context Engineering for Coding Agents" (ACE-FCA). **Strong validation that we're solving the problem correctly.**

**Key insight**: The bottleneck in AI coding is context management, not model capability.

**What we adopted from them**: Context thresholds (40-50% wrap up, 60% hard stop), YAML frontmatter, visual diagrams (now using Mermaid instead of PlantUML).

**Our unique strengths**: Implementation Manager (autonomous flow via sub-agents), comprehensive current-system.md (works on unfamiliar codebases), explicit "paste output" rule (we discovered agents fake testing), agent-agnostic design.

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
→ **Solution**: Token budget monitoring (40-50% wrap up, 60% hard stop) + sub-agent delegation + progressive disclosure.

### Problem: Documentation sprawl
Agents invent new docs (SESSION_SUMMARY.md, NOTES.md, etc.) instead of using existing structure.
→ **Solution (Refinement #45)**: Two-directory structure with clear boundaries
- Only two valid locations: `ongoing-changes/` (temporary) and `spec/` (permanent)
- "No Documentation Sprawl" section in all prompts with explicit allowed lists
- DELETE unauthorized docs outside these directories

### Problem: Researcher cleanup overreach
Researcher told to "aggressively delete" docs, but unclear boundaries - could delete other agents' docs.
→ **Solution (Refinement #38, enhanced by #45)**: Explicit scope boundaries in researcher prompt.
- Cleanup authority LIMITED to `spec/` folder only (researcher's territory)
- Complete allowed list for spec/ (all researcher-owned docs)
- Explicit "NEVER touch" rule: `ongoing-changes/` directory (planner/implementor/manager territory)
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
- **`ongoing-changes/`** - Temporary work-in-progress documents (deleted when work complete)
- **`spec/`** - Permanent system documentation (continuously updated, never deleted)

**Agent document ownership**:
- **Researcher** owns:
  - `spec/current-system.md` (+ `spec/system/components/*.md`, `spec/system/flows/*.md` if split)
  - `spec/research-status.md`
  - `README.md` (project root - user-facing overview, kept aligned with current-system.md)
- **Planner** owns:
  - `ongoing-changes/new-features.md`
  - `ongoing-changes/planning-status.md`
  - `ongoing-changes/questions.md`
- **Implementor** owns:
  - `ongoing-changes/implementor-progress.md`
  - `README.md` (updates for user-facing feature changes only - researcher owns structure)
  - (updates `ongoing-changes/new-features.md` with completions)
- **Implementation Manager** owns:
  - `ongoing-changes/manager-progress.md`
- **Meta-Agent** owns:
  - `meta/status.md` (in dotfiles repo, not target projects)
  - All agent prompts in `~/dotfiles/agents/commands/`

### System Documentation Principle
**For current-system.md**: "Document the system efficiently. Skip diagrams that add no information."

Follow C4 model (Context → Containers → Components → Code) but skip any level that adds no information. A container diagram with one container wastes tokens, but simple apps still need documentation - just appropriately sized.

**C4 Levels**:
- **Level 1: Context** - System + external dependencies (skip if no external systems)
- **Level 2: Containers** - Deployable units (skip if single container)
- **Level 3: Components** - Major building blocks within containers
- **Level 4: Code** - Class diagrams, data models (when not covered at higher levels)

**Additional diagrams**: Class/domain models, sequence flows, state diagrams - include when they add value not shown at higher levels.

**Threshold**: Keep current-system.md under 500 lines. Split when any component needs >150 lines.

**The test**: "Could someone plan a new feature without missing critical constraints or breaking existing behavior?"

### Handoff Pattern
Agents read handoff docs from previous role:
- Planner reads `spec/current-system.md` (from researcher)
- Implementor reads `ongoing-changes/new-features.md` (from planner) + `spec/current-system.md` + `ongoing-changes/implementor-progress.md`
- Implementation Manager reads `ongoing-changes/new-features.md` (from planner) + `ongoing-changes/manager-progress.md`
- Next implementor reads `ongoing-changes/implementor-progress.md` (from previous implementor)
- Meta-agent reads `meta-status.md` (from previous meta-agent, in dotfiles)

But agents DON'T read internal progress docs from other roles:
- Planner doesn't read `spec/research-status.md`, `ongoing-changes/implementor-progress.md`, or `ongoing-changes/manager-progress.md`
- Implementor doesn't read `spec/research-status.md`, `ongoing-changes/planning-status.md`, or `ongoing-changes/manager-progress.md`
- Implementation Manager doesn't read `spec/current-system.md`, `spec/research-status.md`, `ongoing-changes/planning-status.md`, or `ongoing-changes/implementor-progress.md`
- Researcher doesn't read `ongoing-changes/implementor-progress.md`, `ongoing-changes/manager-progress.md`, or `ongoing-changes/planning-status.md`
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
- **meta-status.md** - This file (system state and history)
- **commands/meta-agent.md** - Meta-agent instructions
- Each agent prompt is self-contained with full instructions
- questions.md is for planner-human Q&A only

## Active Development Areas

### Recently Completed (2025-12-10)

✅ **Summary + link navigation and diagram arrows** (Refinement #62)
  - Added "Core Principle: Summary + Link" section with concrete example
  - Key insight: If detail doc would surprise someone who only read summary, summary is incomplete
  - Enhanced diagram guidance: arrows must label what flows, not just that relationship exists
  - Added diagram test: "Could someone unfamiliar understand the flow from diagram alone?"
  - Consolidated C4 from 4 subsections to single table, merged Progressive Disclosure into file structure
  - Template reduced from 145 to 126 lines while adding new guidance

✅ **Documentation quality verification** (Refinement #61)
  - Optional verification step for comprehensive research sessions
  - Fresh agent poses 3-5 questions, answers from docs only, then verifies against code
  - 2x2 evaluation matrix: gap type (low-level vs conceptual) × fill difficulty (easy vs hard)
  - Success criteria: gaps are low-level AND easy to fill = docs captured conceptual understanding
  - Key insight: Validates that docs focus on architecture/intent, leaving implementation to code
  - Not mandatory - diagnostic tool for comprehensive research, not targeted queries

✅ **Remove feature-tests.md** (Refinement #60)
  - Removed underspecified feature test registry
  - Problem: Duplicated what test suites already do, wasn't battle-tested
  - Testing discipline (Ref #36) remains - implementors still create repeatable tests
  - May revisit with clearer specification in future

✅ **C4 with "skip empty diagrams" principle** (Refinement #59)
  - Adopted full C4 model with explicit guidance on when to skip levels
  - Each C4 level has "Include when" and "Skip when"
  - Summary table for quick reference

✅ **spec/README.md ownership clarification** (Refinement #58)
  - Only meta-agent owns spec/README.md (template file for documentation standards)
  - Added "NEVER modify" warnings to researcher, planner, implementor entry points
  - Added warning header to spec-README-template.md source file
  - Key: If conventions need changing, update source template in dotfiles, not project copies

### Previously Completed (2025-11-25)

✅ **Comments: last resort, not default** (Refinement #57)
  - Reframed: "A comment is an admission that the code isn't clear enough"
  - Compressed from ~140 lines to ~30 lines (same rules, less verbosity)
  - Three rules: stand alone, no comparatives/negations, check when changing code
  - One example (Unity "not in Assets" case), one valid use (external constraints)
  - Philosophy shift: comments are failure to write clear code, not just "for WHY"

✅ **Prompt verbosity reduction (round 2)** (Refinement #56)
  - Removed ~345 lines across agent prompts while preserving critical behavioral rules
  - Removed PlantUML syntax examples (research.md, plan.md) - kept workflow + link to docs
  - Compressed verbose project rules "bad examples" - kept teaching value, reduced tokens
  - **"Documentation is Not History" sections kept LOUD** - fights base model training
  - Results: research.md 16% shorter, plan.md 11% shorter, implement.md 1% shorter
  - Preserves all critical instructions: coding standards, verification requirements, absolute rules
  - Focus: compress teaching examples, strengthen anti-history guidance

✅ **Planner spawns researcher sub-agents** (Refinement #55)
  - Planner can autonomously spawn /research sub-agents for factual gaps
  - Clear boundary: factual questions (spawn researcher) vs design decisions (ask human)
  - Researcher updates spec/current-system.md, returns RESEARCH SUMMARY
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
  - Researcher now owns and must keep README.md current alongside current-system.md
  - Problem: README becomes stale while internal docs (current-system.md) stay fresh
  - Added README.md to researcher's allowed files and document ownership
  - Process step 3 now requires updating both current-system.md AND README.md
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
  - Planner diagrams now go in `ongoing-changes/diagrams/` (temporary, shows planned changes)
  - Researcher diagrams remain in `spec/diagrams/` (permanent, shows current system)
  - Fixes violation of ownership boundaries (planner was putting diagrams in researcher's spec/ folder)
  - Temporal clarity: planned changes vs actual current state kept separate
  - Clean handoff: planner diagrams deleted after implementation, researcher documents actual result
  - Updated all references in plan.md from spec/diagrams/ to ongoing-changes/diagrams/
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
  - Never relies on secondhand information from meta-status.md descriptions
  - Prompt length becomes observable signal (if too long to read, that's a problem to fix)
  - Firsthand knowledge enables better refinement decisions
  - Can identify inconsistencies between prompts
  - meta-status.md focuses on history/patterns, not mirroring prompt content
✅ **Directory structure clarification** (Refinement #45)
  - Two-directory structure: `ongoing-changes/` (temporary) + `spec/` (permanent)
  - Prevents documentation sprawl by limiting valid locations
  - Clear separation: work-in-progress vs permanent system knowledge
  - Planner/implementor/manager docs → `ongoing-changes/`
  - Researcher docs → `spec/`
  - Easy cleanup: delete entire `ongoing-changes/` when project phase complete
  - Clarifies that prompts in ~/dotfiles/agents/commands/ work on ANY project

### Previously Completed (2025-11-11)
✅ **Prompt verbosity reduction** (Refinement #44)
  - Consolidated "Documentation is Not History" sections (40-50 lines → 15 lines)
  - Simplified format migration instructions (40+ lines → 5 lines)
  - Condensed allowed/forbidden file lists (removed excessive symbols/explanations)
  - Removed git permissions sections (settings.json handles this)
  - ~759 lines removed across 4 prompts (~24% reduction)
  - Kept all critical teaching examples (coding standards, verification, progressive disclosure)
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
✅ **Progressive disclosure** (Refinement #41, enhanced in #59)
  - Multi-level documentation structure following C4 model
  - Keeps current-system.md under 500 lines, splits to component/flow docs as needed
  - 60-75% token savings: agents read only relevant detail levels
  - Enhanced in #59 with full C4 levels and explicit "skip when" guidance
✅ **Token usage reporting** (Refinement #40)
  - All agents now report current token usage percentage at each interaction
  - Added clear instruction to Token Budget section in all four agent prompts
  - Improves self-monitoring, user visibility, and accountability to thresholds
  - Helps users understand context consumption and make informed stopping decisions
✅ **Lowercase document filenames** (Refinement #39)
  - All documentation filenames migrated to lowercase (current-system.md, new-features.md, etc.)
  - Agent prompts updated with lowercase references
  - Migration instructions added for automatic UPPERCASE → lowercase conversion
  - Follows standard markdown file naming conventions
✅ **Researcher cleanup scope boundaries** (Refinement #38)
  - Explicit boundaries: cleanup authority LIMITED to spec/ folder only
  - Complete allowed list for spec/ (includes planner-owned docs like new-features.md)
  - Explicit "NEVER delete" list: implementor-progress.md, manager-progress.md, docs outside spec/
  - Prevents cross-agent document conflicts
  - Clarifies document ownership boundaries

### Older Completions (2025-11-05 and earlier)
✅ **Repeatable test suite framework** - (Refinement #36) (Note: feature-tests.md removed in Refinement #60)
✅ **Diagram files with SVG generation**
✅ **Context usage tracking**
✅ **Settings.json permissions**
✅ **Implementation Manager (autonomous multi-task orchestration)**
✅ **Slash command integration** - Claude Code CLI integration via dotfiles
✅ **Context threshold optimization** - Aligned with ACE-FCA proven thresholds
✅ **Mermaid diagram integration** - Inline visual architecture documentation
✅ **YAML frontmatter metadata** - Traceability and status tracking
✅ **Document format migration rule** - Automatic updates to latest standards
✅ Agent-agnostic terminology (supports Claude, GPT-5, Gemini, etc.)
✅ Split workflow docs (agent_workflow.md for users, commands/meta-agent.md for meta-development)
✅ No documentation sprawl rules (explicit allowed lists, DELETE unauthorized docs)
✅ System documentation principles (behavior/integration focus, multi-file strategy for large systems)
✅ Proof-required testing (paste actual terminal output, no claims without evidence)
✅ Comprehensive system doc guidelines for researchers (when to split, what to include/exclude)

### Current Status
**System is stable and production-ready.** Enhanced with autonomous Implementation Manager for multi-task orchestration, visual documentation, metadata tracking, and slash command integration. Prompts now live in `~/dotfiles/agents/commands/` for easy deployment. Continue monitoring agent behavior in real usage. Document new failure patterns as they emerge.

**Major workflow improvement**: Implementation Manager eliminates human friction between tasks while maintaining our paranoid testing requirements.

**Deployment**: Prompts are in `~/dotfiles/agents/commands/` and symlinked to `~/.claude/commands` for availability in any project.

### Known Issues to Monitor

**Recent Refinements (41-62):**
- Ref #62 (Summary + link, diagram arrows): Do researchers write summaries that surface important points? Are detail docs free of surprises not in the summary? Do diagram arrows explain what flows (not just "relationship exists")? Could someone unfamiliar understand diagrams alone?
- Ref #61 (Doc quality verification): Do researchers use verification for comprehensive sessions? Does fresh agent approach work? Does 2x2 matrix help identify doc gaps? Do researchers update docs based on findings? Is it useful as diagnostic without being mandatory overhead?
- Ref #59 (C4 skip empty diagrams): Do agents use full C4 levels appropriately? Do they skip container diagrams for single-container apps? Do they include class/sequence/state diagrams when they add value? Is documentation right-sized for system complexity?
- Ref #58 (spec/README.md ownership): Do agents avoid modifying spec/README.md? Do they copy template correctly when missing? If conventions need updating, do they ask human to update source template?
- Ref #57 (Comments last resort): Are comments rare? Do agents try to make code self-explanatory first? Do comments avoid comparatives/negations? Are comments treated as failure to write clear code?
- Ref #56 (Prompt compression round 2): Do agents still follow critical behavioral instructions after compression? **CRITICAL: Do agents still avoid documentation-as-history (this fights base model training)?** Do agents create Mermaid diagrams inline (workflow preserved)? Do agents read project-specific rules (format simplified)? Did compression harm any critical behaviors?
- Ref #55 (Planner spawns researchers): Does planner spawn researcher for factual gaps vs ask human for decisions? Does planner use Task tool correctly with RESEARCH SUMMARY prompt? Does researcher return proper RESEARCH SUMMARY format (question, answer, spec updates with line numbers, key constraints)? Does researcher update spec/current-system.md before returning summary? Does planner read summary and continue, or read referenced spec sections for detail? Does this reduce friction for factual questions? Do planners still ask humans for design decisions?
- Ref #54 (Project rules): Do agents read `.agent-rules/` during entry point? Do they APPEND (not rewrite)? Only add when human explicitly requests? Do rules use absolute language? Does planner read implementation rules to understand constraints? Do rules accumulate properly across sessions?
- Ref #53 (README ownership): Does researcher keep README.md current alongside current-system.md? Is README user-facing and aligned with discoveries? Does implementor respect researcher's overall structure?
- Ref #51 (Comment accuracy): Do comments avoid comparisons to removed code ("less/more than...")? State current facts, not what changed?
- Ref #50 (No code in specs): Do planners avoid dumping implementation code? Focus on WHAT/HOW IT BEHAVES vs HOW TO BUILD?
- Ref #49 (Sub-agent delegation): Does researcher use sub-agents aggressively? Launch 5-10 parallel agents for >100k LOC codebases? Stay <50% context?
- Ref #48 (Verification mindset): Does researcher trust code over claims? Avoid documenting documentation history?
- Ref #47 (Diagram ownership): Diagrams inline in relevant markdown files (Mermaid syntax)?
- Ref #46 (Meta reads prompts): Does meta-agent read all four prompts directly?
- Ref #45 (Directory structure): Do agents respect `ongoing-changes/` (temporary) vs `spec/` (permanent) boundaries? No unauthorized docs elsewhere?
- Ref #44 (Prompt verbosity): Are prompts more efficient? Did reduction harm anything?
- Ref #43 (Coding standards): Do implementors follow Simple > Complex, Clear > Clever? Comments only for WHY? Treat complexity as precious?
- Ref #42 (Documentor role): Does researcher stay in documentor role (facts) vs critic role (recommendations)? No IMPROVEMENTS.md files?
- Ref #41 (Progressive disclosure): Do researchers keep overview <500 lines? Split to detail files appropriately? Do agents read only relevant levels? (Enhanced by Ref #59 with full C4)

**Core System (Refinements 28-40):**
- Token usage reporting: Do agents report context % at each interaction?
- Repeatable tests (Ref #36): Do implementors CREATE repeatable tests (not just test once)? Verify end-to-end user experience? Run regression checks?
- (Ref #37 removed - feature-tests.md deprecated in Refinement #60)
- Paste output rule: Do agents paste actual terminal output (not just claim they tested)?
- Mermaid diagrams: Do agents create inline diagrams in markdown files?
- YAML frontmatter: Do agents update metadata each session?
- Document cleanup: Do researchers only delete in spec/ folder (not implementor-progress.md, manager-progress.md)?
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
