#!/usr/bin/env bash

# Shows a challenge card you haven't seen yet in the current review cycle.
# Once every card has been shown, a new cycle starts.
#
# Usage: challenge.sh [count]    show `count` cards (default: 1)
#        challenge.sh --status   show cycle progress only
#
# Environment:
#   CYCLE_DAYS                  length of a review cycle in days (default: 90)
#   DELIBERATE_PRACTICE_STATE   where progress is stored (default: ~/.deliberate-practice)

# Get the absolute directory where this script is saved
PRACTICE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATE_DIR="${DELIBERATE_PRACTICE_STATE:-$HOME/.deliberate-practice}"
SEEN_FILE="$STATE_DIR/seen"
CYCLE_START_FILE="$STATE_DIR/cycle_start"
CYCLE_DAYS="${CYCLE_DAYS:-90}"

count=1
if [ "$1" = "--status" ]; then
    count=0
elif [[ "$1" =~ ^[0-9]+$ ]]; then
    count=$1
elif [ -n "$1" ]; then
    echo "Usage: $(basename "$0") [count] | --status"
    exit 1
fi

cd "$PRACTICE_DIR" || exit 1

# Find all .md files in the repository (any depth), except README.md
files=()
while IFS= read -r -d '' f; do
    files+=("${f#./}")
done < <(find . -name '*.md' ! -name 'README.md' ! -path './.git/*' -print0)

if [ ${#files[@]} -eq 0 ]; then
    echo "[-] No challenge markdown files found in $PRACTICE_DIR"
    exit 1
fi

mkdir -p "$STATE_DIR"
touch "$SEEN_FILE"
[ -s "$CYCLE_START_FILE" ] || date +%s > "$CYCLE_START_FILE"

# Parse every file into cards and pick `want` random cards not yet seen.
# A new card starts ONLY if a line starts with a bullet AND has NO leading
# spaces (top-level only). Indented sub-bullets are grouped into the card.
# A card's ID is its first line, so editing that line makes it a new card.
#
# Output: first line "<total cards>\t<unseen cards>", then one line per picked
# card: "<id>\t<topic>\t<section>\t<body>", with newlines in body as \037.
read -r -d '' PICKER <<'AWK'
function flush() {
    if (item == "") return
    sub(/[ \t\n]+$/, "", item)
    n++
    id[n] = first; topic[n] = cur_topic; sect[n] = section; body[n] = item
    if (!(first in seen)) unseen[++u] = n
    item = ""
}
BEGIN {
    while ((getline line < seenfile) > 0) { sub(/\r$/, "", line); seen[line] = 1 }
    close(seenfile)
    srand(seed)
}
FNR == 1 {
    flush()
    section = "GENERAL"
    cur_topic = FILENAME
    sub(/\.md$/, "", cur_topic)
    gsub(/\//, " / ", cur_topic)
}
{ sub(/\r$/, "") }
/^##[ \t]+/ { flush(); section = $0; sub(/^##[ \t]+/, "", section); next }
/^#/ { flush(); next }
/^([*-]|[0-9]+\.)[ \t]+/ { flush(); item = $0; first = $0; sub(/[ \t]+$/, "", first); next }
item != "" { item = item "\n" $0 }
END {
    flush()
    printf "%d\t%d\n", n, u
    for (i = 1; i <= want && i <= u; i++) {
        j = i + int(rand() * (u - i + 1))
        t = unseen[i]; unseen[i] = unseen[j]; unseen[j] = t
        k = unseen[i]
        b = body[k]; gsub(/\n/, "\037", b)
        printf "%s\t%s\t%s\t%s\n", id[k], toupper(topic[k]), sect[k], b
    }
}
AWK

pick() {
    awk -v seenfile="$SEEN_FILE" -v want="$1" -v seed="$(( $(date +%s) + RANDOM * 32768 + RANDOM ))" \
        "$PICKER" "${files[@]}"
}

output=$(pick "$count")
IFS=$'\t' read -r total unseen <<< "${output%%$'\n'*}"

if [ "$total" -eq 0 ]; then
    echo "[-] No valid list items found in $PRACTICE_DIR"
    exit 1
fi

# Every card has been shown: start a new cycle
if [ "$unseen" -eq 0 ] && [ "$count" -gt 0 ]; then
    echo ""
    echo "*** Review cycle complete: all $total cards seen. Starting a new cycle. ***"
    : > "$SEEN_FILE"
    date +%s > "$CYCLE_START_FILE"
    output=$(pick "$count")
    IFS=$'\t' read -r total unseen <<< "${output%%$'\n'*}"
fi

marked=0
while IFS=$'\t' read -r id topic section body; do
    [ -n "$id" ] || continue
    body=${body//$'\037'/$'\n'}

    # Display clean terminal card using standard characters
    echo ""
    echo "+---------------------------------------------------------+"
    echo "|                 DELIBERATE PRACTICE TIME!               |"
    echo "+---------------------------------------------------------+"
    echo "| TOPIC:    $topic"
    echo "| SUBTITLE: $section"
    echo "+---------------------------------------------------------+"
    echo ""

    # Render using Glow if available, otherwise fall back to plain text
    if command -v glow &> /dev/null; then
        printf '%s\n' "$body" | glow -
    else
        printf '%s\n' "$body"
    fi

    # Only count the card once you confirm you worked through it. Without a
    # terminal to ask on, leave it unseen so it comes back later.
    [ -t 3 ] || continue
    echo ""
    read -r -p "Mark this card as done? [y/N, q to quit] " answer <&3
    case "$answer" in
        [yY]*) printf '%s\n' "$id" >> "$SEEN_FILE"; marked=$((marked + 1)) ;;
        [qQ]*) break ;;
    esac
done 3<&0 < <(tail -n +2 <<< "$output")

# Progress through the current cycle
now=$(date +%s)
start=$(cat "$CYCLE_START_FILE")
day=$(( (now - start) / 86400 + 1 ))
remaining=$(( unseen - marked ))
done_count=$(( total - remaining ))
days_left=$(( CYCLE_DAYS - day + 1 ))

echo ""
echo "+---------------------------------------------------------+"
if [ "$days_left" -ge 1 ]; then
    per_day=$(( (remaining + days_left - 1) / days_left ))
    echo "| CYCLE:    $done_count/$total cards · day $day/$CYCLE_DAYS · $per_day/day to stay on track"
else
    echo "| CYCLE:    $done_count/$total cards · $(( -days_left + 1 )) day(s) past the $CYCLE_DAYS-day goal"
fi
echo "+---------------------------------------------------------+"
