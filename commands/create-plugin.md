---
name: create-plugin
description: Guided end-to-end plugin creation workflow with component design, implementation, and validation
---

# Plugin Creation Workflow

Guide the user through creating a complete, high-quality plugin from initial concept to tested implementation.

## Core Principles

- **Ask clarifying questions**: Identify all ambiguities about plugin purpose, triggering, scope, and components
- **Use TodoWrite**: Track all progress throughout all phases
- **Follow best practices**: Apply proven patterns
- **Progressive disclosure**: Create lean skills with references/examples

**Initial request:** {argument}

---

## Phase 1: Discovery

**Goal**: Understand what plugin needs to be built

**Actions**:
1. Create todo list with all phases
2. If plugin purpose is clear, summarize understanding
3. If unclear, ask user:
   - What problem does this plugin solve?
   - Who will use it and when?
   - What should it do?

**Output**: Clear statement of plugin purpose

---

## Phase 2: Component Planning

**Goal**: Determine what plugin components are needed

**Actions**:
1. Analyze requirements and determine needed components:
   - **Skills**: Specialized knowledge or user-initiated actions
   - **Agents**: Autonomous tasks (validation, generation, analysis)
   - **Hooks**: Event-driven automation
   - **MCP**: External service integration

2. Present component plan as table:
   ```
   | Component Type | Count | Purpose |
   |----------------|-------|---------|
   | Skills         | 5     | ...     |
   | Agents         | 1     | ...     |
   ```

3. Get user confirmation

**Output**: Confirmed list of components

---

## Phase 3: Implementation

**Goal**: Create each component

**Actions**:
1. Create directory structure
2. Write SKILL.md files with proper frontmatter
3. Create agent markdown files
4. Set up hooks if needed
5. Test each component

---

## Phase 4: Validation

**Goal**: Ensure plugin works correctly

**Actions**:
1. Verify all files are correctly structured
2. Test skill triggering
3. Test agent execution
4. Present findings to user

---

## Phase 5: Documentation

**Goal**: Ensure plugin is well-documented

**Actions**:
1. Create/update README.md
2. Add usage examples
3. Document installation steps
