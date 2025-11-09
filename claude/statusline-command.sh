#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current working directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Get git branch if in a git repo (skip optional locks for performance)
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch="$branch "
    fi
fi

# Format output with colors:
# - Yellow for directory
# - Green for git branch
printf "\033[33m%s\033[0m \033[32m%s\033[0m" "$cwd" "$git_branch"
