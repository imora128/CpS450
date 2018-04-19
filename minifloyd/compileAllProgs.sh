#!/bin/bash
rm *.o
rm *.s
make
./gradlew clean install

#all tests
declare -a arr=("bchange" "blist" "bnulltest" "bobjbasics" "bstrbasics" "bstrlits" "cbasics" "cchange" "cfact" "cgcd" "citerfact" "assign1" "breakit" "loopy" "testnum")
#phase 5 b version
#declare -a arr=("bchange" "blist" "bnulltest" "bobjbasics" "bstrbasics" "bstrlits")
#phase 5 c version
#declare -a arr=("cbasics" "cchange" "cfact" "cgcd" "citerfact")
#phase 4
#declare -a arr=("assign1" "breakit" "loopy" "testnum")

for i in "${arr[@]}"
do

   rm $i
   build/install/minifloyd/bin/minifloyd $i.floyd
done