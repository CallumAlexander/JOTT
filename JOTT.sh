#!/bin/bash

echo "JOTT"
echo "Jargon Of The Terminal"
echo "Courtesy of The on-line hacker Jargon File, version 4.4.7"

BASE_URL="http://www.catb.org/jargon/html/"
URL="http://www.catb.org/jargon/html/go01.html"

LINKS=$(timeout 2s curl -s "$URL" | grep -o '<a [^>]*href="[^"]*"[^>]*>' | sed 's/<a [^>]*href="\([^"]*\)"[^>]*>/\1/g' | grep -E '[A-Z0-9]/[^/]+\.html')


if [ -z "$LINKS" ]; then
    echo "No links found on the webpage."
    exit 1
fi

IFS=$'\n' read -rd '' -a LINK_ARRAY <<< "$LINKS"

TOTAL_LINKS="${#LINK_ARRAY[@]}"
RANDOM_INDEX=$((RANDOM % TOTAL_LINKS))
RANDOM_LINK="${LINK_ARRAY[RANDOM_INDEX]}"
echo $RANDOM_LINK
FULL_URL="$BASE_URL$RANDOM_LINK"

# echo "$FULL_URL"

LINK_CONTENT=$(curl -s "$FULL_URL")

WORD=$(echo "$LINK_CONTENT" | grep -o '<b>[^<]*</b>' | sed 's/<b>\(.*\)<\/b>/\1/')

# pronunciation=$(echo "$LINK_CONTENT" | awk -F '[<>]' '/class="pronunciation"/ {print $3}')
# grammar=$(echo "$LINK_CONTENT" | awk -F '[<>]' '/class="grammar"/ {print $3}')

DEFINITION=$(echo "$LINK_CONTENT" | awk -v RS='</dd>' -F '<p>|</p>' '{gsub(/<a[^>]*>|<\/a>/, ""); print $2}')

DEFINITION=$(echo "$DEFINITION" | sed 's/&#8220;/"/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8221;/"/g')

DEFINITION=$(echo "$DEFINITION" | sed 's/&#8216;/'\''/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/&#8217;/'\''/g')

DEFINITION=$(echo "$DEFINITION" | sed 's/&#8212;/'—'/g')

DEFINITION=$(echo "$DEFINITION" | sed 's/<i class="glossterm">\(.*\)<\/i>/\1/g')
DEFINITION=$(echo "$DEFINITION" | sed 's/<i class="citetitle">\(.*\)<\/i>/\1/g')

# DEFINITION=$(echo "$DEFINITION" | sed 's/<span[^>]*>\(.*\)<\/span>/\1/g')
# DEFINITION=$(echo "$DEFINITION" | sed 's/<span class="quote">\(.*\)<\/span>/\1/g')
# DEFINITION=$(echo "$DEFINITION" | sed 's/<span class="emphasis">\(.*\)<\/span>/\1/g')
# DEFINITION=$(echo "$DEFINITION" | sed 's/<span class="citerefentry">\(.*\)<\/span>/\1/g')
# DEFINITION=$(echo "$DEFINITION" | sed 's/<span class="firstterm">\(.*\)<\/span>/\1/g')
# DEFINITION=$(echo "$DEFINITION" | sed 's/<span[^>]*>\(.*\)<\/span>/\1/g')


DEFINITION=$(echo "$DEFINITION" | sed 's/<span[^>]*>//g; s/<\/span>//g')

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No color

# DEFINITION=$(echo "$LINK_CONTENT" | sed -n '/<dd>/,/<\/dd>/p' | sed 's/<a[^>]*>[^<]*<\/a>//g' | sed 's/<[^>]*>//g' | awk '{$1=$1}' | tr -d '\n' | sed 's/<dd>/\n\n<dd>/g')

echo -e "Word: ${RED}$WORD${NC}"
echo -e "Definition:${GREEN}"
echo -e "$DEFINITION${NC}"