#!/bin/bash
make
./gradlew clean install
build/install/foo/bin/foo -s phase4.floyd
