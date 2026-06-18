#!/usr/bin/env bash
# install-zai.sh - Z.ai installer for Superpowers skills
# Usage:
#   bash install-zai.sh              # install or update all skills
#   bash install-zai.sh --core-only  # install only Tier 1+2 skills (8 skills, skip Tier 3)
#   bash install-zai.sh --force      # reinstall even if exists (overwrite)
#   bash install-zai.sh --force --core-only  # force reinstall core skills only
#   bash install-zai.sh uninstall    # remove all sp-* skills
#   bash install-zai.sh status       # show installed vs available
#
# Works as a git submodule:
#   git submodule add https://github.com/<USER>/superpowers-zai.git .superpowers-zai
#   bash .superpowers-zai/install-zai.sh
#
# Update to latest version:
#   git submodule update --remote .superpowers-zai
#   bash .superpowers-zai/install-zai.sh --force

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_SKILLS="$SCRIPT_DIR/skills"
# Auto-detect target: look for sibling 'skills/' dir or default to Z.ai path
if [ -d "$SCRIPT_DIR/../skills" ]; then
    TARGET_DIR="$(cd "$SCRIPT_DIR/../skills" && pwd)"
else
    TARGET_DIR="/home/z/my-project/skills"
fi

ACTION="${1:-install}"
CORE_ONLY=false
for arg in "$@"; do
    if [ "$arg" = "--core-only" ]; then CORE_ONLY=true; fi
done

# --- List of all skill directories (source names, before sp- prefix) ---
ALL_SKILLS=(
    brainstorming
    dispatching-parallel-agents
    executing-plans
    finishing-a-development-branch
    receiving-code-review
    requesting-code-review
    sp-writing-plans
    subagent-driven-development
    systematic-debugging
    test-driven-development
    using-git-worktrees
    using-superpowers
    verification-before-completion
    writing-skills
)

# Core skills: Tier 1 (directly useful) + Tier 2 (useful with adaptation)
# Skip: executing-plans (redundant with subagent-driven-development),
#        finishing-a-development-branch (not applicable to Z.ai),
#        using-superpowers (needs manual invocation, no auto-inject hook)
CORE_SKILLS=(
    brainstorming
    dispatching-parallel-agents
    receiving-code-review
    requesting-code-review
    sp-writing-plans
    subagent-driven-development
    systematic-debugging
    test-driven-development
    using-git-worktrees
    verification-before-completion
    writing-skills
)

# Select which list to use
if [ "$CORE_ONLY" = true ]; then
    SKILLS=("${CORE_SKILLS[@]}")
else
    SKILLS=("${ALL_SKILLS[@]}")
fi

# --- Status ---
if [ "$ACTION" = "status" ]; then
    echo "superpowers-zai install status ($([ "$CORE_ONLY" = true ] && echo "core-only" || echo "all skills"))"
    echo "Source: $PLUGIN_SKILLS"
    echo "Target: $TARGET_DIR"
    echo ""
    printf "%-40s %s\n" "SKILL" "STATUS"
    printf "%-40s %s\n" "-----" "------"
    for skill in "${SKILLS[@]}"; do
        src="$PLUGIN_SKILLS/$skill"
        # Target always has sp- prefix
        if [[ "$skill" == sp-* ]]; then
            tgt="$TARGET_DIR/$skill"
            display="$skill"
        else
            tgt="$TARGET_DIR/sp-$skill"
            display="sp-$skill"
        fi
        if [ ! -d "$src" ]; then
            status="MISSING (not in source)"
        elif [ ! -d "$tgt" ]; then
            status="NOT INSTALLED"
        else
            # Compare by checking if SKILL.md content differs
            if diff -q "$src/SKILL.md" "$tgt/SKILL.md" >/dev/null 2>&1; then
                status="[OK] up to date"
            else
                status="[UPDATE] differs from source"
            fi
        fi
        printf "%-40s %s\n" "$display" "$status"
    done
    exit 0
fi

# --- Uninstall ---
if [ "$ACTION" = "uninstall" ]; then
    echo "Uninstalling superpowers skills from $TARGET_DIR..."
    count=0
    for skill in "${ALL_SKILLS[@]}"; do
        if [[ "$skill" == sp-* ]]; then
            d="$TARGET_DIR/$skill"
        else
            d="$TARGET_DIR/sp-$skill"
        fi
        if [ -d "$d" ]; then
            rm -rf "$d"
            echo "  Removed: $(basename "$d")"
            count=$((count + 1))
        fi
    done
    echo "Done. Removed $count skills."
    exit 0
fi

# --- Install / Update ---
FORCE=false
if [ "$ACTION" = "--force" ] || [ "$ACTION" = "install" ]; then
    if [ "$ACTION" = "--force" ]; then
        FORCE=true
    fi
else
    echo "Usage: bash install-zai.sh [--force] [--core-only] | uninstall | status"
    exit 1
fi

echo "Installing superpowers skills for Z.ai$([ "$CORE_ONLY" = true ] && echo " (core-only)" || echo "")..."
echo "Source:  $PLUGIN_SKILLS"
echo "Target:  $TARGET_DIR"
echo ""

# Verify source exists
if [ ! -d "$PLUGIN_SKILLS" ]; then
    echo "ERROR: Plugin skills not found at $PLUGIN_SKILLS"
    echo "Make sure this script is inside the superpowers-zai directory."
    exit 1
fi

# Create target if needed
mkdir -p "$TARGET_DIR"

installed=0
updated=0
skipped=0

for skill_dir in "$PLUGIN_SKILLS"/*/; do
    [ -d "$skill_dir" ] || continue
    name=$(basename "$skill_dir")

    # Determine target name: add sp- prefix if not already present
    if [[ "$name" == sp-* ]]; then
        target_name="$name"
    elif [ "$name" = "writing-plans" ]; then
        target_name="sp-writing-plans"
    else
        target_name="sp-$name"
    fi

    target="$TARGET_DIR/$target_name"

    if [ -d "$target" ]; then
        if [ "$FORCE" = true ]; then
            rm -rf "$target"
            cp -r "$skill_dir" "$target"
            echo "  [UPDATE] $target_name"
            updated=$((updated + 1))
        else
            # Check if content differs
            if diff -q "$skill_dir/SKILL.md" "$target/SKILL.md" >/dev/null 2>&1; then
                echo "  [OK]    $target_name (up to date)"
                skipped=$((skipped + 1))
            else
                echo "  [SKIP]  $target_name (exists, differs -- use --force to update)"
                skipped=$((skipped + 1))
            fi
        fi
    else
        cp -r "$skill_dir" "$target"
        echo "  [NEW]   $target_name"
        installed=$((installed + 1))
    fi
done

echo ""
echo "Summary: $installed installed, $updated updated, $skipped unchanged"

if [ "$updated" -gt 0 ] || [ "$skipped" -gt 0 ]; then
    echo ""
    echo "NOTE: In Z.ai sandbox, there is no hook system to auto-inject"
    echo "the 'using-superpowers' entry skill. Options:"
    echo ""
    echo "  1. Manual: Invoke Skill(command=\"sp-using-superpowers\") at session start"
    echo "  2. Auto:   Add the content of sp-using-superpowers/SKILL.md to your"
    echo "            system prompt configuration (if your setup supports it)"
fi

echo ""
echo "To check for updates later:  bash $0 status"
echo "To update to latest:        bash $0 --force"
echo "To uninstall:               bash $0 uninstall"