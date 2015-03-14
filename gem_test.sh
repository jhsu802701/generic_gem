#!/bin/bash

gem uninstall generic_gem
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

echo "If all went well, there are no error messages and no failed tests."
echo
