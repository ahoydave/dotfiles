# ACE-FCA vs Our Looped Agent Workflow - Detailed Comparison

**Date**: 2025-11-09
**Status**: Research Complete - Ready for Discussion

---

## Executive Summary

We've independently converged on **remarkably similar solutions** to the same problem. Both systems use a Research-Plan-Implement workflow with context management as the core principle. The implementations differ in some tactical details but share the same strategic insights.

**Key Similarity**: Both recognize that the bottleneck in AI coding is context management, not model capability.

---

## Side-by-Side Architecture Comparison

### Workflow Phases

| Aspect | Their System (ACE-FCA) | Our System |
|--------|----------------------|------------|
| **Phase 1** | Research (documentarian role) | Researcher (system documentation) |
| **Phase 2** | Plan (interactive, skeptical) | Planner (collaborative via QUESTIONS.md) |
| **Phase 3** | Implement (phase-by-phase) | Implementor (one task per session) |
| **Context Target** | 40-60% usage | 60-70% wrap up, 80% hard stop |
| **Agent Invocation** | Slash commands (`.claude/commands/`) | Slash commands (`~/dotfiles/claude/commands/`) |

### Core Principles - Nearly Identical

| Principle | ACE-FCA | Our System |
|-----------|---------|------------|
| **Frequent Compaction** | ✅ Core technique | ✅ "Documentation is Not History" |
| **Subagent Delegation** | ✅ codebase-locator, codebase-analyzer | ✅ Task agents (Explore, general-purpose) |
| **Context Efficiency** | ✅ Keep 40-60% | ✅ Monitor at 60-70%, stop at 80% |
| **Handoff Documents** | ✅ Research → Plan → Implementation | ✅ CURRENT_SYSTEM → NEW_FEATURES → PROGRESS |
| **Human Review Points** | ✅ After research, after plan | ✅ Interactive planning, checkpoint reviews |

---

## Document Structure Comparison

### Their Structure
```
thoughts/shared/
├── research/
│   └── YYYY-MM-DD_HH-MM-SS_topic.md (with YAML frontmatter)
└── plans/
    └── descriptive-name.md
```

**Characteristics**:
- Timestamped research files
- YAML metadata headers (date, researcher, git SHA, tags, status)
- Plans stored in shared directory
- Implementation updates plan file directly (checkboxes)

### Our Structure
```
spec/
├── CURRENT_SYSTEM.md (or system/*.md if split)
├── NEW_FEATURES.md
├── PROGRESS.md
├── RESEARCH_STATUS.md
├── PLANNING_STATUS.md
└── QUESTIONS.md
```

