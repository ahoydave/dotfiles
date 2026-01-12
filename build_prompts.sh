#!/bin/bash
set -euo pipefail

# Configuration
SRC_DIR="agents/src"
DEST_DIR="agents/commands"
CORE_FILE="$SRC_DIR/_core.md"

# Ensure directories exist
mkdir -p "$DEST_DIR"

# Check if core file exists
if [ ! -f "$CORE_FILE" ]; then
    echo "Error: Core file not found at $CORE_FILE"
    exit 1
fi

echo "Building prompts from $SRC_DIR..."

# Loop through all files in src starting with _ but skip _core.md
for file in "$SRC_DIR"/_*.md; do
    # Skip _core.md
    if [ "$file" == "$CORE_FILE" ]; then
        continue
    fi
    
    filename=$(basename "$file")
    # Remove leading underscore for output filename
    # _research.md -> research.md
    out_name="${filename#_}"
    dest_file="$DEST_DIR/$out_name"
    
    echo "  Building $out_name..."
    
    # Concatenate Core + Role Extension
    cat "$CORE_FILE" > "$dest_file"
    echo -e "\n\n" >> "$dest_file" # Add spacing
    cat "$file" >> "$dest_file"
done

echo "Prompts built successfully."

# Run the Gemini sync script
if [ -f "./sync_gemini_commands.sh" ]; then
    echo "Syncing Gemini definitions..."
    ./sync_gemini_commands.sh
else
    echo "Warning: sync_gemini_commands.sh not found."
fi

echo "Done."
