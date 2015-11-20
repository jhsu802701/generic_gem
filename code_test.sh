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
rubocop 2>&1 | tee $DIR_GENERIC_GEM/log/main-rubocop.txt

echo
echo '-----------'
echo 'sandi_meter'
sandi_meter 2>&1 | tee $DIR_GENERIC_GEM/log/main-sandi.txt

echo
echo '------------'
echo 'bundle-audit'
bundle-audit 2>&1 | tee $DIR_GENERIC_GEM/log/main-bundle-audit.txt