#!/bin/sh

echo "What is the name of the site?"
read friendlyname
shopt -s extglob
rm -rf !("$friendlyname")

# sed -i '' "s/PROJECTNAME/$sitename/g" ../composer/composer.json

# eval "sed -i '' s/PROJECTNAME/$sitename/g ../composer/composer.json"