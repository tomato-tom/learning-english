#!/bin/bash

file="broken.txt"
[ -f "$file" ] && rm "$file"

# URL自動チェック
grep -o 'https://[^)" ]*' README.md | sort -u | while read url; do
    echo -en "Checking $url ..."
    if curl -s -I -L -m 3 -A "Mozilla/5.0" "$url" 2>/dev/null | head -n 1 | grep -q "200\|301\|302\|307"; then
        :
    else
        echo "$url" >> "$file"
    fi

    sleep 0.3
    echo -en "\r\033[K"
done

# URL手動チェック
file="broken.txt"
cat "$file" | while read url; do
    firefox "$url"
    sleep 0.1
done

