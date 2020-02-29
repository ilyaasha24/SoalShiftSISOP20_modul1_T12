#!/bin/bash
fix() {
  n=$(ls 2>/dev/null -1 -- ./"$1"/"$1"_* | wc -l)
  for i in $2; do
    let n+=1
    mv $i "./$1/$1_$n"
  done
}
grep 'Location:' wget.log | cut -c32-53 | tr -d "_" > location.log
a=($(paste "./location.log" <(echo -e "pdkt_kusuma_"{1..28}"\n" | tr -d " ") | awk -F \\t '{a[$1]=$2}END{for(i in a)if(i)print a[i]}' | sort -k2))
b=($(ls pdkt_kusuma_* | sort))
c=()
for i in "${b[@]}"; do
    skip=
    for j in "${a[@]}"; do
        [[ $i == $j ]] && { skip=1; break; }
    done
    [[ -n $skip ]] || c+=("$i")
done
mkdir -p duplicate kenangan
fix duplicate "${c[*]}"
fix kenangan "${a[*]}"
mv ./wget.log{,.bak}