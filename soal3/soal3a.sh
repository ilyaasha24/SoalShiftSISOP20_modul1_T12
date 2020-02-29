#!/bin/bash
rm wget.log 2>/dev/null
for i in `seq 1 28`; do
  wget https://loremflickr.com/320/240/cat -O pdkt_kusuma_$i -a wget.log
done