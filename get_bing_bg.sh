#!/bin/bash
# PICTURE_REPO=~/CNSS/unix_homework/Pictures/bing_wallpapers/
# mkdir -p "${PICTURE_REPO}"

PIC_FILE=$(date +U_Bing_bg_%Y_%m_%d.jpg)
BING_URL="https://www.bing.com"
BING_HTML="BingWeb.html"

# echo "$PIC_URL"
# echo "$PIC_FILE"

wget "${BING_URL}" -O "${BING_HTML}"
PIC_URL=$(grep -Po '(?<=href=")[^"]*jpg[^"]*' ./${BING_HTML})
wget "${BING_URL}$PIC_URL" -O "$PIC_FILE"
