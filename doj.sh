#!/bin/bash -vx

[ -e "${1}" ] || exit 2

# SHIP=$(echo "${1}" | grep -o '^[^.]*')
# TYPE=$(echo "${1}" | grep -o '[^.]*$')
SHIP="${1%.*}"
TYPE="${1#*.}"
# echo $SHIP
# echo $TYPE

case $TYPE in
    c) gcc -g -Wall -Werror "${1}" -o "${SHIP}.exe"
        ;;
    cpp) g++ -std=c++11 -g -Wall -Werror "${1}" -o "${SHIP}.exe"
        ;;
    *) exit 1
esac

"./${SHIP}.exe" < input.txt | cat > output.txt
# echo "ok1"
cat output.txt
