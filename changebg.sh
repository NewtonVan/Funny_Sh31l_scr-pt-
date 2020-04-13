#!/bin/bash
PICTURE_REPO=~/CNSS/unix_homework/Pictures/bing_wallpapers/
echo "${PICTURE_REPO}"
mkdir -p "${PICTURE_REPO}"

PIC_FILE=$(date +U_Bing_bg_%Y_%m_%d.jpg)
BING_URL="https://www.bing.com"
BING_HTML="BingWeb.html"

# echo "$PIC_URL"
# echo "$PIC_FILE"
 
wget "${BING_URL}" -O "${BING_HTML}"
PIC_URL=$(grep -Po '(?<=href=")[^"]*jpg[^"]*' ./${BING_HTML})

echo "${PICTURE_REPO}${PIC_FILE}"
echo "Wanna Download picture to this destination?>"
read OPT
case $OPT in
    y|yes|YES|Y) ;;
    n|no|NO|N) exit 0
        ;;
esac

wget "${BING_URL}$PIC_URL" -O "${PICTURE_REPO}${PIC_FILE}"
rm -i "$BING_HTML"

if [ -e "orgin_bg" ]; then
    echo "orgin_bg has existed"
else
    gsettings get org.gnome.desktop.background picture-uri > ./orgin_bg
fi

PIC_DIR="file://${PICTURE_REPO}${PIC_FILE}"

echo $PIC_DIR
echo "Wanna Change ur background?>"
read OPT
case $OPT in
    y|yes|YES|Y) ;;
    n|no|NO|N) exit 0
        ;;
esac

gsettings set org.gnome.desktop.background picture-uri "$PIC_DIR"
