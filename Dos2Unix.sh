#!/bin/bash
for FILE in $(find /exam -name "*.txt" -type f ); do
    sed -e 's/\r//g' $FILE > ${FILE}.bak
done
