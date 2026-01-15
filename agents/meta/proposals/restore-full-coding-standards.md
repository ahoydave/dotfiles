# Proposal: Restore Full Coding Standards

## Overview
The user identified that valuable details were lost in the condensed "Coding Standards" section. Comparing the old vs. new versions confirms that **concrete examples** and **specific operational rules** were removed, leaving only high-level principles.

## Missing "Good Stuff" to Restore

### 1. The "Clarity" Example
*Why: Shows exactly what "Explicit flow over magic" means. Prevents "clever" one-liners.*
```markdown
❌ `result = reduce(lambda a, b: a + b if b % 2 == 0 else a, numbers, 0)`

✅ 
```python
total = 0
for num in numbers:
    if num % 2 == 0:
        total += num
```
```

### 2. The "Comments" Rules & Example
*Why: Prevents "history comments" ("updated this to fix X") which rot quickly.*
```markdown
**Rules:**
1. Comments must stand alone (no "less than before", "instead of X")
2. No comparatives to removed code ("better/faster/simpler than...")
3. When changing code, delete/update comments that reference old code

**Positive example** - non-obvious external constraint:
```python
MAX_RETRIES = 3  # External API SLA requires exactly 3
```
```

### 3. The "Complexity Budget" Questions
*Why: Forces agents to justify abstraction instead of defaulting to it.*
```markdown
Before adding abstraction:
1. Is the problem inherently complex, or am I making it complex?
2. Do I have 3+ concrete cases that need this? (Not 1-2)
3. Does this make code MORE obvious or LESS?
```

## Action
Restore the full "Coding Standards" section in `agents/src/_implement.md`.
