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

# Parse file using awk. A new card starts ONLY if a line starts with a bullet 
# AND has NO leading spaces (top-level only). Indented sub-bullets are grouped.
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
    } else if ($0 ~ /^([*-]|[0-9]+\.)[ \t]+/) {
        # STRICT MATCH: Only top-level bullets with zero leading whitespace trigger a new card
        if (item != "") {
            gsub(/\n/, "\\n", item);
            print section "@@@" item;
        }
        item = $0;
    } else if (item != "" && $0 !~ /^#[#]+/) {
        # Append indented lines, sub-bullets, and setup notes to the current card
        item = item "\n" $0;
    } else if ($0 ~ /^[ \t]*$/ && item != "") {
        # Keep blank lines inside multi-line cards if they are part of a lab block
        item = item "\n" $0;
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

# Display clean terminal card using standard characters
echo ""
echo "+---------------------------------------------------------+"
echo "|                 DELIBERATE PRACTICE TIME!               |"
echo "+---------------------------------------------------------+"
echo "| TOPIC:    $topic_upper"
echo "| SUBTITLE: $subtitle"
echo "+---------------------------------------------------------+"
echo ""

# Render using Glow if available, otherwise fall back to standard echo -e
if command -v glow &> /dev/null; then
    echo -e "$item_text" | glow -
else
    echo -e "$item_text"
fi

echo ""
echo "+---------------------------------------------------------+"