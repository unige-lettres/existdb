#!/usr/bin/env bash
set -euo pipefail

INDEX=$((0))
for URL in "$@"
do
    echo "$URL"
    mkdir "$INDEX"
    pushd "$INDEX"
    curl --fail --location --remote-name "$URL"
    for TAR_FILE in *.tar*; do ! test -f "$TAR_FILE" || tar x -a -f "$TAR_FILE"; done
    for ZIP_FILE in *.zip; do ! test -f "$ZIP_FILE" || unzip -q "$ZIP_FILE"; done
    find -name build.xml -exec ant -Dbuild.dir="$PWD"/build -buildfile {} ';'
    find build -name '*.xar' -exec mv {} ../"$INDEX".xar ';'
    popd
    rm -r "$INDEX"
    INDEX=$(("$INDEX"+1))
done

cp -r /opt opt
