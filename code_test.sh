#!/bin/bash

gem uninstall generic_gem

DIR_GENERIC_GEM=$PWD
DIR_PARENT="${PWD%/*}"
DIR_TMP="$DIR_PARENT/tmp"
mkdir -p log
rm -rf tmp

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

echo '--------------------------------------------------------------------'
echo 'bundle viz --file=diagram-gems --format=svg --requirements --version'
bundle viz --file=diagram-gems --format=svg --requirements --version
echo 'The gem dependency diagram is in the diagram-gems.svg file.'
