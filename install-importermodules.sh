#!/bin/bash
for dir in $(find . -mindepth 1 -maxdepth 1 -type d -name 'sdm4-*'); do
	pushd $dir
    mvn clean install
    popd
done