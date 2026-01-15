# Proposal: Restoring Critical Agent Instructions

## Overview
Recent efforts to reduce prompt size (`Refinement #65`) inadvertently removed critical operational instructions. This proposal identifies high-value sections to restore to improve agent reliability, specifically addressing:
1.  **Manager:** Hallucinating tools due to vague delegation instructions.
2.  **Implementor:** Lower quality output due to missing verification and coding standards.
3.  **Planner/Researcher:** Loss of specific "how-to" guidance for their artifacts.

---

## 1. Implementation Manager
**Problem:** Manager sometimes uses incorrect tools ("skills") or vague prompts because the specific `Task tool` template was removed.

### Restore: "Spawning Implementors" Template
*Why: Forces the manager to use the correct tool structure and explicitly tells the sub-agent what to do.*

```markdown
### Spawning Implementors

Delegate using the `delegate_to_agent` tool.

**Objective Template:**
"You are a sub-agent.
Task: [Specific task description]
Context: Task [N] of [Total]
Steps:
1. Implement the feature
2. Verify it works (create test/script)
3. Update ongoing-changes/implementor-progress.md
4. Return IMPLEMENTATION SUMMARY"
```

### Restore: "Processing Reports" Logic
*Why: Ensures the manager correctly parses the sub-agent's return value to decide on the next step.*

```markdown
### Processing Reports
Expect `IMPLEMENTATION SUMMARY` from sub-agent.
- **Success**: Mark complete ✅ in `manager-progress.md`.
- **Blocked**: Mark blocked 🚫, STOP, and report to human.
- **Context Limit**: If task incomplete, spawn fresh agent to continue.
```

---

## 2. Implementor
**Problem:** "Verification First" mindset and coding standards were lost, potentially leading to untested or complex code.

### Restore: "Verification FIRST" Process Step
*Why: Critical for TDD/quality. Prevents "it looks like it works" code.*

```markdown
### 2. Verification FIRST
Before coding, create a verification strategy (test or script).
- **Automated tests** (preferred): `pytest tests/test_feature.py`
- **Verification script**: `tools/verify_feature.sh`
- **Procedure**: Documented manual steps for interactive features.

**Rule:** If verification fails, fix code. Do not document broken features as complete.
```

### Restore: "Coding Standards" (Condensed)
*Why: Prevents over-engineering.*

```markdown
## Coding Standards
- **Clarity over Cleverness**: clear names > short names.
- **Comments**: Only if code cannot be made clear. No "updated X" comments.
- **Complexity Budget**: Default to simple. No abstractions without 3+ concrete use cases.
- **Delete Freely**: Remove unused code/files.
```

---

## 3. Planning Agent
**Problem:** Specs might drift into implementation details or lack verification strategies.

### Restore: "Spec Standards"
*Why: Keeps the planner focused on "WHAT" vs "HOW".*

```markdown
## Spec Standards
- **No Implementation Code**: Describe behavior, not algorithms.
- **Verification Strategy**: For EACH feature, specify *how* to verify it (e.g., "User sees error X when Y").
- **Keep it Simple**: Max 2-3 phases.
```

---

## 4. Research Agent
**Problem:** Researcher might just read comments/docs instead of verifying code truth.

### Restore: "Verification Mindset"
*Why: Ensures the researcher documents reality, not just intent.*

```markdown
## Verification Mindset
**Trust code, not claims.**
- Verify comments against actual code behavior.
- Run tests/scripts to confirm system state.
- If tests fail, document "System state unclear/failing".
```

### Restore: "Sub-Agent Mode"
*Why: Optimized path for when the Planner calls the Researcher (avoids full system documentation loop).*

```markdown
## Sub-Agent Mode (when called by Planner)
1. Answer the specific question.
2. Update `spec/current-system.md` with new findings.
3. Return `RESEARCH SUMMARY` with answer and key constraints.
```

---

## Next Steps
Upon approval, I will:
1.  Update `agents/src/_[role].md` files with these restored sections.
2.  Run `build_prompts.sh` to regenerate commands.
