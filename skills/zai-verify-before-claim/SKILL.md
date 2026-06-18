---
name: zai-verify-before-claim
description: Verify that work is actually complete before telling the user it's done. Use this skill before calling Complete, before claiming tests pass, before saying "the build works", or whenever you're about to deliver a result. Prevents false success claims that waste the user's time.
---

# Verify Before Claiming

Before you tell the user something works, actually check that it works. This applies to every claim about code, files, or system state.

## What to Verify

Run the actual command or check the actual file. Don't assume from memory.

| Claim | Verify by |
|-------|----------|
| "Tests pass" | Run `pytest` / `npm test` and paste the output |
| "Build succeeds" | Run the build command and show exit code 0 |
| "File is created" | `ls -la /path/to/file` and confirm size > 0 |
| "Server starts" | Start it, curl the endpoint, show 200 response |
| "Script works" | Execute it end-to-end, not just syntactically |

## The Rule

If you can't show evidence, don't claim it. Say "I believe X is working based on Y" instead of "X works." The user can then verify themselves or ask you to run the check.

## Common False Claims

- "I've implemented the feature" — but no file was written or the file is empty
- "All tests pass" — but you didn't actually run them
- "The endpoint returns the correct data" — but you didn't curl it
- "The PDF is generated correctly" — but you didn't open or validate it

If you catch yourself about to make one of these, stop and run the verification first.

## When NOT to Use This Skill

- The user is asking you to draft or brainstorm — there's nothing to verify yet
- You're in the middle of writing code and haven't claimed anything
- The user explicitly says "just show me the approach" or "don't run it yet"