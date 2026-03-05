# Claude Code User Instructions

## Up to Date Information

Your knowledge has a cutoff. **Always use web search** to get current information before using libraries, models, tools, or APIs. Do not trust your training data for version-specific or recent documentation. If web search is unavailable, stop and report the problem.

---

## GitHub

Use the `gh` CLI for all GitHub interactions (PRs, issues, checks, releases, API calls). Do not use the GitHub web UI or raw API calls when `gh` can do the job.

---

## AGENTS.md Fallback

If a project has an `AGENTS.md` file but no `CLAUDE.md`, read `AGENTS.md` as the project instructions — it serves the same purpose for other AI coding tools.

---

## Coding Standards

### Read Before Writing

Never assume APIs exist or work a certain way. Always read the actual implementation files first:
- Class interfaces and method signatures
- How objects are constructed and initialized
- What properties/methods actually exist
- Type hierarchies and constraints

### Avoid Over-Engineering

- **Minimal comments** - only where logic isn't self-evident
- Do not add comments to explain a change - the next reader won't know what used to be there
- Don't add docstrings, comments, or type annotations to code you didn't change
- Only make changes that are directly requested or clearly necessary
- Keep solutions simple and focused
- Don't add features, refactor code, or make "improvements" beyond what was asked

### Don't Design for Hypothetical Requirements

- Don't add error handling, fallbacks, or validation for scenarios that can't happen
- Trust internal code and framework guarantees
- Only validate at system boundaries (user input, external APIs)
- Don't use feature flags or backwards-compatibility shims when you can just change the code
- Don't create helpers, utilities, or abstractions for one-time operations
- Three similar lines of code is better than a premature abstraction

### Backwards Compatibility

- Avoid backwards-compatibility hacks like renaming unused `_vars`, re-exporting types, or adding `// removed` comments
- **If something is unused, delete it completely**

### Security

Be careful not to introduce security vulnerabilities:
- Command injection
- XSS (Cross-Site Scripting)
- SQL injection
- Other OWASP Top 10 vulnerabilities
- Never commit secrets (API keys, tokens, passwords) to a repository

**If you notice you wrote insecure code, immediately fix it.**

---

## TDD — Tests as Sensory Feedback

Tests are not just verification. They are the primary way an agent understands whether the system is working correctly.

**Write tests that exercise the real system end-to-end.** Not mocks of mocks, not isolated unit tests that can't see actual behaviour. Tests that call through the real stack and produce real output.

**Run tests, read the failure output, understand the system from that.** A failing test with a clear error message tells you more about what's wrong than reading 10 source files. That failure output IS your understanding of the system.

**Tests before implementation — always.** Write acceptance tests first, confirm they fail, then implement. A test that passes before you've written implementation is either testing the wrong thing or the feature already exists — investigate which.

**The full cycle for every change:**
1. Write failing tests that describe the desired behaviour
2. Implement the minimum to make them pass
3. Run the full suite — no regressions
4. Refactor (the working implementation is a draft, not the final version)

**Tests are the contract between agents.** When work is handed off, passing tests are proof. Claimed-complete work with no tests is not done.

**Before marking anything complete:** have a sub-agent do a fresh-eyes code review of the changed files. They will catch what you missed.

---

## Work Continuity

### Complete Tasks Without Stopping

- Work through tasks to completion unless you encounter a blocker
- Don't stop for optional clarifications or minor decisions
- Make reasonable assumptions when specifications are clear enough
- Only pause when you genuinely need critical information you cannot infer

### When to Ask Questions

Use the AskUserQuestion tool when:
- Requirements are genuinely ambiguous or contradictory
- Multiple valid approaches exist and the choice significantly impacts the implementation
- You need to make architectural decisions you're uncertain about
- You encounter an actual blocker that prevents you from proceeding

**Don't ask questions for:**
- Minor implementation details you can reasonably decide
- Formatting preferences when existing code shows a pattern
- Optional enhancements that weren't requested

---

## Planning and Autonomous Work

### NEVER Use EnterPlanMode Tool

The EnterPlanMode tool forces a mandatory approval checkpoint that conflicts with autonomous work. Instead:

- **Write plans directly** to a `plan.md` file in the appropriate location
- **Respect user instructions** about whether to wait for approval or proceed immediately
- **If instructed to work autonomously**, proceed directly from planning to implementation without stopping

### Planning Workflow

When a task requires planning:

1. **Do your research** - Read relevant code, understand the system
2. **Write the plan** - Create a clear, actionable plan in a markdown file
3. **Follow user intent**:
   - If user says "plan and wait for approval" → Ask for approval using AskUserQuestion
   - If user says "work autonomously" or "I won't be available" → Proceed directly to implementation
   - If unclear, default to proceeding (user can interrupt if needed)

**Never let tooling force you to stop when the user explicitly requested autonomous work.**

---

## Agent Workflow

When working on larger tasks that benefit from sub-agents, there are three modes:

**Main session** (default) — Investigations, explorations, planning discussions, small changes. CLAUDE.md gives you ambient context. No special command needed.

**`/implement` sub-agent** — For a single well-defined task. Follows the 4-phase TDD workflow: write failing tests → design → implement → refactor. One task, verify, stop. Do not spawn this until you have clear acceptance criteria and a defined verification method.

**`/manage` orchestrator** — For multiple independent tasks. Spawns `/implement` workers. Stays under 30% context. Tracks via `ongoing-changes/manager-progress.md`.

**Rule**: Do not spawn sub-agents for investigation or planning. Those belong in the main session.
