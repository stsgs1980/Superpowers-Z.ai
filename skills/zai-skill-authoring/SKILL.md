---
name: zai-skill-authoring
description: Write and iterate on Z.ai skills. Use when the user says "create a skill", "write a skill", "new skill", "improve this skill", "fix the skill trigger", "skill isn't working", or "debug a skill". Combines Z.ai skill-creator progressive disclosure with Superpowers' test-driven approach and concrete examples.
---

# Z.ai Skill Authoring

Create skills that are concise, trigger reliably, and do one thing well.

## Core Principles

1. **One skill, one job** — if a skill does two unrelated things, split it
2. **Progressive disclosure** — YAML description (<100 words) triggers loading; SKILL.md body (<500 lines) provides instructions; references/ holds detail
3. **Imperative tone** — "run the test" not "the test should be run"
4. **Examples over rules** — show what good output looks like rather than listing 20 restrictions
5. **Explain why, not just what** — the model follows instructions better when it understands the reason

## Writing a New Skill

### 1. Define the Trigger (YAML Frontmatter)

The `description` field is the primary trigger mechanism. Include:
- What the skill does
- When it should activate (specific phrases and contexts)
- Edge cases where it should or shouldn't fire

Make the description slightly "pushy" — GLM tends to under-trigger skills. Include synonyms and related phrases.

**Bad:** "A skill for making charts"
**Good:** "Create charts, graphs, and data visualizations. Use whenever the user mentions charts, plots, graphs, dashboards, data visualization, 'show me the data', or wants to compare numbers visually — even if they don't explicitly say 'chart'."

### 2. Write the Body (SKILL.md)

Start with a brief overview (2-3 sentences). Then structure the instructions:

```
# Skill Name
One paragraph overview.

## When to Use
## When NOT to Use  (prevents over-triggering)
## How It Works
## Examples (Input/Output pairs)
## Common Pitfalls
```

Keep it under 200 lines for simple skills. For complex skills, use references/ files and point to them: "See references/api-patterns.md for the full request/response schema."

### 3. Test the Skill

Write 2-3 test prompts — the kind of thing a real user would say. Run them with and without the skill loaded. Compare the results.

**Test prompt example:** "Make a bar chart of monthly sales data"
- Without skill: might generate a text table or a generic response
- With skill: should produce a proper chart file

### 4. Iterate Based on Results

If the skill under-triggers (doesn't fire when it should):
- Add more trigger phrases to the description
- Check if a more specific skill is stealing the trigger

If the skill over-triggers (fires when it shouldn't):
- Add a "When NOT to Use" section
- Narrow the description

If the output quality is wrong:
- Add concrete Input/Output examples
- Simplify the instructions — the model may be following some parts and ignoring others
- Move detailed reference material into separate files

## Skill File Structure

```
skill-name/
  SKILL.md          # Required. Frontmatter + instructions.
  references/       # Optional. Detailed docs loaded on demand.
  scripts/          # Optional. Deterministic/repetitive tasks.
  assets/           # Optional. Templates, fonts, icons.
```

## Integration with Superpowers TDD

For code-heavy skills (like debugging or testing), combine with:
- `sp-test-driven-development` — write evals as test cases
- `zai-verify-before-claim` — verify the skill actually works before declaring it done
- `sp-writing-skills` — for detailed skill-writing methodology (if you need deeper guidance)

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skill is 800+ lines | Split into SKILL.md + references/ |
| No "When NOT to Use" | Add one — prevents false triggers |
| Description is too vague | Include specific user phrases |
| All rules, no examples | Add 2-3 Input/Output pairs |
| Skill competes with built-in | Check the built-in skill list first; extend rather than replace |