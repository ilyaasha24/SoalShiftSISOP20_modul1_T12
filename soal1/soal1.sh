#!/bin/bash
region=($(awk -F "\"*,\"*" 'FNR>1{u[$13]+=$NF}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n1))
state=($(awk -F "\"*,\"*" -v a=${region[1]} 'FNR>1{if($13~a)u[$11]+=$NF}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n2))
prod12=($(awk -F "\"*,\"*" -v a=${state[1]} -v b=${state[3]} -v c="1" 'FNR>1{if($11~a||$11~b)u[$17]+=$NF}END{for(i in u)printf "%5.4f in %s\\n\n",u[i],i}' Sample-Superstore.csv | sort -g | head -n10 | nl -s"."))
echo -e "\n${region[1]} Region has the lowest profit at ${region[0]}\n\n2 States with lowest profit in ${region[1]} region :\n 1.${state[1]} at ${state[0]}\n 2.${state[3]} at ${state[2]}\n\n10 Products with lowest profit in both states :\n ${prod12[*]}"