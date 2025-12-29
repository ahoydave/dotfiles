# AI Coding Workflow Comparisons

**Date**: 2025-12-26
**Status**: Active Analysis
**Workflows Analyzed**: 5 systems (ACE-FCA, Our System, Lmorchard, Addyo, Ralph, 12-Factor)

---

## Quick Reference Matrix

| System | Phases | Context Strategy | Testing | Philosophy | Unique Value |
|--------|--------|------------------|---------|------------|--------------|
| **ACE-FCA** | 3 (R→P→I) | 40-60% handoffs | Unspecified | Structured autonomy | Proven metrics |
| **Our System** | 3+ atomic | Agent-agnostic docs | Proof-required | Paranoid reliability | Verifiable tasks |
| **Lmorchard** | 7 waterfall | Session resets | Manual review | Managed partnership | Reflection phase |
| **Addyo** | 5 sequential | Bundled repos | Multi-model CI/CD | Supervised iteration | Cross-validation |
| **Ralph** | 1 continuous | Single PROMPT.md | Implicit | Radical minimalism | Cost efficiency |
| **12-Factor** | Principles | Own your context | Error compaction | Control over magic | Engineering discipline |

---

## Detailed Comparisons

### 1. Les Orchard - "Semi-Automatic Coding"

**Source**: https://blog.lmorchard.com/2025/06/07/semi-automatic-coding/

#### Workflow Structure
```
spec.md (intentions)
  → plan.md (concrete steps)
  → plan refinement (iterative)
  → execution (supervised)
  → notes.md (reflection)
```

**7 Phases**: Init → Specification → Planning → Refinement → Execution → Supervision → Reflection

#### Key Innovations
- ✨ **notes.md reflection phase** - Post-implementation AI synthesis of learnings
- ✨ **Model personality swapping** - Different LLMs for different "temperaments"
- ✨ **ADHD-optimized framing** - Context-switching as feature, not bug
- ✨ **Waterfall as breathing room** - Deliberately extended phases for human pacing

#### Context Management
- **Strategic session resets** when conversation unwieldy
- **Artifact-driven isolation** (spec/plan/notes as boundaries)
- **Embraces token limits** as forced focus mechanism
- Model swapping mid-workflow for fresh perspective

#### Testing Approach
- Minimal structured testing
- Relies on: Git commits as checkpoints, manual review during generation, human redirection
- **Major gap**: No proof requirements or automated verification

#### Comparison to Our System
| Dimension | Lmorchard | Our System |
|-----------|-----------|------------|
| Task granularity | Waterfall phases | Atomic tasks |
| Reflection | **Explicit notes.md** | Not emphasized |
| Supervision | **During generation** | After completion (proof) |
| Context | Session resets | Agent-agnostic handoffs |
| Philosophy | Partnership rhythm | Verifiable completion |

**Unique contribution**: Reflection as structured artifact. Notes phase captures emergent learnings that other systems lose.

**Missing from Lmorchard**: Proof-required testing, automated verification, multi-session reliability

---

### 2. Addy Osmani - "My LLM Coding Workflow"

**Source**: https://addyo.substack.com/p/my-llm-coding-workflow-going-into

#### Workflow Structure
```
Plan → Design → Iterative Development → Verification → Integration
```

**"Waterfall in 15 minutes"** - Heavy upfront planning before any code

#### Key Innovations
- ✨ **Multi-model cross-validation** ("Model Musical Chairs") - Same prompt to Claude/Gemini/GPT for consensus
- ✨ **Chrome DevTools MCP** - AI gets browser runtime access for debugging
- ✨ **Claude Skills Framework** - Modular pattern-triggered workflows
- ✨ **Worktree isolation** - Parallel AI sessions in separate git worktrees
- ✨ **AI-reviewing-AI** - Secondary model reviews primary model's code

#### Document Structure
- `spec.md` - Requirements, architecture, data models, testing strategy
- `plan.md` - Sequential task breakdown
- `CLAUDE.md` / `GEMINI.md` - Model-specific process rules
- Linear handoff: Each phase outputs → next phase inputs

