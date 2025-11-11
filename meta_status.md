# Meta-Agent System Status

---
last_updated: 2025-11-11
git_commit: a612a1c553b63b2e5bba1944ddd11f9e0e448ba9
refinement_count: 44
status: production-ready
recent_focus: prompt_verbosity_reduction
agent_count: 4
---

## Current State (2025-11-11)

### Status: Production-Ready with Autonomous Implementation Manager

**Agent prompts**: 44 refinements applied through iterative testing
**Testing**: All agents tested on real projects, failures documented and addressed
**Documentation**: Complete workflow documentation split (agent_workflow.md for users, commands/meta-agent.md for meta-development)
**Recent focus**: Prompt verbosity reduction (consolidated repetitive sections, removed unnecessary examples, cleaner format migration rules)

### What's Working

✅ **Researcher**: Clean handoffs, effective exploration, comprehensive system documentation with UML diagrams (separate .puml files + auto-generated SVGs), test suite verification, documentor role (facts, not recommendations)
✅ **Planner**: Interactive collaboration via questions.md, visual planning with change-highlighted diagrams, verification strategy in specs
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

### 42 Iterative Refinements (2025-11-01 to 2025-11-10)

**Key improvements made**:
1. Documentation is Not History principle (delete obsolete info)
2. ONE task per session rule (implementor)
3. Mandatory end-to-end user testing with evidence
4. Follow spec literally (replace means replace)
5. questions.md as primary planner communication
6. Spec Detail Level guidelines (interfaces, not code dumps)
7. progress.md REWRITE requirement (not append)
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
22. questions.md cleanup (delete answered questions)
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
   - Two-document system: manager_progress.md (outcomes) + implementor_progress.md (technical details)
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
   - Manager tracks context usage per task in manager_progress.md
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
   - Researcher: Documents test results, coverage gaps in current_system.md
   - Planner: Includes verification strategy in specs (HOW to test repeatably)
   - Test types: Automated tests (tests/), verification scripts (tools/verify_*.sh), documented procedures
   - Emphasis: "Can another agent run this test?" "Does it test the user experience?"
   - Closes the gap: Future agents can verify features work by running the test suite
