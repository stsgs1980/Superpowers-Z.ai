---
name: zai-debugging
description: Systematic debugging for Z.ai sandbox. Use this skill whenever code fails at runtime, tests fail unexpectedly, a build step errors out, or the user says "fix this bug", "debug", "why is this broken", "it doesn't work", or similar. Applies to Type 3 (code) and Type 4 (data processing) tasks. Do NOT use for document generation issues (Type 1/2) — those have their own skill chains.
---

# Z.ai Debugging

A four-phase debugging workflow designed for the Z.ai sandbox environment. The goal is to find the root cause quickly and fix it without guessing.

## Phase 1: Read the Error

Before writing any fix, read the actual error output. Don't infer from memory.

1. Run the failing command or test again to get a fresh error message
2. Copy the exact error text — file path, line number, error type
3. Check if the error is a symptom or the cause:
   - `TypeError: X is not a function` — usually a cause (wrong import, missing export)
   - `Unexpected token` — usually a cause (syntax error)
   - `Test timed out` — usually a symptom ( investigate what it was waiting for)

If the error message is unclear, add one diagnostic print/log, re-run, and read the new output. Don't add five prints at once.

**Bad:** "The test fails, let me refactor the whole function"
**Good:** "The test fails with `ReferenceError: userId is not defined` on line 42. Let me check where `userId` is declared."

## Phase 2: Narrow the Scope

Identify the smallest code region that produces the error.

- If a test fails, run just that one test (not the whole suite)
- If a request handler fails, isolate the specific endpoint
- If a component renders wrong, check the component in isolation

Use binary search when the failure is in a long flow:
- Comment out half the code path, see if the error persists
- This tells you which half contains the bug

**Bad:** Reading all 20 files in the project looking for "the problem"
**Good:** `pytest tests/test_auth.py::test_login_invalid_password -v` — run the narrowest failing test

## Phase 3: Form a Hypothesis

Before changing code, state what you think is wrong and why. Write it as a one-line comment above your fix.

Your hypothesis should explain:
- What is the expected behavior?
- What is the actual behavior?
- Why is there a gap? (wrong data, wrong logic, missing dependency, race condition)

**Bad:** Adding `try/catch` around everything to suppress the error
**Good:** "Hypothesis: `fetchUser()` returns `null` when the user doesn't exist, but the caller assumes it always returns an object. Fix: add a null check."

## Phase 4: Fix and Verify

1. Make the minimal change that addresses the hypothesis
2. Run the failing test/command again
3. If it passes, run the broader test suite to check for regressions
4. If it still fails, your hypothesis was wrong — go back to Phase 2

After a successful fix, commit with a message that includes the root cause:

**Bad:** `git commit -m "fixed bug"`
**Good:** `git commit -m "fix(auth): handle null user in session lookup"`

## Common Z.ai Pitfalls

| Situation | What to check |
|-----------|--------------|
| Module not found | Check `package.json` dependencies, run `npm install` |
| Permission denied | Use `/tmp/` for temporary files, check file modes |
| Port already in use | `lsof -i :3000` then kill or use a different port |
| Git operation fails | Check if inside a worktree, run `git status` |
| Timeout in sandbox | Z.ai has a 10-minute bash timeout; long tasks need backgrounding |
| Font/image missing | Check absolute paths; Z.ai fonts are under `/usr/share/fonts/` |

## When NOT to Use This Skill

- User asks to add a new feature (not a bug) — use `zai-code-planning` instead
- User asks to write tests for existing code — use `sp-test-driven-development`
- The error is in a generated document (PDF/DOCX/PPTX) — check the relevant document skill