#!/usr/bin/env bash
set -euo pipefail

INDEX=$((0))
for URL in "$@"
do
    echo "$URL"
    mkdir "$INDEX"
    pushd "$INDEX"
    curl --fail --location --remote-name "$URL"
    for TAR_FILE in *.tar*; do tar x -a -f "$TAR_FILE"; done
    find -name build.xml -exec ant -Dbuild.dir="$PWD"/build -buildfile {} ';'
    find build -name '*.xar' -exec mv {} ../"$INDEX".xar ';'
    popd
    rm -r "$INDEX"
    INDEX=$(("$INDEX"+1))
done

cp -r /opt opt
