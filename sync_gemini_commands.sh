#!/bin/bash

# This script synchronizes the Gemini command definitions in gemini/commands/
# with the agent prompts in agents/commands/.
# It generates a .toml file for each .md prompt, ensuring the paths are correct.

set -euo pipefail

# The script should be run from the project root directory.
PROJECT_ROOT="."
SRC_DIR="$PROJECT_ROOT/agents/commands"
DEST_DIR="$PROJECT_ROOT/gemini/commands"

# Ensure the destination directory exists.
mkdir -p "$DEST_DIR"

echo "Syncing Gemini commands from '$SRC_DIR' to '$DEST_DIR'..."

# Find all markdown files in the source directory.
for md_file in "$SRC_DIR"/*.md; do
  # Check if it is a file
  if [ -f "$md_file" ]; then
    filename=$(basename "$md_file")
    base_filename="${filename%.md}"
    toml_file="$DEST_DIR/$base_filename.toml"

    # Extract agent name from the first line (H1) of the markdown file.
    # e.g. "# Implementor Agent" -> "Implementor Agent"
    agent_name=$(grep -m 1 '^# ' "$md_file" | sed -e 's/^# //' -e 's/$//')

    # If no H1 found, create a name from the filename.
    # e.g. "my-agent.md" -> "My Agent"
    if [ -z "$agent_name" ]; then
        agent_name=$(echo "$base_filename" | sed -e 's/-/ /g' -e 's/\b\(.\)/\u\1/g')
        # append agent if not there
        if [[ $agent_name != *"Agent"* ]]; then
            agent_name="$agent_name Agent"
        fi
    fi

    # The prompt path is relative to the location of the TOML file.
    # TOML: gemini/commands/implement.toml
    # MD:   agents/commands/implement.md
    # Relative path from gemini/commands/ is ../../agents/commands/
    prompt_path="../../agents/commands/$filename"

    echo "  -> Generating $toml_file"

    # Create the .toml file content.
    # Note the double backslash for newline `\\n` is needed for `cat << EOL`.
    cat > "$toml_file" << EOL
prompt = "@{$prompt_path}\n\nTask: {{args}}"
description = "Engage the ${agent_name} workflow"
EOL
  fi
done

echo "Sync complete."
