#!/usr/bin/env bash
set -euo pipefail

if test "$#" -eq 0
then CONTEXTS=(https://github.com/"$GITHUB_REPOSITORY"/archive/"$GITHUB_SHA".zip)
else CONTEXTS=("$@")
fi

INDEX=$((0))
for CONTEXT in "${CONTEXTS[@]}"
do
    echo "$CONTEXT"
    mkdir /tmp/"$INDEX"
    pushd /tmp/"$INDEX"
    curl --fail --location --remote-name "$CONTEXT"
    for TAR_FILE in *.tar*; do ! test -f "$TAR_FILE" || tar --extract --file "$TAR_FILE"; done
    for ZIP_FILE in *.zip; do ! test -f "$ZIP_FILE" || unzip -q "$ZIP_FILE"; done
    find -name build.xml -exec ant -Dbuild.dir=/tmp/"$INDEX"/build -buildfile {} ';'
    find /tmp/"$INDEX"/build -name '*.xar' -exec mv {} /tmp/"$INDEX".xar ';'
    popd
    INDEX=$(("$INDEX"+1))
done

cp --recursive /opt /tmp/context
cp /tmp/*.xar /tmp/context

IMAGE="ghcr.io/${GITHUB_REPOSITORY,,}"
podman build --squash --tag "$IMAGE" /tmp/context

DEFAULT_BRANCH="$(curl --silent https://api.github.com/repos/"$GITHUB_REPOSITORY" | jq --raw-output .default_branch)"
if test "$GITHUB_REF_NAME" = "$DEFAULT_BRANCH"
then podman push "$IMAGE"
fi
