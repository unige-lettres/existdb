#!/bin/sh
set -euo pipefail

rm /exist/autodeploy/*

(
    trap 'cat /exist/logs/exist.log' EXIT
    java org.exist.start.Main client --no-gui --local --file /tmp/install.xq
)

rm /exist/logs/*
sed -i '/<features>/,/<\/features>/ s/<!--\|-->//g' /exist/etc/conf.xml
sed -i '/<param-name>xquery-submission<\/param-name>/{n;s/<param-value>enabled<\/param-value>/<param-value>disabled<\/param-value>/}' /exist/etc/webapp/WEB-INF/web.xml
sed -i '/<param-name>xupdate-submission<\/param-name>/{n;s/<param-value>enabled<\/param-value>/<param-value>disabled<\/param-value>/}' /exist/etc/webapp/WEB-INF/web.xml
