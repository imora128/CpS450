#!/bin/bash
fileName="test"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/minifloyd/bin/minifloyd -dp $fileName.floyd
