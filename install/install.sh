#!/bin/sh
set -euo pipefail

rm /exist/autodeploy/*

if ! java org.exist.start.Main client --no-gui --local --file /tmp/opt/install.xq
then
    RESULT="$?"
    cat /exist/logs/exist.log
    exit "$RESULT"
fi

rm /exist/logs/*
sed -i '/<features>/,/<\/features>/ s/<!--\|-->//g' /exist/etc/conf.xml
sed -i '/<param-name>xquery-submission<\/param-name>/{n;s/<param-value>enabled<\/param-value>/<param-value>disabled<\/param-value>/}' /exist/etc/webapp/WEB-INF/web.xml
sed -i '/<param-name>xupdate-submission<\/param-name>/{n;s/<param-value>enabled<\/param-value>/<param-value>disabled<\/param-value>/}' /exist/etc/webapp/WEB-INF/web.xml
