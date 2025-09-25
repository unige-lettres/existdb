#!/bin/sh
set -euo pipefail

rm /exist/autodeploy/*

(
java org.exist.start.Main client --no-gui --local --file /tmp/opt/install.xq
RESULT="$?"
echo "$RESULT"
cat /exist/logs/exist.log
test "$RESULT" -eq 0 || exit "$RESULT"
)

rm /exist/logs/*
sed -i '/<features>/,/<\/features>/ s/<!--\|-->//g' /exist/etc/conf.xml
sed -i '/<param-name>xquery-submission<\/param-name>/{n;s/<param-value>enabled<\/param-value>/<param-value>disabled<\/param-value>/}' /exist/etc/webapp/WEB-INF/web.xml
sed -i '/<param-name>xupdate-submission<\/param-name>/{n;s/<param-value>enabled<\/param-value>/<param-value>disabled<\/param-value>/}' /exist/etc/webapp/WEB-INF/web.xml