37. **Feature test registry (feature_tests.md - single source of truth)**
   - **The problem**: Tests scattered (tests/ dir, tools/verify_*.sh, README procedures)
   - Hard to discover what features exist and how to verify each
   - No clear coverage visibility (what has tests, what doesn't)
   - Researcher unclear what to run to verify system state
   - **The solution**: `spec/feature_tests.md` as feature test registry
   - Single registry: All features + verification methods in one place
   - Clarified test types: Automated, Verification Script, Agent-Interactive (not "manual")
   - Agent-interactive testing valid for non-deterministic systems (chatbots, AI, UX)
   - Implementor: Adds entry to feature_tests.md for each feature built
   - Researcher: Runs tests from feature_tests.md, updates status/dates, documents gaps
   - Planner: References in specs, verification strategy becomes feature_tests.md entry
   - Easy gap analysis: Features without tests immediately visible
   - Document ownership: Implementor creates, Researcher maintains, Planner references
38. **Researcher cleanup scope boundaries (prevents accidental deletion)**
   - **The problem**: Researcher told to "aggressively delete" docs, but unclear boundaries
   - Risk: Could delete implementor_progress.md, manager_progress.md owned by other agents
   - Risk: Could delete documents outside spec/ folder inappropriately
   - **The solution**: Explicit scope boundaries in researcher prompt
   - Cleanup authority LIMITED to `spec/` folder only
   - Complete allowed list for spec/ (includes planner-owned docs like new_features.md)
   - Explicit "NEVER delete" list: implementor_progress.md, manager_progress.md, any docs outside spec/
   - Clarifies document ownership boundaries between agents
   - Prevents cross-agent document conflicts
39. **Lowercase document filenames (consistency and convention)**
   - **The rationale**: UPPERCASE filenames were unconventional for markdown docs
   - Lowercase is standard convention in most projects
   - **The change**: All documentation filenames migrated to lowercase
   - CURRENT_SYSTEM.md → current_system.md
   - NEW_FEATURES.md → new_features.md
   - IMPLEMENTOR_PROGRESS.md → implementor_progress.md
   - MANAGER_PROGRESS.md → manager_progress.md
   - RESEARCH_STATUS.md → research_status.md
   - PLANNING_STATUS.md → planning_status.md
   - QUESTIONS.md → questions.md
   - FEATURE_TESTS.md → feature_tests.md
   - All agent prompts updated to reference lowercase filenames
   - Migration instructions added so agents will rename old UPPERCASE files automatically
   - Document format migration rule updated to include filename case normalization
40. **Token usage reporting (self-monitoring and visibility)**
   - **The problem**: Agents monitor token usage internally but don't report it to users
   - Hard for users to understand when agents are approaching limits
   - Agents may not proactively communicate context pressure
   - Users can't gauge progress or help agents make stopping decisions
   - **The solution**: All agents now report current token usage percentage at each interaction
   - Added to all four agent prompts: research, plan, implement, implementation-manager
   - Clear instruction: "Report your current token usage percentage at each interaction"
   - Helps agents stay accountable to thresholds (40-50% wrap up, 60% hard stop)
   - Gives users visibility into context consumption patterns
   - Enables better decision-making about when to stop/continue
41. **C4-inspired progressive disclosure for documentation (MAJOR structural improvement)**
   - **The problem**: Documentation didn't provide gradual increase in detail, "dived in haphazardly"
   - Agents read too much context (2000+ lines) when they only needed high-level overview
   - No systematic structure for organizing documentation by detail level
   - Unclear when to split docs or how to navigate between levels
   - Token inefficiency: reading everything when only parts are relevant
   - **The inspiration**: C4 Model (Context, Containers, Components, Code) - proven systematic approach to architecture documentation
   - **The solution**: Three-level progressive disclosure structure
   - **Level 1: System Context** (always in current_system.md)
     - What the system does, who uses it, external dependencies
     - Diagram: system-context.puml (system boundary with external actors)
     - Target: 100-200 lines
   - **Level 2: Containers/Components Overview** (always in current_system.md)
     - Major components, data flows, integration points
     - Diagram: containers-overview.puml (components with connections)
     - Target: 200-400 lines
     - **Threshold: Keep Levels 1+2 under 500 lines total**
   - **Level 3: Component Details** (split to spec/system/components/<name>.md when needed)
     - Internal component architecture, APIs, constraints
     - Diagrams: component-detail.puml, component-sequence.puml
     - Create when: Component description >150 lines or complexity warrants focus
   - **Critical Flows** (split to spec/system/flows/<name>.md as needed)
     - Important sequences spanning multiple components
     - Diagrams: flow-sequence.puml
     - Create when: Flow is critical (auth, payment, startup) or spans 3+ components
   - **Navigation rules**: Every doc has clear "drill down" and "back up" links
   - **Reading strategy**:
     - Planner: Always reads Levels 1+2 (~500 lines), drills to Level 3 only if feature touches that component
     - Implementor: Always reads Levels 1+2, drills to specific components/flows they're modifying
     - Researcher: Builds progressively, Level 1 → Level 2 → Level 3 as system complexity requires
   - **Token savings**: 60-75% reduction (500 lines vs 2000+) for typical planning/implementation tasks
   - **Benefits**:
     - Human comprehension: Easy to grasp system at appropriate level
     - Token efficiency: Read only what you need
     - Systematic structure: Clear guidelines for when to split and how to organize
     - Scalability: Works for small systems (single file) and large systems (multi-file)
   - **Implementation**:
     - Completely rewrote Research agent's "System Documentation Principles" section (not just appended)
     - Updated diagram guidelines to align with C4 levels
     - Updated PlantUML examples to show Level 1, 2, 3 diagrams
     - Added "Reading current_system.md Efficiently" sections to Plan and Implement agents
     - Planner diagrams now explicitly work at Level 2 (component-level changes)
     - All output requirements updated to reflect new structure
   - **Validated by real usage**: User reported Unity project diagrams "were very good" but docs "dived in haphazardly" - this refinement directly addresses that pain point
42. **Role clarity: Documentor, not critic**
   - **The problem**: Researcher acting as critic instead of documentor
   - Spent token budget analyzing what "should" be improved (planner's job)
   - Created recommendation documents (IMPROVEMENTS.md, REDUNDANT_API_CALLS.md, PERFORMANCE_ISSUES.md)
   - Half-baked improvement suggestions without planner's design process
   - Documentation sprawl from unauthorized recommendation files
   - **The insight**: Inspired by ACE-FCA's emphasis on researcher as documentor
   - **The solution**: Clear role boundary - researcher documents WHAT EXISTS, planner identifies WHAT SHOULD BE
   - Researcher documents issues FACTUALLY in current_system.md
   - Example: "Component X makes 3 API calls per request" (fact), NOT "Component X should be refactored" (recommendation)
   - Trust planner to read documentation and identify improvements
   - Added "Role Clarity: Documentor, Not Critic" section to research prompt
   - Expanded forbidden files list to include common recommendation file names
   - **Benefits**:
     - Researcher's tokens go to documentation, not analysis
     - Prevents documentation sprawl (no separate recommendation files)
     - Cleaner handoff: objective facts → thoughtful design
     - Planner equipped to design solutions, researcher equipped to describe reality
43. **Coding standards: Clarity, simplicity, complexity budget**
   - **The problem**: Implementors producing code that's hard for humans and future agents to understand
   - Comments explaining changes that stay forever in codebase
   - Unnecessary abstractions and indirection imposing cognitive load
   - Complex code when simple code would suffice
   - Premature optimization and "planning for the future"
   - **The philosophy**: Simple > Complex, Clear > Clever, Delete > Keep
   - **The solution**: Explicit "Coding Standards - ABSOLUTE RULES" section in implementor prompt
   - **Comment discipline**:
     - Comments ONLY for non-obvious WHY (not WHAT, not change descriptions)
     - Before commenting: Can I make the code clearer instead?
     - Examples showing good vs bad comment usage
   - **Simplicity over cleverness**:
     - Code is read 10x more than written - optimize for reading
     - Obvious structure over abstraction
     - Clear names over short names
     - Explicit flow over magic
     - "If a human or agent can't easily see what's happening, there's a problem"
   - **Complexity budget**:
     - Treat complexity like precious resource (like memory in embedded systems)
     - Default to simple, add complexity only when problem demands it
     - Need 3+ concrete cases before abstracting (not 1-2)
     - Ask: Is problem inherently complex, or am I making it complex?
   - **Code deletion is beautiful**:
     - Every line of code is a liability
     - Delete unused code, remove commented-out code, simplify when requirements change
     - Git remembers - no "keeping just in case"
   - **Examples**: Concrete before/after showing bad (clever/complex) vs good (simple/clear)
   - **Benefits**:
     - Code easier for future agents to reason about
     - Less cognitive load for humans reviewing code
     - Fewer bugs from unnecessary complexity
     - Faster implementation (simple solutions complete faster)
     - Aligns with atomic task approach (simple code = easier verification)
44. **Prompt verbosity reduction (major cleanup)**
   - **The problem**: Agent prompts had grown to 750-1050 lines with significant repetition
   - Documentation sprawl instructions repeated across prompts (30-50 lines each)
   - Format migration instructions with bash examples (40+ lines each)
   - Git permissions sections duplicated (20+ lines) despite settings.json handling this
   - Allowed/forbidden file lists with excessive symbols and explanations
   - YAML frontmatter examples shown multiple times per prompt
   - Hard for humans to review, signal-to-noise ratio degraded
   - **The solution**: Systematic reduction of repetitive, redundant, and unnecessary content
   - **Five high-impact reductions**:
     1. Consolidated "Documentation is Not History" (40-50 lines → 15 lines per prompt)
     2. Simplified format migration (40+ lines → 5 lines, removed bash examples)
     3. Condensed allowed/forbidden lists (removed ❌ symbols, reduced explanatory text)
     4. Removed git permissions sections (settings.json handles this)
     5. Deduplicated YAML examples (removed redundant instances)
   - **What we kept**: Critical teaching examples (coding standards, verification discipline, C4 progressive disclosure)
   - **Estimated reduction**: ~759 lines across 4 prompts (~24% reduction)
   - **Benefits**:
     - Faster human review when refining prompts
     - Clearer signal-to-noise ratio for agents
     - Reduced context consumption when agents read their own instructions
     - Maintained all critical rules and examples
     - More prominent placement of essential guidance

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
- **We adopted**: YAML frontmatter in ALL major docs (current_system, new_features, progress, etc.)
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

**2. Comprehensive System Documentation (current_system.md)**
- **Their approach**: Targeted, problem-specific research docs (timestamped, archived)
- **Our approach**: Living current_system.md that covers entire system
- **Why we keep it**: Works for unfamiliar codebases, reduces planner errors from missing constraints
- **Trade-off**: More upfront researcher work, but better for general use

**3. Explicit "Paste Output" Testing Rule**
- **Their approach**: Verification required but less explicit
- **Our approach**: "ABSOLUTE RULE: paste actual terminal output or it didn't happen"
- **Why we keep it**: We discovered agents fake testing (critical failure mode)
- **Evidence**: Our 42 refinements found this pattern repeatedly

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

### Problem: Complex, hard-to-understand code
Implementors produce code with unnecessary abstraction, clever one-liners, and comments explaining changes.
→ **Solution (Refinement #43)**: "Coding Standards - ABSOLUTE RULES" section in implementor prompt. Simple > Complex, Clear > Clever, comments only for WHY (not WHAT), complexity budget principle, concrete examples showing good vs bad.

### Problem: Historical accumulation
Agents treat docs like append-only logs.
→ **Solution**: "Documentation is Not History" section in all prompts. REWRITE, don't append.

### Problem: Researcher as critic
Researcher spends tokens analyzing what "should" be improved instead of documenting what exists.
→ **Solution (Refinement #42)**: "Role Clarity: Documentor, Not Critic" section. Document facts objectively, trust planner to identify improvements. No recommendation files (IMPROVEMENTS.md, REDUNDANT_API_CALLS.md, etc.).

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
→ **Solution**: "No Documentation Sprawl" section in all prompts. Explicit allowed list. DELETE unauthorized docs.

### Problem: Researcher cleanup overreach
Researcher told to "aggressively delete" docs, but unclear boundaries - could delete other agents' docs.
→ **Solution (Refinement #38)**: Explicit scope boundaries in researcher prompt.
- Cleanup authority LIMITED to `spec/` folder only
- Complete allowed list for spec/ (includes planner-owned docs that researcher must NOT delete)
- Explicit "NEVER delete" list: implementor_progress.md, manager_progress.md, docs outside spec/
- Clarifies document ownership boundaries between agents

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
Each agent has clear document ownership:
- **Researcher** owns current_system.md (+ spec/system/*.md if split), feature_tests.md (maintains/verifies), research_status.md
- **Planner** owns new_features.md, planning_status.md, questions.md (reads feature_tests.md)
- **Implementor** owns implementor_progress.md, feature_tests.md (creates entries) (+ updates new_features.md with completions)
- **Implementation Manager** owns manager_progress.md (high-level outcome tracking)
- **Meta-Agent** owns meta_status.md (this file), all agent prompts in commands/

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
- Planner reads current_system.md (from researcher)
- Implementor reads new_features.md (from planner) + current_system.md + implementor_progress.md
- Implementation Manager reads new_features.md (from planner) + manager_progress.md
- Next implementor reads implementor_progress.md (from previous implementor)
- Meta-agent reads meta_status.md (from previous meta-agent)

But agents DON'T read internal progress docs from other roles:
- Planner doesn't read research_status.md, implementor_progress.md, or manager_progress.md
- Implementor doesn't read research_status.md, planning_status.md, or manager_progress.md
- Implementation Manager doesn't read current_system.md, research_status.md, planning_status.md, or implementor_progress.md
- Researcher doesn't read implementor_progress.md, manager_progress.md, or planning_status.md
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

### Recently Completed (2025-11-11)
✅ **Prompt verbosity reduction** - JUST ADDED (Refinement #44)
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
- **NEW**: Do agents read and process prompts more efficiently with reduced verbosity?
- **NEW**: Did we remove any critical instructions that cause issues?
- **NEW**: Are remaining rules more prominent and easier to follow?
- Do implementors follow coding standards (simple > complex, clear > clever)?
- **NEW**: Do implementors avoid unnecessary comments (only WHY, not WHAT)?
- **NEW**: Do implementors resist premature abstraction (wait for 3+ cases)?
- **NEW**: Do implementors delete unused code instead of commenting it out?
- **NEW**: Is code produced easier for future agents to understand and modify?
- **NEW**: Do implementors treat complexity as precious (complexity budget principle)?
- **NEW**: Do researchers stay in documentor role (facts only) or drift into critic role (recommendations)?
- **NEW**: Do researchers avoid creating unauthorized recommendation files (IMPROVEMENTS.md, REDUNDANT_API_CALLS.md, etc.)?
- **NEW**: Do researchers document issues factually in current_system.md instead of separate files?
- **NEW**: Do researchers trust the planner to identify improvements, or try to do the planner's job?
- **NEW**: Do researchers create C4-level documentation correctly (Level 1+2 in current_system.md, Level 3 split when needed)?
- **NEW**: Do researchers keep current_system.md under 500 lines for Levels 1+2?
- **NEW**: Do researchers create system-context and containers-overview diagrams consistently?
- **NEW**: Do planners and implementors read only relevant documentation levels (not everything)?
- **NEW**: Does progressive disclosure actually reduce token usage in practice (target: 60-75% reduction)?
- **NEW**: Do navigation links (📖 drill down, ⬆️ back up) work well for humans and agents?
- **NEW**: When do researchers decide to split to Level 3? (Is 150-line threshold working?)
- **NEW**: Do agents actually report their token usage percentage at each interaction?
- **NEW**: Does token usage reporting help agents make better stopping decisions?
- **NEW**: Do agents automatically rename UPPERCASE document files to lowercase on encounter?
- **NEW**: Do researchers respect cleanup scope boundaries (only delete in spec/, not implementor_progress.md/manager_progress.md)?
- **NEW**: Do implementors add entries to feature_tests.md for features they build?
- **NEW**: Do researchers use feature_tests.md as their test checklist?
- **NEW**: Do researchers update test status/dates in feature_tests.md after running tests?
- **NEW**: Do agents properly distinguish between Automated/Verification Script/Agent-Interactive test types?
- **NEW**: Do implementors actually CREATE repeatable tests (not just test once)?
- **NEW**: Do implementors create tests that verify END-TO-END user experience (not just "code exists")?
- **NEW**: Do implementors run existing test suite (regression check)?
- **NEW**: Do researchers actually RUN the test suite to verify system state?
- **NEW**: Do researchers document test results and coverage gaps in current_system.md?
- **NEW**: Do planners include verification strategies in specs?
- Do agents actually follow the "paste output" rule, or do they still fake testing?
- Do agents properly split large current_system.md files using the multi-file strategy?
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
- Hybrid modes (careful vs flow)?
