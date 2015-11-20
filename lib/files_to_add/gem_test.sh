#!/bin/bash

# uninstall
bin/setup
echo '-------'
echo 'rubocop'
rubocop
echo '-----------'
echo 'sandi_meter'
sandi_meter
echo '----'
echo 'rake'
rake
