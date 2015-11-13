#!/bin/bash

bin/setup
echo '-------'
echo 'rubocop'
rubocop
echo '----'
echo 'rake'
rake
