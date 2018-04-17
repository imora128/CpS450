#!/bin/bash
fileName="bstrlits"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/minifloyd/bin/minifloyd $fileName.floyd