**Characteristics**:
- Role-based document ownership
- Living documents (rewrite, don't append)
- Explicit status tracking per role
- Clear handoff between roles

---

## Prompt Philosophy Comparison

### Research Agent

**Their Approach** (research_codebase.md):
- Role: "Documentarian, not critic"
- Strictly descriptive (no improvements/suggestions)
- YAML frontmatter with metadata
- Structured sections: Research Question, Summary, Detailed Findings, Code References, Architecture Insights
- Spawns specialized subagents (codebase-locator, codebase-analyzer)

**Our Approach** (researcher.md):
- Role: "Investigate and document existing system"
- "Behavior and integration points clear, implementation details minimal"
- Focus on what planner needs to know
- Structured: Overview, Architecture, Integration Points, Constraints
- Multi-file strategy for large systems (>800-1000 lines)
- Spawns Task agents (Explore/general-purpose)

**Similarity**: ~85% - Both avoid critique, both use subagents, both focus on understanding not improving
**Key Difference**: They use YAML metadata; we use multi-file splits for large systems

### Planning Agent

**Their Approach** (create_plan.md):
- "Skeptical, thorough, collaborative"
- 5-step process: Context → Research → Structure → Details → Review
- Interactive before writing details
- Template with sections: Overview, Current State, Desired End State, Phases, Success Criteria (automated + manual)
- Emphasizes "no open questions in final plan"
- Updates plan file with checkboxes during implementation

**Our Approach** (planner.md):
- Collaborative via QUESTIONS.md
- 2-3 phase specs recommended (not 5+)
- "User experience clear, implementation flexible"
- Template: Feature Requirements, User Impact, Technical Approach, Implementation Phases, Testing Requirements
- Separates automated and user verification
- REWRITE NEW_FEATURES.md (don't append)

**Similarity**: ~80% - Both interactive, both emphasize clarity, both separate automated/manual testing
**Key Differences**:
- They update plan with checkboxes; we keep separate PROGRESS.md
- We explicitly limit to 2-3 phases; they don't specify
- They use single plan file; we use role-specific files

### Implementation Agent

**Their Approach** (implement_plan.md):
- "Follow plan intent while adapting to reality"
- Sequential phases with verification after each
- Updates checkboxes in plan file
- Pause for human verification after automated tests
- "Trust completed work (checked items)"
- Can deviate if reality differs from plan (but must explain)

**Our Approach** (implementor.md):
- "ONE TASK PER SESSION" - absolute rule
- Follow spec literally
- REWRITE PROGRESS.md after each task
- Proof-required testing (paste actual terminal output)
- End-to-end user testing mandatory
- Check what you're replacing (capability verification)

**Similarity**: ~70% - Both emphasize verification, both sequential
**Key Differences**:
- **Major**: They continue through phases; we stop after one task
- **Major**: They update plan checkboxes; we rewrite PROGRESS.md
- **Major**: We have strict "paste output" rule; they don't explicitly mandate this
- We have stronger "follow spec literally" guidance

---

## Testing & Verification Comparison

### Their Approach
- Automated tests run after each phase
- Manual verification steps documented
- Pause for human verification
- Success criteria split: automated vs manual
- Real examples: 300k LOC in 1 hour, 35k LOC in 7 hours

### Our Approach
- "ABSOLUTE RULE: paste actual terminal output"
- Test EXACT commands from documentation
- End-to-end user testing mandatory
- Regression testing for replacements
- 27 refinements through iterative testing

**Similarity**: Both require proof, both separate automated/manual
**Key Difference**: We're more explicit about "paste output or it didn't happen"

---

## Context Management Comparison

### Their Strategy
- Target: 40-60% context usage
- "Frequent intentional compaction"
- Create summary documents
- Use commit messages for compaction
- Subagents prevent context pollution

### Our Strategy
- Monitor: 60-70% wrap up, 80% hard stop
- "Documentation is Not History"
- REWRITE, don't append
- Sub-agent delegation for verbose work
- Explicit token budget monitoring

**Similarity**: ~95% - Nearly identical philosophy
**Key Difference**: Slightly different percentage thresholds

---

## What They Have That We Don't

### 1. YAML Metadata System
Their research documents include:
```yaml
date: 2025-08-05 05:15:59 UTC
researcher: dex
commit: abc123
branch: canary
repository: baml
tags: [research, codebase, test-assertions]
status: complete
```

**Value**: Traceability, searchability, automation potential
**Relevance to us**: Could enhance our system, especially for multi-project usage

### 2. Checkbox-Based Progress Tracking
Plan files have:
```markdown
## Phase 1
- [ ] Step 1
- [ ] Step 2
- [x] Step 3 (completed)
```

**Value**: Visual progress, single source of truth
**Relevance to us**: Conflicts with our "one task per session" philosophy but interesting

### 3. Slash Command Integration
Uses `.claude/commands/` for command invocation

**Value**: Convenient invocation, IDE integration
**Relevance to us**: Platform-specific (Claude Desktop/CLI), we're agent-agnostic

### 4. Documented Real-World Results
- Bug fix: 300k LOC Rust codebase, 1 hour
- Feature: 35k LOC changes, 7 hours (vs 3-5 days each)
- Multiple PRs linked as examples

**Value**: Credibility, benchmarks
**Relevance to us**: We should document our results similarly

---

## What We Have That They Don't

### 1. Explicit "One Task Per Session" Rule
Our implementor stops after each task.

**Value**: Clean boundaries, easier debugging, prevents drift
**Uniqueness**: They continue through multiple phases

### 2. Multi-File System Documentation Strategy
When CURRENT_SYSTEM.md exceeds ~800-1000 lines:
```
spec/system/
├── architecture.md
├── integration-points.md
└── constraints.md
```

**Value**: Scalability for large systems
**Uniqueness**: They use single research files (though timestamped)

### 3. Aggressive "No Documentation Sprawl" Rules
Explicit allowed lists, DELETE unauthorized docs

**Value**: Prevents confusion, enforces discipline
**Uniqueness**: They don't explicitly address this (though they may handle it implicitly)

### 4. "Paste Output or It Didn't Happen" Testing Rule
Absolute requirement for actual terminal output

**Value**: Prevents fake verification (critical failure mode we discovered)
**Uniqueness**: They require verification but less explicit about the "paste output" requirement

### 5. Checkpoint Review Process
Researcher verifies after 2-3 implementations

**Value**: Catches drift, maintains accuracy
**Uniqueness**: Their cycle appears more linear (though they may do this implicitly)

### 6. Document Ownership Model
Each agent owns specific files:
- Researcher: CURRENT_SYSTEM, RESEARCH_STATUS
- Planner: NEW_FEATURES, PLANNING_STATUS, QUESTIONS
- Implementor: PROGRESS (+ updates NEW_FEATURES)

**Value**: Clear responsibilities, no overlap/confusion
**Uniqueness**: They use shared directory with timestamped files

### 7. Comprehensive Failure Pattern Documentation
meta_status.md documents 42 refinements and specific failure modes

**Value**: Learning from mistakes, continuous improvement
**Uniqueness**: Their system is more polished but doesn't show the iteration history

---

## Philosophical Differences

### Their Philosophy
- **Adaptable**: "Follow plan intent while adapting to reality"
- **Continuous**: Flow through phases in single session
- **Metadata-rich**: YAML frontmatter, detailed tracking
- **Tool-integrated**: Slash commands, Claude-specific features

### Our Philosophy
- **Literal**: "Follow spec literally" (if unclear, ask)
- **Atomic**: One task per session, clean stops
- **Minimal**: Only essential docs, aggressive pruning
- **Agent-agnostic**: Works with Claude, GPT-5, Gemini, etc.

**Neither is better** - they optimize for different constraints:
- They optimize for senior engineer productivity (adapt and flow)
- We optimize for reliability and debugging (stop and verify)

---

## Convergent Evolution Analysis

### Why We Both Arrived Here

1. **Context is the bottleneck** - Both recognized LLMs are stateless; only input quality matters
2. **Compaction is key** - Both use aggressive context management
3. **Subagents prevent pollution** - Both delegate exploration to separate contexts
4. **Human review at leverage points** - Both put humans where they add most value
5. **Phase separation works** - Research/Plan/Implement is natural decomposition

### Where We Diverged

1. **Task granularity**: They continue through phases; we stop after one task
2. **Document model**: They use timestamped files; we use role-owned living docs
3. **Platform coupling**: They integrate with Claude tooling; we stay generic
4. **Testing strictness**: We're more explicit about proof requirements
5. **Drift prevention**: We have checkpoint reviews; they rely on continuous flow

---

## Strengths & Weaknesses

### Their System Strengths
✅ **Proven results** - Documented real-world successes with metrics
✅ **Metadata system** - Better for multi-project, searchability
✅ **Flow efficiency** - Complete more in single session
✅ **Tool integration** - Slash commands are convenient
✅ **Polished** - Feels production-ready, well-documented

### Their System Potential Weaknesses
⚠️ **Multi-task risk** - Continuing through phases could accumulate errors
⚠️ **Claude-specific** - Slash commands lock to one platform
⚠️ **Less explicit testing** - Verification required but "paste output" not mandated
⚠️ **Historical tracking** - Timestamped files could accumulate (though useful for audit)

### Our System Strengths
✅ **Atomic tasks** - ONE task per session prevents error accumulation
✅ **Agent-agnostic** - Works with any coding agent platform
✅ **Explicit testing** - "Paste output" rule prevents fake verification
✅ **Document discipline** - Strong anti-sprawl, anti-bloat rules
✅ **Failure learning** - 27 documented refinements show iteration
✅ **Checkpoint reviews** - Catches drift early

### Our System Potential Weaknesses
⚠️ **More sessions** - One task per session means more handoffs
⚠️ **Less metadata** - No YAML tracking, harder to audit
⚠️ **Stricter** - "Follow spec literally" reduces adaptability
⚠️ **Less polished** - No real-world metrics documented yet

---

## Recommendations

### What We Should Consider Adopting

1. **YAML Metadata** (High Value)
   - Add frontmatter to research/plan docs
   - Track: date, git SHA, tags, status
   - Enables searchability, traceability, automation

2. **Documented Results** (High Value)
   - Document real usage with metrics
   - Link to actual PRs/implementations
   - Builds credibility and provides benchmarks

3. **More Flexible Implementation** (Medium Value)
   - Consider "follow plan intent" vs "follow literally"
   - Allow adaptation with explanation
   - Balance between rigidity and pragmatism

### What We Should Keep Distinct

1. **One Task Per Session** (Core Value)
   - This is our key differentiator
   - Prevents error accumulation
   - Easier debugging
   - Don't compromise this

2. **Agent-Agnostic Design** (Strategic Value)
   - Works across platforms
   - Future-proof as new models emerge
   - Don't tie to specific tooling

3. **Proof-Required Testing** (Critical Value)
   - "Paste output" rule prevents fake verification
   - This is a failure mode we discovered through testing
   - Make it even more prominent

4. **Document Ownership Model** (Organizational Value)
   - Clear responsibilities per agent
   - Prevents confusion
   - Works well for our atomic approach

### Areas for Further Investigation

1. **Hybrid Approach?**
   - Could we support both modes?
   - "Quick flow" mode (their approach) vs "Careful atomic" mode (ours)
   - User selects based on task complexity/risk

2. **Metadata Without Platform Lock-in**
   - YAML frontmatter doesn't require Claude-specific features
   - We could add this to our documents easily

3. **Better Progress Visualization**
   - Checkboxes are nice for tracking
   - Could we use them without multi-task creep?
   - Maybe in plan phase only?

4. **Cross-System Learning**
   - Their Y Combinator talk and weekly sessions suggest community
   - Could we learn from their real-world experiences?
   - Share our failure patterns with them?

---

## Conclusions

### We Built Essentially the Same Thing
Both systems recognize that **context management is the core challenge** in AI coding. The three-phase workflow (Research-Plan-Implement) appears to be the natural solution. We've independently validated the same core insights.

### Our Tactical Differences Are Complementary
- They optimize for **flow and productivity**
- We optimize for **reliability and verification**

Neither is universally better - they solve slightly different problems.

### Our System Is More Paranoid (In a Good Way)
Our 27 refinements show we've battle-tested against failure modes:
- Fake verification → "paste output" rule
- Multi-task creep → ONE task per session
- Documentation sprawl → explicit allowed lists
- Spec reinterpretation → "follow literally"

These aren't theoretical - we discovered them through real failures.

### Their System Is More Proven
- Documented metrics (1 hour, 7 hours, etc.)
- Real PRs linked
- Multiple case studies
- Y Combinator presentation

We should document our results similarly.

### The Convergence Validates Both Approaches
The fact that two independent efforts arrived at nearly identical solutions is strong evidence that this is the **right architecture** for AI-assisted coding in complex codebases.

---

## Next Steps for Discussion

1. **Should we adopt YAML metadata?**
   - Pros: Traceability, searchability, professionalism
   - Cons: Adds complexity, requires discipline
   - Recommendation: Yes, high value for minimal cost

2. **Should we maintain "one task per session"?**
   - This is our key differentiator
   - Recommendation: Yes, but document why (error prevention)

3. **Should we make testing rules even more explicit?**
   - Our "paste output" rule seems like a discovered insight they don't have
   - Recommendation: Yes, make it even more prominent

4. **Should we document real-world results?**
   - They have metrics; we don't
   - Recommendation: Yes, credibility matters

5. **Should we explore hybrid modes?**
   - Support both atomic and flow modes?
   - Recommendation: Maybe later, don't dilute focus now

6. **Should we reach out to them?**
   - Share learnings, compare notes
   - Recommendation: Consider it, could benefit both systems

---

## Final Thought

**We independently solved the same problem and converged on nearly identical solutions.** This is the strongest possible validation that we're on the right track.

The differences between our systems are complementary, not contradictory. There's value in:
- Learning from their polished presentation and documented results
- Preserving our paranoid testing and atomic task discipline
- Potentially merging the best of both approaches

**Status**: Ready for discussion on which elements to adopt, which to preserve, and where to go next.
