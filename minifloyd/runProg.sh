#!/bin/bash
fileName="jaja"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/minifloyd/bin/minifloyd -dp $fileName.floyd
