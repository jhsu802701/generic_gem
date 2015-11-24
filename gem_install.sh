#!/bin/bash

gem uninstall generic_gem

echo '--------------'
echo 'bundle install'
bin/setup >/dev/null

echo '------------'
echo 'rake install'
rake install
