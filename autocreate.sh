#!/bin/sh

#pwd

#echo "$1 just wrote a shell script."

#echo "What is your name?"
#read name
#echo "$name"

echo "What is the name of the site you'd like to create?"
read sitename

terminus site:create --org Bluetext "$sitename" "$sitename" e8fe8550-1ab9-4964-8838-2b9abdccf4bf

echo "CMS deploy completed;"

terminus connection:set "$sitename".dev git

echo "Connection mode set to git;"