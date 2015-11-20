#!/bin/bash

gem uninstall generic_gem

DIR_GENERIC_GEM=$PWD
DIR_PARENT="${PWD%/*}"
DIR_TMP="$DIR_PARENT/tmp"
mkdir -p log

echo '--------------'
echo 'bundle install'
bin/setup >/dev/null

echo
echo '-------'
echo 'rubocop'
rubocop

echo
echo '-----------'
echo 'sandi_meter'
sandi_meter

echo
echo '------------'
echo 'bundle-audit'
bundle-audit

echo '----------'
echo 'gemsurance'
gemsurance
echo 'The Gemsurance Report is in gemsurance_report.html in the root directory.'
