#!/bin/bash
fileName="blist"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/minifloyd/bin/minifloyd $fileName.floyd
