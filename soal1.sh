#!/bin/bash
region=($(awk -F "\"*,\"*" 'FNR>1{u[$13]+=$21}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n1))
state=($(awk -F "\"*,\"*" -v a=${region[1]} 'FNR>1{if($13~a)u[$11]+=$21}END{for(i in u)printf "%6.4f %s \n", u[i], i}' Sample-Superstore.csv | sort -g | head -n2))

#jika dipisah per state
#prod1=($(awk -F "\"*,\"*" -v a="${state[1]}" 'FNR>1{if($11~a)u[$17]+=$21}END{for(i in u)printf "%5.4f in %s \\n\n", u[i], i}' Sample-Superstore.csv | sort -g | head -n10))
#prod2=($(awk -F "\"*,\"*" -v b="${state[3]}" 'FNR>1{if($11~b)u[$17]+=$21}END{for(i in u)printf "%5.4f in %s \\n\n", u[i], i}' Sample-Superstore.csv | sort -g | head -n10))

#jika digabung state dan product
prod12=($(awk -F "\"*,\"*" -v a="Texas" -v b="Illinois" -v c="1" 'FNR>1{if($11~a||$11~b)u[$17]+=$21}END{for(i in u)printf "%5.4f in %s\\n\n",u[i],i}' Sample-Superstore.csv | sort -g | head -n10 | nl -s"."
))

#jika digabung state namun dipisah per product
#prod12=($(awk -F "\"*,\"*" -v a="${state[1]}" -v b="${state[3]}" 'FNR>1{if($11~a||$11~b)printf "%5.4f %s\n",$21,$17}' Sample-Superstore.csv | sort -g | head -n10))

echo -e "\n${region[1]} Region has the lowest profit at ${region[0]}\n\n2 States with lowest profit in ${region[1]} region :\n 1.${state[1]} at ${state[0]}\n 2.${state[3]} at ${state[2]}\n\n10 Products with lowest profit in both states :\n ${prod12[*]}"

#echo -e "\n10 Products with lowest profit in ${state[1]} :\n ${prod1[*]}\n10 Products with lowest profit in ${state[3]} :\n ${prod2[*]}\n"