#### Context Management
- **Comprehensive bundling**: Uses `gitingest`, `repo2txt` to package entire repos
- **Selective filtering**: Despite large windows, explicitly tells AI what to exclude
- **Guided prompts**: "Here's X, extend to Y, don't break Z" pattern
- **Persistent docs**: Model-specific instruction files

#### Testing Approach
**Multi-layered verification**:
- TDD integration (tests per feature)
- Automated CI/CD (linting, style, tests)
- Staging deployments per branch
- **AI code reviews by different models**
- Mandatory manual line-by-line review

#### Core Principles
1. "Stay in control" - Developer = senior, AI = junior pair
2. "Specs before code" - No direct coding without planning
3. "Small manageable tasks" - Step-by-step execution
4. "Critical thinking remains key" - LLM programming is "difficult and unintuitive"
5. "Don't skip reviews" - Extra scrutiny required

#### Comparison to Our System
| Dimension | Addyo | Our System |
|-----------|-------|------------|
| Planning | Heavy upfront | Collaborative questions.md |
| Verification | **Multi-model + CI/CD** | Proof-required single agent |
| Context | Bundled repos | Minimal per-task |
| Tooling | **DevTools MCP, Skills** | Agent-agnostic |
| Philosophy | Supervised iteration | Task independence |

**Unique contribution**: Multi-model validation as quality strategy. Using LLM diversity for cross-checking.

**Interesting tooling**: DevTools MCP gives AI actual debugging runtime access (novel integration)

**Assessment**: 70% derivative of ACE-FCA, 30% original (multi-model strategy, runtime tools, Skills framework)

---

### 3. Geoffrey Huntley - "Ralph"

**Source**: https://ghuntley.com/ralph/

#### Workflow Structure
```
PROMPT.md (single file) → Agent loop (infinite) → Operator intervention (when fails)
```

**Single-phase continuous loop** - No discrete research/plan/implement separation

#### Key Innovations
- ✨ **Infinite loop architecture** - Never "completes," continuously regenerates
- ✨ **Guitar tuning metaphor** - Iterative prompt refinement vs debugging
- ✨ **Greenfield focus** - Explicitly designed for new projects only
- ✨ **Radical minimalism** - Anti-complexity stance

#### Context Management
- **Single persistent file**: `PROMPT.md` serves as entire specification
- No handoff between agents/phases
- Context accumulates through prompt refinement (add guardrails when failures occur)

#### Testing Approach
- **Not explicitly described**
- Implicit: Operator observes failures → refines prompts → re-runs loop
- No formal proof requirements or verification protocol

#### Core Principles
- **"Deterministically bad in an undeterministic world"** - Predictable failure modes
- **Prompt tuning over system redesign** - Refine instructions, don't restructure
- **Operator skill primacy** - Effectiveness depends on prompt engineering expertise
- **Extreme cost efficiency claim**: $50k contracts for $297 in compute

#### Comparison to Our System
| Dimension | Ralph | Our System |
|-----------|-------|------------|
| Phases | 1 (continuous) | 3+ (atomic tasks) |
| Context | Single PROMPT.md | Proof artifacts + tests |
| Handoffs | None (operator only) | Task-to-task verification |
| Testing | Implicit/undefined | Proof-required mandatory |
| Complexity | **Minimal (purposefully)** | High (quality-focused) |
| Best for | **Greenfield MVPs** | Production-grade code |

**Unique contribution**: Challenges assumption that AI workflows need structure. Maximum simplification.

**Philosophy**: Opposite direction from ACE-FCA. While ACE adds structure, Ralph removes it.

**Key limitation**: No public evidence of scalability beyond greenfield or long-term maintainability.

**Relationship to "stdlib"**: No explicit connection found. Refined PROMPT.md files could become reusable templates, but not formalized.

---

### 4. HumanLayer - "12-Factor Agents"

**Source**: https://github.com/humanlayer/12-factor-agents

#### Relationship to ACE-FCA
- **Complementary, different layers**: ACE-FCA = deployment/operational architecture; 12-Factor = engineering principles
- **Same team, different purposes**: ACE-FCA is "how to structure agent infrastructure"; 12-Factor is "how to build reliable agent code"
- **Compatible**: Build 12-Factor agents, deploy with ACE-FCA

