#!/bin/bash

sh gem_test.sh 2>&1 | tee log/gem_test.log
sh code_test.sh 2>&1 | tee log/code_test.log
sh gem_install.sh 2>&1 | tee log/gem_install.log
