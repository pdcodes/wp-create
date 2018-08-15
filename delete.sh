#!/bin/sh

# Removing a site during troubleshooting...
echo "Enter the name of the site that you'd like to delete:"
read $sitename

rm -rf $sitename

terminus site:delete $sitename

# DELETE /repos/:owner/:repo

curl -u pdcodes --request DELETE https://api.github.com/repos/BluetextDC/wflow-test

# curl -u "$githubusername" https://api.github.com/orgs/BluetextDC/repos -d '{"name":"'$sitename'"}'

# curl -u 'USER' https://api.github.com/user/repos -d '{"name":"REPO"}'