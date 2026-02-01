#!/bin/bash
# remove_broken_links.sh

FILE="README_ja.md"
BROKEN="broken.txt"

# 各行を削除
while IFS= read -r url; do
    # URLに含まれる特殊文字をエスケープ
    escaped_url=$(echo "$url" | sed 's/[][\/.^$*]/\\&/g')
    sed -i "/$escaped_url/d" "$FILE"
done < "$BROKEN"

echo "Done!"
