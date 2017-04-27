#!/bin/bash

DIR_GENERIC_GEM=$PWD
DIR_PARENT="${PWD%/*}"
mkdir -p log
rm -rf tmp

echo '--------------'
echo 'bundle install'
bin/setup >/dev/null

echo
echo '----------------------'
echo 'bundle exec rubocop -D'
bundle exec rubocop -D

echo
echo '-----------------------'
echo 'bundle exec sandi_meter'
bundle exec sandi_meter

echo
echo '------------------------'
echo 'bundle exec bundle-audit'
bundle exec bundle-audit

echo '----------------------------------------------------------'
echo 'bundle exec gemsurance --output log/gemsurance_report.html'
bundle exec gemsurance --output log/gemsurance_report.html
echo 'Gemsurance Report: log/gemsurance_report.html'

echo '------------------------------------------------------------------------'
echo 'bundle viz --file=log/diagram-gems --format=svg --requirements --version'
bundle viz --file=log/diagram-gems --format=svg --requirements --version
echo 'Gem dependency diagram: log/diagram-gems.svg'
