#!/bin/bash
fileName="breakit"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/minifloyd/bin/minifloyd -g $fileName.floyd
