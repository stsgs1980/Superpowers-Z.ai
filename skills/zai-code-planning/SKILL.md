---
name: zai-code-planning
description: Plan code implementation tasks in Z.ai. Use this skill before starting any multi-step code task (Type 3) — when the user says "build a feature", "implement X", "set up a project", "add an API endpoint", "refactor this module", or "let's plan this out". For document/report planning (Type 1/2), the built-in Outline tool handles that — do NOT use this skill. Routes between detailed plans (code) and outline mode (documents) based on task type.
---

# Z.ai Code Planning

Plan before you code. This skill helps break down code tasks into concrete, ordered steps that you can execute and verify one at a time.

## When to Use This Skill

- Building a new feature or component (3+ files or steps)
- Refactoring existing code with a clear target state
- Setting up a new project (config, dependencies, structure)
- Implementing an API endpoint or data pipeline

## When NOT to Use This Skill

- The task is a document, report, or presentation — use the Outline tool instead (Type 1/2)
- The task is a single-line fix or trivial change — just do it
- The user said "just do it" or "skip planning" — respect that

## Planning Process

### Step 1: Understand the Target

Write a one-sentence goal. If you can't, ask the user to clarify what "done" looks like.

**Good:** "Add a login page with email/password that stores sessions in cookies"
**Bad:** "Fix the auth stuff" (what auth? what's broken? what's the fix?)

### Step 2: List Files to Change

Write down every file you will create or modify. Include the full path. If you discover new files needed while implementing, add them to the plan.

```
Create: src/app/api/auth/route.ts
Modify: src/app/layout.tsx (add session provider)
Create: src/components/LoginForm.tsx
Modify: src/middleware.ts (add auth check)
```

### Step 3: Order the Steps

Steps should be ordered so each one is independently verifiable. Prefer this order:

1. Types and interfaces (if needed)
2. Backend / data layer
3. Frontend components that consume the data
4. Integration / wiring
5. Tests
6. Commit

### Step 4: Write the Plan

Use the TodoWrite tool to create the task list. Each task should be specific enough that someone could execute it without guessing.

**Bad:** "Set up auth"
**Good:** "Create `src/app/api/auth/route.ts` with POST handler that validates email/password against the users table and returns a session cookie"

### Step 5: Execute and Update

As you complete each task:
1. Mark it complete
2. If the plan needs to change (you discovered a dependency, a step is no longer needed), update the list
3. Don't let the plan go stale — if reality diverges, the plan should catch up

## Plan Size Guide

| Task complexity | Plan detail |
|----------------|------------|
| Single function fix | No plan needed, just do it |
| 2-4 files | 3-5 todo items |
| Feature (5+ files) | 8-15 todo items with file paths |
| Full project setup | 15+ items, consider using subagents |

## Integration with Other Skills

After planning, use these skills for execution:
- `zai-debugging` — if a step fails
- `sp-test-driven-development` — if you want tests before implementation
- `sp-subagent-driven-development` — if steps can run in parallel
- `zai-verify-before-claim` — before marking the final task complete