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
if [ -s $file.txt ]
then
  echo "Encrypting..."
else
  echo "Creating..."
  rand28=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
  echo "$rand28" > "$file.txt"
fi
crtime=($(genesis "$file.txt"))
crhour=$(echo ${crtime[4]} | head -c2)
#echo "$file $crhour ${crtime[*]}"
shift=$(chr "$(($crhour + 65))")-ZA-$(chr "$(($crhour + 64))")$(chr "$(($crhour + 97))")-za-$(chr "$(($crhour + 96))")
CC=$(echo $file | tr [A-Za-z] [$shift])
#echo "$file.txt" "$CC.txt"
mv "$file.txt" "$CC.txt"
