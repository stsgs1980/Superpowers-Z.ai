---
name: list
description: List all configured hookify rules
---

# List Hookify Rules

Show all configured hookify rules in the project.

## Steps

1. Find all hookify rule files:
   ```
   pattern: ".claude/hookify.*.local.md"
   ```

2. For each file found:
   - Read the file
   - Extract frontmatter fields: name, enabled, event, pattern
   - Extract message preview (first 100 chars)

3. Present results in a table:

```
## Configured Hookify Rules

| Name | Enabled | Event | Pattern | File |
|------|---------|-------|---------|------|
| warn-dangerous-rm | Yes | bash | rm\s+-rf | hookify.dangerous-rm.local.md |
| warn-console-log | Yes | file | console\.log\( | hookify.console-log.local.md |

**Total**: 2 rules (2 enabled)
```

## If No Rules Found

```
## No Hookify Rules Configured

You haven't created any hookify rules yet.

To get started:
1. Use /hookify to create rules
2. Or manually create .claude/hookify.my-rule.local.md files
```
