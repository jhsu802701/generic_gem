#!/bin/bash

bin/setup
echo "*************************"
echo "BEGIN TESTING generic_gem"
rake
echo "FINISHED TESTING generic_gem"
echo "****************************"

echo "******************************"
echo "BEGIN TESTING THE tmp RUBY GEM"
cd tmp && sh gem_test.sh
echo "FINISHED TESTING THE tmp RUBY GEM"
echo "*********************************"

echo "****************************"
echo "BEGIN RUNNING THE EXECUTABLE"
rake install
generic_gem
#expect -nocase \"Enter the directory name\" {send \"tmp2\r\"; interact}
#expect -nocase \"Enter your name\" {send \"Maya Angelou\r\"; interact}
echo "FINISHED RUNNING THE EXECUTABLE"
echo "*******************************"

echo "If all went well, every test passed, and none failed"
echo
