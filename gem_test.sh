#!/bin/bash

gem uninstall generic_gem

DIR_GENERIC_GEM=$PWD
DIR_PARENT="${PWD%/*}"
DIR_TMP=$DIR_PARENT/tmp

FILE_LOG_MAIN=$DIR_GENERIC_GEM/log/1-test-gem-main.log
FILE_LOG_TMP=$DIR_GENERIC_GEM/log/2-test-gem-tmp.log

FILE_LOG_MAIN_CODE=$DIR_GENERIC_GEM/log/3-test-code-main.log
FILE_LOG_TMP_CODE=$DIR_GENERIC_GEM/log/4-test-code-tmp.log

FILE_LOG_MAIN_INSTALL=$DIR_GENERIC_GEM/log/5-install-main.log
FILE_LOG_TMP_INSTALL=$DIR_GENERIC_GEM/log/6-install-tmp.log

mkdir -p $DIR_GENERIC_GEM/log

echo '--------------'
echo 'bundle install'
bin/setup >/dev/null

echo '*************************'
echo 'BEGIN TESTING generic_gem'
rake 2>&1 | tee $FILE_LOG_MAIN
echo 'FINISHED TESTING generic_gem'
echo '****************************'

echo '******************************'
echo 'BEGIN TESTING THE tmp RUBY GEM'
DIR_PARENT="${PWD%/*}"
DIR_TMP="$DIR_PARENT/tmp"
cd $DIR_TMP && sh gem_test.sh 2>&1 | tee $FILE_LOG_TMP
echo 'FINISHED TESTING THE tmp RUBY GEM'
echo '*********************************'

echo '******************************'
echo 'BEGIN TESTING generic_gem CODE'
cd $DIR_GENERIC_GEM && sh code_test.sh 2>&1 | tee $FILE_LOG_MAIN_CODE
echo 'FINISHED TESTING generic_gem CODE'
echo '*********************************'

echo "******************************"
echo "BEGIN TESTING THE tmp CODE"
cd $DIR_TMP && sh code_test.sh | tee $FILE_LOG_TMP_CODE
echo 'FINISHED TESTING THE tmp CODE'
echo '*********************************'

echo '****************************'
echo 'BEGIN INSTALLING generic_gem'
cd $DIR_GENERIC_GEM && sh gem_install.sh 2>&1 | tee $FILE_LOG_MAIN_INSTALL
echo 'FINISHED INSTALLING generic_gem'
echo '*******************************'

echo '****************************'
echo 'BEGIN INSTALLING THE tmp GEM'
cd $DIR_TMP && sh gem_install.sh | tee $FILE_LOG_TMP_INSTALL
echo 'FINISHED INSTALLING THE tmp GEM'
echo '*******************************'

echo 'The results of gem_test.sh are logged at:'
echo $FILE_LOG_MAIN
echo $FILE_LOG_TMP
echo $FILE_LOG_MAIN_CODE
echo $FILE_LOG_TMP_CODE
echo $FILE_LOG_MAIN_INSTALL
echo $FILE_LOG_TMP_INSTALL
echo
echo "Gemsurance Report: $DIR_GENERIC_GEM/log/gemsurance_report.html"
echo "Gem dependency diagram: $DIR_GENERIC_GEM/log/diagram-gems.svg"
echo
echo 'If all went well, there are no error messages and no failed tests.'
echo
