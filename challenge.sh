#!/usr/bin/env bash

# Get the absolute directory where this script is saved
PRACTICE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d "$PRACTICE_DIR" ]; then
    echo "[-] Practice directory not found: $PRACTICE_DIR"
    exit 1
fi

# Find all .md files in the script's directory (excluding README.md if desired)
shopt -s nullglob
files=("$PRACTICE_DIR"/*.md)
shopt -u nullglob

# Filter out README.md if it exists in the repo
filtered_files=()
for f in "${files[@]}"; do
    if [[ "$(basename "$f")" != "README.md" ]]; then
        filtered_files+=("$f")
    fi
done

if [ ${#filtered_files[@]} -eq 0 ]; then
    echo "[-] No challenge markdown files found in $PRACTICE_DIR"
    exit 1
fi

# Pick a random markdown file (Filename = Topic)
rand_file="${filtered_files[RANDOM % ${#filtered_files[@]}]}"
topic=$(basename "$rand_file" .md)
topic_upper=$(echo "$topic" | tr '[:lower:]' '[:upper:]')

# Parse multi-line markdown items using awk
items=()
while IFS= read -r item; do
    [ -n "$item" ] && items+=("$item")
done < <(awk '
BEGIN { item = ""; }
{
    if ($0 ~ /^[ \t]*([-*]|\d+\.)[ \t]+/) {
        if (item != "") print item;
        item = $0;
    } else if (item != "" && $0 !~ /^[ \t]*$/) {
        item = item " " $0;
    } else if ($0 ~ /^[ \t]*$/) {
        if (item != "") { print item; item = ""; }
    }
}
END { if (item != "") print item; }
' "$rand_file")

if [ ${#items[@]} -eq 0 ]; then
    echo "[-] No valid list items found in topic: $topic"
    exit 1
fi

# Pick a random item from the selected file
rand_item="${items[RANDOM % ${#items[@]}]}"

# Display clean terminal card
echo ""
echo "┌─────────────────────────────────────────────────────────┐"
echo "│          🧠 DELIBERATE PRACTICE: $topic_upper           │"
echo "└─────────────────────────────────────────────────────────┘"
echo ""
echo "$rand_item"
echo ""
echo "-----------------------------------------------------------"