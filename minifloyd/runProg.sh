#!/bin/bash
fileName="cchange"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/minifloyd/bin/minifloyd $fileName.floyd
