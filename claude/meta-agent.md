# Meta-Agent: Developing the Looped Agent Workflow System

**Last Updated**: 2025-11-09 (Feature test registry - Refinement #37)
**Your Role**: You are the meta-agent helping develop and refine this looped agent workflow system.

**Read this file completely** - it contains critical context about what we're building, what's working, what fails, and where to continue.

## What You're Building

A system for using coding agent instances (Claude, GPT-5, Gemini, etc.) in loops to research, plan, and implement software projects. Three specialized agent prompts work together through shared documentation, with clean handoffs between sessions.

**Core Components** (all in `~/dotfiles/claude/`):
- `commands/research.md` - Research agent prompt (invoke with `/research`)
- `commands/plan.md` - Planning agent prompt (invoke with `/plan`)
- `commands/implement.md` - Implementor agent prompt (invoke with `/implement`)
- `commands/implementation-manager.md` - Manager agent for autonomous multi-task implementation (invoke with `/implementation-manager`)
- `agent_workflow.md` - User-facing workflow documentation
- `meta-agent.md` - This file (meta-development context)
- `ACE-FCA-COMPARISON.md` - Comparison analysis with similar system

## Current State (2025-11-09)

### Status: Production-Ready with Autonomous Implementation Manager

**Agent prompts**: 36 refinements applied through iterative testing
**Testing**: All agents tested on real projects, failures documented and addressed
**Documentation**: Complete workflow documentation split (agent_workflow.md for users, meta-agent.md for meta-development)
**Recent focus**: Repeatable test suite framework (tests as first-class deliverables), manager-based autonomous implementation, UML/PlantUML diagram integration, YAML frontmatter metadata, context management optimization (40-60% based on ACE-FCA proven thresholds)

### What's Working

✅ **Researcher**: Clean handoffs, effective exploration, comprehensive system documentation with UML diagrams (separate .puml files + auto-generated SVGs), test suite verification
✅ **Planner**: Interactive collaboration via QUESTIONS.md, visual planning with change-highlighted diagrams, verification strategy in specs
✅ **Implementor**: Clear task boundaries, repeatable test creation requirements, end-to-end verification focus
✅ **Implementation Manager**: Autonomous multi-task orchestration via sub-agents (NEW - Refinement #32)
  - Eliminates human friction between tasks
  - Minimal context (stays <30% throughout)
  - Continues until done, blocked, or context limit
  - Manager-worker pattern: delegates to `/implement` sub-agents
  - Graceful restart handling via MANAGER_PROGRESS.md
✅ **Sub-agent delegation**: Only results return to context (not exploration process)
✅ **Document structure**: Clear ownership, no sprawl (explicit allowed lists)
✅ **Token efficiency**: Optimized to 40-60% (aligned with ACE-FCA proven thresholds)
✅ **Agent-agnostic**: Works with Claude, GPT-5, Gemini, etc.
✅ **System documentation**: Multi-file strategy for large systems (>800-1000 lines)
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

⚠️ **Testing honesty**: Agents claim they tested when they didn't
- Solution: ABSOLUTE RULE requiring actual terminal output pasted as proof
- Examples showing acceptable vs unacceptable verification
- "If you say you tested it, paste the output" - no exceptions

## Development History

### 36 Iterative Refinements (2025-11-01 to 2025-11-09)

**Key improvements made**:
1. Documentation is Not History principle (delete obsolete info)
2. ONE task per session rule (implementor)
3. Mandatory end-to-end user testing with evidence
4. Follow spec literally (replace means replace)
5. QUESTIONS.md as primary planner communication
6. Spec Detail Level guidelines (interfaces, not code dumps)
7. PROGRESS.md REWRITE requirement (not append)
8. Development cycle clarity (removed "next agent will..." assumptions)
9. Context management strategy (originally 60-70% wrap up, 80% hard stop)
10. Sub-agent delegation for verbose work
11. Checkpoint review process (researcher verifies after 2-3 implementations)
12. Spec simplicity guidelines (2-3 phases max)
13. Document ownership clarification
14. Token efficiency strategies
15. Quality standards for code and specs
16. End-to-end verification requirements
17. User-facing documentation separation (README vs spec/)
18. Component replacement capability checks
19. Regression testing requirements
20. Development artifact cleanup
21. User verification instructions
22. QUESTIONS.md cleanup (delete answered questions)
23. Agent-agnostic terminology (Claude → coding agents)
24. Workflow documentation split (agent_workflow.md vs meta-agent.md)
25. No documentation sprawl (explicit allowed list, DELETE rule)
26. System documentation principles (behavior/integration focus, multi-file strategy)
27. Proof-required testing (paste actual output, no claims without evidence)
28. **Context threshold optimization (40-50% wrap up, 60% hard stop - aligned with ACE-FCA)**
29. **UML/PlantUML diagram integration (component, sequence, interface diagrams)**
30. **YAML frontmatter metadata (git SHA, dates, status tracking for traceability)**
31. **Slash command integration (Claude Code CLI integration via dotfiles)**
   - Commands in `~/dotfiles/claude/commands/` (research.md, plan.md, implement.md)
   - Invoked with `/research`, `/plan`, `/implement`
   - Maintains agent-agnostic design (still usable via file references)
   - Deprecates install.sh script (dotfiles handles deployment)
32. **Implementation Manager (autonomous multi-task orchestration)**
   - Manager-worker pattern: thin orchestration layer delegates to implementor sub-agents
   - Eliminates human friction between tasks (continues autonomously until done/blocked)
   - Minimal manager context (<30%) enables handling 10s-100s of tasks per session
   - Two-document system: MANAGER_PROGRESS.md (outcomes) + IMPLEMENTOR_PROGRESS.md (technical details)
   - Graceful restart handling and context overflow recovery
   - Balances ACE-FCA flow mode with our paranoid testing requirements
33. **Settings.json permissions (autonomous development operations)**
   - All standard dev commands pre-approved in settings.json (tests, builds, git)
   - Agents work autonomously without permission requests for safe operations
   - Dangerous operations (git push, rm -rf, sudo) still require approval
   - Eliminates friction for Implementation Manager autonomous flow
   - Single source of truth: settings.json controls permissions, prompts stay clean
34. **Context usage tracking (feedback loop for task sizing)**
   - Implementor sub-agents report final context usage in summaries
   - Manager tracks context usage per task in MANAGER_PROGRESS.md
   - Context Usage Analysis section shows statistics (avg, range, distribution)
   - Planner reviews historical data to calibrate future task sizes
   - Enables data-driven refinement of planning granularity
   - Target: Keep implementors in 40-50% context range
35. **Diagram files with SVG generation (improved human review)**
   - PlantUML diagrams now in separate `.puml` files in `spec/diagrams/`
   - Researcher generates SVG files: `plantuml spec/diagrams/*.puml -tsvg`
   - Markdown references SVGs with source links: `![Desc](diagrams/name.svg)` + `*[View/edit source](diagrams/name.puml)*`
   - Humans see diagrams immediately in any markdown viewer (GitHub, VS Code, etc.)
   - No external rendering tools needed (was major friction point)
   - Format migration rule: convert inline PlantUML to separate files
   - Both `.puml` sources and `.svg` outputs committed to git
36. **Repeatable test suite framework (fixes "fake testing" at its root)**
   - **The problem**: Agents tested once and pasted output, but didn't create repeatable tests
   - "Code exists" ≠ "Feature works from user perspective"
   - Researcher couldn't verify implementations (no tests to run)
   - No accumulation of test coverage as features were built
   - **The solution**: Tests are now first-class deliverables
   - Implementor: CREATES repeatable tests (scripts/automated/documented), not just tests once
   - Implementor: RUNS new tests + existing test suite (regression check)
   - Implementor: Tests verify END-TO-END user experience, not just code existence
   - Researcher: RUNS test suite to verify system state (not just reads code)
   - Researcher: Documents test results, coverage gaps in CURRENT_SYSTEM.md
   - Planner: Includes verification strategy in specs (HOW to test repeatably)
   - Test types: Automated tests (tests/), verification scripts (tools/verify_*.sh), documented procedures
   - Emphasis: "Can another agent run this test?" "Does it test the user experience?"
   - Closes the gap: Future agents can verify features work by running the test suite
37. **Feature test registry (FEATURE_TESTS.md - single source of truth)**
   - **The problem**: Tests scattered (tests/ dir, tools/verify_*.sh, README procedures)
   - Hard to discover what features exist and how to verify each
   - No clear coverage visibility (what has tests, what doesn't)
   - Researcher unclear what to run to verify system state
   - **The solution**: `spec/FEATURE_TESTS.md` as feature test registry
   - Single registry: All features + verification methods in one place
   - Clarified test types: Automated, Verification Script, Agent-Interactive (not "manual")
   - Agent-interactive testing valid for non-deterministic systems (chatbots, AI, UX)
   - Implementor: Adds entry to FEATURE_TESTS.md for each feature built
   - Researcher: Runs tests from FEATURE_TESTS.md, updates status/dates, documents gaps
   - Planner: References in specs, verification strategy becomes FEATURE_TESTS.md entry
   - Easy gap analysis: Features without tests immediately visible
   - Document ownership: Implementor creates, Researcher maintains, Planner references

**See git history for full chronological details.**

## Convergent Evolution: ACE-FCA Comparison (2025-11-09)

### The Discovery

During development, we discovered another team (HumanLayer) independently built a nearly identical system called "Advanced Context Engineering for Coding Agents" (ACE-FCA). **We converged on ~80-85% the same solution** despite working independently.

**Their system**: https://github.com/humanlayer/advanced-context-engineering-for-coding-agents

### Key Finding: We Both Recognized the Same Core Problem

**The bottleneck in AI coding is context management, not model capability.**

Both systems use:
- Research → Plan → Implement workflow (three phases, same names)
- Frequent compaction to prevent context bloat
- Subagent delegation for exploration
- Human review at leverage points
- Document-based handoffs between sessions

This convergence is **strong validation** that we're solving the problem correctly.

### What We Learned and Adopted from ACE-FCA

**1. Context Thresholds (Refinement #28)**
- **They use**: 40-60% target range
- **We had**: 60-70% wrap up, 80% hard stop
- **We adopted**: 40-50% wrap up, 60% hard stop
- **Why**: Their thresholds proven in real production codebases (300k LOC Rust projects, 35k LOC changes)

**2. YAML Frontmatter Metadata (Refinement #30)**
- **They use**: Metadata headers in research docs (git SHA, date, researcher, tags, status)
- **We adopted**: YAML frontmatter in ALL major docs (CURRENT_SYSTEM, NEW_FEATURES, PROGRESS, etc.)
- **Why**: Traceability, searchability, automation potential, audit trails

**3. Visual Documentation Principle**
- **They showed**: Diagrams dramatically improve human review speed
- **We adopted**: PlantUML diagrams for architecture (Refinement #29)
- **Why**: LLMs generate PlantUML reliably, humans render it easily, reduces ambiguity

**4. Documented Real-World Results**
- **They have**: Metrics and linked PRs proving effectiveness
- **We learned**: Need to document our own real-world usage similarly
- **Action**: Future agents should document metrics from actual projects

### What We Kept Different (Our Unique Strengths)

**1. Flow Mode via Implementation Manager (Refinement #32)**
- **Their approach**: Continue through multiple phases in one session
- **Our approach (updated)**: Implementation Manager orchestrates autonomous flow via sub-agents
  - Manager continues through all tasks (like ACE-FCA)
  - But each task delegated to fresh `/implement` sub-agent
  - Maintains our paranoid testing (each sub-agent must paste output)
  - Maintains atomic task boundaries (each sub-agent does ONE task)
- **Why this works**: Best of both worlds - autonomous flow WITHOUT error accumulation
- **Trade-off**: More complex (manager + workers) but maintains reliability

**2. Comprehensive System Documentation (CURRENT_SYSTEM.md)**
- **Their approach**: Targeted, problem-specific research docs (timestamped, archived)
- **Our approach**: Living CURRENT_SYSTEM.md that covers entire system
- **Why we keep it**: Works for unfamiliar codebases, reduces planner errors from missing constraints
- **Trade-off**: More upfront researcher work, but better for general use

**3. Explicit "Paste Output" Testing Rule**
- **Their approach**: Verification required but less explicit
- **Our approach**: "ABSOLUTE RULE: paste actual terminal output or it didn't happen"
- **Why we keep it**: We discovered agents fake testing (critical failure mode)
- **Evidence**: Our 27 refinements found this pattern repeatedly

**4. Document Format Migration Rule**
- **Their approach**: Not explicitly documented
- **Our approach**: "Update old formats IMMEDIATELY, no permission needed"
- **Why we added it**: Ensures system evolves uniformly, applies to all future improvements
- **Benefit**: Automatic adoption of better practices

**5. Agent-Agnostic Design**
- **Their approach**: Slash commands, Claude-specific tooling
- **Our approach**: Works with any coding agent (Claude, GPT-5, Gemini, etc.)
- **Why we keep it**: Future-proof, platform-independent
- **Trade-off**: Less IDE integration convenience

### Philosophical Differences

**ACE-FCA optimizes for**: Flow and senior engineer productivity
- Continue through phases when it makes sense
- Adapt plan to reality during implementation
- Assume developer has system knowledge

**We optimize for**: Reliability and verification
- Strict boundaries (one task per session)
- Follow spec literally (if unclear, ask)
- Comprehensive system documentation upfront
- Proof-required testing

**Neither is universally better** - they solve slightly different problems:
- ACE-FCA: Augment expert developers on their own codebases
- Us: Work on any codebase, including unfamiliar ones

### What This Means for Future Development

**1. We're on the Right Track**
Independent convergence on the same architecture is the strongest possible validation. The Research-Plan-Implement pattern with context management appears to be the **natural solution** to AI-assisted coding.

**2. Learn from Their Results**
- They have documented real-world metrics (1 hour for bug fixes in 300k LOC codebases)
- We should document our own usage with similar rigor
- Their weekly coding sessions and Y Combinator talk suggest active community

**3. Consider Hybrid Modes**
Future consideration: Could we support both modes?
- "Careful mode" (our approach): Atomic tasks, strict verification
- "Flow mode" (their approach): Continue through phases when appropriate
- User selects based on task complexity/risk

**4. Maintain Our Paranoid Testing**
Our "paste output" rule and strict verification caught real failure modes. Don't compromise this even if others don't emphasize it as strongly.

**5. Cross-Pollinate Ideas**
- Check their updates periodically for new insights
- Consider reaching out to share learnings
- Our documented failure patterns could benefit their system too

### Reference Documents

- **Full comparison analysis**: `ACE-FCA-COMPARISON.md` (in this repository)
- **Their main doc**: https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md
- **Their prompts**:
  - Research: https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/research_codebase.md
  - Plan: https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/create_plan.md
  - Implement: https://github.com/humanlayer/humanlayer/blob/main/.claude/commands/implement_plan.md

### Key Takeaway for Future Meta-Agents

When someone proposes a change, ask:
1. Does this align with our core principles (reliability, verification, atomic tasks)?
2. Does ACE-FCA do this? What was their experience?
3. Is there evidence from real usage?
4. Does it compromise our unique strengths?

We should learn from others but maintain our identity as the **paranoid, reliable, proof-required** approach to agent workflows.

## Common Failure Patterns & Solutions

### Problem: Historical accumulation
Agents treat docs like append-only logs.
→ **Solution**: "Documentation is Not History" section in all prompts. REWRITE, don't append.

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
→ **Solution**: "Follow spec literally" rule. If unclear, ask in QUESTIONS.md (planner) or directly (implementor).

### Problem: Code-heavy specs
Planner dumps implementation code instead of requirements.
→ **Solution**: "Spec Detail Level" guidelines. Focus on interfaces and behavior, not code dumps.

### Problem: QUESTIONS.md bloat
Planner doesn't delete answered questions.
→ **Solution**: Explicit cleanup requirement. Delete answered questions immediately.

### Problem: Component replacement without capability check
Implementor replaces component but loses features.
→ **Solution**: "Check what you're replacing" step. List capabilities before replacing.

### Problem: Context overflow
Agents read too much into their context.
→ **Solution**: Token budget monitoring (60-70% wrap up, 80% hard stop) + sub-agent delegation.

### Problem: Documentation sprawl
Agents invent new docs (SESSION_SUMMARY.md, NOTES.md, etc.) instead of using existing structure.
→ **Solution**: "No Documentation Sprawl" section in all prompts. Explicit allowed list. DELETE unauthorized docs.

## Design Principles

### Core Philosophy
- **Documents are for future agents, not history** - Delete obsolete info aggressively
- **No documentation sprawl** - Use existing structure, never invent new docs
- **One task per session** - Clean boundaries, easier debugging
- **Simple > complex** - 2-3 phase specs beat 5+ phase specs
- **Tests are first-class deliverables** - Create repeatable tests that verify user experience
- **Test suite accumulation** - Each feature adds to test suite, researchers verify by running tests
- **Token efficiency** - Delegate verbose work to sub-agents

### Document Structure
Each agent has clear document ownership:
- **Researcher** owns CURRENT_SYSTEM.md (+ spec/system/*.md if split), FEATURE_TESTS.md (maintains/verifies), RESEARCH_STATUS.md
- **Planner** owns NEW_FEATURES.md, PLANNING_STATUS.md, QUESTIONS.md (reads FEATURE_TESTS.md)
- **Implementor** owns IMPLEMENTOR_PROGRESS.md, FEATURE_TESTS.md (creates entries) (+ updates NEW_FEATURES.md with completions)
- **Implementation Manager** owns MANAGER_PROGRESS.md (high-level outcome tracking)

### System Documentation Principle
**For CURRENT_SYSTEM.md**: "Behavior and integration points clear, implementation details minimal"

Document WHAT the system does and HOW components connect - enough to plan changes without surprises, not enough to implement without reading code.

**Multi-file strategy** (when >800-1000 lines):
- `spec/CURRENT_SYSTEM.md`: Overview + navigation (200-300 lines)
- `spec/system/architecture.md`: Components, data flows
- `spec/system/integration-points.md`: APIs, contracts, data formats
- `spec/system/constraints.md`: Technical debt, limitations

**Analogous to planner specs**:
- Planner: "User experience clear, implementation flexible"
- Researcher: "System behavior clear, implementation minimal"

### Handoff Pattern
Agents read handoff docs from previous role:
- Planner reads CURRENT_SYSTEM.md (from researcher)
- Implementor reads NEW_FEATURES.md (from planner) + CURRENT_SYSTEM.md + IMPLEMENTOR_PROGRESS.md
- Implementation Manager reads NEW_FEATURES.md (from planner) + MANAGER_PROGRESS.md
- Next implementor reads IMPLEMENTOR_PROGRESS.md (from previous implementor)

But agents DON'T read internal progress docs from other roles:
- Planner doesn't read RESEARCH_STATUS.md, IMPLEMENTOR_PROGRESS.md, or MANAGER_PROGRESS.md
- Implementor doesn't read RESEARCH_STATUS.md, PLANNING_STATUS.md, or MANAGER_PROGRESS.md
- Implementation Manager doesn't read CURRENT_SYSTEM.md, RESEARCH_STATUS.md, PLANNING_STATUS.md, or IMPLEMENTOR_PROGRESS.md
- Researcher doesn't read IMPLEMENTOR_PROGRESS.md, MANAGER_PROGRESS.md, or PLANNING_STATUS.md

## Testing Approach

### Real-World Validation
All prompts tested on actual project (this docbot system):
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
- Context usage (target: <70% for clean exits)
- Document size growth (should shrink/stabilize, not grow indefinitely)
- Handoff success (next agent can pick up cleanly)
- Verification completeness (evidence provided, not just claims)

## Where to Continue

### If Refining Prompts Further
- Monitor whether agents follow documentation cleanup rules in practice
- Check if PROGRESS.md stays clean across multiple sessions
- Test implementor with various spec complexities (2-3 phases vs 5+ phases)
- Verify checkpoint reviews catch drift effectively
- Test with different coding agents (GPT-5, Gemini) if available

### If Using on New Projects
- Start with researcher to capture current system
- Use planner for next feature set
- Run implementor in loops for each atomic task
- Return to researcher after 2-3 implementations to verify
- Follow the cycle documented in agent_workflow.md

### If Stuck or Confused
- **agent_workflow.md** - How to use the system (user-facing)
- **meta-agent.md** - This file (meta-development context)
- Each agent prompt is self-contained with full instructions
- QUESTIONS.md is for planner-human Q&A only

## Active Development Areas

### Recently Completed (2025-11-09)
✅ **Feature test registry (FEATURE_TESTS.md)** - JUST ADDED (Refinement #37)
  - Single source of truth for all features and their verification methods
  - Clarified test types: Automated, Verification Script, Agent-Interactive
  - Agent-interactive testing explicitly valid for non-deterministic systems (chatbots, AI)
  - Implementors add entries when building features
  - Researchers run tests from registry, update status/dates, document gaps
  - Planners reference in verification strategies
  - Easy gap analysis: features without tests immediately visible
  - Solves test discoverability problem (no more scattered verification docs)
✅ **Repeatable test suite framework** - (Refinement #36)
  - Tests are now first-class deliverables (not just verification evidence)
  - Implementors CREATE repeatable tests: automated tests (tests/), verification scripts (tools/verify_*.sh), or documented procedures
  - Tests verify END-TO-END user experience, not just "code exists"
  - Implementors RUN new tests + existing test suite (regression check)
  - Researchers RUN test suite to verify system state (not just read code)
  - Researchers document test results, coverage gaps in CURRENT_SYSTEM.md
  - Planners include verification strategy in specs (HOW to test repeatably)
  - Closes critical gap: Future agents can verify features work by running tests
  - Solves "fake testing" at root cause: one-off checks → repeatable test suites
✅ **Diagram files with SVG generation**
  - Separate `.puml` files in `spec/diagrams/` with generated `.svg` outputs
  - Humans see diagrams immediately in markdown viewers (no external tools needed)
  - Researcher always generates SVGs after creating/editing diagrams
  - Format migration rule: convert inline PlantUML to separate files automatically
  - Major improvement to human review leverage point
✅ **Context usage tracking**
  - Implementors report context usage to manager
  - Manager aggregates data in MANAGER_PROGRESS.md
  - Planner uses historical data to calibrate task sizing
  - Creates feedback loop: planning → implementation → metrics → better planning
✅ **Settings.json permissions**
  - Pre-approved all standard dev operations (tests, builds, git local, shell utils)
  - Enables autonomous Implementation Manager flow without permission interruptions
  - Dangerous operations (git push, rm -rf, sudo) still require approval
  - Single source of truth eliminates need for verbose permission lists in prompts
✅ **Implementation Manager (autonomous multi-task orchestration)** - JUST ADDED
  - Manager-worker pattern eliminates human friction between tasks
  - Minimal manager context (<30%) enables 10s-100s of tasks per session
  - Delegates to `/implement` sub-agents for actual work
  - Two-document system: MANAGER_PROGRESS.md (outcomes) + IMPLEMENTOR_PROGRESS.md (details)
  - Graceful restart and context overflow handling
  - Balances ACE-FCA flow mode with our paranoid testing requirements
✅ **Slash command integration** - Claude Code CLI integration via dotfiles
  - Commands in `~/dotfiles/claude/commands/` (research.md, plan.md, implement.md, implementation-manager.md)
  - Invoked with `/research`, `/plan`, `/implement`, `/implementation-manager` in Claude Code
  - Still agent-agnostic (can reference files directly in other agents)
  - Simplified deployment (no install script needed, just dotfiles)
  - Updated all documentation to reference slash commands
✅ **Context threshold optimization** - Aligned with ACE-FCA proven thresholds (40-50% wrap up, 60% hard stop)
✅ **UML/PlantUML diagram integration** - Visual architecture documentation in all agents
  - Researcher: Component, sequence, interface diagrams for system documentation
  - Planner: Change-highlighted diagrams showing modifications, additions, removals
  - Comprehensive syntax examples and placement guidance
  - Human rendering guide in agent_workflow.md
✅ **YAML frontmatter metadata** - Traceability and status tracking
  - All major documents (CURRENT_SYSTEM, NEW_FEATURES, IMPLEMENTOR_PROGRESS, MANAGER_PROGRESS, RESEARCH_STATUS, PLANNING_STATUS)
  - Track: git SHA, dates, status, understanding level, context usage
  - Enables searchability, automation, audit trails
✅ **Document format migration rule** - Automatic updates to latest standards
  - All agents update old format documents immediately
  - Applies to all future format improvements
  - No permission needed, no backward compatibility preservation
  - Includes file name migrations (PROGRESS.md → IMPLEMENTOR_PROGRESS.md)

### Previously Completed (2025-11-05)
✅ Agent-agnostic terminology (supports Claude, GPT-5, Gemini, etc.)
✅ Split workflow docs (agent_workflow.md for users, meta-agent.md for meta-development)
✅ No documentation sprawl rules (explicit allowed lists, DELETE unauthorized docs)
✅ System documentation principles (behavior/integration focus, multi-file strategy for large systems)
✅ Proof-required testing (paste actual terminal output, no claims without evidence)
✅ Comprehensive system doc guidelines for researchers (when to split, what to include/exclude)

### Current Status
**System is stable and production-ready.** Enhanced with autonomous Implementation Manager for multi-task orchestration, visual documentation, metadata tracking, and slash command integration. Prompts now live in `~/dotfiles/claude/commands/` for easy deployment. Continue monitoring agent behavior in real usage. Document new failure patterns as they emerge.

**Major workflow improvement**: Implementation Manager eliminates human friction between tasks while maintaining our paranoid testing requirements.

**Deployment**: No install script needed. Prompts are in dotfiles and automatically available via `~/.claude/commands` symlink.

### Known Issues to Monitor
- **NEW**: Do implementors add entries to FEATURE_TESTS.md for features they build?
- **NEW**: Do researchers use FEATURE_TESTS.md as their test checklist?
- **NEW**: Do researchers update test status/dates in FEATURE_TESTS.md after running tests?
- **NEW**: Do agents properly distinguish between Automated/Verification Script/Agent-Interactive test types?
- **NEW**: Do implementors actually CREATE repeatable tests (not just test once)?
- **NEW**: Do implementors create tests that verify END-TO-END user experience (not just "code exists")?
- **NEW**: Do implementors run existing test suite (regression check)?
- **NEW**: Do researchers actually RUN the test suite to verify system state?
- **NEW**: Do researchers document test results and coverage gaps in CURRENT_SYSTEM.md?
- **NEW**: Do planners include verification strategies in specs?
- Do agents actually follow the "paste output" rule, or do they still fake testing?
- Do agents properly split large CURRENT_SYSTEM.md files using the multi-file strategy?
- Do agents delete unauthorized documentation, or do they still create sprawl?
- Do researchers create separate .puml files and generate SVGs correctly?
- Do researchers migrate inline PlantUML to separate files when found?
- Do agents generate accurate PlantUML diagrams that compile correctly?
- Do agents properly update YAML frontmatter each session?
- Do agents migrate old document formats immediately as instructed?
- Does Implementation Manager correctly delegate to sub-agents and maintain minimal context?
- Does Implementation Manager properly handle restarts and context overflow scenarios?
- Do implementor sub-agents provide clear summaries in the expected format?
- Do settings.json permissions prevent friction during autonomous implementation?
- Do implementors correctly report context usage in their summaries?
- Does manager correctly track and aggregate context usage data?
- Does planner actually use historical context data to calibrate task sizes?

### Future Considerations
- Additional agent types (e.g., reviewer, tester)?
- Cross-project learnings (how to share patterns between projects)?
- Better context usage analytics?
- Automated drift detection?
- Testing framework for agent behavior validation?

## Meta-Development Guidelines

When working on this system:

**Testing is everything**: Real usage reveals issues theory misses. Test on actual projects.

**Failures are learning**: Each agent failure → prompt refinement. Document the pattern in this file.

**Simplicity wins**: Simpler rules > complex rules. Prominent reminders > buried guidelines.

**Be absolute about critical rules**: Vague suggestions don't work. Use "ABSOLUTE RULE", "NO EXCEPTIONS", concrete examples.

**Iterate rapidly**: Small prompt changes, test, observe, refine. Don't overplan.

**Document learnings**: Capture failure patterns and solutions in this file immediately.

**Keep user docs separate**: agent_workflow.md is for users. This file is for meta-development.

**Apply our own principles to this file**:
- "Behavior and integration points clear, implementation details minimal"
- Delete obsolete information (this file is NOT a history log)
- Keep "Current State" current (update dates, status, recently completed)
- Focus on what future meta-agents need to know NOW

**When updating this file**:
- Update "Last Updated" date
- Update "Current State" with latest status
- Move completed items from "In Progress" to "Recently Completed"
- Update refinement count
- Delete truly obsolete information (but preserve failure patterns - those are valuable)

**Critical context for new meta-agents**:
- Read the "Convergent Evolution: ACE-FCA Comparison" section - it explains where key ideas came from
- See `ACE-FCA-COMPARISON.md` for full details on what we learned from similar systems
- Understand our philosophical differences: we optimize for reliability and verification, not just flow
- Our identity: paranoid, proof-required, atomic tasks, comprehensive documentation

---

**Remember**: You're building tools for other agents. Make it clear, make it simple, make it work.
