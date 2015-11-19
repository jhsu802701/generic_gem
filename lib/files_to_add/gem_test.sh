#!/bin/bash

# uninstall
bin/setup
echo '-------'
echo 'rubocop'
rubocop
echo '----'
echo 'rake'
rake
