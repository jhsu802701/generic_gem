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

echo "****************************"
echo "BEGIN RUNNING THE EXECUTABLE"
rake install
echo "Finished rake install"
generic_gem
echo "Finished generic_gem"

echo "FINISHED RUNNING THE EXECUTABLE"
echo "*******************************"

echo "If all went well, every test passed, and none failed"
echo
