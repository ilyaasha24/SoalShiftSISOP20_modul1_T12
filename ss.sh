#!/bin/bash
a=($(md5sum kucing* | awk -F "  " '{a[$1]=$2}END{for(i in a)print i, a[i]}' | uniq |  awk -F " " '{print $2}' | sort))
b=($(ls kucing* | sort))
#echo ${a[@]}
#echo ${b[@]}
Array3=()
for i in "${b[@]}"; do
    skip=
    for j in "${a[@]}"; do
        [[ $i == $j ]] && { skip=1; break; }
    done
    [[ -n $skip ]] || Array3+=("$i")
done
echo ${Array3[*]}
