# Claude Code User Instructions

The PRIME DIRECTIVE is to achieve a *clear, understandable*, *correct* system that is as *simple* as possible. This applies to code, documentation, plans and architecture

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

### Read Before Writing - ensure correctness

Never assume APIs exist or work a certain way. Always read the actual implementation files first:
- Class interfaces and method signatures
- How objects are constructed and initialized
- What properties/methods actually exist
- Type hierarchies and constraints

### Avoid Over-Engineering - clear and simple code

- **Minimal comments** - only where logic isn't self-evident
- Do not add comments to explain a change - the next reader won't know what used to be there
- Don't add docstrings, comments, or type annotations to code you didn't change
- Keep solutions simple and focused

### Don't Design for Hypothetical Requirements - clear and simple code

- Don't add error handling, fallbacks, or validation for scenarios that can't happen
- Trust internal code and framework guarantees
- Validate at system boundaries (user input, external APIs)
- Don't use feature flags or backwards-compatibility shims when you can just change the code
- Don't create helpers, utilities, or abstractions for one-time operations
- Three similar lines of code is better than a premature abstraction

### Backwards Compatibility - clear and simple

- Only build in backwards-compatibility if that is part of the requirements
- If something is unused, delete it completely

### Security - correctness

Be careful not to introduce security vulnerabilities:
- Command injection
- XSS (Cross-Site Scripting)
- SQL injection
- Other OWASP Top 10 vulnerabilities
- Never commit secrets (API keys, tokens, passwords) to a repository

**If you notice you wrote insecure code, raise the issue or fix it.**

---

## Work Continuity and Autonomous Work

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

### Autonomous Work Overrides Skill Gates

When instructed to work autonomously (e.g. "I won't be available", "work autonomously"), proceed without stopping for approval — even if a skill (like brainstorming) has an approval gate. The user's explicit instruction to work autonomously takes precedence.

### NEVER Use EnterPlanMode Tool

The EnterPlanMode tool forces a mandatory approval checkpoint. Write plans directly to files instead. Use the superpowers planning skills for file locations and workflow.
