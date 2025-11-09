# Repeatable Test Suite Framework

## The Problem We're Solving

Agents were testing features once (and pasting output) but not building **repeatable tests** that future agents could run. This meant:
- Researcher couldn't verify implementations by running tests
- No accumulation of test coverage as features were built
- "Code exists" ≠ "Feature works from user perspective"

## The Solution: Test Suite as First-Class Deliverable

Every feature implementation must produce:
1. **The feature code** (obviously)
2. **Repeatable tests** that verify the feature works end-to-end
3. **Documentation** of how to run those tests

## Test Types

### 1. Automated Tests (`tests/` directory)
- Unit tests
- Integration tests
- Run via test framework (pytest, jest, cargo test, etc.)
- **Advantage**: Can run in CI, deterministic
- **Use for**: Code-level verification

### 2. Verification Scripts (`tools/verify_*.sh`)
- End-to-end user experience tests
- Shell scripts that exercise the system as a user would
- **Advantage**: Tests the ACTUAL user experience
- **Use for**: Feature-level verification

### 3. Manual Test Procedures (documented in README or docs/)
- Step-by-step instructions
- Expected outcomes clearly stated
- **Advantage**: Catches UX issues
- **Use for**: Complex workflows, UI testing

## Implementation Workflow Changes

### BEFORE Coding (Planning Your Tests)
Implementor must answer:
- **What** am I testing? (Not "code exists" - what's the USER EXPERIENCE?)
- **How** will I test it repeatably? (Script? Automated test? Documented procedure?)
- **Where** will the test live? (tests/, tools/, README?)
- **Can a future agent run this?** (No manual setup, clear commands)

### DURING Coding (Creating Tests)
As you implement:
- Write automated tests alongside code (TDD or test-after-code)
- Or create verification scripts that test end-to-end
- Or document manual test procedure with EXACT commands

### AFTER Coding (Running Tests)
1. **Run your NEW tests** - Paste output proving they pass
2. **Run EXISTING tests** - Regression check (paste output)
3. **Run end-to-end verification** - Test as a user would (paste output)

### Documentation Requirements
Update one of:
- **README.md**: "To verify X feature works: run Y command"
- **tests/README.md**: Document test suite structure
- **Script comments**: Clear usage instructions

## Researcher Workflow Changes

### Verification by Running Tests
Instead of just reading code, researcher:
1. **Finds the test suite**: Where are tests? How to run them?
2. **Runs the tests**: Execute all tests to verify system state
3. **Documents results**: Do implementations match reality?
4. **Identifies gaps**: Features without tests = unverified

### In CURRENT_SYSTEM.md
Add section:
```markdown
## Verification

**Test Suite Location**: `tests/` + `tools/verify_*.sh`

**Run All Tests**:
```bash
pytest tests/                    # Automated tests
./tools/verify_screenshots.sh   # Screenshot feature
./tools/verify_search.sh         # Search feature
```

**Status**: All tests passing ✓ (verified 2025-11-09)
```

## Planner Workflow Changes

### Plan for Testability
In NEW_FEATURES.md, each feature includes:

```markdown
## Feature: Screenshot Search

### Requirements
[What the feature does]

### Verification Strategy
**Test Type**: Verification script
**Test Location**: `tools/verify_screenshot_search.sh`
**What to Test**:
- User asks UI question → Assistant searches screenshots
- Image data flows through tool call
- Assistant answers using screenshot knowledge
- Screenshot filenames not mentioned in response

**Success Criteria**:
- Script exits 0 (success)
- All checkpoints pass
- Manual review: Answer quality is good
```

Planner thinks about HOW to test during spec design, not just WHAT to build.

## Examples

### ✅ Good: Repeatable End-to-End Test

Implementor creates `tools/verify_screenshot_search.sh`:
```bash
#!/bin/bash
set -e

echo "Testing screenshot search feature..."

# Test 1: Vector DB contains screenshots
echo "✓ Checking vector DB..."
python -c "from tools import check_screenshots; check_screenshots()"

# Test 2: search_documentation returns images
echo "✓ Testing tool function..."
python -c "from tools import test_search_tool; test_search_tool()"

# Test 3: End-to-end assistant test
echo "✓ Testing full assistant flow..."
result=$(./test.sh -q "Where is the Inspector panel?" --verbose)
if echo "$result" | grep -q "inspector"; then
    echo "✓ Assistant answered UI question"
else
    echo "✗ Assistant did not answer correctly"
    exit 1
fi

echo "All screenshot search tests passed ✓"
```

**Why this is good:**
- Future agents can run `./tools/verify_screenshot_search.sh`
- Tests END-TO-END user experience
- Clear pass/fail output
- No manual steps

### ❌ Bad: One-Off Manual Check

```markdown
## Verification Evidence
I tested the screenshot feature by running test.sh with a UI question and it worked correctly.
```

**Why this is bad:**
- Future agents can't reproduce this
- No test artifact created
- "Worked correctly" is subjective
- Can't verify feature still works later

### ✅ Good: Automated Test Suite

```python
# tests/test_screenshot_integration.py
def test_screenshot_search_end_to_end():
    """Test full screenshot search flow from user question to answer."""
    # Setup
    assistant = create_assistant()

    # User asks UI question
    response = assistant.ask("Where is the Inspector panel?")

    # Verify: search_documentation was called
    assert "search_documentation" in response.tool_calls

    # Verify: Image data was included
    tool_response = response.tool_responses[0]
    assert tool_response["type"] == "image"

    # Verify: Assistant gave good answer
    assert "inspector" in response.content.lower()

    # Verify: Didn't mention screenshot file
    assert ".png" not in response.content
```

**Why this is good:**
- Runs in CI automatically
- Tests the FULL user experience
- Verifiable assertions
- Will catch regressions

## Required Deliverables (Implementor)

Before marking a task complete:
- ✅ Feature implemented
- ✅ **Repeatable tests created** (script/automated/documented procedure)
- ✅ **New tests passing** (paste output)
- ✅ **Existing tests still passing** (regression check - paste output)
- ✅ **Tests documented** (README/test docs explain how to run)
- ✅ Documentation updated

## Benefits

### For Future Implementors
- Run test suite before changes → know what works
- Run test suite after changes → verify no regressions
- Add to test suite → coverage grows

### For Researchers
- Verify system state by running tests
- Don't rely on "code exists" - run the tests
- Find gaps: features without tests

### For Humans
- Run tests to verify work
- Tests serve as documentation
- Confidence that features work

## Migration Plan

**Existing projects without test suites:**
1. Researcher documents current test state (if any)
2. Planner includes "create test infrastructure" in first spec
3. Each implementor adds tests for their features
4. Test suite grows incrementally

**New projects:**
1. First implementor sets up test infrastructure
2. Each subsequent implementor adds tests
3. Researcher verifies via test suite

## Key Principles

1. **Repeatability**: "Can another agent run this?"
2. **End-to-end**: "Does it test the user experience?"
3. **Accumulation**: "Does the test suite grow?"
4. **Documentation**: "Can someone find and run the tests?"

---

This framework ensures implementations are truly verified, not just claimed to work.
