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

    # Extract agent name. Prioritize "# Role: Name" format.
    agent_name=$(grep -m 1 '^# Role: ' "$md_file" | sed -e 's/^# Role: //' -e 's/\$//')

    # If not found, check if the first H1 is NOT the core title before accepting it.
    if [ -z "$agent_name" ]; then
        first_h1=$(grep -m 1 '^# ' "$md_file" | sed -e 's/^# //' -e 's/\$//')
        if [[ "$first_h1" != "Looped Agent System - Core Instructions" ]]; then
            agent_name="$first_h1"
        fi
    fi

    # If no valid name found yet, create a name from the filename.
    # e.g. "my-agent.md" -> "My Agent"
    if [ -z "$agent_name" ]; then
        agent_name=$(echo "$base_filename" | sed -e 's/-/ /g' -e 's/\b\(.\)/\u\1/g')
        # append agent if not there
        if [[ $agent_name != *"Agent"* ]]; then
            agent_name="$agent_name Agent"
        fi
    fi

    echo "  -> Generating $toml_file"

    # Create the .toml file content by streaming. This is safer than using a variable with
    # a here-doc, as it prevents the shell from interpreting special characters (`$`, `` ` ``, etc.)
    # inside the markdown file content.
    {
        echo 'prompt = """'
        # Append the raw content of the markdown file.
        cat "$md_file"
        # Append the task arguments, separated by a newline.
        echo
        echo 'Task: {{args}}'
        echo '"""'
        # The description includes the agent name, which needs to be expanded by the shell.
        echo "description = \"Engage the ${agent_name} workflow\""
    } > "$toml_file"
  fi
done

echo "Sync complete."