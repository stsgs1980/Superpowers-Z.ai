#!/usr/bin/env bash
# prepare-github-repo.sh
# Prepares the superpowers-zai plugin as a standalone git repo for GitHub.
# Run this INSIDE the sandbox, then push to GitHub.

set -e

PLUGIN_NAME="superpowers-zai"
SRC_DIR="/home/z/my-project/upload/superpowers-extracted/superpowers/5.1.0"
BUILD_DIR="/tmp/${PLUGIN_NAME}"

echo "=== Preparing ${PLUGIN_NAME} for GitHub ==="

# Clean build directory
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Copy the adapted plugin (source of truth)
cp -r "$SRC_DIR"/* "$BUILD_DIR/"

# Add install script from root
cp "$SRC_DIR/install-zai.sh" "$BUILD_DIR/"

# Remove any artifacts
find "$BUILD_DIR" -name '.DS_Store' -delete
find "$BUILD_DIR" -name '*.pyc' -delete

# Init repo
cd "$BUILD_DIR"
git init
git add -A
git commit -m "Initial commit: Superpowers v5.1.0 adapted for Z.ai (ZCode)

Adaptations:
- 13 skills with sp- prefix to avoid conflicts with built-in skills
- GLM-5-Turbo condensed references for 6 core skills
- ZCode tool mapping (Skill, Task, Edit, MultiEdit, Read, Write, Bash)
- Z.ai sandbox worktree support with GitHub persistence
- Subagent prompt templates adapted for Task(subagent_type) syntax
- Session-start hook with ZCODE_PLUGIN_ROOT detection
- install-zai.sh for one-command setup in any Z.ai project
- Compliant with STD-DOC-002, STD-DOC-003, STD-DOC-004

Based on Superpowers v5.1.0 by Jesse Vincent (obra)
MIT License"

echo ""
echo "=== Repository ready at: ${BUILD_DIR} ==="
echo ""
echo "Next steps:"
echo ""
echo "  1. Create repo on GitHub:"
echo "     gh repo create ${PLUGIN_NAME} --public --source=${BUILD_DIR} --push"
echo ""
echo "     OR without gh CLI:"
echo "     - Go to https://github.com/new"
echo "     - Create empty repo: ${PLUGIN_NAME}"
echo "     - Then run:"
echo ""
echo "  2. Add remote and push:"
echo "     cd ${BUILD_DIR}"
echo "     git remote add origin https://github.com/stsgs1980/Superpowers-Z.ai.git"
echo "     git branch -M main"
echo "     git push -u origin main"
echo ""
echo "  3. In your Z.ai project, add as submodule:"
echo "     cd /home/z/my-project"
echo "     git submodule add https://github.com/stsgs1980/Superpowers-Z.ai.git .superpowers-zai"
echo "     bash .superpowers-zai/install-zai.sh install"
echo ""
echo "  4. On any new machine, clone with submodules:"
echo "     git clone --recurse-submodules <your-project-url>"
echo "     # Then run install:"
echo "     bash .superpowers-zai/install-zai.sh install"