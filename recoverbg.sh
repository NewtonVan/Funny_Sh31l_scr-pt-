#!/bin/bash
if [ ! -e orgin_bg ]; then
    echo "orgin_bg file doesn't exist"
    exit 2
fi

ORG_PI=$(cat orgin_bg)
echo "$ORG_PIC"
echo "Wanna recover?[y/n]>"
read OPT

case $OPT in
    y|yes|YES|Y) ;;
    n|no|NO|N) exit 1
        ;;
esac

gsettings set org.gnome.desktop.background picture-uri $ORG_PIC
