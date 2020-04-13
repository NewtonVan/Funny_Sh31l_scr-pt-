#!/bin/bash
# This is a shell script used to purge the unused old kernel 
# to save the space of the boot

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


df -h
WannaContinue

CUR_U_CORE=$(uname -r | grep -P -o -e '.*(?=-generic)')
echo $CUR_U_CORE
WannaContinue

dpkg --get-selections | grep -P -o -e 'linux-(modules|image|headers)[^[:space:]]*'  | egrep -v "(generic-hwe-|$CUR_U_CORE)" # | nl
WannaContinue
