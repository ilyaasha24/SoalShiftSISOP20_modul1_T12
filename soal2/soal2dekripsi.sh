#!/bin/bash
genesis() {
  for target in "${@}"; do
    inode=$(stat -c %i "${target}")
    fs=$(df  --output=source "${target}"  | tail -1)
    crtime=$(sudo debugfs -R 'stat <'"${inode}"'>' "${fs}" 2>/dev/null |
    grep -oP 'crtime.*--\s*\K.*')
    printf "%s\t%s\n" "${target}" "${crtime}"
  done
}
chr() {
  printf \\$(printf '%03o' $1)
}
#main
file=$(echo $1 | tr -dc 'a-zA-Z')
crtime=($(genesis "$file.txt"))
crhour=$(echo ${crtime[4]} | head -c2)
shift=$(chr "$(($crhour + 65))")-ZA-$(chr "$(($crhour + 64))")$(chr "$(($crhour + 97))")-za-$(chr "$(($crhour + 96))")
dCC=$(echo $file | tr $shift A-Za-z)
mv "$file.txt" "$dCC.txt"
