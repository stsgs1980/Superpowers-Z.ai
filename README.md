# Superpowers for Z.ai (ZCode)

Superpowers is a complete software development methodology for your coding agents, built on top of a set of composable skills and some initial instructions that make sure your agent uses them. This fork is adapted for the Z.ai (ZCode) sandbox environment with git submodule-based installation and update support.

## Features

- Brainstorming and spec refinement through Socratic dialogue with Visual Companion
- Git worktree-based branch isolation for parallel development
- Automated implementation planning with bite-sized tasks (2-5 minutes each)
- Subagent-driven development with two-stage review (spec compliance, code quality)
- Test-driven development enforcement (RED-GREEN-REFACTOR cycle)
- Systematic 4-phase debugging with root cause tracing
- Pre-review checklists and structured code review workflows
- Parallel agent dispatching for independent concurrent tasks
- GLM-condensed references for 6 core skills (optional optimization layer)
- 4 native Z.ai skills written in ZCode style (debugging, verification, planning, skill authoring)
- One-command install and update via install-zai.sh

## Tech Stack

- **Markdown** - skill definitions and documentation format
- **Bash** - installation scripts and shell integration
- **Git** - worktree management, branch isolation, and submodule-based updates
- **JavaScript** - Visual Companion brainstorming server
- **Multi-platform** - Claude Code, Codex CLI, Gemini CLI, OpenCode, Cursor, GitHub Copilot CLI, Z.ai (ZCode)

## Getting Started

### Prerequisites

- Git 2.15+ (for submodule support)
- Bash shell
- A Z.ai (ZCode) sandbox session or local Z.ai-compatible project with a git repository

### Installation

#### Z.ai (ZCode) - Primary target

Add as a git submodule for version tracking and easy updates.

**Initial setup:**
```bash
git submodule add https://github.com/stsgs1980/Superpowers-Z.ai.git .superpowers-zai
echo "skills/sp-*" >> .gitignore
bash .superpowers-zai/install-zai.sh
```

**On a fresh clone (or new Z.ai session):**
```bash
git clone --recurse-submodules <your-project-url>
bash .superpowers-zai/install-zai.sh
```

**Uninstall:**
```bash
bash .superpowers-zai/install-zai.sh uninstall
```

#### Claude Code

