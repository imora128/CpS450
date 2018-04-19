#!/bin/bash
rm *.o
rm *.s
./gradlew clean
declare -a arr=("bchange" "blist" "bnulltest" "bobjbasics" "bstrbasics" "bstrlits" "cbasics" "cchange" "cfact" "cgcd" "citerfact" "assign1" "breakit" "loopy" "testnum")

for i in "${arr[@]}"
do
   rm $i
done