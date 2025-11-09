# Meta-Agent: Developing the Looped Agent Workflow System

**Last Updated**: 2025-11-09
**Your Role**: You are the meta-agent helping develop and refine this looped agent workflow system.

**Read this file completely** - it contains critical context about what we're building, what's working, what fails, and where to continue.

## What You're Building

A system for using coding agent instances (Claude, GPT-5, Gemini, etc.) in loops to research, plan, and implement software projects. Three specialized agent prompts work together through shared documentation, with clean handoffs between sessions.

**Core Components** (all in `~/dotfiles/claude/`):
- `commands/research.md` - Research agent prompt (invoke with `/research`)
- `commands/plan.md` - Planning agent prompt (invoke with `/plan`)
- `commands/implement.md` - Implementor agent prompt (invoke with `/implement`)
- `agent_workflow.md` - User-facing workflow documentation
- `meta-agent.md` - This file (meta-development context)
- `ACE-FCA-COMPARISON.md` - Comparison analysis with similar system

## Current State (2025-11-09)

### Status: Production-Ready with Slash Command Integration

**Agent prompts**: 31 refinements applied through iterative testing
**Testing**: All three agents tested on real projects, failures documented and addressed
**Documentation**: Complete workflow documentation split (agent_workflow.md for users, meta-agent.md for meta-development)
**Recent focus**: UML/PlantUML diagram integration, YAML frontmatter metadata, context management optimization (40-60% based on ACE-FCA proven thresholds)

### What's Working

✅ **Researcher**: Clean handoffs, effective exploration, comprehensive system documentation with UML diagrams
✅ **Planner**: Interactive collaboration via QUESTIONS.md, visual planning with change-highlighted diagrams
✅ **Implementor**: Clear task boundaries with strengthened verification requirements
✅ **Sub-agent delegation**: Only results return to context (not exploration process)
✅ **Document structure**: Clear ownership, no sprawl (explicit allowed lists)
✅ **Token efficiency**: Optimized to 40-60% (aligned with ACE-FCA proven thresholds)
✅ **Agent-agnostic**: Works with Claude, GPT-5, Gemini, etc.
✅ **System documentation**: Multi-file strategy for large systems (>800-1000 lines)
✅ **Proof-required testing**: Implementors must paste actual terminal output as verification
✅ **Visual architecture**: PlantUML diagrams for components, sequences, and interfaces
✅ **Metadata tracking**: YAML frontmatter for traceability (git SHA, dates, status)
✅ **Format migration**: Automatic updates to latest document format standards

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

### 31 Iterative Refinements (2025-11-01 to 2025-11-09)

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

**1. ONE Task Per Session (Implementor)**
- **Their approach**: Continue through multiple phases in one session
- **Our approach**: Stop after each atomic task, clean boundary
- **Why we keep it**: Prevents error accumulation, easier debugging, cleaner handoffs
- **Trade-off**: More sessions but more reliable

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

### Problem: Fake verification (CRITICAL)
Agents claim "works" without testing, or worse, claim they tested when they literally never ran it.
→ **Solution**:
- ABSOLUTE RULE: Never claim testing without pasting actual terminal output
- "I tested X" = UNACCEPTABLE. Paste actual output = REQUIRED
- Test EXACT commands documented (copy from docs, paste in terminal, run, paste output)
- If it fails when tested: FIX IT before claiming done
- Examples in prompt showing acceptable vs unacceptable verification

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
- **Test everything** - No claiming "works" without evidence
- **Token efficiency** - Delegate verbose work to sub-agents

### Document Structure
Each agent has clear document ownership:
- **Researcher** owns CURRENT_SYSTEM.md (+ spec/system/*.md if split), RESEARCH_STATUS.md
- **Planner** owns NEW_FEATURES.md, PLANNING_STATUS.md, QUESTIONS.md
- **Implementor** owns PROGRESS.md (+ updates NEW_FEATURES.md with completions)

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
- Implementor reads NEW_FEATURES.md (from planner) + CURRENT_SYSTEM.md
- Next implementor reads PROGRESS.md (from previous implementor)

But agents DON'T read internal progress docs from other roles:
- Planner doesn't read RESEARCH_STATUS.md or PROGRESS.md
- Implementor doesn't read RESEARCH_STATUS.md or PLANNING_STATUS.md
- Researcher doesn't read PROGRESS.md or PLANNING_STATUS.md

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
✅ **Slash command integration** - Claude Code CLI integration via dotfiles
  - Commands in `~/dotfiles/claude/commands/` (research.md, plan.md, implement.md)
  - Invoked with `/research`, `/plan`, `/implement` in Claude Code
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
  - All major documents (CURRENT_SYSTEM, NEW_FEATURES, PROGRESS, RESEARCH_STATUS, PLANNING_STATUS)
  - Track: git SHA, dates, status, understanding level, context usage
  - Enables searchability, automation, audit trails
✅ **Document format migration rule** - Automatic updates to latest standards
  - All agents update old format documents immediately
  - Applies to all future format improvements
  - No permission needed, no backward compatibility preservation

### Previously Completed (2025-11-05)
✅ Agent-agnostic terminology (supports Claude, GPT-5, Gemini, etc.)
✅ Split workflow docs (agent_workflow.md for users, meta-agent.md for meta-development)
✅ No documentation sprawl rules (explicit allowed lists, DELETE unauthorized docs)
✅ System documentation principles (behavior/integration focus, multi-file strategy for large systems)
✅ Proof-required testing (paste actual terminal output, no claims without evidence)
✅ Comprehensive system doc guidelines for researchers (when to split, what to include/exclude)

### Current Status
**System is stable and production-ready.** Enhanced with visual documentation, metadata tracking, and slash command integration. Prompts now live in `~/dotfiles/claude/commands/` for easy deployment. Continue monitoring agent behavior in real usage. Document new failure patterns as they emerge.

**Deployment**: No install script needed. Prompts are in dotfiles and automatically available via `~/.claude/commands` symlink.

### Known Issues to Monitor
- Do agents actually follow the "paste output" rule, or do they still fake testing?
- Do agents properly split large CURRENT_SYSTEM.md files using the multi-file strategy?
- Do agents delete unauthorized documentation, or do they still create sprawl?
- **NEW**: Do agents generate accurate PlantUML diagrams that compile correctly?
- **NEW**: Do agents properly update YAML frontmatter each session?
- **NEW**: Do agents migrate old document formats immediately as instructed?

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
