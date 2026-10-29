#!/usr/bin/env bash

# Get the absolute directory where this script is saved
PRACTICE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -d "$PRACTICE_DIR" ]; then
    echo "[-] Practice directory not found: $PRACTICE_DIR"
    exit 1
fi

# Find all .md files in the script's directory
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

# Parse file using awk into clean SUBTITLE@@@ITEM blocks
entries=()
while IFS= read -r entry; do
    [ -n "$entry" ] && entries+=("$entry")
done < <(awk '
{
    sub(/\r$/, "");
}
BEGIN { 
    section = "GENERAL";
    item = "";
}
{
    if ($0 ~ /^##[ \t]+/) {
        if (item != "") {
            gsub(/\n/, "\\n", item);
            print section "@@@" item;
            item = "";
        }
        sub(/^##[ \t]+/, "", $0);
        section = $0;
    } else if ($0 ~ /^[ \t]*([*-]|[0-9]+\.)[ \t]+/) {
        if (item != "") {
            gsub(/\n/, "\\n", item);
            print section "@@@" item;
        }
        item = $0;
    } else if (item != "" && $0 !~ /^[ \t]*$/) {
        item = item "\n" $0;
    } else if ($0 ~ /^[ \t]*$/) {
        if (item != "") {
            gsub(/\n/, "\\n", item);
            print section "@@@" item;
            item = "";
        }
    }
}
END { 
    if (item != "") {
        gsub(/\n/, "\\n", item);
        print section "@@@" item;
    }
}
' "$rand_file")

if [ ${#entries[@]} -eq 0 ]; then
    echo "[-] No valid list items found in topic: $topic"
    exit 1
fi

# Pick a random entry
rand_entry="${entries[RANDOM % ${#entries[@]}]}"

# Split subtitle and item text using @@@
subtitle="${rand_entry%%@@@*}"
item_text="${rand_entry#*@@@}"

# Restore actual newlines in the item text
item_text=$(echo -e "$item_text" | sed 's/\\n/\n/g')

# Display clean terminal card with Topic, Subtitle, and Item
echo ""
echo "┌─────────────────────────────────────────────────────────┐"
echo "│                 DELIBERATE PRACTICE TIME!               │"
echo "├─────────────────────────────────────────────────────────┤"
echo "│ TOPIC:    $topic_upper"
echo "│ SUBTITLE: $subtitle"
echo "├─────────────────────────────────────────────────────────┤"
echo ""
echo -e "$item_text"
echo ""
echo "-----------------------------------------------------------"