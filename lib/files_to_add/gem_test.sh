#!/bin/bash

# uninstall
bin/setup
echo '-----------------'
echo 'BEGIN TESTING gem'
rake
echo 'FINISHED TESTING gem'
echo '--------------------'
