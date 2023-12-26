#!/bin/bash

source jott.cfg

echo "JOTT"
echo "Jargon Of The Terminal"
echo -e "Courtesy of The on-line hacker Jargon File, version 4.4.7\n"

BASE_URL="http://www.catb.org/jargon/html/"
URL="http://www.catb.org/jargon/html/go01.html"

if LINKS=$(timeout 2s curl -s "$URL"); then
    LINKS=$(echo "$LINKS" | grep -o '<a [^>]*href="[^"]*"[^>]*>' | sed 's/<a [^>]*href="\([^"]*\)"[^>]*>/\1/g' | grep -E '[A-Z0-9]/[^/]+\.html')
else
    echo "Error: Unable to fetch content from $URL due to a timeout or possible connection problems"
    exit 1
fi

if [ -z "$LINKS" ]; then
    echo "No links found on the webpage."
    exit 1
fi

IFS=$'\n' read -rd '' -a LINK_ARRAY <<< "$LINKS"

TOTAL_LINKS="${#LINK_ARRAY[@]}"
RANDOM_INDEX=$((RANDOM % TOTAL_LINKS))
RANDOM_LINK="${LINK_ARRAY[RANDOM_INDEX]}"
FULL_URL="$BASE_URL$RANDOM_LINK"


LINK_CONTENT=$(curl -s "$FULL_URL")

WORD=$(echo "$LINK_CONTENT" | grep -o '<b>[^<]*</b>' | sed 's/<b>\(.*\)<\/b>/\1/')

# ------------------------
# Processing Definition

DEFINITION=$(echo "$LINK_CONTENT" | awk -v RS='</dd>' -F '<p>|</p>' '{gsub(/<a[^>]*>|<\/a>/, ""); print $2}')

DEFINITION=$(echo "$DEFINITION" | tr '\n' ' ')  # Removes newlines
DEFINITION=$(echo "$DEFINITION" | sed 's/  */ /g')  # Removes any doublespaces

# Apply ANSI escape code replacement for proper unicode characters
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8220;/"/g')      # Open double quotes
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8221;/"/g')      # Close double quotes
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8216;/'\''/g')   # Open single quote
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8217;/'\''/g')   # Close single quote
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8212;/'—'/g')    # Dash-em

if [ "$fancy" = true ]; then
    # Apply italics formatting using ANSI escape codes to <em> and <i> tags
    DEFINITION=$(echo "$DEFINITION" | sed -E 's|<i([^>]*)>([^<]+)<\/i>|\o033[3m\2\o033[0m|g')
    DEFINITION=$(echo "$DEFINITION" | sed -E 's|<em([^>]*)>([^<]+)<\/em>|\o033[3m\2\o033[0m|g')
else
    # Remove the <i> tags, leaving the content
    DEFINITION=$(echo "$DEFINITION" | sed -E 's|<i([^>]*)>([^<]*)<\/i>|\2|g')
    DEFINITION=$(echo "$DEFINITION" | sed -E 's|<em([^>]*)>([^<]*)<\/em>|\2|g')
fi

# Remove span tags
DEFINITION=$(echo "$DEFINITION" | sed 's/<span[^>]*>//g; s/<\/span>//g')
# Remove leading and trailing whitespace
DEFINITION=$(echo "$DEFINITION" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')


RED='\e[31m'
BLUE='\e[34m'
GREEN='\e[32m'
NC='\e[39m'    # Reset color

# Output to the terminal
echo -e "${RED}Word:${NC} $WORD"
echo -e "${BLUE}Definition:${NC}"
echo -e "$DEFINITION"