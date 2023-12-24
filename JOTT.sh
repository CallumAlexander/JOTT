#!/bin/bash

source jott.cfg

echo "JOTT"
echo "Jargon Of The Terminal"
echo "Courtesy of The on-line hacker Jargon File, version 4.4.7"

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


DEFINITION=$(echo "$LINK_CONTENT" | awk -v RS='</dd>' -F '<p>|</p>' '{gsub(/<a[^>]*>|<\/a>/, ""); print $2}')

# Apply ANSI escape code replacement for proper unicode characters
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8220;/"/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8221;/"/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8216;/'\''/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8217;/'\''/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8212;/'—'/g')

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
DEFINITION=$(echo "$DEFINITION" | tr '\n' ' ')  # Removes newlines
DEFINITION=$(echo "$DEFINITION" | sed 's/  */ /g')  # Removes any doublespaces

RED='\e[31m'
GREEN='\e[32m'
NC='\e[39m'  # Reset color


echo -e "Word: ${RED}$WORD${NC}"
echo -e "Definition:"
echo -e "${GREEN}$DEFINITION${NC}"