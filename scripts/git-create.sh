#!/bin/sh

# Troubleshooting repo creation script!

set timeout -1

# Creating a repo in github and pushing up a change...
echo "Creating a repo in github."
echo "What is your Github username?"
read githubusername
# echo "What is your Github password?"
# read password
echo "What should we name the repo?"
read repo

curl -u "$githubusername" https://api.github.com/orgs/BluetextDC/repos -d '{"name":"'$repo'"}'

# expect 'Enter host password for user '"$githubusername"':"'
# send -- "$password\r"


# curl -u 'USER' https://api.github.com/user/repos -d '{"name":"REPO"}'