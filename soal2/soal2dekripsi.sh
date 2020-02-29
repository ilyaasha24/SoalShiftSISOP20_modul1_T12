#!/bin/bash
chr() { printf \\$(printf '%03o' $1); }
file=$(echo $@)
file=$(echo ${file%%.*} | tr -dc A-Za-z)
cr=$(sudo debugfs -R 'stat <'"$(stat -c %i $file.txt)"'>' "$(df --output=source $file.txt | tail -n1)" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' | cut -c12-13)
if [[ $cr != 00 ]]; then
  shift=$(chr $(($cr + 65)))-ZA-$(chr $(($cr + 64)))$(chr $(($cr + 97)))-za-$(chr $(($cr + 96)))
  dCC=$(echo $file | tr A-Za-z $shift)
  mv "$file.txt" "$dCC.txt"
fi