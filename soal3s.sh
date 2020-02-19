#!/bin/bash
#a=($(md5sum kucing* | awk -F "  " '{a[$1]=$2}END{for(i in a)print i, a[i]}' | uniq | awk -F " " '{print $2}' | sort))
b=($(ls pdkt_kusuma_* | sort))
grep 'Location:' wget.log | cut -c32-53 | tr -d "_" > location.log
a=($(paste "./location.log" <(echo -e "pdkt_kusuma_"{1..28}",\n") | tr -d " " | sed 's/\t/,/g' | awk -F "," '{a[$1]=$2}END{for(i in a)print i, a[i]}' | sort -k2 | awk -F " " 'FNR>1{print $2}'))
#echo ${a[@]}
#echo ${b[@]}
c=()
for i in "${b[@]}"; do
    skip=
    for j in "${a[@]}"; do
        [[ $i == $j ]] && { skip=1; break; }
    done
    [[ -n $skip ]] || c+=("$i")
done
#echo ${c[@]}
d=$(ls -1 "./duplicate/" | wc -l)
for i in "${c[@]}"; do
    let d+=1
    mv $i "./duplicate/duplicate_$d"
done
k=$(ls -1 "./kenangan" | wc -l)
for i in "${a[@]}"; do
    let k+=1
    mv $i "./kenangan/kenangan_$k"
done
mv ./wget.log{,.bak}
