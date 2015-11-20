#!/bin/bash

gem uninstall generic_gem

echo '--------------'
echo 'bundle install'
bin/setup >/dev/null

echo "****************************"
echo "BEGIN INSTALLING generic_gem"
rake install
echo "FINISHED INSTALLING generic_gem"
echo "*******************************"
