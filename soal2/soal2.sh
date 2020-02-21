#!/bin/bash
file=$(echo $1 | tr -dc 'a-zA-Z')
rand28=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
echo "$rand28" > "$file.txt"
