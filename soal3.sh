#!/bin/bash
for i in `seq 1 28`
do
  wget https://loremflickr.com/320/240/cat -O kucing$num -o wget.log
done