#### The 12 Factors

1. **Natural Language → Tool Calls** - Transform unstructured input to structured actions
2. **Own Your Prompts** - Explicit control over prompt templates
3. **Own Your Context Window** - Strategic context management
4. **Tools Are Structured Outputs** - Demystify "tools" as JSON schema generation
5. **Unify Execution & Business State** - Track agent workflow state
6. **Launch/Pause/Resume APIs** - Pausable agent execution
7. **Contact Humans with Tool Calls** - Unified agent/human interaction
8. **Own Your Control Flow** - Explicit routing logic
9. **Compact Errors into Context** - Distill errors concisely
10. **Small, Focused Agents** - Specialized agents for different tasks
11. **Trigger from Anywhere** - Multi-channel deployment
12. **Stateless Reducer Pattern** - `f(context, event) → new_state`

#### Coding-Specific Factors
- **#9: Compact Errors** - Critical for compilation errors, test failures
- **#10: Small, Focused Agents** - Specialized code agents

#### General Agent Principles (80% of factors)
- #2, #3, #4, #8: Control over prompts, context, tools, flow
- #5, #6, #12: State management patterns
- #7: Human-in-the-loop
- #11: Multi-channel deployment

#### Factors We Already Follow
- ✅ #1: Natural Language → Tool Calls (Claude Code native)
- ✅ #7: Contact Humans (questions.md pattern)
- ✅ #10: Small, Focused Agents (research/plan/implement separation)
- ✅ #11: Trigger from Anywhere (CLI-first, extensible)
- ✅ Partial #12: Stateless Reducer (agents relatively stateless)

#### Factors to Consider Adopting

**High Priority**:
- **#3: Own Your Context Window** - More deliberate about what context goes to each agent
  - Currently passing full context; could optimize token usage
  - Strategic pre-fetching of relevant files

- **#8: Own Your Control Flow** - More explicit routing logic between agents
  - Currently relies on agent autonomous decisions
  - Could add explicit orchestration layer

- **#9: Compact Errors into Context** - Better error summarization
  - When tests fail, distill errors concisely
  - Prevent context overflow from verbose stack traces

**Medium Priority**:
- **#2: Own Your Prompts** - More explicit prompt templates per agent
- **#5: Unify Execution & Business State** - Track agent execution state

#### Unique Insights Beyond ACE-FCA

1. **"Own Your X" philosophy** - Active control vs framework magic
2. **Stateless Reducer Pattern** - Functional approach to agents (`f(context, event) → new_state`)
3. **Strategic LLM placement** - "Mostly just software" with LLMs at key decision points
4. **Tool calls = Structured outputs** - Reduces vendor lock-in thinking
5. **Error compaction** - Specific guidance for context-constrained error handling
6. **Human contact via tool calls** - Unifying agent/human interaction model

#### Philosophy Difference
- **ACE-FCA**: Build for scale, distribution, production operations
- **12-Factor**: Build for control, reliability, integration with existing products
- **ACE-FCA says**: "Here's how to architect agent systems"
- **12-Factor says**: "Here's how to write agent code that won't bite you"

#### Value for Our System
- #3 (Context Window) - Optimize token usage per agent
- #8 (Control Flow) - Explicit agent orchestration
- #9 (Compact Errors) - Better error summarization for coding tasks
- #10 (Small, Focused Agents) - Validates our multi-agent approach
- **Philosophy**: "Mostly software with strategic LLM steps" - Perfect for coding agents

**Recommendation**: Worth implementing 3-4 factors as explicit improvements.

---

## Synthesis: Cross-Cutting Patterns

