#!/bin/sh

echo "What is the name of the site?"
read sitename

# sed -i '' "s/PROJECTNAME/$sitename/g" ../composer/composer.json

eval "sed -i '' s/PROJECTNAME/$sitename/g ../composer/composer.json"