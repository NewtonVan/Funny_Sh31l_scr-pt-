#!/bin/bash
# This is a shell script used to purge the unused old kernel 
# to save the space for the boot

# Functions
WannaContinue(){
    printf "Wanna continue?[y/n]>"
    read OPT
    case $OPT in
        y|yes|Y|YES|Yes);;
        n|no|N|NO|No) exit 0;;
        *) exit 1
    esac

    return 0
}
WannaPurge(){
    printf "Wanna purge ${1}[y/n]>"
    read OPT
    case $OPT in
        y|yes|Y|YES|Yes) echo "ready to purge ${1}"
            sudo apt-get purge "${1}"
            ;;
        n|no|N|NO|No) ;;
        *) exit 1
    esac
}
ClearDeinstall(){
    printf "Wanna purge ${1}[y/n]>"
    read OPT
    case $OPT in
        y|yes|Y|YES|Yes) echo "ready to clear deinstall ${1}"
            sudo dpkg -P "${1}"
            ;;
        n|no|N|NO|No) ;;
        *) exit 1
    esac

    return 0
}
dpkg --get-selections | grep '^linux-' | nl
WannaContinue

echo "Check the condition of ur mount"
df -h
WannaContinue

echo "This is the currently used kernel"
CUR_U_CORE=$(uname -r | grep -P -o -e '.*(?=-generic)')
echo $CUR_U_CORE
WannaContinue

echo "These are the file which may be the trash"
echo "And this sh doesn't purge all of them, u can be purged by yourself"
dpkg --get-selections | grep -P -o -e 'linux-(modules|image|headers)[^[:space:]]*'  | egrep -v "(generic-hwe-|$CUR_U_CORE)"  | nl
WannaContinue

echo "This is the part this shell will purge."
dpkg --get-selections | grep -P -o -e 'linux-(image|headers)[-0-9.]{3,}generic'  | egrep -v "(generic-hwe-|$CUR_U_CORE)" 
DEL_FILE_SET=($(dpkg --get-selections | grep -P -o -e 'linux-(image|headers)[-0-9.]{3,}generic'  | egrep -v "(generic-hwe-|$CUR_U_CORE)" ))
# echo $DEL_FILE_SET
echo "The following action may cause some dangerous, u have to be really careful"
WannaContinue

if [ -n "$DEL_FILE_SET" ]; then
    for FILE_DEL in "${DEL_FILE_SET[@]}"; do
        WannaPurge $FILE_DEL
    done
else
    echo "There is nothing to purge use sudo perge"
fi

echo "Wanna exec autoremove?[y/n]>"
read OPT
case $OPT in
    y|yes|YES|Y)
        sudo apt autoremove
        ;;
    n|no|NO|N) ;;
    *) exit 1
esac

# dpkg --get-selections | grep -P -o -e '^linux-(modules|image|headers)[^[:space:]]*(?=\s*deinstall)' | egrep -v "(generic-hwe-|$CUR_U_CORE)"
dpkg --get-selections | grep '^linux-.*deinstall'
echo "Here are the packages are deinstall, wanna clear that>"
WannaContinue

DE_INSTL=($(dpkg --get-selections | grep -P -o -e '^linux-(modules|image|headers)[^[:space:]]*(?=\s*deinstall)' | egrep -v "(generic-hwe-|$CUR_U_CORE)"))
if [ -n "$DE_INSTL" ]; then
    for DE_FILE in "${DE_INSTL[@]}"; do
        ClearDeinstall "$DE_FILE"
    done
else
    echo "There is nothing to purge use sudo perge"
fi

sudo update-grub

dpkg --get-selections | grep '^linux-' | nl
echo "Check the condition of ur mount"
df -h
