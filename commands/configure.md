---
name: configure
description: Enable or disable hookify rules interactively
---

# Configure Hookify Rules

Enable or disable existing hookify rules using an interactive interface.

## Steps

### 1. Find Existing Rules

Find all hookify rule files:
```
pattern: ".claude/hookify.*.local.md"
```

If no rules found, inform user:
```
No hookify rules configured yet. Use /hookify to create your first rule.
```

### 2. Read Current State

For each rule file:
- Read the file
- Extract `name` and `enabled` fields from frontmatter
- Build list of rules with current state

### 3. Ask User Which Rules to Toggle

Let user select rules to enable/disable.

### 4. Update Rule Files

For each rule to toggle:
- Change `enabled: true` to `enabled: false` (or vice versa)

### 5. Confirm Changes

Show user what was changed:
```
## Hookify Rules Updated

**Enabled:**
- warn-console-log

**Disabled:**
- warn-dangerous-rm

Changes apply immediately - no restart needed
```

## Important Notes

- Changes take effect immediately on next tool use
- You can also manually edit .claude/hookify.*.local.md files
- To permanently remove a rule, delete its .local.md file