Superpowers is available via the [official Claude plugin marketplace](https://claude.com/plugins/superpowers).

- Install the plugin from Anthropic's official marketplace:

```bash
/plugin install superpowers@claude-plugins-official
```

- Or register the Superpowers marketplace first:

```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

#### Codex CLI

Superpowers is available via the [official Codex plugin marketplace](https://github.com/openai/plugins).

- Open the plugin search interface:

```bash
/plugins
```

- Search for "superpowers" and select "Install Plugin".

#### Codex App

- In the Codex app, click on Plugins in the sidebar.
- Find "Superpowers" in the Coding section.
- Click the `+` next to Superpowers and follow the prompts.

#### Factory Droid

```bash
droid plugin marketplace add https://github.com/obra/superpowers
droid plugin install superpowers@superpowers
```

#### Gemini CLI

```bash
gemini extensions install https://github.com/obra/superpowers
```

#### OpenCode

```bash
# Fetch and follow instructions from the upstream install guide
# See docs/README.opencode.md for details
```

#### Cursor

- In Cursor Agent chat: `/add-plugin superpowers`
- Or search for "superpowers" in the plugin marketplace.

#### GitHub Copilot CLI

```bash
copilot plugin marketplace add obra/superpowers-marketplace
copilot plugin install superpowers@superpowers-marketplace
```

## How It Works

It starts from the moment you fire up your coding agent. As soon as it sees that you're building something, it doesn't just jump into trying to write code. Instead, it steps back and asks you what you're really trying to do.

Once it's teased a spec out of the conversation, it shows it to you in chunks short enough to actually read and digest.

After you've signed off on the design, your agent puts together an implementation plan that's clear enough for an enthusiastic junior engineer with poor taste, no judgement, no project context, and an aversion to testing to follow. It emphasizes true red/green TDD, YAGNI (You Aren't Gonna Need It), and DRY.

Next up, once you say "go", it launches a subagent-driven-development process, having agents work through each engineering task, inspecting and reviewing their work, and continuing forward. It's not uncommon for Claude to be able to work autonomously for a couple hours at a time without deviating from the plan you put together.

There's a bunch more to it, but that's the core of the system. And because the skills trigger automatically, you don't need to do anything special. Your coding agent just has Superpowers.

## The Basic Workflow

1. **brainstorming** - Activates before writing code. Refines rough ideas through questions, explores alternatives, presents design in sections for validation. Saves design document.
2. **using-git-worktrees** - Activates after design approval. Creates isolated workspace on new branch, runs project setup, verifies clean test baseline.
3. **sp-writing-plans** - Activates with approved design. Breaks work into bite-sized tasks (2-5 minutes each). Every task has exact file paths, complete code, verification steps.
4. **subagent-driven-development** or **executing-plans** - Activates with plan. Dispatches fresh subagent per task with two-stage review (spec compliance, then code quality), or executes in batches with human checkpoints.
5. **test-driven-development** - Activates during implementation. Enforces RED-GREEN-REFACTOR: write failing test, watch it fail, write minimal code, watch it pass, commit. Deletes code written before tests.
6. **requesting-code-review** - Activates between tasks. Reviews against plan, reports issues by severity. Critical issues block progress.
7. **finishing-a-development-branch** - Activates when tasks complete. Verifies tests, presents options (merge/PR/keep/discard), cleans up worktree.

The agent checks for relevant skills before any task. Mandatory workflows, not suggestions.

## What's Inside

### Skills Library

**Testing**
- **test-driven-development** - RED-GREEN-REFACTOR cycle (includes testing anti-patterns reference)

**Debugging**
- **systematic-debugging** - 4-phase root cause process (includes root-cause-tracing, defense-in-depth, condition-based-waiting techniques)
- **verification-before-completion** - Ensure it's actually fixed

**Collaboration**
- **brainstorming** - Socratic design refinement
- **sp-writing-plans** - Detailed implementation plans
- **executing-plans** - Batch execution with checkpoints
- **dispatching-parallel-agents** - Concurrent subagent workflows
- **requesting-code-review** - Pre-review checklist
- **receiving-code-review** - Responding to feedback
- **using-git-worktrees** - Parallel development branches
- **finishing-a-development-branch** - Merge/PR decision workflow
- **subagent-driven-development** - Fast iteration with two-stage review (spec compliance, then code quality)

**Meta**
- **writing-skills** - Create new skills following best practices (includes testing methodology)
- **using-superpowers** - Introduction to the skills system

### Native Z.ai Skills (Phase 2)

Written in ZCode skill-creator style: imperative tone, progressive disclosure, examples over rules.

- **zai-debugging** - 4-phase debugging (Read Error, Narrow Scope, Hypothesize, Fix & Verify) with Z.ai sandbox pitfalls
- **zai-verify-before-claim** - Prevent false success claims by requiring evidence before delivery
- **zai-code-planning** - Type-aware planning: routes to Outline tool for documents (Type 1/2) or detailed task plans for code (Type 3)
- **zai-skill-authoring** - Skill creation methodology combining Z.ai progressive disclosure with Superpowers TDD

## Updating

### Z.ai (ZCode) - Submodule-based updates

Since Z.ai is installed as a git submodule, updates are pulled from this repository.

**Check if a newer version is available:**
```bash
cd .superpowers-zai
git fetch origin
git log HEAD..origin/main --oneline
```

**Update to the latest version:**
```bash
git submodule update --remote .superpowers-zai
bash .superpowers-zai/install-zai.sh --force
```

**Pin to a specific version (recommended for stable projects):**
```bash
cd .superpowers-zai
git checkout v5.1.0  # or any tag
cd ..
git add .superpowers-zai
git commit -m "Pin superpowers-zai to v5.1.0"
```

**Check installed version and status:**
```bash
bash .superpowers-zai/install-zai.sh status
```

### Other platforms

Superpowers updates are somewhat coding-agent dependent, but are often automatic.

## Contributing

The general contribution process for Superpowers is below. Keep in mind that we don't generally accept contributions of new skills and that any updates to skills must work across all of the coding agents we support.

1. Fork the repository
2. Switch to the 'dev' branch
3. Create a branch for your work
4. Follow the `writing-skills` skill for creating and testing new and modified skills
5. Submit a PR, being sure to fill in the pull request template.

See `skills/writing-skills/SKILL.md` for the complete guide.

## License

MIT License - see LICENSE file for details.

## Community

Superpowers is built by [Jesse Vincent](https://blog.fsck.com) and the rest of the folks at [Prime Radiant](https://primeradiant.com).

- **Discord**: [Join us](https://discord.gg/35wsABTejz) for community support, questions, and sharing what you're building with Superpowers
- **Issues**: https://github.com/obra/superpowers/issues
- **Release announcements**: [Sign up](https://primeradiant.com/superpowers/) to get notified about new versions

---

Built with: Markdown + Bash + Git + JavaScript