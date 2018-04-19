#!/bin/bash
fileName="aarrlist"
rm *.o
rm *.s
rm $fileName
make
./gradlew clean install
build/install/floyd/bin/floyd $fileName.floyd
