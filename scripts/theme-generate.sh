#!/bin/sh

# Removing a site during troubleshooting...
echo "Friendly name:"
read $friendlyname

underscores -n "$friendlyname" -d "Custom theme for $friendlyname website." -g "$friendlyname" -a 'Bluetext <technology@bluetext.com>' -u "https://bluetext.com" -s -k
