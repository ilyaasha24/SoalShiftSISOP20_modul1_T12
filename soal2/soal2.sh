#!/bin/bash
file=$(echo $@)
file=$(echo ${file%%.*} | tr -dc 'a-zA-Z')
rand28=$(dd if=/dev/urandom | tr -dc a-zA-Z0-9 | fold -w 28 | awk '/[A-Z]/&&/[a-z]/&&/[0-9]/;a[$1]{for(i in a)print i}' | head -n1)
echo "$rand28" > "$file.txt"