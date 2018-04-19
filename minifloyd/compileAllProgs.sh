#!/bin/bash
rm *.o
rm *.s
make
./gradlew clean install

#phase 5 b version
declare -a arr=("bchange" "blist" "bnulltest" "bobjbasics" "bstrbasics" "bstrlits")
#phase 5 c version
#declare -a arr=("cbasics" "cchange" "cfact" "cgcd" "citerfact")
#phase 4
#declare -a arr=("assign1" "breakit" "loopy" "testnum")

for i in "${arr[@]}"
do

   rm $i
   build/install/minifloyd/bin/minifloyd $i.floyd
done