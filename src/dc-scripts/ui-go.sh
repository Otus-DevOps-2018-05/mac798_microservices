#!/bin/sh

echo Changing container content whatever you like
# Ex.: cd /app && git checkout && git pull origin master
# run puma server

cd /app && puma $*