### Pattern 1: Context Management is Universal
**All systems recognize context as the bottleneck**:
- ACE-FCA: 40-60% handoffs
- Our System: 40-50% wrap, 60% hard stop
- Lmorchard: Strategic session resets
- Addyo: Selective bundling despite large windows
- Ralph: Single file accumulation
- 12-Factor: "Own Your Context Window" (#3)

**Convergence**: Context management is THE core challenge, not model capability.

### Pattern 2: Phase Separation Spectrum

```
Ralph (1 phase) ← → Lmorchard (7 phases)
         ↑
    Our System (3+) ≈ ACE-FCA (3) ≈ Addyo (5)
```

**Sweet spot**: 3-5 phases with clear boundaries. Too few = chaos, too many = overhead.

### Pattern 3: Testing Approaches Diverge Dramatically

| System | Testing Philosophy |
|--------|-------------------|
| **Our System** | Proof-required (paste output) |
| **Addyo** | Multi-model validation + CI/CD |
| **ACE-FCA** | Unspecified |
| **Lmorchard** | Manual review during generation |
| **Ralph** | Implicit (fix when breaks) |
| **12-Factor** | Error compaction (#9) |

**Our unique stance**: Most explicit about proof requirements. Others mention testing but we mandate verification evidence.

### Pattern 4: Document Structure Philosophy

**Living documents** (rewrite, don't append):
- Our System: Explicit REWRITE requirement
- ACE-FCA: Frequent compaction
- 12-Factor: Stateless reducer pattern

**Append-friendly documents**:
- Lmorchard: notes.md accumulates learnings
- Addyo: Plan/spec persist across iterations
- Ralph: PROMPT.md accumulates guardrails

**Timestamped archives**:
- ACE-FCA: Research files with timestamps

**Tradeoff**: Living docs = token efficient; Archives = audit trail

### Pattern 5: Human-in-the-Loop Strategies

- **Our System**: Interactive planning (questions.md), checkpoint reviews
- **ACE-FCA**: After research, after plan
- **Lmorchard**: Supervision during generation
- **Addyo**: Multi-layered reviews (manual + AI)
- **Ralph**: Operator intervention on failures
- **12-Factor**: Tool calls for human contact (#7)

**Convergence**: All systems put humans at leverage points, not continuous oversight.

### Pattern 6: Unique Innovations by System

| Innovation | System | Adoption Potential |
|------------|--------|-------------------|
| **Multi-model validation** | Addyo | High - quality through diversity |
| **Reflection phase (notes.md)** | Lmorchard | Medium - learning capture |
| **DevTools MCP integration** | Addyo | Medium - runtime debugging |
| **Proof-required testing** | **Our System** | High - prevents fake verification |
| **Atomic tasks (ONE per session)** | **Our System** | Medium - tradeoff speed for reliability |
| **Radical minimalism** | Ralph | Low - greenfield only |
| **12-Factor principles** | HumanLayer | High - engineering discipline |
| **Error compaction** | 12-Factor | High - context efficiency |
| **Model personality swapping** | Lmorchard | Low - interesting but niche |

---

## Convergent Evolution Summary

### What Everyone Agrees On
1. ✅ **Context management is the bottleneck** (not model capability)
2. ✅ **Phase separation works** (research/plan/implement or variations)
3. ✅ **Subagents prevent context pollution** (delegate exploration)
4. ✅ **Human review at leverage points** (after major phases)
5. ✅ **Document-driven handoffs** (not just conversation history)

### Where Systems Diverge

**Granularity spectrum**:
- Ralph (continuous) ← Addyo/ACE (phased) ← Our System (atomic)

**Philosophy spectrum**:
- Flow (ACE, Addyo) ← → Reliability (Our System, 12-Factor)
- Adaptability (Lmorchard, Ralph) ← → Literal specs (Our System)
- Simplicity (Ralph) ← → Structure (ACE-FCA, Our System)

**Testing rigor**:
- Implicit (Ralph) ← Manual (Lmorchard) ← Multi-layer (Addyo) ← Proof-required (Our System)

### Our Unique Position

**Paranoid and Proud**:
- Most explicit testing requirements (paste output rule)
- Most atomic task boundaries (ONE per session)
- Most aggressive anti-sprawl rules (explicit allowed lists)
- Most agent-agnostic (works with any LLM)

**Philosophy**: We optimize for reliability and verification over flow and speed.

**Validation**: 12-Factor principles align with our approach (control, small agents, error compaction).

---

## Recommendations for Our System

### Adopt from Other Systems

**High Priority** (should implement):

1. **Multi-model validation** (from Addyo)
   - Run critical specs/code through multiple LLMs
   - Quality through diversity
   - Implementation: Add "verify with different model" step

2. **Error compaction** (from 12-Factor #9)
   - When tests fail, distill errors concisely
   - Prevent context overflow from stack traces
   - Implementation: Add error summarization step

3. **Own Your Context Window** (from 12-Factor #3)
   - More deliberate about what context goes to each agent
   - Strategic pre-fetching vs full dumps
   - Implementation: Optimize entry point reads

4. **Reflection capture** (from Lmorchard)
   - Optional notes.md for non-obvious learnings
   - Capture emergent insights
   - Implementation: Add to researcher or meta-agent

**Medium Priority** (consider):

5. **Model swapping flexibility** (from Lmorchard)
   - Allow different models for different phases
   - Already agent-agnostic, just formalize it
   - Implementation: Document model selection guidance

6. **DevTools-style MCP integration** (from Addyo)
   - Runtime debugging access for web projects
   - Implementation: Explore MCP server integrations

**Low Priority** (interesting but not critical):

7. **Checkbox progress tracking** (from ACE-FCA)
   - Visual progress in specs
   - Conflicts with atomic task philosophy
   - Implementation: Maybe for planner phase only

### Preserve Our Unique Strengths

**Don't compromise**:
1. ✅ **ONE task per session** - Our key differentiator
2. ✅ **Proof-required testing** - Prevents fake verification
3. ✅ **Agent-agnostic design** - Future-proof
4. ✅ **Document ownership model** - Clear responsibilities
5. ✅ **Atomic task boundaries** - Error prevention

### Document Real-World Results

**Gap identified**: All other systems have metrics/examples:
- ACE-FCA: "300k LOC in 1 hour"
- Addyo: "Feature in 7 hours vs 3-5 days"
- Ralph: "$50k contracts for $297"
- Our System: ??? (no documented metrics)

**Action**: Document real usage with metrics, link to PRs/implementations.

---

## Meta-Insight: The Two Philosophies

### Flow Philosophy (ACE-FCA, Addyo, Lmorchard)
- **Optimize for**: Developer productivity, rapid iteration
- **Assume**: Senior engineers on familiar codebases
- **Accept**: Some errors, fix as you go
- **Value**: Speed, adaptability, flow state

### Reliability Philosophy (Our System, 12-Factor)
- **Optimize for**: Verifiable correctness, debugging ease
- **Assume**: Any codebase, any skill level
- **Accept**: Slower iteration, more handoffs
- **Value**: Proof, atomicity, clarity

**Neither is universally better** - they solve different problems.

**Our niche**: Production-grade code on unfamiliar codebases with verifiable quality.

---

## Future Considerations

### Hybrid Modes?
Could we support both philosophies?
- **Quick mode**: Flow-oriented for prototyping (like ACE-FCA)
- **Careful mode**: Atomic tasks for production (current system)
- User selects based on task risk/complexity

### Cross-System Learning
- Share our "paste output" insight with ACE-FCA team
- Learn from Addyo's multi-model validation
- Adopt 12-Factor error compaction
- Community cross-pollination

### Evolution Areas
1. **Better error handling** - 12-Factor #9 guidance
2. **Context optimization** - 12-Factor #3 principles
3. **Multi-model quality** - Addyo's cross-validation
4. **Learning capture** - Lmorchard's reflection phase
5. **Metrics documentation** - All systems have this except us

---

## Conclusion

**We've validated the core approach**: Independent convergence on Research→Plan→Implement with context management proves this is the right architecture.

**Our position is clear**: More paranoid, more verifiable, more atomic than alternatives. This is a feature, not a bug.

**High-value adoptions**: Error compaction, multi-model validation, context optimization, learning capture.

**Preserve**: ONE task per session, proof-required testing, agent-agnostic design.

**Next step**: Implement 3-4 improvements from other systems while preserving our unique strengths.

---

**Status**: Ready for refinement discussion and implementation planning.
