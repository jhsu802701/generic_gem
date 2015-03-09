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
